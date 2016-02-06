function tot(image);

im = imread(image);
if ndims(im)>=3
	im = rgb2gray(im);
end

[origRow,origCol] = size(im);

%figure, imshow(im) , title('Original');
%im = imrotate(im,33,'crop');
new_im = im;
%{

[r,c] = size(im);
new_r = r;
new_c = c/3;

new_im = zeros(new_r,new_c);

for i=1:new_r
	for j=1:new_c
		new_im(i,j) = im(i,j);
	end
end

%}

%im = imrotate(im,33,'crop');
%imshow(new_im,[]),title('Ustaad');
edgi = edge(im,'prewitt',[],'horizontal');
edgi = imsharpen(double(edgi));
%figure, imshow(edgi);

[H,theta,rho] = hough(edgi);
P = houghpeaks( H,7,'threshold', ceil( 0.3*max( H(:) ) ) );

x = theta(P(:,2));
y = rho(P(:,1));
%plot(x,y,'s','color','black');

lines = houghlines(edgi,theta,rho,P,'FillGap',5,'MinLength',10);

figure, imshow(im), hold on

[rr,cc] = size(edgi);
vect = zeros(cc,2);

lin=0;
max_len = 0;

row=[1 length(lines)];
row(:,:) = rr+1;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
   
   row(1,k) = xy(2,2);
   % Plot beginnings and ends of lines
   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end

%highlight the longest line segment
plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');
%figure, imshow(im) , title('Outiiii');

%results = ocr(im);
% Display one of the recognized words
%word = results.Text

temp = min(row(1,:))
mini =max(row(1,:))

totalLiness = length(lines)
finRow=0;

if(temp<= (300))
	for i=1:totalLiness
		if( (row(1,i) < mini) & row(1,i) >300 )
			finRow = row(1,i);
			mini = row(1,i);
		end
	end
else
	finRow = temp;
end

finRow

nim = zeros(240,cc);
start = finRow-120;
endi = finRow+120;

irow=1;
icol=1;

if(start<0)
	start = -1*(start);
end

if(endi<0)
	endi = -1*(endi);
end

for i=start:endi
	for j=1:cc
			nim(irow,icol) = im(i,j);
			icol=icol+1;
	end
	irow=irow+1;
	icol=1;
end

edgi = edge(nim,'prewitt',[],'both');
%figure , imshow(edgi,[]) , title('Edgee Image');
%imwrite(double(edgi),'nameBar.png');
figure, imshow(nim,[]) , title('Name_place');
