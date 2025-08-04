# Kinova-Gen3-Control

A comprehensive MATLAB/Simulink framework for controlling the Kinova Gen3 7-DOF robotic manipulator using various advanced control algorithms. **All robot dynamics are computed using the ManiDyn toolbox**, ensuring accurate and efficient dynamic modeling.

## Requirements

- **ManiDyn** toolbox ([GitHub link](https://github.com/BanaanKiamanesh/ManiDyn)) - **Core dependency for robot dynamics computation**
- MATLAB R2021a or newer
- MATLAB **Robotics** Toolbox
- **Symbolic Math** Toolbox
- **Simscape Multibody**

---

## Repository Contents

### Robot Description & Modeling
- **URDF Files**: Complete Kinova Gen3 robot description files
- **Simscape Template**: Ready-to-use Simulink model with Simscape Multibody integration
- **Robot Data Package**: Comprehensive robot specifications and parameters

### Dynamics & Kinematics
**All robot dynamics are computed using the ManiDyn toolbox**, providing:
- **Forward Kinematics**: MEX-compiled functions for fast FK computation
- **Jacobian Matrices**: Efficient Jacobian calculation functions
- **Dynamics**: Complete dynamic model with Coriolis, centrifugal, and gravity terms along with the system ODE Function ready for simulation

### Control Algorithms

The repository implements the following control algorithms:

1. **PD + Gravity Compensation**
2. **PID Control**
3. **Feedback Linearization + PD**
4. **Inverse Dynamics Control**
5. **Sliding Mode Control**
6. **Robust Inverse Dynamics Control**

### Utilities & Tools
- **CreateRobot.m**: Automated robot model generation script using ManiDyn
- **MEX Functions**: High-performance compiled functions for real-time control
- **Design Scripts**: Parameter tuning and analysis tools for each controller

---

## Getting Started

1. Install all required MATLAB toolboxes
2. Clone the ManiDyn toolbox repository
3. Run `utils/CreateRobot.m` to generate robot models using ManiDyn
4. Open the desired control algorithm folder
5. Follow the README in each control folder for specific implementation details

## Contributing

This repository serves as a comprehensive reference for advanced robotic control algorithms. Contributions for additional control methods, improvements, or documentation are welcome.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

