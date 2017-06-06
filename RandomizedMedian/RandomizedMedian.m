#Vissarion Konidaris
#Randomized Algorithms Course
# 18/3/2017

function [median,Compares] = RandomizedMedian(S)
    R=[];
    n=numel(S);
    for i=1:ceil(n^(3/4))
        R=[R S(randi(n))];
    end
    Compares=0;
    [RC,Compares]=Quicksort(R,Compares);
    d=RC(floor((n^(3/4))/2-sqrt(n))+1);
    u=RC(ceil((n^(3/4))/2+sqrt(n))+1);
    ld=0;
    lu=0;
    C=[];
    for index=1:n
        if S(index)<d
            Compares = Compares + 1;
            ld=ld+1;
        elseif S(index)<=u
            Compares = Compares + 2;
            C=[C S(index)];
        else
            Compares = Compares + 2;
            lu=lu+1;
        end
    end
    if ld>n/2 || lu>n/2 || numel(C)>4*n^(3/4)
        median=NaN;
    else
        comps=0;
        [SC,comps]= Quicksort(C,comps);
        Compares = Compares + comps;
        median=SC(ceil(n/2) - ld);
    end
    return
end
