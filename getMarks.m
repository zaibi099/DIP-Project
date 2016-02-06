function getMarks(image,namez);

im = imread(image);
if ndims(im)>=3
	im = rgb2gray(im);
end

[origRow,origCol] = size(im);

new_im = im;

edgi = edge(im,'prewitt',[],'horizontal');

[H,theta,rho] = hough(edgi);
P = houghpeaks( H,7,'threshold', ceil( 0.3*max( H(:) ) ) );

x = theta(P(:,2));
y = rho(P(:,1));

lines = houghlines(edgi,theta,rho,P,'FillGap',5,'MinLength',10);

[rr,cc] = size(edgi);
vect = zeros(cc,2);

lin=0;
max_len = 0;

row=[1 length(lines)];
row(:,:) = rr+1;

for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');				%= for line
   
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

temp = min(row(1,:));
mini =max(row(1,:));

totalLiness = length(lines);
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

finRow;

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

last_row = max(row(1,:));
start = last_row-290;
last_row = last_row+30;

Matcols = origCol-100;
start_coli=100;

marks = zeros(320,Matcols-start_coli);

[marksRows,marksCols] = size(marks)
start;
last_row;

u=1;
v=1;

for i=start:last_row
	for j=start_coli:Matcols
		marks(u,v) = im(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

close all
figure, imshow(marks,[]) , title('Marks');
edgi = edge(marks,'prewitt',[],'both');
imwrite(marks,gray(255),namez);
