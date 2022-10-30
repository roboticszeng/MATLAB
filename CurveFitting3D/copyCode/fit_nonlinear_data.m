function [beta, r]=fit_nonlinear_data(X, Y, choose)
% Input: X 自变量数据(N, D)， Y 因变量(N, 1)，choose 1-regress, 2-nlinfit 3-lsqcurvefit
if choose==1
    X1=[ones(length(X(:, 1)), 1), X];
    [beta, bint, r, rint, states]=regress(Y, X1)
    % 多元线性回归
    % y=beta(1)+beta(2)*x1+beta(3)*x2+beta(4)*x3+...
    % beta—系数估计
    % bint—系数估计的上下置信界
    % r—残差
    % rint—诊断异常值的区间
    % states—模型统计信息
    rcoplot(r, rint)
%     saveas(gcf,sprintf('线性曲线拟合_残差图.jpg'),'bmp');
elseif choose==2
    beta0=ones(7, 1);
    % 初始值的选取可能会导致结果具有较大的误差。
    [beta, r, J]=nlinfit(X, Y, @myfun, beta0)
    % 非线性回归
    % beta—系数估计
    % r—残差
    % J—雅可比矩阵
    [Ypred,delta]=nlpredci(@myfun, X, beta, r, 'Jacobian', J)
    % 非线性回归预测置信区间
    % Ypred—预测响应
    % delta—置信区间半角
    plot(X(:, 1), Y, 'k.', X(:, 1), Ypred, 'r');
%     saveas(gcf,sprintf('非线性曲线拟合_1.jpg'),'bmp');
elseif choose==3
    beta0=ones(7, 1);
    % 初始值的选取可能会导致结果具有较大的误差。
    [beta,resnorm,r, ~, ~, ~, J]=lsqcurvefit(@myfun,beta0,X,Y)
    % 在最小二乘意义上解决非线性曲线拟合（数据拟合）问题
    % beta—系数估计
    % resnorm—残差的平方范数 sum((fun(x,xdata)-ydata).^2)
    % r—残差 r=fun(x,xdata)-ydata
    % J—雅可比矩阵
    [Ypred,delta]=nlpredci(@myfun, X, beta, r, 'Jacobian', J)
    plot(X(:, 1), Y, 'k.', X(:, 1), Ypred, 'r');
%     saveas(gcf,sprintf('非线性曲线拟合_2.jpg'),'bmp');
end
end
 
 
function yy=myfun(beta,x) %自定义拟合函数
yy=beta(1)+beta(2)*x(:, 1)+beta(3)*x(:, 2)+beta(4)*x(:, 3)+beta(5)*(x(:, 1).^2)+beta(6)*(x(:, 2).^2)+beta(7)*(x(:, 3).^2);
end