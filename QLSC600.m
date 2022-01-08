%% Welcome To MATLAB Tutorial
% * *Computational Neuroscience MATLAB Bootcamp winter 2022 @McGill University
% * *Contact Info* yavar.korkian@gmail.com
% * *Zoom Office Hours Every Monday @ 9-10 AM (ET)
% * *Reference* MATLAB Documentation (in Command Window >> doc/help name_of_the_function)
% * *Version* MATLAB 2016b
%% MATLAB Environment
% * *Command Window*    Execute any command here one line at a time!
% * *Editor*            You can write your script in an Editor, save & execute it!
% * *Workspace*         Access & Inspect all variables created by the user and loaded into memory!
% * *Current Folder*    Files that are located in the current directory!
% * *Path*              Where MATLAB searches for files & scripts!
%% Editorial Board 
% * *%%*                            Creates a section in your script that helps running the sections individually
% * *%*                             To make comments. Here are shortcuts for commenting & uncommenting: 
%
%                                                       Windows users: comment(Ctrl+R) / uncomment(Ctrl+T)
%                                                       macOS users: comment(Cmd+/) / uncomment(Cmd+T)
%
% * *Semicolon ;*                   Without it at the end of each line you print the output to the Command Window   
% * *Square brackets []*            Creat arrays and matrices, define rows with semicolon and columns with comma
% * *Parentheses/brackets ()*       Input to the functions go in here 
%% Usefull commands to start your scripts with

% clears all the variable from your Workspace
clear all 
% clears cache
clear cache 
% closes all the figures that are open
close all 
% clears Command Window
clc 
%% Import .mat files to Workspace
% * *Function: load([Path2Data filename.mat])*

%  Locate the folder that contains data files
dataPath = 'E:\Courses\TA4QLSC600D2\';
%  Improt .mat file to MATLAB
load([dataPath 'data.mat'])
%% Common functions and Operations
% * *Multiplication/division between a scaler & vector*
mltp1 = S1 * 10;
div1 = S1 / 10;
%%
% * *Elementwise multiplication/division (vector X vector or vector X matrix)*
mltp2 = S1 .* S2;
div2 = S1 ./ S2;
%%
% * *length and size of a matrix*
length_S1 = length(S1);
[row column] = size(S1);
% row = size(S1,1);
% column = size(S1,2);
%%
% * *Generate linearly spaced vector*
t = linspace(0,1,size(S1,1));
%% 
% * *Mean, Maximum, & Minimum*
mean_S1 = mean(S1);
max_S1 = max(S1);
min_S1 = min(S1);
%% For Loop and IF statement
% * *For Loop general form*
%
%             for idx
%                 statements
%             end
%
% * *IF statement general form*
%
%             if exp
%                statements    
%             elseif exp
%                statements
%             else
%                statements
%             end

% generate matrix of zeros of size n * m
moon = zeros(20,10); 
counter = 0;
for i = 1:1:size(moon,1)
    for j = 1:size(moon,2)
        if mod(j,2) == 0 
            moon(i,j) = i / j;
        elseif mod(j,2) == 1
            moon(i,j) = i / (-j);
        else
            disp('I have got nothing for you :)')
            break
        end
    end
    counter = counter + i;
end
%% Figures: Plots & Scatter Plots:     
% * *Plot: plot(x-axis-val,y-axis-val)*

figure; % This pops out an empty figure
plot(t,S1,'Color','k','LineWidth',0.5)
hold on; % to print to plots on a same figure
plot(t,S2,'Color','r','LineWidth',0.5)
grid on; % Use grid off to turn it off (default) 
legend({'Control','Test'},'Location','NorthEast') % Add legend to your figure 
title 'Neural Activity of Neuron I'
xlabel 'Time (sec)'
ylabel 'Amplitude (mv)'
%% 
% * *Scatter Plot: scatter(x-axis-val,y-axis-val)*
figure;
scatter(S1,S2,'MarkerEdgeColor','g','MarkerFaceColor','b')
title 'Control vs. Test'
xlabel 'Control'
ylabel 'Test'
%% Figure with multiple subplots
% * *subplot(#row,#column,grid#)*
figure;
subplot(2,2,1)
plot(t,S1,'Color','k','LineWidth',0.5)
xlabel 'Time (sec)'
ylabel 'Amplitude (mv)'
subplot(2,2,2)
plot(t,S2,'Color','r','LineWidth',0.5)
subplot(2,2,3)
scatter(S1,S2,'MarkerEdgeColor','g','MarkerFaceColor','b')
xlabel 'Control'
ylabel 'Test'
subplot(2,2,4)
scatter(S2,S1,'MarkerEdgeColor','r','MarkerFaceColor','k')
suptitle 'Summary of Results' % Adds general title to the figure
%% Heatmaps & Spectrograms:
% * *imagesc(2D matrix of size m*n)*
noise = rand(100,100,6); % generate a random 3D matrix 
figure;
for i = 1:size(noise,3)
    subplot(3,2,i)
    imagesc(squeeze(noise(:,:,i))) % plot heatmap or spectrogram
    set(gca,'YDir','Normal')
    % squeeze: remove dimensions of length = 1
end
%% Linear Regression
% * *mldivid or "\" function*
% * *Predictive model* that measures relationship between two variables (one independent & the other dependent) by fitting a linear equation. 
% * *Minimizing the distance* between the fitting line & each data point to find an optimal fit
% * *Solve Systems* of linear equations HX = Y for H (eg. X = X\Y) 

% Generate two linear random variables with some noise
samples = linspace(1,100,100)';
a = randn(size(samples,1),1);
b = randn(size(samples,1),1);
X = samples * 0.2 + a;
Y = samples * 0.2 + b;
H = X\Y; % Slope, regression coefficients, solution to the linear system
Yestimated = H * X;

figure
scatter(X,Y,40,'g','filled')
hold on
plot(X,Yestimated,'k','LineWidth',2)
title 'Linear Regression Relation X vs. Y'
legend({'Actual','Estimated'},'Location','NorthWest')
xlabel 'X'
ylabel 'Y'
%% Function & Polyfit
% * *function [y1,...,yN] = myfun(x1,...,xM)*
% * This is an important introduction to how to declare a function in MATLAB and call it in scripts
% * Often using custom-defined functions can boost the performance of your scripts and make it easier to troubleshoot
% * eg. custom-written function polyx uses polyfit & polyval built-in functions to fit a polynomial of degree n = 2 to a given dataset

% Inputs to the function polyx
lowerband = -1;
upperband = 5;
numpoints = 100;
noise = 'on';
% Call polyx function
[x y xhat yhat] = polyx(lowerband,upperband,numpoints,noise,0.3);
