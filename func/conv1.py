def conv1(pattern):
  with open('ini.mc', mode='r') as f:
    initial = f.read()
  with open(file, mode='w') as f:
    f.write(initial)
  with open(file, mode='r') as f:
    list = f.readlines()
    all = len(list)
    x_send(all, pattern[0], pattern[1], pattern[2])
  with open(file, mode='r') as f:
    list = f.readlines()
    all = len(list)
    x_calc(all, pattern[3], pattern[4], pattern[5])
  with open(file, mode='r') as f:
    list = f.readlines()
    all = len(list)
    x_back(all, pattern[6], pattern[7], pattern[8])
  with open(file, mode='r') as f:
    list = f.readlines()
    i = 0
    rows = 0
    for line in list:
      if '#' in line: 
        list[rows] = '#%d\n' % i
        i += 1
      rows += 1
  with open(file, mode='w') as f:
    f.writelines(list)

def x_send(num, addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as f:
    list = f.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(num, '\n')
    list.insert(num, '//send\n')
    list.insert(num, '#1\n')
    list.insert(num, push('INST_RADDRX', addr, 16))
    list.insert(num, push('INST_RCEBX', 0, 1))
    list.insert(num, '\n')
    list.insert(num, '#2\n')
    list.insert(num, push('INST_WBUF_EN', 1, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', row, 6))
    list.insert(num, '\n')
    list.insert(num, '#3\n')
    list.insert(num, push('INST_COUNTER0_WE', 1, 1))
    list.insert(num, push('INST_COUNTER0', loop, 16))
    list.insert(num, '\n')
    list.insert(num, '#4\n')
    list.insert(num, push('INST_COUNTER0_WE', 0, 1))
    list.insert(num, push('INST_JUMP_COUNTER0', 1, 1))
    list.insert(num, push('INST_PC', 2, 32))
    list.insert(num, '\n')
    list.insert(num, '#5\n')
    list.insert(num, push('INST_JUMP_COUNTER0', 0, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', 1, 6))
    list.insert(num, '\n')
    list.insert(num, '#6\n')
    list.insert(num, push('INST_WBUF_EN', 0, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', 0, 6))
    list.insert(num, push('INST_RADDRX', -1, 16))
    list.insert(num, '\n')
    list.insert(num, '#7\n')
    list.insert(num, push('INST_RADDRX', 0, 16))
    with open(file, mode='w') as f:
      f.writelines(list)

def x_calc(num, addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as f:
    list = f.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(num, '\n')
    list.insert(num, '//calc\n')
    list.insert(num, '#1\n')
    list.insert(num, push('INST_RADDRX', addr, 16))
    list.insert(num, push('INST_RCEBX', 0, 1))
    list.insert(num, '\n')
    list.insert(num, '#2\n')
    list.insert(num, push('INST_WBUF_EN', 1, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', row, 6))
    list.insert(num, '\n')
    list.insert(num, '#3\n')
    list.insert(num, push('INST_COUNTER0_WE', 1, 1))
    list.insert(num, push('INST_COUNTER0', loop, 16))
    list.insert(num, '\n')
    list.insert(num, '#4\n')
    list.insert(num, push('INST_COUNTER0_WE', 0, 1))
    list.insert(num, push('INST_JUMP_COUNTER0', 1, 1))
    list.insert(num, push('INST_PC', 2, 32))
    list.insert(num, '\n')
    list.insert(num, '#5\n')
    list.insert(num, push('INST_JUMP_COUNTER0', 0, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', 1, 6))
    list.insert(num, '\n')
    list.insert(num, '#6\n')
    list.insert(num, push('INST_WBUF_EN', 0, 1))
    list.insert(num, push('INST_WBUF_EN_CTRL', 0, 6))
    list.insert(num, push('INST_RADDRX', -1, 16))
    list.insert(num, '\n')
    list.insert(num, '#7\n')
    list.insert(num, push('INST_RADDRX', 0, 16))
    with open(file, mode='w') as f:
      f.writelines(list)

def x_back(num, addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as l:
    list = l.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(num, '\n')
    num += 1
    list.insert(num, '//back\n')
    num += 1
    list.insert(num, '#1\n')
    num += 1
    list.insert(num, push('INST_RADDRX', addr, 16))
    num += 1
    list.insert(num, push('INST_RCEBX', 0, 1))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#2\n')
    num += 1
    list.insert(num, push('INST_WBUF_EN', 1, 1))
    num += 1
    list.insert(num, push('INST_WBUF_EN_CTRL', row, 6))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#3\n')
    num += 1
    list.insert(num, push('INST_COUNTER0_WE', 1, 1))
    num += 1
    list.insert(num, push('INST_COUNTER0', loop, 16))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#4\n')
    num += 1
    list.insert(num, push('INST_COUNTER0_WE', 0, 1))
    num += 1
    list.insert(num, push('INST_JUMP_COUNTER0', 1, 1))
    num += 1
    list.insert(num, push('INST_PC', 2, 32))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#5\n')
    num += 1
    list.insert(num, push('INST_JUMP_COUNTER0', 0, 1))
    num += 1
    list.insert(num, push('INST_WBUF_EN_CTRL', 1, 6))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#6\n')
    num += 1
    list.insert(num, push('INST_WBUF_EN', 0, 1))
    num += 1
    list.insert(num, push('INST_WBUF_EN_CTRL', 0, 6))
    num += 1
    list.insert(num, push('INST_RADDRX', -1, 16))
    num += 1
    list.insert(num, '\n')
    num += 1
    list.insert(num, '#7\n')
    num += 1
    list.insert(num, push('INST_RADDRX', 0, 16))
    with open(file, mode='w') as f:
      f.writelines(list)

def push(state, value, width):
  space = ''
  zero  = ''
  mask = (1 << width) - 1
  if value < 0:
    binary = bin((abs(value) ^ mask) + 1)[2:]
  else:
    binary = format(value, 'b')
    for a in range(width-len(str(binary))):
      zero = zero + '0'
    binary = zero + binary
  for n in range(24-len(state)):
    space = space + ' '
  return state + space + binary +'\n'


#命令のまとまりを指定位置に挿入する関数
def set_command(num, command, pattern): #挿入位置（#num以降に挿入）、挿入する命令のまとまり
  target = '#%d\n' % num
  rows = 0
  i = 0
  with open(file, mode='r') as f:
    list = f.readlines()
    for line in list:
      rows = rows + 1
      if '#' in line: 
        if line == target:
          command(rows-3, pattern[0], pattern[1], pattern[2])
  rows = 0
  with open(file, mode='r') as f:
    list = f.readlines()
    for line in list:
      rows = rows + 1
      if '#' in line: 
        list[rows-1] = '#%d\n' % i
        i = i + 1
  with open(file, mode='w') as f:
    f.writelines(list)

A = [1, 32, 1, 1, 32, 1, 1, 32, 1]
B = [16, 16, 1, 16, 16, 1, 16, 16, 1]
file = 'output.txt'
#conv1(B)

set_command(8, x_back, A)