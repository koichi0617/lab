#!/usr/bin/python
# coding: UTF-8
import sys

file = 'output.txt'
state = 'aaa'
value = 1

#命令を1行書き込む
def push(state, value):
  with open(file, mode='a') as f:
    f.write(state)
    for n in range(24-len(state)):
      f.write(' ')
    f.write(str(value))
    f.write('\n')


def place(num):
  with open(file, mode='r') as f:
    text = f.read()
    if ('#%d' % num) in text: #'#○'があったら、その下にpush
      push(state, value)
    else:
      line = f.readline()
      while line:
        if '#' in line:
          i = 0
          i += 1
          if i == num and line == ('#%d\n' % i):
            with open(file, mode='a') as f:
              f.write('\n')
              push(state, value)
              break

        line = f.readline()
        if line == '':
          with open(file, mode='a') as f:
            f.write('\n')
            f.write('#%d\n' % i)
          with open(file, mode='r') as f:
            line = f.readline()

place(2)
