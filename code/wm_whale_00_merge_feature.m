

db_feature_path= '../feature/';
%dir_name = 'train';
dir_name = 'test';

db_save_path = '../feature/';

db_feature_dir =  fullfile(db_feature_path, dir_name) ;
db_feature_dir =  [db_feature_dir '/'];

dbImageFns = struct2cell(dir([ db_feature_dir, '*.ppm.hesaff.sift']));
dbImageFns = dbImageFns(1,:);
numImages  = length(dbImageFns);

db_num_sift = zeros(numImages,1);
for k1 = 1:numImages

    cur_fname =  dbImageFns{k1};   
    fid = fopen([db_feature_dir cur_fname],'r');
    meta_infor = textscan(fid,'%d',2);
    
    n_dim = meta_infor{1}(1);
    if(n_dim ~= 128)
        disp('dim error\n');
    end
    
    cur_nsift = meta_infor{1}(2);    
    db_num_sift(k1) = cur_nsift;    

    fclose(fid);
         
    if(k1 / 100 == round(k1/100))
        disp(k1);
    end
end

%db_num_sift = load_ext([db_feature_dir 'Pitts_nsift_db.uint32']);
%numImages   = length(db_num_sift);

db_geom     = zeros(5, sum(db_num_sift(1:numImages)));
db_sift     = zeros(128, sum(db_num_sift(1:numImages)),'uint8');

idx = 0;
for k1 = 1:numImages

    cur_fname =  dbImageFns{k1};   
    fid = fopen([db_feature_dir cur_fname],'r');
    meta_infor = textscan(fid,'%d',2);
    
    n_dim = meta_infor{1}(1);
    if(n_dim ~= 128)
        disp('dim error\n');
    end
    
    cur_nsift = meta_infor{1}(2);    
    db_num_sift(k1) = cur_nsift;
    
    if(cur_nsift ~= db_num_sift(k1))
        disp('size of sift error\n');
    end
       
    cur_geoinfor = zeros(5,cur_nsift);
    cur_siftinfor = zeros(n_dim,cur_nsift);
    
    for k2 = 1:cur_nsift
       tmp_geo = textscan(fid,'%f',5); 
       cur_geoinfor(:,k2) = tmp_geo{1};
       tmp_sift = textscan(fid,'%d',n_dim); 
       cur_siftinfor(:,k2) = tmp_sift{1};
    end

    fclose(fid);
       
    db_geom(:,idx+1:idx+cur_nsift) = cur_geoinfor;
    db_sift(:,idx+1:idx+cur_nsift) = cur_siftinfor;
    idx = idx + cur_nsift;
    
    if(k1 / 100 == round(k1/100))
        disp(k1);
    end
end

save([db_save_path sprintf('%s_fname.mat',dir_name)], 'dbImageFns');
save_ext([db_save_path sprintf('%s_geom.float',dir_name)], db_geom);
save_ext([db_save_path sprintf('%s_sift.uint8',dir_name)], db_sift);
save_ext([db_save_path sprintf('%s_nsift.uint32',dir_name)], db_num_sift);