function find_Object(origImage,Is,Itm,totQuestions)

BestScore=-100000;

si = size(Is);
outi = zeros(si);
[score, ind ,tempSize ]=hough_transform(Is,Itm,totQuestions);

totalScores = size(score,2);
tr = tempSize(1,1);
tc = tempSize(1,2);

tImage = zeros(tr,tc);


%  == TO MAKE THEM IN ORDER

doneMat = [1 totalScores];
maxVal = max(ind(:,2))+100;

ind(:,2)

polka = 1;
for i=1:totalScores	
	[minVal in] = min(ind(:,2));
	minVal;
	var = in
	
%================================

	BestScore=score(var);% remember best score
	Ybest=ind(var,2);% mark best location y
	Xbest=ind(var,1);% mark best location x
	ind(in(1,1),2);
	ind(in(1,1),2)=maxVal;
	ItmSize=size(Itm);

	%Xbest
	%Ybest
	
	endR = si(1,1)-20;
	startR = Xbest + 50;

	endC = Ybest + 120;
	startC = Ybest - 40;

	u=1;
	v=1;

	for i=startR:endR
		for j=startC:endC
			tImage(u,v) = Is(i,j);
			v=v+1;
		end
		v=1;
		u=u+1;
	end

	%tImage = imsharpen(tImage);
	tImage = imdilate(tImage,[1 1 1;1 1 1;1 1 1]);
	%edgi = imdilate(edgi,[1 1 1;1 1 1;1 1 1]);
	%tImage= imerode(tImage,[0 1 0;0 0 0;0 1 0]);
	subplot(1,7,polka), imshow(tImage,[]);
	
	outi(Xbest,Ybest)=255;
	outi(Xbest+1,Ybest)=255;
	outi(Xbest+2,Ybest)=255;
	outi(Xbest+3,Ybest)=255;
	
	
	formatSpec = 'mr_%d.jpg';
	str = sprintf(formatSpec,polka);
	imwrite(tImage,str);
	polka = polka+1;
	
	%{

	BestScore
	if BestScore>-100000% Display best match
		Itr=Resize_binary_edge_image(Itm,ItmSize(1),ItmSize(2));
		[yy,xx] =find(Itm);
		Ismarked=set2(Is,[yy,xx],255,Ybest,Xbest);%Mark best match on image
		imshow(Ismarked);
		Iborders=logical(zeros(size(Is)));
		Iborders=set2(Iborders,[yy,xx],1,Ybest,Xbest);
	else % if no match 
		disp('Error no match founded');
		Ismarked=0;% assign arbitary value to avoid 
		Iborders=0;
		Iborders=0;    
	end
	
	%}








end



%}




















%{
Xbest
Ybest

endR = Xbest + floor(tr/2)
startR = Xbest - floor(tr/2)

endC = Ybest + floor(tc/2)
startC = Ybest - floor(tc/2)

u=1;
v=1;

for i=startR:endR+floor(tr/2)
	for j=startC:endC+floor(tc/2)
		tImage(u,v) = Is(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

figure, imshow(tImage,[]);

%}

%figure, imshow(outi,[]);
impixelinfo;
