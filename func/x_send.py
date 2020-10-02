def conv1(pattern):
  with open('ini.mc', mode='r') as f:
    initial = f.read()
  with open(file, mode='w') as f:
    f.write(initial)
  with open(file, mode='a') as f:
    if pattern == 'A':
      x_send(A[0], A[1], A[2])
      x_calc(A[3], A[4], A[5])
      x_back(A[6], A[7], A[8])
    else:
      x_send(B[0], B[1], B[2])
      x_calc(B[3], B[4], B[5])
      x_back(B[6], B[7], B[8])
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

def x_send(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as f:
    list = f.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(-1, '\n')
    list.insert(-1, 'send')
    list.insert(-1, '#1\n')
    list.insert(-1, push('INST_RADDRX', addr, 16))
    list.insert(-1, push('INST_RCEBX', 0, 1))
    list.insert(-1, '\n')
    list.insert(-1, '#2\n')
    list.insert(-1, push('INST_WBUF_EN', 1, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', row, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#3\n')
    list.insert(-1, push('INST_COUNTER0_WE', 1, 1))
    list.insert(-1, push('INST_COUNTER0', loop, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#4\n')
    list.insert(-1, push('INST_COUNTER0_WE', 0, 1))
    list.insert(-1, push('INST_JUMP_COUNTER0', 1, 1))
    list.insert(-1, push('INST_PC', 2, 32))
    list.insert(-1, '\n')
    list.insert(-1, '#5\n')
    list.insert(-1, push('INST_JUMP_COUNTER0', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 1, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#6\n')
    list.insert(-1, push('INST_WBUF_EN', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 0, 6))
    list.insert(-1, push('INST_RADDRX', -1, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#7\n')
    list.insert(-1, push('INST_RADDRX', 0, 16))
    with open(file, mode='w') as f:
      f.writelines(list)

def x_calc(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as f:
    list = f.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(-1, '\n')
    list.insert(-1, '//calc')
    list.insert(-1, '#1\n')
    list.insert(-1, push('INST_RADDRX', addr, 16))
    list.insert(-1, push('INST_RCEBX', 0, 1))
    list.insert(-1, '\n')
    list.insert(-1, '#2\n')
    list.insert(-1, push('INST_WBUF_EN', 1, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', row, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#3\n')
    list.insert(-1, push('INST_COUNTER0_WE', 1, 1))
    list.insert(-1, push('INST_COUNTER0', loop, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#4\n')
    list.insert(-1, push('INST_COUNTER0_WE', 0, 1))
    list.insert(-1, push('INST_JUMP_COUNTER0', 1, 1))
    list.insert(-1, push('INST_PC', 2, 32))
    list.insert(-1, '\n')
    list.insert(-1, '#5\n')
    list.insert(-1, push('INST_JUMP_COUNTER0', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 1, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#6\n')
    list.insert(-1, push('INST_WBUF_EN', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 0, 6))
    list.insert(-1, push('INST_RADDRX', -1, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#7\n')
    list.insert(-1, push('INST_RADDRX', 0, 16))
    with open(file, mode='w') as f:
      f.writelines(list)

def x_back(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  with open(file, mode='r') as f:
    list = f.readlines()
    # #0の末尾は最後の命令から２回改行
    list.insert(-1, '\n')
    list.insert(-1, '//back')
    list.insert(-1, '#1\n')
    list.insert(-1, push('INST_RADDRX', addr, 16))
    list.insert(-1, push('INST_RCEBX', 0, 1))
    list.insert(-1, '\n')
    list.insert(-1, '#2\n')
    list.insert(-1, push('INST_WBUF_EN', 1, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', row, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#3\n')
    list.insert(-1, push('INST_COUNTER0_WE', 1, 1))
    list.insert(-1, push('INST_COUNTER0', loop, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#4\n')
    list.insert(-1, push('INST_COUNTER0_WE', 0, 1))
    list.insert(-1, push('INST_JUMP_COUNTER0', 1, 1))
    list.insert(-1, push('INST_PC', 2, 32))
    list.insert(-1, '\n')
    list.insert(-1, '#5\n')
    list.insert(-1, push('INST_JUMP_COUNTER0', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 1, 6))
    list.insert(-1, '\n')
    list.insert(-1, '#6\n')
    list.insert(-1, push('INST_WBUF_EN', 0, 1))
    list.insert(-1, push('INST_WBUF_EN_CTRL', 0, 6))
    list.insert(-1, push('INST_RADDRX', -1, 16))
    list.insert(-1, '\n')
    list.insert(-1, '#7\n')
    list.insert(-1, push('INST_RADDRX', 0, 16))
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


A = [1, 32, 1, 1, 32, 1, 1, 32, 1]
B = [16, 16, 1, 16, 16, 1, 16, 16, 1]
file = 'output.txt'
conv1('B')
