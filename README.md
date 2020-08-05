# MatlabFunction

step1：预处理数据集fea，对其进行归一化，使用tfidf.m 及 NormalizeFea.m
step2：采用核心算法对fea进行处理(如NMF,GNMF)，如该算法需要用到L矩阵，则使用constructW.m构造W矩阵，L=D-W，同时最后对结果进行归一化处理NormalizeUV.m
step3：对得到的结果进行聚类分析，返回新的分类结果，使用litekmeans.m进行k-means聚类分析
step4：判断该算法优劣，对新分类结果与真值进行比较，使用MutualInfo.m计算互信息

函数定义如下：
function fea = tfidf(fea,bNorm)
function fea = NormalizeFea(fea,row,norm)
function W = constructW(fea,options)
function [U, V] = NormalizeUV(U, V, NormV, Norm)
function [label, center, bCon, sumD, D] = litekmeans(X, k, varargin)
function MIhat = MutualInfo(L1,L2)
