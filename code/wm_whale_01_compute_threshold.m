% this script is used to compute hamming thresholds by using visual word
% and sift information

d = 128;
bits = 128;

[Q, ~] = qr (randn(d));
Q = Q(1:bits,:);

db_num_sift = load_ext(['../feature/' 'train_nsift.uint32']);
num_sift = sum(db_num_sift);

num_codebook = 200000;
threshold = zeros(bits,num_codebook); 

all_sift = load_ext('../feature/train_sift.uint8',128,num_sift);
all_vw   = load_ext('../feature/train_vw.int32');

% load('./projection_pitts.mat');
% Q = P;
% clear P;

for k1 = 1:num_codebook
   cur_sift = all_sift(:,all_vw == k1);
       
   vtest_root = zeros(128,size(cur_sift,2));
    for k2 = 1:size(cur_sift,2)
        tmp_v = single(cur_sift(:,k2)) / sum(cur_sift(:,k2));
        vtest_root(:,k2) = sqrt(tmp_v);
    end
   cur_proj = Q * double(vtest_root);
   threshold(:,k1) = median(cur_proj,2);
   
   if (k1/1000 == round(k1/1000))
    disp(k1);
   end
   
end

%save('projection_data_root_whale_64bits.mat','Q','threshold');
save('../codebook/projection_data_root_whale_128bits.mat','Q','threshold');
