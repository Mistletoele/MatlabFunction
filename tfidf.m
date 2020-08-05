function fea = tfidf(fea,bNorm)
%  fea is a document-term frequency matrix, this function return the tfidf ([1+log(tf)]*log[N/df])
%  weighted document-term matrix.
%    
%     If bNorm == 1, each document verctor will be further normalized to
%                    have unit norm. (default)
%
%   version 2.0 --Jan/2012 
%   version 1.0 --Oct/2003 
%
%   Written by Deng Cai (dengcai AT gmail.com)
%

if ~exist('bNorm','var')  % 检测bNorm中的变量是否存在 ~取反
    bNorm = 1;
end


[nSmp,mFea] = size(fea);  % size：获取数组的行数和列数
[idx,jdx,vv] = find(fea);  % 找出矩阵中非零元素所在行和列,并存在x、y中，并将结果放在vv中
df = full(sum(sparse(idx,jdx,1,nSmp,mFea),1));
% S=sparse(X)—将矩阵X转化为稀疏矩阵的形式，即矩阵X中任何零元素去除，非零元素及其下标（索引）组成矩阵S
% sum(a,dim); a表示矩阵；dim等于1或者2，1表示每一列进行求和，2表示每一行进行求和
% full 把稀疏矩阵转为全矩阵


df(df==0) = 1;
idf = log(nSmp./df);

tffea = sparse(idx,jdx,log(vv)+1,nSmp,mFea);

fea2 = tffea';
idf = idf'; % 转置

MAX_MATRIX_SIZE = 5000; % You can change this number based on your memory.
nBlock = ceil(MAX_MATRIX_SIZE*MAX_MATRIX_SIZE/mFea); % ceil(z)函数将输入z中的元素取整，值w为不小于本身的最小整数
for i = 1:ceil(nSmp/nBlock)
    if i == ceil(nSmp/nBlock)
        smpIdx = (i-1)*nBlock+1:nSmp;
    else
        smpIdx = (i-1)*nBlock+1:i*nBlock;
    end
    fea2(:,smpIdx) = fea2(:,smpIdx) .* idf(:,ones(1,length(smpIdx)));
end

%Now each column of fea2 is the tf-idf vector.
%One can further normalize each vector to unit by using following codes:

if bNorm
   fea = NormalizeFea(fea2,0)'; 
end

% fea is the final document-term matrix.
