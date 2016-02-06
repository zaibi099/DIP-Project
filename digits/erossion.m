function [ erodeimage ] = erossion( im )

s=[0 1 0;
   1 1 1;
   0 1 0];

erodeimage=imerode(im,s);
%figure, imshow(erodeimage);

end
