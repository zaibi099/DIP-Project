close all
clear all
load mnist;

%X is the data and Y its corresponding value
%Number of rows of X and Y are same

N = 784;	%Vector dimension of X
M = 12000; %Number of vectors used for training

X = train_x(1:M,1:end);
X = double(X);
Y = find(train_y(1,1:end))-1;
for j=2:M;
    Y = [Y find(train_y(j,1:end))-1];
end
Y = Y';

% test data set : t_x, value corresponding to an entry in t_x : t_y
n = 2000;	% No. of test cases : n
t_x = test_x(1:n,1:end);
t_x = double(t_x);
t_y = find(test_y(1,1:end))-1;
for j=2:n;
    t_y = [t_y find(test_y(j,1:end))-1];
end
t_y = t_y';

error_fraction = [];

K = 49;   % K is the no. of neighbours to be looked at
for k=1:K;
    count = 0;
    for i=1:n;
        IDX = knnsearch(X,t_x(i,1:end),'K',k);
        cmp = mode(Y(IDX));
        if cmp ~= t_y(i)
            count = count + 1;
        end
    end
    ef = count/n;
%    disp(['Fraction of estimates wrong while considering ' num2str(k) ' neighbours is ' num2str(ef)]);
    error_fraction = [error_fraction ef];
end
x = 1:1:K;
plot((1:K),error_fraction,'-*k');
xlabel('No. of neighbours')
ylabel('Error fraction')
