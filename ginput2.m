function [X, Y] = ginput(n)

X = [];
Y = [];
for i=1:n,
	[px py ] = ginput(1);
	X = [X ; px];
	Y = [Y ; py];
	plot( px, py, 'r+' );
	text_handle = text( px+5, py, num2str(i) );
	set(text_handle,'Color',[1 1 1])
end
