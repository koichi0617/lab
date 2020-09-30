#!/usr/bin/python
# coding: UTF-8

#命令を1行生成する
def push(state, bin, width):
  space = ''
  zero  = ''
  for a in range(width-len(str(bin))):
    zero = zero + '0'
  for n in range(24-len(state)):
    space = space + ' '
  return state + space + zero + str(bin) +'\n'


def place(num, state, value, width): #(#num, 命令, 値, ビット幅)
  bin = format(value, 'b')
  if width < len(str(bin)):
    print('Error : Bit width is too short or value is too long.')
  else:
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
            list.insert(row, push(state, bin, width))
            with open(file, mode='w') as f:
              f.writelines(list)
            break


        if row == len(list) and num >= i:
          if not line == '\n':
            list.insert(row, '\n')
          list.insert(row+1, '#%d\n' % i)
          list.insert(row+2, '\n')
          with open(file, mode='w') as f:
            f.writelines(list)

file = 'output.txt'
state = 'aaa'
value = 1


#place(4, 'INST_COUNTER3_WE', 100, 8) 

def insert(num, command): # num:挿入したい箇所の＃番号, command:挿入したい命令
  point = '#%d\n' % num
  row = 0
  i = 0
  with open(file, mode='r') as f:
    list = f.readlines()
    for line in list:
      row = row + 1
      if '#' in line: 
        i = i + 1
        if line == point:
          list.insert(row-1, command)
          with open(file, mode='w') as f:
            f.writelines(list)
        line = '#%d\n' % i

command = "#1\nINST_RADDRX             0000000000000001\nINST_RCEBX              0\n\n#2\nINST_WBUF_EN            1\nINST_WBUF_EN_CTRL       000000\n\n"

insert(3, command)