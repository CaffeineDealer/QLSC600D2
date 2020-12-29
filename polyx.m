function [x y xhat yhat] = polyx(lb,ub,npoints,noise,varargin)
%% [output] = polyx(input)
% * *Function polyx* uses polyfit to fit polynomial function of degree 2 to a given input 
% * *System under study* is a noisy Quadratic function: y = f(x) + noise = 2x^2 -5x - 6 + noise
% * *Reference* MATLAB Documentation (in Command Window >> doc/help name_of_the_function)
%% Inputs
% * lb: min possible value
% * ub: max possible value
% * npoints: number of values
% * noise: Activate: 'on' & Deactivate: 'off'

%% Outputs
% * x: Input sample points
% * y: Output of f(x)
% * xhat: new input values
% * yhat: predicted output
% * Written by Yavar Korkian on Dec.13.2020
% * Last modified by Yavar Korkian on Dec.14.2020

%% Initial step: To activate or deactivate noise
% * *switch, case, otherwise general form*
%
%             switch switch_exp
%                case case_exp
%                   statements
%                case case_exp
%                   statements
%                ...
%                otherwise
%                   statements
%             end

switch noise
    case 'on'
        e = varargin{1}; % arbitrary epsilon value
    case 'off'
        e = 0;
end
%% Computation for equation y = f(x) + noise
x = unifrnd(lb,ub,[npoints 1]); % Generate uniformly distributed random numbers as sample points
f = @(x) (2*x.^2) - (5*x) - 6; % Quadratic function
y = f(x) + (e * randn(npoints,1)); % Output of your function
% Polynomial curve fitting function: to find coefficients for a given polynomial of a degree n (n = 2)
p = polyfit(x,y,2);
% Polynomial evaluation function: evaluates polynomial p @ each point in x
xhat = linspace(lb,ub,npoints); % define some new x-values 
yhat = polyval(p,xhat); % evaluate predicted output
%% Figures
figure;
scatter(x,y,40,'k','filled') % scatter(x-axis,y-axis,point-size,color,filled)
hold on
plot(xhat,yhat,'r','LineWidth',1)
grid on
legend({'Observation','Fitted'},'Location','NorthWest')
xlabel 'x'
ylabel 'y'
