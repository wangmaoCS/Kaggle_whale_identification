
%load codebook
load('../codebook/Whale_train_rootsift_18M_200k_clst_30iter');

db_save_path = '../feature/'; 


cur_feature_path = db_save_path;

sub_feature_fname = struct2cell(dir([cur_feature_path '*_sift.uint8']));
sub_feature_fname = sub_feature_fname(1,:);

slicesize = 10000;
knn = 5;

%for k1 = 2:length(sub_feature_fname)
for k1 = 1:1

   sift = load_ext([cur_feature_path sub_feature_fname{k1}],128);
   nsift = load_ext([cur_feature_path sub_feature_fname{k1}(1:end-10) 'nsift.uint32']);
   num_sift = size(sift,2);
   
   if(sum(nsift) ~= num_sift)
       disp('error');
       break;
   end
   
   vw = zeros(knn,num_sift);
   for k2 = 1:slicesize:num_sift
       endi = min(k2+slicesize-1, num_sift);               
       
       cur_sift = single(sift(:,k2:endi));        
       for k3 = 1:size(cur_sift,2)            
           tmp_v = cur_sift(:,k3) / sum(cur_sift(:,k3));
           cur_sift(:,k3) = sqrt(tmp_v);
       end
        
        [cur_vw,cur_dis] = yael_nn(codebook, cur_sift, knn);
        vw(1:knn,k2:endi) = cur_vw; 
        fprintf('%d-%d-%d\n',k1,endi,num_sift);
   end
      
   %vw_fname = [cur_feature_path sprintf('%s_vw.int32',sub_feature_fname{k1}(1:end-11))];
   vw_fname = [cur_feature_path sprintf('%s_vw_knn%d.int32',sub_feature_fname{k1}(1:end-11),knn)];
   save_ext(vw_fname,vw);  
   disp(k1);
end

knn = 1 ;
for k1 = 2:length(sub_feature_fname)
    
   sift = load_ext([cur_feature_path sub_feature_fname{k1}],128);
   nsift = load_ext([cur_feature_path sub_feature_fname{k1}(1:end-10) 'nsift.uint32']);
   num_sift = size(sift,2);
   
   if(sum(nsift) ~= num_sift)
       disp('error');
       break;
   end
   
   vw = zeros(knn,num_sift);
   for k2 = 1:slicesize:num_sift
       endi = min(k2+slicesize-1, num_sift);               
       
       cur_sift = single(sift(:,k2:endi));        
       for k3 = 1:size(cur_sift,2)            
           tmp_v = cur_sift(:,k3) / sum(cur_sift(:,k3));
           cur_sift(:,k3) = sqrt(tmp_v);
       end
        
        [cur_vw,cur_dis] = yael_nn(codebook, cur_sift, knn);
        vw(1:knn,k2:endi) = cur_vw; 
        fprintf('%d-%d-%d\n',k1,endi,num_sift);
   end
      
   vw_fname = [cur_feature_path sprintf('%s_vw.int32',sub_feature_fname{k1}(1:end-11))];
   %vw_fname = [cur_feature_path sprintf('%s_vw_knn%d.int32',sub_feature_fname{k1}(1:end-11),knn)];
   save_ext(vw_fname,vw);  
   disp(k1);
end