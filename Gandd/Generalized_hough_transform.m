function [score, indexes, tempSize ] = hough_transform(Is,Itm,maxVals) 


if (nargin<2)
Itm=imread('itm.tif');
Is=imread('Is.tif');
end;

tempSize = size(Itm);

[y x]=find(Itm>0);
nvs=size(x);
if (nvs<1) disp('error no points find in in template in generalize hought transform, teriminating'); quit() ; end

%-------------------Define Yc and Xc ----------------------------------------------

Cy=1;
Cx=1;

GradientMap = gradient_direction( Itm );

MaxAngelsBins=30;
MaxPointsPerangel=nvs(1);

PointCounter=zeros(MaxAngelsBins);
Rtable=zeros(MaxAngelsBins,MaxPointsPerangel,2); 

for f=1:1:nvs(1)
    bin=round((GradientMap(y(f), x(f))/pi)*(MaxAngelsBins-1))+1; % transform from continues gradient angles to discrete angle bins and 
    PointCounter(bin)=PointCounter(bin)+1;% add one to the number of points in the bin
    if (PointCounter(bin)>MaxPointsPerangel)
        disp('exceed max bin in hugh transform');
    end;
    Rtable(bin, PointCounter(bin),1)= Cy-y(f);% add the vector from the point to the object center to the bin
    Rtable(bin, PointCounter(bin),2)= Cx-x(f);% add the vector from the point to the object center to the bin
end;


[y x]=find(Is>0);
np=size(x);

if (np<1) disp('error no points find in in edge image in generalize hought transform, teriminating'); quit() ; end;

GradientMap=gradient_direction(Is); % create gradient direction  map of the Is
Ss=size(Is); % Size of the main image Is
houghspace=zeros(size(Is));% the hough space assume to be in size of the image but it should probably be smaller
    for f=1:1:np(1)
          bin=round((GradientMap(y(f), x(f))/pi)*(MaxAngelsBins-1))+1; % transform from continues gradient angles to discrete angle bins and 

          for fb=1:1:PointCounter(bin)
              ty=Rtable(bin, fb,1)+ y(f);
              tx=Rtable(bin, fb,2)+ x(f);
               if (ty>0) && (ty<Ss(1)) && (tx>0) && (tx<Ss(2))  
                   houghspace(Rtable(bin, fb,1)+ y(f), Rtable(bin, fb,2)+ x(f))=  houghspace(Rtable(bin, fb,1)+ y(f), Rtable(bin, fb,2)+ x(f))+1; % add point in were the center of the image should be according to the pixel gradient
               end;        
          end;
    end;
    
Itr=houghspace;%./(sum(sum(Itm))); %
%Itr=Itr./sqrt(sum(sum(Itm)));% normalize

iterX=1;
[Ir,Ic] = size(Itr);
maxees = zeros(1,maxVals);
indexes = zeros(maxVals,2);
maxVar=0;

i_x=1;
j_x=1;

for temp=1:maxVals
	for i=1:Ir
		for j=1:Ic
			if(Itr(i,j)>maxVar)
				maxVar=Itr(i,j);
				i_x=i;
				j_x=j;
			end
		end
	end
	
	maxees(1,iterX)=maxVar;
	iterX=iterX+1;
	
	maxVar=0;
	Itr(i_x,j_x)=0;
	
	indexes(temp,1) = i_x;
	indexes(temp,2) = j_x;
	
	i_x=1;
	j_x=1;

end

indexes

%[y,x]=find(Itr==mx, 1, 'first');
%score=Itr(y,x); % find max score in the huogh space 

score = maxees

%-------------------------------------Mark  and display the best result on the system image (Optional Part demand addition function find2 and set2 given below)---------------------------------------------------------------------------
    %k =find2(Itm,1);
  %  mrk=set2(Is,k,255,y(1),x(1)); %paint the templa itm on the image Is
   % imshow(mrk);
  %pause();

end

