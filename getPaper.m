function getPaper(imgi,namee)

im = (imread(imgi));
[h1 w1 d1] = size(im);

if d1>=3
	im = rgb2gray(im);
end

outputImage = zeros(h1,w1);

% show input images and prompt for correspondences

figure; subplot(1,2,1); imshow(im); axis image; hold on;
title('first input image');

[X1 Y1] = ginput2(4); % get two points from the user , X1 columns, Y1 rows

mat= [X1 Y1];
mat = round(mat);
[r,c] = size(mat);

left_top = mat(1,:);
right_top = mat(2,:);
left_bot = mat(3,:);
right_bot = mat(4,:);

% =====  TOP LINE

box_Size=0;

x=[left_top(1) right_top(1)];
y=[left_top(2) right_top(2)];

X=left_top(1):right_top(1);
Y=interp1(x,y,X);
Y=round(Y);
fprintf('====== \n');

top_line = zeros(size(X,2),2);
size(top_line)
top_line(:,1) = X(1,:);
top_line(:,2) = Y(1,:);

box_size =  size(X,2); 
plot(x,y,'o',X,Y,'.');

% =====  BOTTOM LINE

x=[left_bot(1) right_bot(1)];
y=[left_bot(2) right_bot(2)];

X=left_bot(1):right_bot(1);
Y=interp1(x,y,X);
Y=round(Y);

fprintf('====== \n');

bot_line = zeros(size(X,2),2);
size(bot_line)
bot_line(:,1) = X(1,:);
bot_line(:,2) = Y(1,:);

box_size = box_size + size(X,2);
plot(x,y,'o',X,Y,'.');

% =====  RIGHT LINE

if(right_top(1) <= right_bot(1) )
	x=[right_top(1) right_bot(1)+2];
	X=right_top(1):right_bot(1)+2;
else

	dif = (right_top(1) - right_bot(1))+1;
	x=[right_top(1) right_top(1)-dif];
	X=right_bot(1):right_top(1);
end

y=[right_top(2) right_bot(2)];
Y=interp1(x,y,X);
Y=round(Y);

fprintf('====== \n');

right_line = zeros(size(X,2),2);
size(right_line)
right_line(:,1) = X(1,:);
right_line(:,2) = Y(1,:);

box_size = box_size + size(X,2);
plot(x,y,'o',X,Y,'.');

% =====  LEFT LINE

fprintf('===left_top_right_below=== \n');

left_top(1)
left_top(2)
left_bot(1)
left_bot(2)
dif=0;

if(left_top(1) <= left_bot(1) )
	x=[left_top(1) left_bot(1)+2];
	X=left_top(1):left_bot(1);
else

	dif = (left_top(1) - left_bot(1))+1
	x=[left_top(1) left_top(1)-dif];
	%X=left_bot(1):left_top(1)+dif;
	X=left_bot(1):left_top(1);
end

y=[left_top(2) left_bot(2)];

fprintf('===x,y=== \n');

Y=interp1(x,y,X);
Y=round(Y);

%fprintf('x : %6.2f.\n',size(X,1));
fprintf('====== \n');

left_line = zeros(size(X,2),2);
size(left_line)
left_line(:,1) = X(1,:);
left_line(:,2) = Y(1,:);

box_size = box_size + size(X,2)
plot(x,y,'o',X,Y,'.');

final_pixels = zeros(box_size,2);
[r,c] = size(top_line);

u=1;
v=1;

for i=1:r
	for j=1:c
		final_pixels(u,v) = top_line(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

[r,c] = size(bot_line);

for i=1:r
	for j=1:c
		final_pixels(u,v) = bot_line(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

[r,c] = size(right_line);

for i=1:r
	for j=1:c
		final_pixels(u,v) = right_line(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

[r,c] = size(left_line);

for i=1:r
	for j=1:c
		final_pixels(u,v) = left_line(i,j);
		v=v+1;
	end
	v=1;
	u=u+1;
end

%final_pixels
[r,c] = size(final_pixels);

for i=1:r
	for j=1:c
		if(final_pixels(i,1)~=NaN || final_pixels(i,2)~=NaN )
			final_pixels(i,j)
		end
	end
end


end_col_1 = max(top_line(:,1))
end_col_2 = max(bot_line(:,1)) 	% column

start_col_1 = min(top_line(:,1))
start_col_2 = min(bot_line(:,1)) 	% column

end_row_1 = max(left_line(:,2))
end_row_2 = max(right_line(:,2)) 	% row , select small in both

start_row_1 = min(left_line(:,2))
start_row_2 = min(right_line(:,2)) 	% row


%==================  COLUMNS   ===========================

smallest_start_row=0;
smallest_end_row=0;
smallest_start_column=0;
smallest_end_column=0;


if(end_col_1 >= end_col_2)
	smallest_end_column = end_col_2
else
	smallest_end_column = end_col_1
end

if(start_col_1 >= start_col_2)
	smallest_start_column = start_col_1
else
	smallest_start_column = start_col_2
end

%=============================================

if(end_row_1 >= end_row_2)
	smallest_end_row = end_row_2
else
	smallest_end_row = end_row_1
end 

if(start_row_1 >= start_row_2)
	smallest_start_row = start_row_1
else
	smallest_start_row = start_row_2
end

ro = min(final_pixels(:,2));
roMax = max(final_pixels(:,2));

co = min(final_pixels(:,1));
coMax = max(final_pixels(:,1));

h1;
w1;

[fr,fc] = size(final_pixels);

for i=1:fr
	for j=1:fc
		if(final_pixels(i,1)~=NaN && final_pixels(i,2)~=NaN)
				index_r = final_pixels(i,1);
				index_c = final_pixels(i,2);
				outputImage(index_c,index_r) = im(index_c,index_r);
		end
	end
end

tot_rows = smallest_end_row - smallest_start_row + 1
tot_cols = smallest_end_column - smallest_start_column +1

out_x = zeros(tot_rows,tot_cols);

u=1;
v=1;

for i=smallest_start_row:smallest_end_row
	for j=smallest_start_column:smallest_end_column
		out_x(u,v) = im(i,j);
		v=v+1;
	end
	
	v=1;
	u=u+1;
end

figure, imshow(out_x,[]) , title('Output Image');
imwrite(out_x,gray(256),namee);

end
