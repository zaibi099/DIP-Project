function [Ismarked,Iborders,Ybest,Xbest, ItmSize, BestScore]= find_Object_2(Is,Itm)

if ndims(Is)>=3
	Is=rgb2gray(Is);
end

Itm=logical(Itm);% make sure Itm is boolean image
BestScore=-100000;
close all;
imtool close all;
%%%%%%%%%%%%%%%%Some parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555555555
St=size(Itm);
Ss=size(Is);
SizeRatio=min(Ss(1)/St(1), Ss(2)/St(2)); % size ratio between the template Itm and image Is (minimum dimension)

Xbest=0;
Ybest=0;
tempSz =zeros(1,2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Main Scan  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------------Resize template Itm in each cycle and search for the template in the target image Is-----------------------------------------------------------------------------------------------------------------------
%Start by resizing the tempplate Itm to the max size that fit the image Is and then resize shrinked it in 
%Jumps of 0.5% and use hough/template match for every resized  version to the image
for Scale=100:-0.5:2   % Determine the size of the template Itm in each step of the loop in percetage (100 is original size)  
    disp([num2str(100-Scale) '% Scanned']); 
    Itr=Resize_binary_edge_image(Itm,SizeRatio*Scale/100); % resize the template line while maintianing it is binary close countour line image with thinkness of 1 pixel 
    St=size(Itr);% write the new size of resize template Itr
      if (St(1)*St(2)<400) break; end; %if the resize template contain less then 300 pixels it is to for practical matching and the loop is terminated
 %----------------------------------------------------------------------------------------------------------------------------------------- 
 % the actuall recogniton step of the resize template Itm in the orginal image Is and return location of best match and its score can occur in one of three modes given in search_mode
      [score,ind,tempSz ]=Gen_hough(Is,Itr,1);% use generalized hough transform to find the template in the image
     %--------------------------if the correct match score is better then previous best match write the paramter of the match as the new best match------------------------------------------------------
     if (score(1)>BestScore) % if item  result scored higher then the previous result
           BestScore=score(1);% remember best score
           Ybest=ind(1,2);% mark best location y
           Xbest=ind(1,1);% mark best location x
           ItmSize=size(Itr);
     end;
%-------------------------------mark best found location on image----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------        
end;

Ybest
Xbest

tr = tempSz(1,1);
tc = tempSz(1,2);

outi = zeros(size(Is));

outi(Xbest,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;
outi(Xbest+1,Ybest) = 255;

figure, imshow(outi,[]),title('Out');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%output%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%show   best match optional part can be removed %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%BestScore
%if BestScore>-100000% Display best match
%      Itr=Resize_binary_edge_image(Itm,ItmSize(1),ItmSize(2));
%            [yy,xx] =find(Itr);
%             Ismarked=set2(Is,[yy,xx],255,Ybest,Xbest);%Mark best match on image
%            imshow(Ismarked);
%            Iborders=logical(zeros(size(Is)));
%       Iborders=set2(Iborders,[yy,xx],1,Ybest,Xbest);
%else % if no match 
%   disp('Error no match founded');
%    Ismarked=0;% assign arbitary value to avoid 
%       Iborders=0;
%       Iborders=0;
%       
%end;

end
