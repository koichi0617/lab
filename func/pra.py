# coding: UTF-8

d = {'INST_COUNTER0_WE':0, 'INST_COUNTER3_WE':0, 'INST_COUNTER2_WE':32}

print("keys=")
print(d.keys())

for k in d.keys():
  d_keys = []
  d_keys.append(k)

print(d_keys[0])
print(d[d_keys[0]])

def conv1():
  xsend(~)
  calc(~)

def xsend(num,addr,loop):
  place(num, "INST_RADDRX", addr, 16)
  place(num, "INST_RCEBX",  0, 1)

   

  place(num+2, "INST_COUNTER0",loop,16)