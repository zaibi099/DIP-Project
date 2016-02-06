function run()

img = 'im4.jpg';
out = 'out4.jpg';
marks = 'mark_3.jpg';
template = 'q_temp.png';

%mosaic(img,out);
%getMarks(out,marks) , title(marks);

%templateMatcher(marks,template);

%getPaper(marks,'marksOut.jpg');

getMarksLines(marks,marks);

%marks = 'mous.png';
%template = 'eye.png';


%templateMatcher(marks,template);

%getMarksLines('mark_1.jpg');
%getMarksLines('mark_2.jpg');
%getMarksLines('mark_3.jpg');
%getMarksLines('mark_4.jpg');
%getMarksLines('mark_6.jpg');

end
