#Vissarion Konidaris
#Randomised Algotithms Course
# 18/3/2017

function [Vector,Compares] = Quicksort(x)
  if numel(x)<=1
    Compares=0;
    Vector=x;
    return
  end
  pivot = randi(numel(x));
  Left=[];
  Right=[];
  for i=numel(x):-1:1
    if i~=pivot
      if x(i)<x(pivot)
        Left=[Left,x(i)];
      else
        Right=[Right,x(i)];
      end
    end
  end
  [Partition1,comps1] = Quicksort(Left);
  [Partition2,comps2] = Quicksort(Right);
  Compares = numel(x)-1+comps1+comps2;
  Vector = [Partition1,x(pivot),Partition2];
  return
endfunction