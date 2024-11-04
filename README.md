# Code for Kinematic and Hydrodynamic Analysis of a Manta Ray-Inspired Robot
![image info](AbstractB.png)
Resources and extra documentation for the manuscript "Kinematic and Hydrodynamic Analysis of a Manta Ray-Inspired Robot" published in IEEE Latin America Transactions. The project hierarchy and folders description is as follows:
1. Code
2. Model
3. Video
4. Abstract

## Requirements

* Matlab 2021b or later. All additional packages (only needed codes) were uploaded in this repository.

In the code section, the following files are presented, with their functionality and use explained below:

Perfil_ala.m: This MATLAB code models and visualizes the structure of a fin inspired by manta rays. It defines parameters such as the number of radial elements (R), fin segments (S), and oscillations. It uses the linspace function to generate three-dimensional coordinates (x, y, z) and employs a double loop to calculate the positions of the points forming the fin. Finally, it draws the NACA profile and visually represents the geometry of the fin, which is essential for understanding its behavior in fluids.

ray_model.m: This code simulates the movement of an oscillating fin inspired by manta rays over time. It defines movement parameters and calculates the length of each radial segment. In a time loop, it simulates the oscillation using trigonometric functions and stores the positions (x, y, z) in matrices. The position data is saved for later analysis and visualization of the fin's dynamic behavior.

ray_graph.m: This code loads positions from a three-dimensional model simulating the oscillation of the fins of a robot inspired by the manta ray. It updates the positions of the segments in a 3D graph and uses aerodynamic equations to visualize the shape of the fins during oscillation. It includes a brief delay to enhance the dynamic visualization of the simulation.

ray_full.m: This code visualizes and manipulates three-dimensional data of positions over time for trajectory analysis. It loads data from files and defines rotation matrices. In a loop, it plots lines in 3D representing the object's trajectories using the loaded data. It calculates chord lengths and generates new points using parametric equations. Finally, it saves the generated points in text files for later analysis, allowing for the simulation of the movement of nature-inspired structures.
