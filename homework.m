function main()
    S = [4,15,29,48,52,23,68,15,71,22,4,9,18,91,86,45,60,68];
    k=8;
    fprintf('����Ϊ:')
    disp(S)
    fprintf('����Ϊ:')
    disp(sort(S))
    s=select(S,k);%���ú������KС
    fprintf('����ȡ�е� %dСΪ:%d\n', k,s);
end
function s = select(S,k)
    n = length(S);
    S2 = [];  %S2��ʼ��
    if length(S)<5    %��������Ϊ5
        S = sort(S);
        s=S(k);
        return;
    end
    if rem(n,5)==0   %����Ϊ5�ı���
        S1 = reshape(S,5,floor(n/5));
    else
        S0 = S(1:floor(n/5)*5);  %��n-b+1������������S0
        S1 = reshape(S0,5,floor(n/5)); %����S0����״��5�У�floor(n/5)��
        b = rem(n,5);
        S2 = S(end-b+1:end);      %ʣ���������S2
        S1 = sort(S1,'descend');
        S2 = sort(S2,'descend'); 
    end
    S1 = sortrows(S1',3)';   %������
    M = S1(3,:);             %��λ������M
    if rem(length(M),2)==1;  %M����Ϊ����
        m = median(M);
    else
        m = M(length(M)/2);
    end
    B = S1(1:2,ceil(length(M)/2):size(S1,2));      %��ȡ��B����
    B1 = reshape(B,1,numel(B));                    %����B����
    B1 = [B1,S1(3,ceil(length(M)/2)+1:size(S1,2))];%B����Ԫ�ز���
    C = S1(4:5,1:ceil(length(M)/2));
    C1 = reshape(C,1,numel(C));
    if rem(length(M),2)==1
        C1 = [C1,S1(3,1:floor(length(M)/2))];
    else
        C1 = [C1,S1(3,1:floor(length(M)/2)-1)];    %C1��ż����
    end
    if rem(length(M),2)==1
        A = S1(1:2,1:floor(length(M)/2));          %��ȡA������ż
    else
        A = S1(1:2,1:floor(length(M/2))-1);
    end
    if length(M)==2
        A=[];
    end
    A = reshape(A,1,numel(A));                     %A�������
    D = S1(4:5,ceil(length(M)/2)+1:size(S1,2));
    D = reshape(D,1,numel(D)); 
    num = numel(S1);                               %S1Ԫ���ܸ���
    i = 1;
    j = 1;
    while length(B1)+length(C1)+1<num              %A.D��Ԫ�ط���B.C��
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
    while l<=length(S2)                            %S2��Ԫ�ط���B.C
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
