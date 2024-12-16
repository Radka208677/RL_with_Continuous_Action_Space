import gymnasium as gym
from gymnasium import spaces
import numpy as np
import shutil
from fmpy import read_model_description, extract
from fmpy.fmi2 import FMU2Slave
from fmpy.util import plot_result
import matplotlib.pyplot as plt
from math import atan2, sin, cos


class FMUGymEnv(gym.Env):
    def __init__(self, fmu_filename, start_time, stop_time, step_size, threshold):
        super(FMUGymEnv, self).__init__()

        self.fmu_filename = fmu_filename
        self.start_time = start_time
        self.stop_time = stop_time
        self.step_size = step_size
        self.threshold = threshold

        # Read the model description
        self.model_description = read_model_description(self.fmu_filename)
        
        # Collect the value references
        self.vrs = {}
        for variable in self.model_description.modelVariables:
            self.vrs[variable.name] = variable.valueReference

        # Value references for inputs and outputs
        self.vr_input_torque = self.vrs['TORQUE']
        self.vr_angle = self.vrs['ANGLE']
        self.vr_ang_vel = self.vrs['ANG_VEL']

        # Define the action and observation space
        # Action space: Continuous torque from 0 to 50000
        self.action_space = spaces.Box(low=np.array([-300]), high=np.array([300]), dtype=np.float32)
        
        # Observation space: Continuous space for ANGLE, ANG_VEL, VELOCITY_X
        self.observation_space = spaces.Box(low=-np.inf, high=np.inf, shape=(3,), dtype=np.float32)

        # Initialize time and reward list
        self.time = None
        self.reward_per_episode = []
        self.previous_actions = []

    def reset(self, seed=None, options=None):
        # Optional: Seed the random number generator for reproducibility
        super().reset(seed=seed)
        if seed is not None:
            np.random.seed(seed)
            
        if hasattr(self, 'fmu'):
            self.fmu.terminate()
            self.fmu.freeInstance()
            del self.fmu
            self.unzipdir = extract(self.fmu_filename)
    

        # Extract the FMU (if not already extracted)
        elif not hasattr(self, 'unzipdir'):
            self.unzipdir = extract(self.fmu_filename)
        
        # Instantiate the FMU
        self.fmu = FMU2Slave(guid=self.model_description.guid,
                             unzipDirectory=self.unzipdir,
                             modelIdentifier=self.model_description.coSimulation.modelIdentifier,
                             instanceName='instance1')

        # Set up the FMU for simulation
        self.fmu.instantiate()
        self.fmu.setupExperiment(startTime=self.start_time)
        self.fmu.enterInitializationMode()
        self.fmu.exitInitializationMode()

        # Initialize the simulation time and state variables
        self.time = self.start_time
        self.angle = 0
        self.ang_vel = 0


        # Reset reward tracking
        self.reward_per_episode = []
        self.observations = []
        self.torque_values = []
        torque = 0
        
        observation = np.array([sin(self.angle), cos(self.angle), self.ang_vel], dtype=np.float32)
        self.observations.append(observation)
        self.torque_values.append(torque)
        return observation, {}

    def step(self, action):
        # Convert the discrete action into the torque value
        torque = np.clip(action[0], -300, 300)

        # Set the input torque
        self.fmu.setReal([self.vr_input_torque], [torque])

        # Perform one step
        self.fmu.doStep(currentCommunicationPoint=self.time, communicationStepSize=self.step_size)

        # Advance time
        self.time += self.step_size

        # Get the outputs
        self.angle, self.ang_vel = self.fmu.getReal([self.vr_angle, self.vr_ang_vel])
        
        self.torque_values.append(torque)

        # Calculate reward
        reward = -1.0 * (atan2(sin(self.angle-np.pi), cos(self.angle-np.pi)))**2 - 0.1 * np.clip(self.ang_vel, -50, 50)**2 -0.000001*self.torque_values[-1]**2
        self.reward_per_episode.append(reward)

        # Check if the episode is terminated or truncated
        terminated = abs(self.ang_vel) > self.threshold
        truncated = self.time >= self.stop_time
    
        observation = np.array([sin(self.angle), cos(self.angle), self.ang_vel], dtype=np.float32)
        
        self.observations.append(observation)
        
        # Include termination time in the info dictionary
        info = {}
        if terminated:
            info['termination_time'] = self.time

        return observation, reward, terminated, truncated, info

    def render(self, mode='human'):
        # Optional: implement rendering
        pass

    def close(self):
        if hasattr(self, 'fmu'):
            self.fmu.terminate()
            self.fmu.freeInstance()
            del self.fmu  # Ensure the FMU object is deleted to free memory
        if hasattr(self, 'unzipdir'):
            shutil.rmtree(self.unzipdir, ignore_errors=True)
            del self.unzipdir  # Ensure the directory attribute is removed
    def plot_observations(self):
        # Convert observations list to numpy array for easier indexing
        observations = np.array(self.observations)
        torques = np.array(self.torque_values)
        
        # Plot each observation component over time
        time_steps = np.arange(len(observations)) * self.step_size

        plt.figure(figsize=(12, 8))

        plt.subplot(4, 1, 1)
        plt.plot(time_steps, observations[:, 0], label='Sin')
        plt.xlabel('Time')
        plt.ylabel('Angle')
        plt.legend()
        
        plt.subplot(4, 1, 2)
        plt.plot(time_steps, observations[:, 1], label='Cos')
        plt.xlabel('Time')
        plt.ylabel('Angle')
        plt.legend()

        plt.subplot(4, 1, 3)
        plt.plot(time_steps, observations[:, 2], label='Angular Velocity')
        plt.xlabel('Time')
        plt.ylabel('Angular Velocity')
        plt.legend()

        plt.subplot(4, 1, 4)
        plt.plot(time_steps, torques, label='Torque', color='red')
        plt.xlabel('Time')
        plt.ylabel('Torque')
        plt.legend()

        plt.tight_layout()
        plt.show()


if __name__ == "__main__":
    # Simulations with random input
    fmu_filename = 'pendulum.fmu'
    env = FMUGymEnv(fmu_filename, start_time=0, stop_time=10.0, step_size=0.05, threshold=1000)

    for episode in range(5):
        observation = env.reset()
        terminated = False
        truncated = False
        total_reward = 0
        while not (terminated or truncated):
            action = env.action_space.sample()  # Random action
            observation, reward, terminated, truncated, info = env.step(action)
            total_reward += reward
            if terminated:
                print(f"Episode {episode + 1} terminated at time {info['termination_time']} with total reward: {total_reward}.")
            if truncated:
                print(f"Episode {episode + 1} finished with total reward: {total_reward}")
                # Plot observations for the episode
        env.plot_observations()
    env.close()