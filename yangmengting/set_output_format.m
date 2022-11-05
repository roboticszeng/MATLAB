function data_output = set_output_format(InfoStruct, strTitle)

% for i = 1 : 89
%     data_output(i) = "a";
% end


data_output = strTitle;

for i = 1 : length(InfoStruct)
    % 姓名
    data_this_line = [InfoStruct(i).StudentName];
    % 作答时间
    data_this_line = [data_this_line, num2str(InfoStruct(i).AnswerTime)];
    % 基本信息
    for j = 1 : length(InfoStruct(i).baseInfo)
        data_this_line = [data_this_line, num2str(InfoStruct(i).baseInfo(j))];
    end
    % a b c的值
    for j = 1 : length(InfoStruct(i).a)
        data_this_line = [data_this_line, num2str(InfoStruct(i).a(j))];
    end
    for j = 1 : length(InfoStruct(i).b)
        data_this_line = [data_this_line, num2str(InfoStruct(i).b(j))];
    end
    for j = 1 : length(InfoStruct(i).c)
        data_this_line = [data_this_line, num2str(InfoStruct(i).c(j))];
    end
    % factor的值
    for j = 1 : length(InfoStruct(i).a_factor)
        data_this_line = [data_this_line, num2str(InfoStruct(i).a_factor(j))];
    end
    for j = 1 : length(InfoStruct(i).b_factor)
        data_this_line = [data_this_line, num2str(InfoStruct(i).b_factor(j))];
    end
    for j = 1 : length(InfoStruct(i).c_factor)
        data_this_line = [data_this_line, num2str(InfoStruct(i).c_factor(j))];
    end
    % sum的值
    data_this_line = [data_this_line, num2str(InfoStruct(i).a_sum), ...
        num2str(InfoStruct(i).b_sum), num2str(InfoStruct(i).c_sum), num2str(InfoStruct(i).sum)];
    
    data_output = [data_output; data_this_line];
end

% data_output = [];
