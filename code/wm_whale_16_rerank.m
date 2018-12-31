
qPath = '../img/test_img/';
dbPath = '../img/train_img/';
load('../feature/test_fname.mat'); 
qImageFns  = dbImageFns;
load('../feature/train_fname.mat'); 

%load inital query result 
load('../result/result_list_top1000_52_knn5.mat');

num_query = length(qImageFns);
rank = 1000;

result_list_rerank = zeros(rank,num_query);

for k1 = 1:num_query

    
    num_inlier = zeros(rank,1);
    load(sprintf('../result/matches_sp/match_spTop1000_%05d.mat',k1));
    
    for k2 = 1:rank
        num_inlier(k2) = length(match_sp{k2});
    end
    
    [~,idx] = sort(num_inlier,'descend');
    result_list_rerank(:,k1) = result_list(idx,k1);
    
    disp(k1);
end

result_list = result_list_rerank;
save('../result/result_list_top1000_52_knn5_rerank.mat','result_list');
