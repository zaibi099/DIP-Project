function run()

img = 'im1.jpg';
out = 'out.jpg';
marks = 'marks.jpg';
marksOut = 'transformedMarks.jpg';		% Transformed Image of Matrix
template = 'q_temp.png';
totQuestions =7;

fileName= 'myExamplex.xlsx';

getPaper(img,out);
getMarks(out,marks) , title(marks);

getMarksLines(marks,marksOut);
templateMatcher(marksOut,template,totQuestions);

storeExcel(fileName);

formatSpec = 'mr_%d.jpg';
marks = sprintf(formatSpec,totQuestions);

Classify(marks,1,totQuestions);

%marks = 'mous.png';
%template = 'eye.png';


%templateMatcher(marks,template);

%getMarksLines('mark_1.jpg');
%getMarksLines('mark_2.jpg');
%getMarksLines('mark_3.jpg');
%getMarksLines('mark_4.jpg');
%getMarksLines('mark_6.jpg');

end
