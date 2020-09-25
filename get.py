#!/usr/bin/python
# coding: UTF-8

#命令を1行書き込む
# def push(state, value):
#   with open('aaa.txt', mode='w') as f:
#     f.write(state)
#     for n in range(24-len(state)):
#       f.write(' ')
#     f.write(str(value))
#     f.write('\n')


def place(num):
  target = '#%d\n' % num
  row = 0
  i = 0
  with open(file, mode='r') as f:
    list = f.readlines()
    for line in list:
      row = row + 1
      if '#' in line: 
        i = i + 1
        if line == target:
          list.insert(row, 'aaa\n')
          with open(file, mode='w') as f:
            f.writelines(list)
            break

      if line == list[-1] and num > i:
        list.insert(row+1, '#%d\n' % i)
        list.insert(row+2, '\n')

file = 'output.txt'
state = 'aaa'
value = 1

place(5)
