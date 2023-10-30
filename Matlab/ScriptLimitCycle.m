%% frequency response:
% Estimate transfer function
s=tf('s'); 
data = iddata(ScopeData.signals.values(:,2),ScopeData.signals.values(:,1),0.005);
T=tfest(data,2,0)

Kp = 5

wn = sqrt(T.Denominator(3))
tau = 1/T.Denominator(2)
k = wn^2*tau/Kp

% Generate plots from recordings and simulated transfer function
s=tf('s');
G = k/(tau*s+1)/s % update the transfer function values
figure(1)
plot(ScopeData.time,ScopeData.signals.values(:,1))
hold on
plot(ScopeData.time,ScopeData.signals.values(:,2),'.','MarkerSize',7,'MarkerEdgeColor','r');
[y,t] = lsim(Kp*G/(1+Kp*G),ScopeData.signals.values(:,1),ScopeData.time);
plot(t,y,'k','LineWidth',1);
hold off
grid on
title('Frequency response')
legend Input ActualSystem Theoretical
xlabel Time[sec]
ylabel [Rad]
