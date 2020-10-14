%initial conditions

T0=0;
Tf=25;
dT=0.1; % Time step

% for x=a: Px0=a, Py0=0, Vx0=v, Vy0=0;
% for y=b: Px0=0, Py0=b, Vx0=0, Vy0=v';
% for y=mx+c: (Px0,Py0)=(x0,y0), (Vx0,Vy0)=(v, mv);

Vx0 = 10;
Vy0 = 5;
Px0 = 0;
Py0 = 0;

n=(Tf-T0)/dT; % Number of iterations

% true values/ Initialisation
% True Velocity

Vx = Vx0;
Vy = Vy0;

% True Position
Px = zeros(n+1,1);
Py = zeros(n+1,1);
Px(1,1) = Px0;
Py(1,1) = Py0;

% True State
X_true = zeros(4,n+1);

X_true(:,1) = [Px(1,1); Py(1,1); Vx; Vy];

for i=2:1:n+1
    Px(i,1) = Px(i-1,1) + Vx * dT;
    Py(i,1) = Py(i-1,1) + Vy * dT;
    X_true(:,i) = [Px(i,1); Py(i,1); Vx; Vy];
end
% true values will be used to compare estimation efficiency later

% Required arrays

X_predicted = zeros(4,n+1); % state X(:,i) ith iteration
Z = zeros(4,n+1); % measurement
X_estimated = zeros(4,n+1); % estimated states

P_predicted = zeros(4,4,n+1); % covariance prediction
P_updated = zeros(4,4,n+1); % updated covariance

K_gain = zeros(4,4,n+1); %Kalman Gain

Q = zeros(4); % process noise covariance, zero for this problem
R = zeros(4); % measurement noise covariance
 
% KF parameters for given problem

%{
    function: x_dot = A * x;
    B=0; \implies tau=0;
    phi = expm (A*dT);  F here
%}

A = [0, 0, 1, 0;
     0, 0, 0, 1;
     0, 0, 0, 0;
     0, 0, 0, 0];

I = [1, 0, 0, 0;
     0, 1, 0, 0;
     0, 0, 1, 0;
     0, 0, 0, 1];
 
%{
     x(k/k-1) = F * x(k-1/k-1); prediction
     z(k) = Hx(k) + ν(k); measurement
%}
     
F = expm(A*dT); %function governing the mathematical model
H = I;  %matrix relating the measurements to the state to be estimated

%***
