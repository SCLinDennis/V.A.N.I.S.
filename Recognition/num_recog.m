function Answer = num_recog(InputIn,fs, MFCC_train_list1, MFCC_train_list2, MFCC_train_list3)
MFCC_test_list = MFCC2(InputIn, fs);
D = zeros(20, 3);
D1 = zeros(20, 3);
D2 = zeros(20, 3);
D3 = zeros(20, 3);
% D4 = zeros(20, 3);
% D5 = zeros(20, 3);
% D6 = zeros(20, 3);
% D7 = zeros(20, 3);
for i = 1: 20
    for j = 1: 3
        [D1(i, j)] = DTWforstu(MFCC_train_list1{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
        [D2(i, j)] = DTWforstu(MFCC_train_list2{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
        [D3(i, j)] = DTWforstu(MFCC_train_list3{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
%         [D4(i, j)] = DTWforstu(MFCC_train_list4{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
%         [D5(i, j)] = DTWforstu(MFCC_train_list5{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
%         [D6(i, j)] = DTWforstu(MFCC_train_list6{i,j}(:,1:5)',MFCC_test_list(:,1:5)');
%         [D7(i, j)] = DTWforstu(MFCC_train_list7{i,j}(:,1:9)',MFCC_test_list(:,1:9)');

        D(i, j) = D1(i, j)+D2(i, j)+D3(i, j);
    end

%     [value,index] = min(D1+D2+D3);
%     result(i) = index;
    

end
[D_min D_min_index] = min(D, [], 2);
Answer= mode(D_min_index);
% Answer
end