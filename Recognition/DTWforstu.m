function [D] = DTWforstu(A,B)
% DTW building
Arange= size(A,2);
Brange = size(B,2);
if size(Arange,1)~=size(Brange,1)
    error('Error in dtw(): the dimensions of the two input signals do not match.');
end
% costs
d = zeros(Arange, Brange);
for i = 1:Arange
    for j = 1:Brange
       d(i, j) = sqrt(sum(abs(A(:, i)-B(:,j)).^2));
    end
end

% DTW
D = zeros(Arange+1,Brange+1); % use it to trace the line
D(:,:) = realmax;
D(1,1) = 1*d(1, 1);
for i = 2:Arange+1
   for j = 2:Brange+1
      D(i, j) = d(i-1, j-1) + min([D(i-1, j), D(i-1, j-1), D(i, j-1)]);
   end
end


% D(m,n) is what we find
D = D(end,end);