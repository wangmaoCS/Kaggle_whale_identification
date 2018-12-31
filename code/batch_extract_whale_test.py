
import os
import time
import tarfile
import shutil

source_dir = '../data/train/'
target_dir = '../feature/train/'

#source_dir = '../data/test/'
#target_dir = '../feature/test/'

#source_dir = '../test_img/'
#target_dir = '../feature/'

cur_target_dir = target_dir
    
if not os.path.exists(cur_target_dir):
    os.mkdir(cur_target_dir)

cur_dir = source_dir
filenames = os.listdir(cur_dir)
num_img  = len(filenames)
        
#process all images
for k2 in range(num_img):
	img_name    = filenames[k2]
	source_file = source_dir + img_name
	target_file = target_dir + img_name.replace('.jpg','.ppm')
	cmd_line = 'jpegtopnm ' + source_file + ' > ' + target_file
	os.popen(cmd_line)    	
	time.sleep(1)    	
	cmd_line_extract = './hesaff ' + target_file   	
	os.popen(cmd_line_extract)    	
	time.sleep(1)   	
	cmd_line_delete  = 'rm ' + target_file   	
	os.popen(cmd_line_delete)     	
	print num_img,k2    
