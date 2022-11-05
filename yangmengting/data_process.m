clear;clc;
dataorigin = importfile('/yangmengting/data_origin.xlsx');
load data_origin.mat;
stdIndex = 1;
timeIndex = 3;
nameIndex = 7;
baseInfoIndex = 8;
baseInfoLength = 8;
% sexIndex = 9;
% ageIndex = 10;
% gradeIndex = 11;
% childIndex = 12;

aIndex = 16;
aDataLength = 26;
bIndex = 43;
bDataLength = 22;
cIndex = 65;
cDataLength = 17;

timeLimit = 140;

[nRow, ~] = size(data_origin);

% StudentStruct.ori = data_origin;
StudentStruct.ori.stdIndex = nan(nRow,  1);
StudentStruct.ori.ansTime = nan(nRow, 1);
j = 1;
for i = 2 : nRow
    timeChar = char(data_origin{i, timeIndex});
    ansTime = str2double(timeChar(1:end-1));
    
    for k = 1 : aDataLength
        tmp(k) = data_origin{i, aIndex + k - 1};
    end
    StudentStruct.ori.aLimit(i) = max(tmp) - min(tmp);
    tmp = [];
    for k = 1 : bDataLength
        tmp(k) = data_origin{i, bIndex + k - 1};
    end
    StudentStruct.ori.bLimit(i) = max(tmp) - min(tmp);
    tmp = [];
    for k = 1 : cDataLength
        tmp(k) = data_origin{i, cIndex + k - 1};
    end
    StudentStruct.ori.cLimit(i) = max(tmp) - min(tmp);
    tmp = [];
    
    % 筛选时间符合要求的数据
    if (ansTime > timeLimit) && ...
            (StudentStruct.ori.aLimit(i) ~= 0 || ...
            StudentStruct.ori.bLimit(i) ~= 0 || ...
            StudentStruct.ori.cLimit(i) ~= 0)
        StudentStruct.Info(j).StudentName = data_origin{i, nameIndex};
        StudentStruct.Info(j).AnswerTime = ansTime;
        for k = 1 : baseInfoLength
            StudentStruct.Info(j).baseInfo(k) = data_origin{i, baseInfoIndex + k - 1};
        end
        for k = 1 : aDataLength
            StudentStruct.Info(j).a(k) = data_origin{i, aIndex + k - 1};
        end
        for k = 1 : bDataLength
            StudentStruct.Info(j).b(k) = data_origin{i, bIndex + k - 1};
        end
        % c数据需要特殊处理
        for k = 1 : cDataLength
            StudentStruct.Info(j).c(k) = -data_origin{i, cIndex + k - 1} + 7;
        end
        j = j + 1;
    end
        
    
end

usefulIndex = length(StudentStruct.Info);

% 指定因子索引
aFactorIndex{1} = [1, 2, 4, 15, 25];
aFactorIndex{2} = [3, 9, 16, 18, 22];
aFactorIndex{3} = [17, 18, 19, 20, 21, 23, 24];
aFactorIndex{4} = [12, 13, 14];
aFactorIndex{5} = [5, 8, 11, 26];
aFactorIndex{6} = [6, 7, 23, 24];

bFactorIndex{1} = [1, 2, 3, 4, 6, 8, 9, 14, 17, 18, 19, 22];
bFactorIndex{2} = [5, 10, 13, 15, 16];
bFactorIndex{3} = [7, 11, 12, 20, 21];

cFactorIndex{1} = [1, 2, 3, 5, 7, 9];
cFactorIndex{2} = [4, 8, 10, 12, 15, 17];
cFactorIndex{3} = [6, 11, 13, 14, 16];

% 因子求平均
for j = 1 : usefulIndex
    for k = 1 : length(aFactorIndex)
