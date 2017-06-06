#Vissarion Konidaris
#Randomised Algotithms Course
# 21/5/2017

clc;
clear;
clc;

# Calculating the number of empty bins

NumberOfBins=365;
Balls=200;

NumberOfExperiments=10000;
EmptyBins(1:1,1:NumberOfExperiments)=NumberOfBins;
Experiments=linspace(1,NumberOfExperiments,NumberOfExperiments);

# Starting the experiments
for i=1:NumberOfExperiments 
  # Empty the bins for the experiment.
  Bins=zeros(1,NumberOfBins); 
  for j=1:Balls
    # Throw the ball randomly into a bin.
    index=randi(NumberOfBins);
    # If the bin was empty before, reduce the number of empty bins
    if Bins(index)==0
      EmptyBins(i)=EmptyBins(i)-1;
    end
    Bins(index)=Bins(index)+1;
  end
end

disp(sprintf('Expected number of empty bins = %f',sum(EmptyBins)/NumberOfExperiments));

# Plotting the histogram
figure();
hist(EmptyBins,length(Experiments)/100);
title('Histogram of Empty Bins in Balls & Bins problem over 10000 experiments');
xlabel('Number of Empty Bins');
ylabel('Number of experiments');