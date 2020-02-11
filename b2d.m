function y = b2d(x)
% Transform a matrix of binary numbers to a vector of decimal numbers

z = repmat(2.^(size(x,2)-1:-1:0),size(x,1),1);
y = sum(x.*z,2);

end

