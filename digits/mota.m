function mota(imagee)

im = imread(imagee);

if ndims(im)>=3
	im = rgb2gray(im);
end

regionImage = im;
regionImage = padarray(regionImage, [1 1]);

% Compute the stroke width image.
distanceImage = bwdist(~regionImage);
skeletonImage = bwmorph(regionImage, 'thin', inf);

strokeWidthImage = distanceImage;
strokeWidthImage(~skeletonImage) = 0;

% Show the region image alongside the stroke width image.
figure, imshow(regionImage,[]),title('Region Image')

figure, imshow(strokeWidthImage,[]),title('strokeWidthImage Image')

end
