# for num in range(10):
#   push(num, aaa, 1)

def push(state, value):
  with open('output.txt', mode='a') as f:
    f.write(state)
    for num in range(24-len(state)):
      f.write(' ')
    f.write(value)


push('aaa', '1')
