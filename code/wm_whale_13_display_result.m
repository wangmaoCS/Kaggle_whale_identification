%load image data

qPath = '../img/test/';
dbPath = '../img/train/';

load('../feature/test_fname.mat'); 
qImageFns  = dbImageFns;

load('../feature/train_fname.mat'); 

%load inital query result 
%load('./result/result_list_top1000_24_knn5.mat');
load('../result/result_list_top1000_52_knn5.mat');

%load geom information
feature_path = '../feature/';
geom_db   = load_ext([feature_path 'train_geom.float'],5);
nsift_db  = load_ext([feature_path 'train_nsift.uint32']);
cndes_db  = [0 cumsum(double(nsift_db))];
geom_q    = load_ext([feature_path 'test_geom.float'],5);
nsift_q   = load_ext([feature_path 'test_nsift.uint32']);
cndes_q   = [0 cumsum(double(nsift_q))];

num_query = length(qImageFns);
rank = 1000;

for k1 = 42:num_query
    q_fname = qImageFns{k1};
    q_fname = [q_fname(1:end-15) 'jpg'];
    q_im    = imread([qPath q_fname]);    
    q_feat  = geom_q(:,cndes_q(k1)+1:cndes_q(k1+1));
    
   load(sprintf('../result/matches/matche_set_128bits_ht52_q%05d.mat',k1));
    for k2 = 1:1
       db_idx   = result_list(k2,k1);
       db_fname = dbImageFns{db_idx};
       db_fname = [db_fname(1:end-15) 'jpg'];
       db_im = imread([dbPath db_fname]);
       db_feat  = geom_db(:,cndes_db(db_idx)+1:cndes_db(db_idx+1));

%         match_idx = [];
%         disp_match_features_hesaff(q_im,db_im,q_feat,db_feat,match_idx,'r');
       
       match_idx = match_set{k2}(1:2,:);
       match_idx(1,:) = mod(match_idx(1,:),int32(nsift_q(k1)));
       match_idx(1,match_idx(1,:) == 0) = nsift_q(k1);
       disp_match_features_hesaff(q_im,db_im,q_feat,db_feat,match_idx,'r');
       
       fprintf('query: %d, database: %d\n', k1,k2);
    end
end

