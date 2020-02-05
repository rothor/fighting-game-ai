# Fighting Game AI with Neural Networks

## Overview

This project is a proof-of-concept neural network decision engine written in Lua for the Bizhawk emulator. It serves as an example of how to integrate a neural network with Bizhawk's embedded Lua API to create a learning AI for a fighting game.

## Inspiration

After watching the MarI/O video on YouTube, I was inspired to create a similar project. The video demonstrated the power of neural networks in game AI, and I wanted to apply those principles to a different genre. I chose the game X-Men: Mutant Academy 2 for PlayStation 1 because of my familiarity with it and being able to setup scripting with it in Bizhawk.

## Neural Network Implementation

The neural network is implemented in Lua and it processes the game state to make decisions in real-time. The key components include:

- **Input Layer**: Receives the current game state, including positions, health, energy, and actions of both characters. It has 22 nodes.
- **Two hidden layers**: Each with 66 nodes.
- **Output Layer**: Determines what controller buttons to press based on input. Has 8 nodes.

## Reinforcement Learning

The AI uses reinforcement learning to improve its performance over time. The learning process involves scoring the AI's performance, giving it positive rewards for landing hits and negative rewardS for taking damage. I would mutate the AI's genome (neural network weights), and if the AI performed better, I would keep those genetic mutations. If not, I would undo them and create new mutations. This process is repeated thousands of times to create a high-performing neural network.

## Results

The AI showed significant improvement over multiple training sessions, eventually outperforming the built-in AI on easy difficulty. There were several limiting factors to this project:

- **Reverse-engineering Memory Values**: I had to reverse-engineer the memory values of the game myself, providing the AI with a limited view of the current game state.
- **Time Constraints**: Each simulation took several minutes, and training an AI over hundreds of iterations could take several hours. I often left the emulator running overnight, and even then, I feel the results could have been better with more time.

Despite these limitations, the project serves as a great proof-of-concept that neural networks with even a limited view of the current context can improve their performance over time with reinforcement learning.