#Vissarion Konidaris
#Randomised Algotithms Course
# 18/3/2017

clc;
clear;
clc;

n=1000; % number of verticies
% the prob. of choosing each one of the n*(n-1)/2 possible edges
p=40*log(n)/n; 
if p<=0.2
  disp(p);
  p=0.2;
end
Gnp = zeros(n,n-1); % Initializing the random graph

%% creating the random graph %%
for i=1:n-1
  for j=i:n-1
    if rand()>1-p
      if j<i 
        Gnp(i,j)=j;
        Gnp(j,i)=i;
      else
        Gnp(i,j)=j+1;
        Gnp(j+1,i)=i;
      end
    end
  end
end

Path=[]; % Initializing the path
RndGraph={}; % Initializing the unused lists of Gnp graph
% Matrix indicating the number of adjacent used edges 
% and the number of adjacent edges of each vertex
Used=zeros(n,2);

%% Creating the unused lists for each vertex %% 
for i=1:n
  list={};
  for j=1:n-1
    if Gnp(i,j)~=0
      if rand()>1-p/2
        list{numel(list)+1}=[Gnp(i,j),0];
      end
    end
  end
  RndGraph{i}=list;
  Used(i,2)=numel(list);
end

hitbox=zeros(2,n);
forward=1;
PathFindingEpoch=0;
FAIL=0;

head=randi(n);
Path=[Path head];
hitbox(1,head)=1;
hitbox(2,head)=1;
verticies=1;

% Create the Hamiltonian Path.
while 1
  
  % Increment epoch.
  PathFindingEpoch=PathFindingEpoch+1;
  
  sample=rand();
  
  if sample<=1/n
  
    forward=not(forward);
    if forward
      head=Path(verticies);
    else
      head=Path(1);
    end
    
  elseif sample<=1-Used(head,1)/n %  Choose unused edge.
  
    % Check for failure.
    % The algorithm fails if the number of used edges. 
    % Is equal to the number of adjacent edges.
    if Used(head,1)==Used(head,2)
      FAIL=1;
      break;
    end
    
    % Select an unused edge un. at rand.
    index=ceil(rand()*(Used(head,2)-Used(head,1))+Used(head,1));
    Node=RndGraph{head}{index}(1); % Select the vertex.
    RndGraph{head}{index}(2)=1; % Declare edge as used.
    
    % Rearange the head list so the used edges are infont.
    if index~=1
      if index==length(RndGraph{head})
        RndGraph{head}=RndGraph{head}([index 1:index-1]);
      else
        RndGraph{head}=RndGraph{head}([index 1:index-1 index+1:end]);
      end
    end
    % Increment number of used edges of head.
    Used(head,1)=Used(head,1)+1;
    
    % Check if its in the path.
    if hitbox(1,Node)==0 % If it is not in the path, insert it.
      if forward
        hitbox(2,Node)=verticies+1;
        Path=[Path Node];
        head=Path(verticies+1);
      else
        hitbox(2,Node)=1;
        for i=1:n
          if hitbox(1,i)~=0 && i~=Node
            hitbox(2,i)=hitbox(2,i)+1;
          end
        end
        Path=[Node Path];
        head=Path(1);
      end
      hitbox(1,Node)=1;
      verticies=verticies+1;
    else % It's in path. So we can rotate.
      % So we rotate.
      if forward
        if Node~=Path(verticies-1) %Rotating from behind.
          index=hitbox(2,Node);
          hitbox(2,Path(index+1:verticies))=(verticies:-1:index+1);
          Path(index+1:verticies)=Path(verticies:-1:index+1);
          head=Path(verticies);
        end
      else
        if Node~=Path(2) % Rotating from infront.
          index=hitbox(2,Node);
          hitbox(2,Path(1:index-1))=(index-1:-1:1);
          Path(1:index-1)=Path(index-1:-1:1);
          head = Path(1);
        end
      end
    end
    
  else % A used edge where choosen.
    
    # Choose a random used edge of head.
    edge = RndGraph{head}{randi(Used(head,1))}(1);
    % It is definately in the Path, so we rotate.
    if forward
      if edge~=Path(verticies-1) %Rotating from behind.
        index=hitbox(2,edge);
        hitbox(2,Path(index+1:verticies))=(verticies:-1:index+1);
        Path(index+1:verticies)=Path(verticies:-1:index+1);
        head=Path(verticies);
      end
    else
      if edge~=Path(2) % Rotating from infront.
        index=hitbox(2,edge);
        hitbox(2,Path(1:index-1))=(index-1:-1:1);
        Path(1:index-1)=Path(index-1:-1:1);
        head=Path(1);
      end
    end
    
  end
  
  if verticies==n % the Hamiltonian path was succesfully created.
    break;
  end
  
  % Check for failure
  % The alg fails if it takes more than 2nlog(n) epochs
  if PathFindingEpoch==2*n*log(n)
    FAIL==1;
    break;
  end
  
