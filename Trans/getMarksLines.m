function getMarksLines(image,namz);

im = imread(image);
if ndims(im)>=3
	im = rgb2gray(im);
end

[origRow,origCol] = size(im);

edgi = edge(im,'prewitt',[],'Horizontal');
edgi = imdilate(edgi,[1 1 1;1 1 1;1 1 1]);

[H,theta,rho] = hough(edgi);

figure, imshow(edgi), hold on				%= for line
impixelinfo;

P = houghpeaks( H,5,'threshold', ceil( 0.3*max( H(:) ) ) );

x = theta(P(:,2));
y = rho(P(:,1));

lines = houghlines(edgi,theta,rho,P,'FillGap',50,'MinLength',500);

[rr,cc] = size(edgi);
vect = zeros(cc,2);

lin=0;
max_len = 0;

x = lines(1).point1
y = lines(1).point2

y1 = x(1,1);
x1 = x(1,2);
x2 = y(1,2);
y2 = y(1,1);

xdiff = x2-x1
ydiff = y2-y1

angli = atan2(ydiff,xdiff);
degree = angli * 57.2368
%radian = angli
getMarksLinesRotate(im,degree,namz);

%row=[1 length(lines)];
%row(:,:) = rr+1;
%
%for k = 1:length(lines)
%   xy = [lines(k).point1; lines(k).point2];
%   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');				%= for line
%   
%   row(1,k) = xy(2,2);
%   % Plot beginnings and ends of lines
%   %plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
%   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
%
%   % Determine the endpoints of the longest line segment
%   len = norm(lines(k).point1 - lines(k).point2);
%   if ( len > max_len)
%      max_len = len;
%      xy_long = xy;
%   end
%end
%
%plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red'); 			%= for line
%

end
