import os
import sys
import shutil
import subprocess


def select_copy_config():
    if sys.platform == 'linux' or sys.platform == 'linux2':
        # linux
        config_path = '/home/jeffery/.local/share/shadowsocksr/config.json'
    elif sys.platform == 'darwin':
        # OSX
        config_path = '/Users/jeffery/.local/share/shadowsocksr/config.json'

    # get all the file names in current folder
    choice = []
    for file in os.listdir('.'):
        if file.endswith('.json'):
            choice.append(file)

    # print choose
    print("choose config file:")
    for (i, file) in enumerate(choice):
        print('\t[{0}] {1}'.format(i + 1, file))

    # check input choose
    selected = input('Please select choose: ')
    while not selected.isdigit() or int(selected) < 0 or int(selected) > len(choice):
        selected = input('Input error, please select choose: ')

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
