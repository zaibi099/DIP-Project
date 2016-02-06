function Biggest_Region(im)

bin = im2bw(im,0.3);
[brows,bcols] = size(bin);
outi = zeros(brows,bcols);
outi(:,:) = 125;

figure , imshow(bin,[]) , title('Before Image');

invert = ~(bin);
conn = bwconncomp(bin,8);

numPixels = cellfun(@numel,conn.PixelIdxList);
[biggest,idx] = max(numPixels);
tot_components = conn.NumObjects;
size(numPixels);,m,
pixelss= conn.PixelIdxList{idx};

pix_rows = size(pixelss,1)
[x,y]=ind2sub(size(bin), conn.PixelIdxList{idx});

size_x = size(x)
size_y = size(y)

for i=1:pix_rows
	rowi = x(i,1);
	coli = y(i,1);
	bin(rowi,coli)  = 0;
	outi(rowi,coli) = im(rowi,coli);
end

%edgi = edge(outi,'prewitt',[],'both');
%imwrite(edgi,'imagee.jpg');
%figure , imshow(bin,[]) , title('After Image');
figure , imshow(outi,[]) , title('Out Image');
%figure , imshow(edgi,[]) , title('Edgee Image');
end

%{


function FindBackgroundAndLargestBlob
x = imread('peppers.png');
I = x(:,:,2);
level = graythresh(I);
bw = im2bw(I,level);
b = bwlabel(bw,8);
rp = regionprops(b,'Area','PixelIdxList');
areas = [rp.Area];
[unused,indexOfMax] = max(areas);
disp(indexOfMax);
end

---------------------------------------------

CC = bwconncomp(BW);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
BW(CC.PixelIdxList{idx}) = 0;
 
figure, imshow(BW);

for i=1:length(numPixels)
	if(i~=idx)
		bin(conn.PixelIdxList{i}) = 0;
		disp('Yesss');
	end
end

%}