end

disp('Epochs for Ham Path');
disp(PathFindingEpoch);
disp('2nlog(n)');
disp(2*n*log(n));

% BoubleCheck for failure.
% This section was not neccesery.

if FAIL==1
  disp('The algorithm failed.');
  if PathFindingEpoch == 2*n*log(n)
    disp('The alg failed in finding a Hamilt. Too many epochs.');
  end
else
  verticies=0;
  for i=1:n
    if hitbox(i=1,i)==0
      FAIL=1;
      break;
    end
    verticies=verticies+1;
  end
  if FAIL~=1 && verticies==n && length(Path)==n
    for i=1:length(Path)
      for j=1:length(Path)
        if i~=j
          if Path(i)==Path(j)
            disp('Something went wrong!');
            FAIL=1;
            break;
          end
        end
      end
    end
    if FAIL~=1
      disp('');
      disp('Found a Hamilt Path in under than 2nln/n epochs.');
    end
  else
    disp('Something went wrong!');
  end 
end

% Close the Hamiltonian Path if the 
% first part of the algorithm was succesfull.
if FAIL~=1

  disp('');
  PathClosingEpoch=0;
  while 1
    
    % Increment epoch.
    PathClosingEpoch=PathClosingEpoch+1;
    
    sample=rand();
    
    if sample<=1/n
    
      forward=not(forward);
      if forward
        head=Path(n);
      else
        head=Path(1);
      end
      
    elseif sample<=1-Used(head,1)/n % An unused edge where choosen.
    
      % Check for failure.
      if Used(head,1)==Used(head,2)
        FAIL=1;
        break;
      end
      
      % Select an unused edge un. at rand.
      index=ceil(rand()*(Used(head,2)-Used(head,1))+Used(head,1)); 
      Node=RndGraph{head}{index}(1); % Select the vertex.
      RndGraph{head}{index}(2)=1; % Declare edge as used.
      
      % Rearange the head list so the used edges are infont.
      if index~=1
        if index==length(RndGraph{head})
         RndGraph{head}=RndGraph{head}([index 1:index-1]);
        else
         RndGraph{head}=RndGraph{head}([index 1:index-1 index+1:end]);
        end
      end
      % Increment number of used edges of head.
      Used(head,1)=Used(head,1)+1; 
      
      % Check if the Path closes. If not we rotate.
      if forward
        if Node==Path(1)
          disp('Closing the Path.');
          break;
        end;
        if Node~=Path(verticies-1) %Rotating from behind.
          index=hitbox(2,Node);
          hitbox(2,Path(index+1:verticies))=(verticies:-1:index+1);
          Path(index+1:verticies)=Path(verticies:-1:index+1);
          head=Path(verticies);
        end
      else
        if Node==Path(n)
          disp('Closing the Path.');
          break;
        end;
        if Node~=Path(2) % Rotating from infront.
          index=hitbox(2,Node);
          hitbox(2,Path(1:index-1))=(index-1:-1:1);
          Path(1:index-1)=Path(index-1:-1:1);
          head=Path(1);
        end
      end
      
    else % A used edge where choosen.
      
      % Choose a random used edge of head.
      edge=RndGraph{head}{randi(Used(head,1))}(1);
      % Check if the Path closes. If not we rotate.
      if forward
        if Node==Path(1)
          disp('Closing the Path.');
          break;
        end;
        if edge~=Path(verticies-1) %Rotating from behind.
          index=hitbox(2,edge);
          hitbox(2,Path(index+1:verticies))=(verticies:-1:index+1);
          Path(index+1:verticies)=Path(verticies:-1:index+1);
          head=Path(verticies);
        end
      else
        if Node==Path(n)
          disp('Closing the Path.');
          break;
        end;
        if edge~=Path(2) % Rotating from infront.
          index=hitbox(2,edge);
          hitbox(2,Path(1:index-1))=(index-1:-1:1);
          Path(1:index-1)=Path(index-1:-1:1);
          head=Path(1);
        end
      end
      
    end
  
    if PathClosingEpoch==n*log(n)
      FAIL=1;
      break;
    end
 
  end
  
  disp('');
  disp('Epochs for closing the path');
  disp(PathClosingEpoch);
  disp('nlog(n)');
  disp(n*log(n));
    
  if FAIL~=1
    disp('Closed the Path in less than nlogn epochs.');
    disp('');
    disp('Found a Hamilt. Cycle in less than 3nlog(n) epochs.');
    disp('Total number of epochs');
    disp(PathFindingEpoch+PathClosingEpoch);
  else
    disp('The alg failed in closing the Hamilt. Path.');
    if PathClosingEpoch==n*log(n)
      disp('Failed in closing the Hamilt. Path. Too many epochs.');
    end
  end
  
end


