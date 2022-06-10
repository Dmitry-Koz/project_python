import os, random, string
import subprocess

def encrypt(file_name):

    # file_name = 'new_file.txt'

    date_file = subprocess.check_output(f'ls -i {file_name}', shell=True).decode('utf-8')
    first_num = str(date_file).split(' ')[0]
    second_num = str(date_file).split(' ')[0]

    second_num = int(str(date_file)[0] + str(date_file)[-1])
    first_num = int(str(date_file)[0] + str(date_file)[1])

    rnd_simbols = [random.choice(string.printable) for i in range(first_num)]
    before_str = ''.join(rnd_simbols)

    rnd_simbols = [random.choice(string.printable) for i in range(second_num)]
    after_str = ''.join(rnd_simbols)

    file = open(file_name, 'r')

    diff = int(str(date_file)[0])
    file_lines = file.readlines()
    file.close()
    newfile_lines = []
    for line in file_lines:
        new_line = ''
        for i in line:
            code = ord(i)
            if code + diff > 127:
                new_code = (code + diff) - 127
            else:
                new_code = code + diff
            new_line += chr(new_code)
        newfile_lines.append(new_line)


    newfile_lines.insert(0, before_str)
    newfile_lines.append(after_str)
    file = open(file_name, 'w')
    file.write(''.join(newfile_lines))
    file.close()



def decrypt(file_name):

    date_file = subprocess.check_output(f'ls -i {file_name}', shell=True).decode('utf-8')

    first_num = str(date_file).split(' ')[0]
    second_num = str(date_file).split(' ')[0]

    second_num = int(str(date_file)[0] + str(date_file)[-1])
    first_num = int(str(date_file)[0] + str(date_file)[1])


    file = open(file_name, 'r')

    diff = int(str(second_num)[0])
    file_lines = file.read()
    file.close()

    new_str = file_lines[first_num : -second_num]
    new_strfile = ''
    for i in new_str:
        code = ord(i)
        if (code - diff) < 0:
            new_code = 127 + (code - diff)
        else:
            new_code = code - diff
        new_strfile += chr(new_code)
    
    file = open(file_name, 'w')
    file.write(new_strfile)
    file.close()

answer = input("Enter encrypt or decrypt ")

if answer == 'encrypt':
    file_name = input("Enter file name ")
    encrypt(file_name)
elif answer == 'decrypt':
    file_name = input("Enter file name ")
    decrypt(file_name)
else:
    print('Try again')



