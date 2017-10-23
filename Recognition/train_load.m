%% Load two speech waveforms of the same utterance (from TIMIT)
function  [ MFCC_train_list1 MFCC_train_list2 MFCC_train_list3 ]...
    = train_load(varargin)


load Bo_all2.mat
load Ch_all2.mat
load Dennis_all2.mat
% load Fan_all.mat
% load Neeraj_all.mat
% load Zhang_all.mat
% load female1_all.mat
% train_wav_List = (dir('./train/'num2str));
MFCC_train_list1 = cell(20, 3);
MFCC_train_list2 = cell(20, 3);
MFCC_train_list3 = cell(20, 3);
MFCC_train_list4 = cell(20, 3);
MFCC_train_list5 = cell(20, 3);
MFCC_train_list6 = cell(20, 3);
MFCC_train_list7 = cell(20, 3);
fs = 44100;
% for i = 1 : length(train_wav_List)
for i = 1:20
    for j = 1 : 3
        if j ==1
            a_number = sprintf('Dennis_one%d', i);
            b_number = sprintf('Ch_one%d', i);
            c_number = sprintf('Bo_one%d', i);
%             d_number = sprintf('Fan_one%d', i);
%             e_number = sprintf('Neeraj_one%d', i);
%             f_number = sprintf('Zhang_A%d', i);
%             g_number = sprintf('female1_A%d', i);
        elseif j==2
            a_number = sprintf('Dennis_two%d', i);
            b_number = sprintf('Ch_two%d', i);
            c_number = sprintf('Bo_two%d', i);
%             d_number = sprintf('Fan_B%d', i);
% %             e_number = sprintf('Neeraj_B%d', i);
%             f_number = sprintf('Zhang_B%d', i);
%             g_number = sprintf('female1_B%d', i);
        elseif j ==3
            a_number = sprintf('Dennis_three%d', i);
            b_number = sprintf('Ch_three%d', i);
            c_number = sprintf('Bo_three%d', i);        
%             d_number = sprintf('Fan_C%d', i);
%             e_number = sprintf('Neeraj_C%d', i);
%             f_number = sprintf('Zhang_C%d', i);  
%             g_number = sprintf('female1_C%d', i);
        end
        MFCC_train_list1{i,j} = MFCC2(eval(a_number), fs);
    
        MFCC_train_list2{i,j} = MFCC2(eval(b_number), fs);
    
        MFCC_train_list3{i,j} = MFCC2(eval(c_number), fs);
% 
%         MFCC_train_list4{i,j} = MFCC2(eval(d_number), fs);
%     
%         MFCC_train_list5{i,j} = MFCC2(eval(e_number), fs);
%     
%         MFCC_train_list6{i,j} = MFCC2(eval(f_number), fs);
%         
%         MFCC_train_list7{i,j} = MFCC2(eval(g_number), fs);  
    end
end
end
%%
% test_wav_List = (dir('./test/u*.wav'));
% MFCC_test_list = cell(1, 40);
% for i = 1 : length(test_wav_List),
% 
%     MFCC_test_list{i} = MFCC(['./test/' test_wav_List(i).name]);
% 
% end

% for i = 1 : 40
%     MFCC_test_list{i} = MFCC(['./test/u' num2str(i-1) '.wav']);
%     
% 
% end
% 
% display('Record your sound saying one of these (A,B,C)');
% in = input('Press any char when you are ready-','s');
% fs = 44100;
% recorder=audiorecorder(fs,16,1);
% recordblocking(recorder, 2);
% InputIn = getaudiodata(recorder);
% MFCC_test_list = MFCC2(InputIn, fs);

% mfccs0 = MFCC('./train/0.wav');
% test_mfcc0 = MFCC('./test/u0.wav');

% test_mfccList = dir('./test/u*.wav');
% D = zeros(1,length(train_mfccList));
% result = zeros(1,40);
% function Answer = num_recog(InputIn, fs)
% D1 = zeros(20, 3);
% D2 = zeros(20, 3);
% D3 = zeros(20, 3);
% D4 = zeros(20, 3);
% D5 = zeros(20, 3);
% D6 = zeros(20, 3);
% for i = 1: 20
%     for j = 1: 3
%         [D1(i, j)] = DTWforstu(MFCC_train_list1{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
%         [D2(i, j)] = DTWforstu(MFCC_train_list2{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
%         [D3(i, j)] = DTWforstu(MFCC_train_list3{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
%         [D4(i, j)] = DTWforstu(MFCC_train_list4{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
%         [D5(i, j)] = DTWforstu(MFCC_train_list5{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
%         [D6(i, j)] = DTWforstu(MFCC_train_list3{i,j}(:,1:7)',MFCC_test_list(:,1:7)');
% 
%         D(i, j) = D1(i, j)+D2(i, j)+D3(i, j)+D4(i, j)+D5(i, j)+D6(i, j);
%     end
% 
% %     [value,index] = min(D1+D2+D3);
% %     result(i) = index;
%     
% 
% end
% [D_min D_min_index] = min(D, [], 2);
% Answer= mode(D_min_index);
% % Answer
% end


%%
% %% calculate the accuracy
% % for i = length(answer)
% correct = 0;
% error = 0;
% answer = zeros(40,1);
% 
% for i = 1:40
%     answer(i) = floor((i-1)/4)+1;
% end
% 
% for i = 1:40
%     if result(i)==answer(i)
%         correct = correct +1;
%     else
%         error = error +1;
%     end
% end
% 
% accuracy = correct/(correct+error);    
% 
% 
% % 
% % [p,q,D] = DTWforstu2(mfccs0,test_mfcc0);
% % [p,q,D1] = DTWforstu2(mfccs0,test_mfcc1);
% % mfccs2 = MFCC('./test/u0.wav');