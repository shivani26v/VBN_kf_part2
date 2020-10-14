
% measurement model
% all errors are random and introduced linearly
% all state parameters are measured independent of each other

% variance
sigma_Px = 10; %can assume any value for now
sigma_Py = 10;
sigma_Vx = 10;
sigma_Vy = 10;

% measurement errors
v_Px = normrnd (0, sigma_Px, [1, n+1]);
v_Py = normrnd (0, sigma_Py, [1, n+1]);
v_Vx = normrnd (0, sigma_Vx, [1, n+1]);
v_Vy = normrnd (0, sigma_Vy, [1, n+1]);

v = zeros(4,n); %error vector

for i=1:1:n+1
   v(:,i) = [v_Px(i); v_Py(i); v_Vx(i); v_Vy(i)];
   Z(:,i) = X_true(:,i) + v(:,i);
end

% measurement noise covariance R
for i=1:1:4
    R(i,i) = var(Z(i,:) - X_true(i,:));
end

% position measurement plot
plot(Z(1,:));
hold on;
plot(Z(2,:));

%***
