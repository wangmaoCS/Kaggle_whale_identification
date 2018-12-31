

load('../feature/test_fname.mat'); 
qImageFns  = dbImageFns;

load('../feature/train_fname.mat'); 

%load inital query result 
%load('../result/result_list_top1000_52_knn5.mat')
load('../result/result_list_top1000_52_knn5_rerank.mat')

db_id_fname = '../data/train.csv';

fid = fopen(db_id_fname);
db_id = textscan(fid,'%s %s','delimiter',',');
fclose(fid);

id_name = db_id{2}(2:end); %9850
num_query = length(qImageFns);

%fid = fopen('../result/wm_submission_he_128bits_5knn_52ht.csv','w');
fid = fopen('../result/wm_submission_he_128bits_5knn_52ht_sp.csv','w');

fprintf(fid,'Image,Id\n');
for k1 = 1:num_query
    q_fname = qImageFns{k1};
    q_fname = [q_fname(1:end-15) 'jpg'];
    
    fprintf(fid,'%s,',q_fname);
    for k2 = 1:4
        fprintf(fid,'%s ',id_name{result_list(k2,k1)});
    end
    fprintf(fid,'%s\n',id_name{result_list(k2+1,k1)});
    disp(k1);
end
fclose(fid);