%         StudentStruct.Info(j).a_factor(k) = mean(StudentStruct.Info(j).a(aFactorIndex{k}));
        StudentStruct.Info(j).a_factor(k) = sum(StudentStruct.Info(j).a(aFactorIndex{k}));
    end
    for k = 1 : length(bFactorIndex)
%         StudentStruct.Info(j).b_factor(k) = mean(StudentStruct.Info(j).b(bFactorIndex{k}));
        StudentStruct.Info(j).b_factor(k) = sum(StudentStruct.Info(j).b(bFactorIndex{k}));
    end
    for k = 1 : length(cFactorIndex)
%         StudentStruct.Info(j).c_factor(k) = mean(StudentStruct.Info(j).c(cFactorIndex{k}));
        StudentStruct.Info(j).c_factor(k) = sum(StudentStruct.Info(j).c(cFactorIndex{k}));
    end
end


% 求和
% for j = 1 : usefulIndex
%     StudentStruct.Info(j).a_sum = sum(StudentStruct.Info(j).a);
%     StudentStruct.Info(j).b_sum = sum(StudentStruct.Info(j).b);
%     StudentStruct.Info(j).c_sum = sum(StudentStruct.Info(j).c);
%     StudentStruct.Info(j).sum = StudentStruct.Info(j).a_sum + ...
%         StudentStruct.Info(j).b_sum + ...
%         StudentStruct.Info(j).c_sum;
% end
% 求均值
for j = 1 : usefulIndex
    StudentStruct.Info(j).a_sum = mean(StudentStruct.Info(j).a);
    StudentStruct.Info(j).b_sum = mean(StudentStruct.Info(j).b);
    StudentStruct.Info(j).c_sum = mean(StudentStruct.Info(j).c);
    StudentStruct.Info(j).sum = sum(StudentStruct.Info(j).a) + ...
        sum(StudentStruct.Info(j).b) + sum(StudentStruct.Info(j).c);
end


% 排序
for j = 1 : usefulIndex
    sumSort(j) = StudentStruct.Info(j).sum;
end
[~, sortIndex] = sort(sumSort, 'descend');
for j = 1 : usefulIndex
    StudentStruct.InfoSort(j) = StudentStruct.Info(sortIndex(j));
end


% 排序
for j = 1 : usefulIndex
    sumSortB(j) = StudentStruct.Info(j).b_sum;
end

[~, sortIndex] = sort(sumSortB, 'descend');
for j = 1 : usefulIndex
    StudentStruct.InfoSortB(j) = StudentStruct.Info(sortIndex(j));
end


% 指定题头
baseInfoTitle = ["name", "ans_time", "phone_number", "sex", "age", "grade", "child_type", ...
    "married", "father_edu", "mother_edu"];
valueTitle = "";
for i = 1 : aDataLength
    valueTitle = [valueTitle, ['a' num2str(i)]];
end
for i = 1 : bDataLength
    valueTitle = [valueTitle, ['b' num2str(i)]];
end
for i = 1 : cDataLength
    valueTitle = [valueTitle, ['c' num2str(i)]];
end
valueTitle = valueTitle(2:end);
factorTitle = ["人际关系因子", "学习压力", "受惩罚", "丧失因子", "健康适应", "其他", ...
    "症状反刍", "强迫反刍", "反省深思", "动机", "精力", "专注"];
sumTitile = ["sum_a", "sum_b", "sum_c", "sum"];
strTitle = [baseInfoTitle, valueTitle, factorTitle, sumTitile];
data_output = set_output_format(StudentStruct.Info, strTitle);
data_output_sort = set_output_format(StudentStruct.InfoSort, strTitle);
data_output_sort_b = set_output_format(StudentStruct.InfoSortB, strTitle);

% 写入excel
filename = './yangmengting/data_output.xlsx';
delete './yangmengting/data_output.xlsx';
xlswrite(filename, data_output, 1);
xlswrite(filename, data_output_sort, 2);
xlswrite(filename, data_output_sort_b, 3);





