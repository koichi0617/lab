
states = {'aaa': 1, 'bbb': 2, 'ccc': 3}

def push(states):
  with open('output.txt', mode='a') as f:
    keys = states.keys()
    values = states.values()
    for i in range(len(states)):
      f.write(keys[i])
      for num in range(24-len(keys[i])):
        f.write(' ')
      f.write(str(values[i]))
      f.write('\n')

with open('output.txt', mode='a') as f:
  
  push(states)
