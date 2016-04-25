function output1 = genLocation (number)

locArray = rand(number, 2);
x = locArray(:,1);
y = locArray(:,2);

x_1 = repmat(x,1,number);
x_2 = repmat(x',number,1);
x_M = (x_1-x_2).^2;

y_1 = repmat(y,1,number);
y_2 = repmat(y',number,1);
y_M = (y_1-y_2).^2;

W = x_M + y_M;

output1 = W ;
end