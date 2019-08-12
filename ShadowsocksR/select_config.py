import os
import sys
import shutil
import subprocess


def select_copy_config(folder):
    if sys.platform == 'linux' or sys.platform == 'linux2':
        # linux
        config_path = '/home/jeffery/.local/share/shadowsocksr/config.json'
    elif sys.platform == 'darwin':
        # OSX
        config_path = '/Users/test/.local/share/shadowsocksr/config.json'

    # get all the file names in current folder
    choices = []
    for file in os.listdir(folder):
        if file.endswith('.json'):
            choices.append(file)
    print(choices)

    # print choose
    print('choose config file:')
    for (i, file) in enumerate(choices):
        print('\t[{0}] {1}'.format(i, file))

    # check input choose
    selected = input('Please select choose: ')
    while not selected.isdigit() or int(selected) < 0 or int(selected) > len(choices):
        selected = input('Input error, please select choose: ')

    # copy file to folder
    selected = int(selected)
    shutil.copy(os.path.join(folder, choices[selected]), config_path)


if __name__ == '__main__':
    folder = os.path.dirname(os.path.realpath(__file__))
    # check sudo
    if os.getuid() == 0:
        select_copy_config(folder)
        subprocess.call('sudo ' + os.path.join(folder, 'ssr') + ' restart', shell=True)
    else:
        print('please add sudo to run the script')
