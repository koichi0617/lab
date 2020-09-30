def command1(sharp_num):
  sharp(sharp_num)



def sharp(num):
  state = 'INST_COUNTER0_WE'
  value = 32
  push()
  push()
  return 



def push(state, value, width):
  bin = format(value, 'b')
  space = ''
  zero  = ''
  for a in range(width-len(str(bin))):
    zero = zero + '0'
  for n in range(24-len(state)):
    space = space + ' '
  return state + space + zero + str(bin) +'\n'
