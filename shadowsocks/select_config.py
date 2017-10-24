import os
import shutil
import subprocess

def select_copy_config():
    config_path = "/home/jeffery/.local/share/shadowsocksr/config.json"
    
    # get all the file names in current folder
    choice = []
    for file in os.listdir('.'):
            if os.path.splitext(file)[1] == '.json':
                choice.append(file)
    
    # print choose
    print("choose config file:")
    i = 0
    print('\t[{}] Do Nothing'.format(i))
    for file in choice:
        i = i + 1
        print('\t[{}] {}'.format(i, file))
    
    
    # check input choose
    selected = raw_input('Select Choose: ')
    while not (selected.isdigit() and int(selected) <= i):
        selected = raw_input('Select Choose: ')
    selected = int(selected)
    
    # copy file to folder
    if selected != 0:
        shutil.copy('./' + choice[selected - 1], config_path)
    
# check sudo
if __name__ == '__main__':
    if os.getuid() == 0:
        select_copy_config()
        subprocess.call('sudo ./ssr stop', shell=True)
        subprocess.call('sudo ./ssr start', shell=True)
    else:
        print('please add sudo to run the script')