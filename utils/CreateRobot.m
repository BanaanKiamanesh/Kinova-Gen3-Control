clear
close all
clc
warning off

%% Create Robot Description and Meshed Using MATLAB Robotics Toolbox
disp(' ---> Generating Robot Description Files...')
KG3 = loadrobot("kinovaGen3");
KG3.DataFormat = 'column';

exportrobot(KG3, ...
            OutputFileName = "KinovaGen3.urdf", ...
            ExportMesh = true);

%% Create Robot Dynamical/Kinematic Model Using ManiDyn Tool-Box
% ManiDyn can be found at: https://github.com/BanaanKiamanesh/ManiDyn/
% Classical DH parameters (Kinova Gen3, 7-DoF)
% Source: Kinova Gen3 User Guide, Table 94 – "7 DoF spherical Classical DH parameters"

% Column Order:  a | alpha |  d | theta
dh = [0,   pi, -0.2848,   0   % Joint 1 – Actuator 1
      0, pi/2, -0.0118,  pi   % Joint 2
      0, pi/2, -0.4208,  pi   % Joint 3
      0, pi/2, -0.0128,  pi   % Joint 4
      0, pi/2, -0.3143,  pi   % Joint 5
      0, pi/2,  0.0000,  pi   % Joint 6
      0,   pi, -0.1674,  pi]; % Joint 7  - Interface

type = 'rrrrrrr';

% Build DHStruct 
DH = DHStruct('alpha', dh(:, 2), 'a', dh(:, 1), 'd', dh(:, 3), ...
              'theta', dh(:, 4), 'type', type);

% Dynamic Parameters Taken from URDF
M = [2.009, 1.106, 1.106, 0.895, 0.654, 0.654, 0.31408]; 

COM = [-2.289e-5,  -0.010511,  -0.075159   % Shoulder
       -2.782e-5,  -0.097298,  -0.012693   % Half Arm 1
        2.981e-5, -0.0062391,  -0.115520   % Half Arm 2
       -1.102e-5,  -0.075357,  -0.014085   % Fore Arm
         -3.3e-7,  -0.009617,  -0.062968   % Wrist 1
         -3.4e-7,  -0.044043, -0.0097804   % Wrist 2
       -2.788e-5, -0.0052162,  -0.022692]; % Bracelet

% pre-allocate inertia tensors
I = cell(7, 1);
I{1} = [ 0.0045081, -8.6e-7, -1.90e-6; -8.6e-7,  0.0047695, -4.5534e-4; -1.90e-6, -4.5534e-4,   0.0013903];
I{2} = [ 0.0089168, -2.9e-6,  -1.7e-7; -2.9e-6, 0.00073106,  5.1768e-4;  -1.7e-7,  5.1768e-4,   0.0090416];
I{3} = [ 0.0088707,  2.3e-7, -3.32e-6;  2.3e-7,  0.0090034, -5.0415e-4; -3.32e-6, -5.0415e-4,  0.00071859];
I{4} = [ 0.0067339,  7.0e-7,  -2.0e-8;  7.0e-7, 0.00045088,  3.8999e-4;  -2.0e-8,  3.8999e-4,   0.0068613];
I{5} = [ 0.0013311,       0,        0;       0,  0.0013282, -2.2936e-4;        0, -2.2936e-4,  0.00030696];
I{6} = [ 0.0013422,       0,        0;       0, 0.00031025,  2.3506e-4;        0,  2.3506e-4,   0.0013360];
I{7} = [0.00022640, -4.9e-7,  -2.6e-7; -4.9e-7, 0.00015697,  -4.561e-5;  -2.6e-7,  -4.561e-5,  0.00025981];

% Build DynStruct
DynPar = DynStruct('Mass',   M, 'Inertia', I, ...
                    'COM', COM,      'DH', DH);


% Create the Kinematics and Dynamics Obj
Kin = ManipulatorKinematics(DH);
Dyn = ManipulatorDynamics(DynPar);

% Generate Files
disp(' ---> Generating Kinematical Functions...')
Kin.Jacobian   ('Generate', 'mex', 'File', 'Gen3Jac');
Kin.CalculateFK('Generate', 'mex', 'File',  'Gen3FK');

disp(' ---> Generating Dynamical Functions...')
Dyn.ODEFunction('Generate', 'mex', 'File', 'Gen3ODEFun');

disp(' ---> Done Generating ..!')
