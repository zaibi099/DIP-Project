function templateMatcher(origImage,tempImage,totQuestions)

orig = imread(origImage);
temp = imread(tempImage);

if ndims(orig)>=3
	orig= rgb2gray(orig);
end

if ndims(temp)>=3
	temp= rgb2gray(temp);
end

origEdges = edge(orig);
origEdges = imdilate(origEdges,[0 1 0;0 1 0;0 1 0]);

%figure , imshow(origEdges) , title('Template MATCHER');

%figure , imshow(origEdges,[]),title('Original Edges');			// DAULAT

temp = imcrop(orig);

tempEdges = edge(temp);
tempEdges = imdilate(tempEdges,[0 1 0;0 1 0;0 1 0]);

%figure, imshow(tempEdges,[]) , title('Edge Binary Image');	// DAULA

find_Object(orig,origEdges,tempEdges,totQuestions);

%find_Object(orig,origEdges,tempEdges);

end