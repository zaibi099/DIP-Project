function [spoints,dpoints,x,y]=selectPoint(iml,n)
% funcion takes as input a left image and a right
% and allow user to select n number of corresponding points 
% from both images...
%input:
% iml= left image
% imr= right image
% n= number of corresponding points to choose
% direction= 'rtl' or 'ltr'; 'rtl' is used to select mathcing points in the left (destination) image for each selected point in the right (source) image i.e. when we are estimating the Homograpy Mapping from right to left in other wards when we are aligning the right image to left. 'ltr' is to used to perform the inverse operation.

% Output: Two matrices containing coordinates of selected points.
% spoints = n x 2 matrix for the point cooridnates from the source image (can be left or right)
% dpoints = n x 2 matrix for the point cooridnates from the destination image (can be )
% Written BY: Sibt ul Hussain  
 
im = imread(iml);	
[origRows , origCols, origDims] = size(im);

[h1 w1 d1] = size(im);

outi =zeros(size(im));

if n<4
	n=4; % by default 4 corresponding points are selected from the image...
end

if origDims>=3
	im = rgb2gray(im);
	outi = rgb2gray(outi);
end

fprintf('Select %d Corresponding Points',n);
figure; subplot(1,2,1); imshow(im); axis image; hold on;
title('first input image');

[x y] = ginput2(n*2); % get two points from the user , X1 columns, Y1 rows

mat = [x y];
[r,c] = size(mat);

plotPoints(iml,x,y)

spoints=[y(1:2:end) x(1:2:end)];
dpoints=[y(2:2:end) x(2:2:end)];

linear_up  = [ spoints(:,2)'  spoints(:,1)' ; spoints(:,1)' -spoints(:,2)' ; 1 1 1 1 0 0 0 0  ; 0 0 0 0 1 1 1 1 ]';
linear_down = [ dpoints(:,2) ; dpoints(:,1) ];
t  = linear_up \ linear_down; % solve the linear system

a = t(1);
b = t(2);
tx = t(3); 
ty = t(4);

%T = [a b tx ; -b a ty ; 0 0 1];
T = [a b 0 ; -b a 0 ; 0 0 1];

cp = T*[ 1 1 w1 w1 ; 1 h1 1 h1 ; 1 1 1 1 ];
Xpr = min( [ cp(1,:) 0 ] ) : max( [cp(1,:) w1] ); % min x : max x 
Ypr = min( [ cp(2,:) 0 ] ) : max( [cp(2,:) h1] ); % min y : max y 
[Xp,Yp] = ndgrid(Xpr,Ypr); 
[wp hp] = size(Xp); % = size(Yp)  

% do backwards transform (from out to in) 
X = T \ [ Xp(:) Yp(:) ones(wp*hp,1) ]'; % warp
figure, imshow(X) , title('Wrapped');

tform = affine2d(T)
finali = imwarp(im,tform);

figure, imshow(finali,[]), title('Final Image');


%{


x_1 = x(2:2:end);
x_2 = x(1:2:end);

y_1 = y(2:2:end);
y_2 = y(1:2:end);

Z = [ x_2'; y_2' ; y_2' -x_2' ; 1 1 1 1 0 0 0 0  ; 0 0 0 0 1 1 1 1 ]';
xp = [ x_1 ; y_1 ];
t = Z \ xp;

spoints=[y(1:2:end) x(1:2:end)]
dpoints=[y(2:2:end) x(2:2:end)]

linear_up  = [ spoints(:,2)'  spoints(:,1)' ; spoints(:,1)' -spoints(:,2)' ; 1 1 1 1 0 0 0 0  ; 0 0 0 0 1 1 1 1 ]';
linear_down = [ dpoints(:,2) ; dpoints(:,1) ];
t  = linear_up \ linear_down; % solve the linear system

ist_el = t(1);
sec_el = t(2);

tr = [ist_el sec_el t(3) ; -sec_el ist_el t(4) ; 0 0 1];

%}

%=======================================================================================
%=======================================================================================
%=======================================================================================

%{

imli = double(imread(iml));
imri = double(imread(imr));

[rl cl dim] = size(imli);
[rr cr dim] = size(imri);

corners = [1 1 1;1 rr 1;cr 1 1;cr rr 1];  %4*3
tc = T*corners';	 %final result = 3*3 _ 3_4 = ( 3*4 ) 

%=======================================================================================
%=======================================================================================
%=======================================================================================


if strcmpi(direction,'ltr')
checkPoints(iml,spoints);
checkPoints(imr,dpoints);
else
checkPoints(imr,spoints);
checkPoints(iml,dpoints);
end

function checkPoints(img,points)
% function display the given points on the input image for visual
% inspection
h=figure(220);
imshow(img);
count=0;
for k=1:size(points,1)
    content = sprintf('%d',count+1);
    
    text(points(k,2),points(k,1),content,'FontSize',20,'Color','r');
    count=count+1;
end
hold on,
plot(points(:,2),points(:,1),'g*'),hold off
disp('Press Key to Close the Window and Continue ');
pause;
%}

function plotPoints(im,x,y)
	subplot(1,2,1),imshow(im),hold on, plot(x(1:end),y(1:end),'r*'),
	count=0;
	for k=1:2:numel(x);
		 content = sprintf('%d',count+1);
		 text(x(k),y(k),content,'FontSize',20);
		 count=count+1;
	end
	hold off;
