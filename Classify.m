function W = Classify(imagee,count,tot)

if tot~=0

	im = imread(imagee);

	if ndims(im)>=3
		im = rgb2gray(im);
	end

	edgi = edge(im,'prewitt',[],'both');
	%edgi = imdilate(edgi,[1 1 1;1 1 1;1 1 1]);
	figure; imshow(edgi);
	imwrite(edgi,'bestEdge.jpg');

	threshold = graythresh(im);
	BW = im2bw(im, threshold);

	%BW = imerode(BW,[0 1 0;0 1 0;0 1 0]);

	%BW = imdilate(BW,[0 1 0;0 1 0;0 1 0]);

	outi = zeros(size(BW));

	[B,L,N,A] = bwboundaries(BW);
	subplot(2,1,1), imshow(BW), hold on;
	impixelinfo;

	%stats = [regionprops(BW,'all'); regionprops((BW),'all')]

	stats = [regionprops(BW,'all'); regionprops((BW),'all')]
	st_sz = size(stats);

	for i = 1:numel(stats)	
		if( stats(i).Area < 500 && stats(i).Area > 50 ) 
			rectangle('Position', stats(i).BoundingBox,'Linewidth',1, 'EdgeColor', 'r', 'LineStyle', '-');
			listi = stats(i).PixelList;
			[rr,cc] = size(listi);
			
				for i=1:rr
						in_i= listi(i,2);
						in_j= listi(i,1);
						outi(in_i,in_j) = 255;
				end
		end
	end

	%for i = 1:numel(stats)
	%
	%	if( stats(i).Area < 500 ) 
	%   	rectangle('Position', stats(i).BoundingBox,'Linewidth',1, 'EdgeColor', 'r', 'LineStyle', '-');
	%   	
	%   	pix = size(stats(i).PixelIdxList)
	%   	pixelss = stats(i).PixelIdxList;
	%   	
	%   	[maxi,idx] = max(pixelss);
	%   	stats(i).PixelIdxList(id)=0;
	%
	%		pix_rows = size(pixelss,1);
	%		[x,y]=ind2sub(size(BW),pixelss);
	%		
	%		size_x = size(x);
	%		size_y = size(y);
	%		
	%		for i=1:pix_rows
	%			rowi = x(i,1);
	%			coli = y(i,1);
	%			outi(rowi,coli) = BW(rowi,coli);
	%		end	
	%		
	%   end
	%end
	%
	%counti=0;
	%
	%for i=size(BW,1)
	%	for j=size(BW,2)
	%		if( outi(i,j)~=0 )
	%			counti = counti + 1;
	%		end
	%	end
	%end
	%
	%counti

	%outi = imerode(outi,[1 0 1;1 0 1;1 0 1]);
	subplot(2,1,2), imshow(outi,[]);
	
	formatSpec = 'mr_%d.jpg';
	str = sprintf(formatSpec,count);
	count=count+1;
	tot=tot-1;
	Classify(str,count,tot);

end

end

%for k = 1:N
%    % Boundary k is the parent of a hole if the k-th column
%    % of the adjacency matrix A contains a non-zero element
%    if (nnz(A(:,k)) > 0)
%        boundary = B{k};
%        plot(boundary(:,2),boundary(:,1),'r','LineWidth',2);
%        % Loop through the children of boundary k
%        for l = find(A(:,k))'
%            boundary = B{l};
%            %plot(boundary(:,2),boundary(:,1),'g','LineWidth',2);
%        end
%    end
%end




%{

%figure,imshow(BW),title('Binary Image');

% Step 4: Invert the Binary Image
BW = ~ BW;

%figure,imshow(BW),title('Inverted Binary Image');

% Step 5: Find the boundaries Concentrate only on the exterior boundaries.
% Option 'noholes' will accelerate the processing by preventing
% bwboundaries from searching for inner contours. 
[B,L] = bwboundaries(BW, 'noholes');

% Step 6: Determine objects properties
STATS = regionprops(L, 'all'); % we need 'BoundingBox' and 'Extent'

% Step 7: Classify Shapes according to properties
% Square = 3 = (1 + 2) = (X=Y + Extent = 1)
% Rectangular = 2 = (0 + 2) = (only Extent = 1)
% Circle = 1 = (1 + 0) = (X=Y , Extent < 1)
% UNKNOWN = 0

figure,imshow(RGB),title('Results'), hold on;

for i = 1 : length(STATS)
  %W(i) = uint8(abs(STATS(i).BoundingBox(3)-STATS(i).BoundingBox(4)) < 0.1);
  W(i) = uint8(STATS(i).Extent);
  centroid = STATS(i).Centroid;
  switch W(i)
      case 1
          plot(centroid(1),centroid(2),'wO');
      case 2
          %plot(centroid(1),centroid(2),'wX');
      case 3
          %plot(centroid(1),centroid(2),'wS');
  end
end
return


%}
