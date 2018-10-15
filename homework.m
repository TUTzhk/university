function main()
    S = [4,15,29,48,52,23,68,15,71,22,4,9,18,91,86,45,60,68];
    k=8;
    fprintf('数组为:')
    disp(S)
    fprintf('排序为:')
    disp(sort(S))
    s=select(S,k);%调用函数求第K小
    fprintf('二次取中第 %d小为:%d\n', k,s);
end
function s = select(S,k)
    n = length(S);
    S2 = [];  %S2初始化
    if length(S)<5    %矩阵行数为5
        S = sort(S);
        s=S(k);
        return;
    end
    if rem(n,5)==0   %长度为5的倍数
        S1 = reshape(S,5,floor(n/5));
    else
        S0 = S(1:floor(n/5)*5);  %（n-b+1）个数做矩阵S0
        S1 = reshape(S0,5,floor(n/5)); %更改S0的形状，5行，floor(n/5)列
        b = rem(n,5);
        S2 = S(end-b+1:end);      %剩余组成数组S2
        S1 = sort(S1,'descend');
        S2 = sort(S2,'descend'); 
    end
    S1 = sortrows(S1',3)';   %列排序
    M = S1(3,:);             %中位数集合M
    if rem(length(M),2)==1;  %M长度为奇数
        m = median(M);
    else
        m = M(length(M)/2);
    end
    B = S1(1:2,ceil(length(M)/2):size(S1,2));      %提取出B矩阵
    B1 = reshape(B,1,numel(B));                    %变形B矩阵
    B1 = [B1,S1(3,ceil(length(M)/2)+1:size(S1,2))];%B矩阵元素补齐
    C = S1(4:5,1:ceil(length(M)/2));
    C1 = reshape(C,1,numel(C));
    if rem(length(M),2)==1
        C1 = [C1,S1(3,1:floor(length(M)/2))];
    else
        C1 = [C1,S1(3,1:floor(length(M)/2)-1)];    %C1奇偶区分
    end
    if rem(length(M),2)==1
        A = S1(1:2,1:floor(length(M)/2));          %提取A矩阵奇偶
    else
        A = S1(1:2,1:floor(length(M/2))-1);
    end
    if length(M)==2
        A=[];
    end
    A = reshape(A,1,numel(A));                     %A矩阵变形
    D = S1(4:5,ceil(length(M)/2)+1:size(S1,2));
    D = reshape(D,1,numel(D)); 
    num = numel(S1);                               %S1元素总个数
    i = 1;
    j = 1;
    while length(B1)+length(C1)+1<num              %A.D中元素放入B.C中
        while i<=length(A);
            if A(i)<=m
                C1 = [C1,A(i)];
                i=i+1;
            else
                B1 = [B1,A(i)];
                i=i+1;
            end
        end
        while j<=length(D)
            if D(j)<=m
                 C1 = [C1,D(j)];
                 j=j+1;
            else
                 B1 = [B1,D(j)];
                 j=j+1;
            end
        end
    end
    l = 1;
    while l<=length(S2)                            %S2中元素放入B.C
        if S2(l)<=m
            C1 = [C1,S2(l)];
            l=l+1;
        else
            B1 = [B1,S2(l)];
            l=l+1;
        end
    end
    if k == length(C1)+1
        s = m;
        return;
    elseif k<=length(C1)
        s = select(C1,k);
        return;
    else
        s = select(B1,k-length(C1)-1);
        return;
    end
end
