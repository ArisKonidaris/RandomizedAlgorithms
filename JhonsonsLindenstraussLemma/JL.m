#Vissarion Konidaris
#Randomised Algotithms Course
# 20/5/2017

clc;
clear;
clc;

N=100000; # Number of dimensions/features.

data=100; # Number of data points.

# Number used for computing the range
# of values of each dimension/feature.
limit=100;

epsilon=0.1; # Margin of error

# The random matrix Q
# constructed by rand vectors of N dimensions.
Q=zeros(N,data);

# Creating the random high-dimensional dataset Q
bounds=linspace(-limit,limit,2*limit+1);
for i=1:N #for each dimension.
  # the range [lower_bound,upper_bound] of  
  # this dimension is calculated first.
  lower_bound=bounds(randi(2*limit+1));
  while 1
    upper_bound=bounds(randi(2*limit+1));
    if lower_bound~=upper_bound
      if lower_bound>upper_bound
        [lower_bound,upper_bound] = deal(upper_bound,lower_bound);
      end
      break;
    end
  end
  # Random calculation the value of this
  # dimension for every data point.
  for j=1:data
    Q(i,j)=(upper_bound-lower_bound)*rand()+lower_bound;
  end
end

# Number of low dimensions
n=ceil(24*log(data)/(epsilon^2));
disp(sprintf('Reducing to %d dimensions.',n));

# Count the number of failures
tries=0;
U=zeros(n,data);
while 1

  #calculating F line by line and computing U iteratively
  for i=1:n
    U(i,:)=((1/sqrt(n))*randn(1,N))*Q;
  end
  
  # Check for the preservation of the
  # pairwise Euclidean distances of the dataset
  FAIL=0;
  for i=1:data-1
    for j=i+1:data
      HighDimDistance=sum((Q(:,i)-Q(:,j)).^2);
      LowDimDistance=sum((U(:,i)-U(:,j)).^2);
      if (1-epsilon)*HighDimDistance>LowDimDistance || (1+epsilon)*HighDimDistance<LowDimDistance
        FAIL=1;
        break;
      end
    end
    if FAIL==1
      break;
    end
  end
  
  tries=tries+1;
  if FAIL==0
    break;
  end

end

disp(sprintf('Succeded after %d tries.',tries));


















