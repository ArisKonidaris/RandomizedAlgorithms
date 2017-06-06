#Vissarion Konidaris
#Randomized Algorithms Course
# 18/3/2017

clc;
clear;
clc;

start=40; % starting n of experiment
finish=1000; % last n of experiment
numOfExperiments=10; % number of experiments
experiments=linspace(start,finish,numOfExperiments);
QuickComps=[]; % the compares of Quicksort
RandMedComps=[]; % the compares of Rand. Med. Alg.
QuickMedians=[]; % Medians of  Quicksort
RandMedians=[]; % Medians of  Rand. Med. Alg.
FAILS=0; % count the number of failures

for i=1:numel(experiments)
  % create a random row vector of integers in range [1 10000]
  list=randi(10000,1,floor(experiments(i)));
  compares=0;
  compares2=0;

  [newList,compares]=Quicksort(list,compares);
  [Median,compares2]=RandomizedMedian(list,compares2);
  
  QuickComps = [QuickComps compares];
  RandMedComps = [RandMedComps compares2];
  
  QuickMedians = [QuickMedians newList(ceil(numel(newList)/2))];
  
  % Check if RandomizedMedian has failed
  if isnan(Median)
    FAILS=FAILS+1;
    RandMedians = [RandMedians -1];
  else
    RandMedians = [RandMedians Median];
  end
  
end

disp(FAILS); % Displaythe number of failures

figure(1); % plot
plot(experiments,QuickComps,experiments,RandMedComps);
legend('QuickSort Median Compares','Randomized Median Compares');
title('Compares of Quicksort and Randomized Median with respect to n');
xlabel('n');
ylabel('Compares');

% medians found in each experiment  
figure(2);
subplot(2,1,1); % add first plot in 2 x 1 grid
plot(experiments,QuickMedians,'g');
title('Medians of Quicksort');
xlabel('n');
ylabel('Medians');

subplot(2,1,2); % add second plot in 2 x 1 grid
plot(experiments,RandMedians,'b'); 
title('Medians of Radomized Median');
xlabel('n');
ylabel('Medians');
