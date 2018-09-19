import os
import shutil
import subprocess

def select_copy_config():
    config_path = "/home/jeffery/.local/share/shadowsocksr/config.json"
    
    # get all the file names in current folder
    choice = []
    for file in os.listdir('.'):
        if file.endswith('.json'):
            choice.append(file)
    
    # print choose
    print("choose config file:")
    for (i, file) in enumerate(choice):
        print('\t[{}] {}'.format(i = 1, file))
    
    
    # check input choose
    selected = raw_input('Please Select Choose: ')
    while not (selected.isdigit() and int(selected) >=0 and int(selected) <= len(choice)):
        selected = raw_input('Input Error, Please Select Choose: ')
    
    # copy file to folder
    selected = int(selected)
    shutil.copy('./' + choice[selected - 1], config_path)
    
# check sudo
if __name__ == '__main__':
    if os.getuid() == 0:
        select_copy_config()
        subprocess.call('sudo ./ssr stop', shell=True)
        subprocess.call('sudo ./ssr start', shell=True)
    else:
        print('please add sudo to run the script')