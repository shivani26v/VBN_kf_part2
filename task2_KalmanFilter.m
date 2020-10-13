% Initialisation

X_estimated(:,1) = X_true(:,1);
P_updated(:,:,1) = 10*R; % randomly assumed for now

%kalman filter

for k=2:1:n+1

    % Prediction
    X_predicted(:,k) = F * X_estimated(:,k-1); %state prediction
    P_predicted(:,:,k) = F * P_updated(:,:,k-1) * inv(F) + Q; %covariance prediction

    % Measurement Update
    K_gain(:,:,k) = P_predicted(:,:,k) * transpose(H) * inv(H * P_predicted(:,:,k) * transpose(H) + R); %Kalman Gain
    X_estimated(:,k) = X_predicted(:,k) + K_gain(:,:,k) * (Z(:,k) - H * X_predicted(:,k)); %state Estimation
    P_updated(:,:,k) = (I - K_gain(:,:,k) * H) * P_predicted(:,:,k); %Covariance Update

end
%kalman filter end

% True vs Estimated Position plots
plot(X_true(1,:));
hold on;
plot(X_true(2,:));
plot(X_estimated(1,:));
plot(X_estimated(2,:));

hold off;
%***