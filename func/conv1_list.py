# 指定した命令の組み合わせをまとめて出力する関数
def conv1():
  # #0の記述を別ファイルからコピー
  with open('ini.mc', mode='r') as f:
    initial = f.read()
  with open(file, mode='w') as f:
    f.write(initial)
  # 命令のまとまりを出力
  commands = cal_wbuf_pool(1,1,1) + wbuf_send(1,1,1) + conv_cal(1,1,1)
  with open(file, mode='a') as f:
    f.writelines(commands)
  # #の番号を昇順にそろえる
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
  list = []
  list.append('//send\n')
  list.append('#1\n')
  list.append(push('INST_RADDRX', addr, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append('\n')
  list.append('#2\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', row, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', loop, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', -1, 16))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append('\n')
  return list

def x_calc(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//calc\n')
  list.append('#1\n')
  list.append(push('INST_RADDRX', addr, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append('\n')
  list.append('#2\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', row, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', loop, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', -1, 16))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append('\n')
  return list

def x_back(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//back\n')
  list.append('#1\n')
  list.append(push('INST_RADDRX', addr, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append('\n')
  list.append('#2\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', row, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', loop, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', -1, 16))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append('\n')
  return list

def cal_wbuf_pool(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//cal + wbuf_pool')
  list.append('#1\n')
  list.append(push('INST_WBUF_PURGE', 1, 16))
  list.append('\n')
  list.append('#2\n')
  list.append(push('INST_I_COMPARE_MODE', 1, 1))
  list.append(push('INST_WBUF_PURGE', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBX', 0, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_WBUF_EN_CTRL_WE', 0, 1))
  list.append(push('INST_I_COMPARE_REGEN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('//RADDRX = adrs - 3\n')
  list.append('#5\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 125, 16))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RCEBW', 0, 1))
  list.append('\n')
  list.append('//loop to here\n')
  list.append('#7\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 1, 1))
  list.append(push('INST_MAC_EN', 1, 1))
  list.append('\n')
  list.append('#8\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_MAC_EN', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('//RADDRX = -(adrs - 1)\n')
  list.append('#9\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#10\n')
  list.append(push('INST_RCEBX', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#11\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_REGEN', 0, 0))
  list.append(push('INST_NL_EN', 0, 0))
  list.append('\n')
  list.append('#12\n')
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_EN', 1, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 1, 1))
  list.append(push('INST_MAC_EN', 1, 1))
  list.append('\n')
  list.append('#13\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_I_COMPARE_EN', 0, 1))
  list.append(push('INST_I_COMPARE_REGEN', 1, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 0, 1))
  list.append(push('INST_MAC_EN', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('//COUTER0 = adrs/4\n')
  list.append('#14\n')
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 32, 16))
  list.append(push('INST_RADDRW', 0, 16))
  list.append('\n')
  list.append('//RADDRX = adrs - 3\n')
  list.append('#15\n')
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 7, 32))
  list.append(push('INST_RADDRX', 125, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#16\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_NL_EN', 0, 1))
  list.append('\n')
  list.append('#17\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_I_COMPARE_REGEN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_MODE', 0, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 0, 1))
  list.append(push('INST_RCEBW', 1, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 0, 1))
  list.append('\n')
  list.append('#18\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_RADDRW', 0, 16))
  list.append('//wbuf_pool end\n')
  list.append('#\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_UNUSED', 0, 1))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 1))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 1))
  list.append('\n')
  list.append('#\n')        
  list.append(push('INST_UNUSED', 0, 1))      
  list.append('\n')
  list.append('#\n')    
  list.append(push('INST_UNUSED', 0, 1))
  list.append('\n')    
  list.append('#\n')    
  list.append(push('INST_UNUSED', 0, 1))    
  list.append('\n')    
  list.append('#\n')    
  list.append(push('INST_UNUSED', 0, 1))    
  list.append('\n')    
  list.append('#\n')    
  list.append(push('INST_UNUSED', 0, 1))    
  list.append('\n')    
  list.append('#\n')    
  list.append(push('INST_UNUSED', 0, 1))
  list.append('\n')
  return list

def cal_wbuf_out(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//cal+wbuf+out\n')
  list.append('#1\n')
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RCEBW', 0, 1))
  list.append(push('INST_OUTPUT_EN_CTRL_WE', 1, 1))
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_WBUF_PURGE', 1, 1))
  list.append('\n')
  list.append('//loop_to_here\n')
  list.append('#2\n')
  list.append(push('INST_OUTPUT_EN_CTRL_WE', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL_WE', 0, 1))
  list.append(push('INST_WCEBX', 0, 1))
  list.append(push('INST_WADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 1, 1))
  list.append(push('INST_MAC_EN', 1, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_WBUF_PURGE', 0, 1))
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_MAC_EN', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_RADDRW', 0, 16))
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 32, 16))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append(push('INST_RCEBX', 1, 1))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_WCEBX', 1, 1))
  list.append(push('INST_WADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append(push('INST_NL_EN', 0, 1))
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append('\n')
  list.append('//conv_cal_loop end\n')
  list.append('#7\n')
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBW', 1, 1))
  list.append(push('INST_RCEBX', 1, 1))
  list.append(push('INST_NL_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#8\n')
  list.append(push('INST_RADDRW', 0, 16))
  list.append(push('INST_RADDRX', 0, 16))
  list.append('//conv_cal+wbuf+out end')
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  return list

def conv_cal(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//conv_cal\n')
  list.append('#1\n')
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RCEBW', 0, 1))
  list.append('\n')
  list.append('//loop_to_here\n')
  list.append('#2\n')
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 1, 1))
  list.append(push('INST_MAC_EN', 1, 1))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_MAC_EN', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_RADDRW', 0, 16))
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 64, 16))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_NL_EN', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('//conv_cal_loop end\n')
  list.append('#7\n')
  list.append(push('INST_RCEBW', 1, 1))
  list.append(push('INST_RADDRW', 1, 1))
  list.append(push('INST_NL_EN', 0, 1))
  list.insert(-1,'\n')
  list.append('#8\n')
  list.append(push('INST_RADDRW', 0, 16))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  return list

def conv_cal_wbuf(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//conv_cal+wbuf start\n')
  list.append('#1\n')
  list.append(push('INST_WBUF_PURGE', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL_WE', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_RCEBW', 0, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append('\n')
  list.append('//loop_to_here\n')
  list.append('#2\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_PURGE', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL_WE', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 1, 1))
  list.append(push('INST_MA_EN', 1, 1))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_MAC_EN', 0, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_RADDRW', 0, 16))
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 64, 16))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_RCEBX', 1, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_NL_EN', 0, 1))
  list.append(push('INST_JUMP_COUNTER0',  0, 0))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('//conv_cal_loop end\n')
  list.append('#7\n')
  list.append(push('INST_RCEBX', 1, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBW', 1, 1))
  list.append(push('INST_RADDRW', 1, 16))
  list.append(push('INST_NL_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.insert(-1,'\n')
  list.append('#8\n')
  list.append(push('INST_NL_EN', 0, 0))
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_RADDRW', 0, 16))
  list.append('//conv_cal+wbuf end\n')
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  return list

def output_send(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('#1\n')
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_WADDRX_WE', 1, 1))
  list.append('\n')
  list.append('//output_send start loop to here\n')
  list.append('#2\n')
  list.append(push('INST_OUTPUT_EN', 1, 1))
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_RESULT_PURGE', 0, 1))
  list.append(push('INST_WCEBX', 0, 1))
  list.append(push('INST_WADDRX', 1, 16))
  list.append(push('INST_WADDRX_WE', 0, 1))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_COUNTER0', 64, 32))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_OUTPUT_EN', 1, 1))
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('//output_send end')
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_WBUF_EN_CTRL', 1, 1))
  list.append('\n')
  return list

def output_send_pool(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('#1\n')
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_WADDRX_WE', 1, 1))
  list.append('\n')
  list.append('//output_send_pool start\n')
  list.append('#2\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_O_COMPARE_SWITCH', 1, 1))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#8\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#9\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_OUTPUT_EN', 0, 1))
  list.append(push('INST_O_COMPARE_EN', 1, 1))
  list.append('\n')
  list.append('//loop to here\n')
  list.append('#10\n')
  list.append(push('INST_WCEBX', 0, 1))
  list.append(push('INST_O_COMPARE_EN', 0, 1))
  list.append(push('INST_O_COMPARE_SWITCH', 0, 1))
  list.append(push('INST_OUTPUT_EN', 0, 1))
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_WADDRX', 1, 16))
  list.append('\n')
  list.append('#11\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#12\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#13\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#14\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_WCEBX', 1, 6))
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_O_COMPARE_SWITCH', 1, 1))
  list.append('\n')
  list.append('#15\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#16\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#17\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 1, 6))
  list.append(push('INST_COUNNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 31, 16))
  list.append('\n')
  list.append('#18\n')
  list.append(push('INST_OUTPUT_EN_CTRL', 0, 6))
  list.append(push('INST_OUTPUT_EN', 0, 1))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 11, 32))
  list.append('\n')
  list.append('#19\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_O_COMPARE_EN', 1, 1))
  list.append('\n')
  list.append('//loop end')
  list.append('#20\n')
  list.append(push('INST_OUTPUT_EN', 1, 1))
  list.append(push('INST_O_COMPARE_SWITCH', 0, 1))
  list.append(push('INST_O_COMPARE_EN', 0, 1))
  list.append(push('INST_WADDRX', 1, 16))
  list.append(push('INST_WCEBX', 0, 1))
  list.append('\n')
  list.append('#21\n')
  list.append(push('INST_WADDRX', 1, 16))
  list.append('\n')
  list.append('#22\n')
  list.append(push('INST_WADDRX', 1, 16))
  list.append('\n')
  list.append('#23\n')
  list.append(push('INST_WADDRX', 1, 16))
  list.append('\n')
  list.append('#24\n')
  list.append(push('INST_OUTPUT_EN', 0, 1))
  list.append(push('INST_O_COMPARE_MODE', 0, 1))
  list.append(push('INST_WADDRX', 0, 16))
  list.append(push('INST_WCEBX', 1, 1))
  list.append('\n')
  list.append('//output_send_pool\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  return list

def wbuf_send(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//wbuf_send start\n')
  list.append('#1\n')
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_WBUF_PURGE', 1, 1))
  list.append('\n')
  list.append('//loop to here\n')
  list.append('#2\n')
  list.append(push('INST_WBUF_PURGE', 0, 1))
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 32, 16))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 2, 32))
  list.append('\n')
  list.append('#5\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append('//wbu_send end\n')
  list.append('\n')
  return list

def wbuf_send_pool(addr, loop, row): #(SRAM開始アドレス、ループ回数、挿入開始列)
  list = []
  list.append('//adrs = row0_depth = row1_depth\n')
  list.append('#1\n')
  list.append(push('INST_WBUF_PURGE', 1, 1))
  list.append('\n')
  list.append('//wbuf_pool start\n')
  list.append('#2\n')
  list.append(push('INST_I_COMPARE_MODE', 1, 1))
  list.append(push('INST_WBUF_PURGE', 0, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_RCEBX', 0, 1))
  list.append('\n')
  list.append('#3\n')
  list.append(push('INST_WBUF_EN_CTRL_WE', 0, 1))
  list.append(push('INST_I_COMPARE_REGEN', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('#4\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('\n')
  list.append('//RADDRX = adrs - 3\n')
  list.append('#5\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 127, 16))
  list.append('\n')
  list.append('#6\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#7\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#8\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append('//RADDRX = -(adrs - 1)\n')
  list.append('\n')
  list.append('#9\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#10\n')
  list.append(push('INST_RCEBX', 1, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_RADDRX', 0, 16))
  list.append('\n')
  list.append('#11\n')
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_REGEN', 0, 1))
  list.append('\n')
  list.append('#12\n')
  list.append(push('INST_RCEBX', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_EN', 1, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#13\n')
  list.append(push('INST_WBUF_EN', 1, 1))
  list.append(push('INST_I_COMPARE_EN', 0, 1))
  list.append(push('INST_I_COMPARE_REGEN', 1, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 0, 1))
  list.append('\n')
  list.append('//COUNTER0 = adrs/4\n')
  list.append('#14\n')
  list.append(push('INST_COUNTER0_WE', 1, 1))
  list.append(push('INST_COUNTER0', 1, 1))
  list.append('\n')
  list.append('//RADDRX = adrs - 3\n')
  list.append('#15\n')
  list.append(push('INST_COUNTER0_WE', 0, 1))
  list.append(push('INST_JUMP_COUNTER0', 1, 1))
  list.append(push('INST_PC', 7, 32))
  list.append(push('INST_RADDRX', 127, 16))
  list.append('\n')
  list.append('#16\n')
  list.append(push('INST_JUMP_COUNTER0', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 1, 6))
  list.append(push('INST_RADDRX', 1, 16))
  list.append('\n')
  list.append('#17\n')
  list.append(push('INST_WBUF_EN', 0, 1))
  list.append(push('INST_RADDRX', 1, 16))
  list.append(push('INST_I_COMPARE_REGEN', 0, 1))
  list.append(push('INST_WBUF_EN_CTRL', 0, 6))
  list.append(push('INST_I_COMPARE_MODE', 0, 1))
  list.append(push('INST_I_COMPARE_SWITCH', 0, 1))
  list.append('\n')
  list.append('#18\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append('//wbuf_pool end\n')
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_RADDRX', 0, 16))
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  list.append('#\n')
  list.append(push('INST_UNUSED', 0, 0))
  list.append('\n')
  return list


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


# 命令のまとまりを指定位置に挿入する関数
def set_command(num, command): #挿入位置（#num以降に挿入）、挿入する命令のまとまり
  target = '#%d\n' % num
  rows = 0
  i = 0
  # 指定した#の行にたどり着いたら命令を出力
  with open(file, mode='r') as f:
    list = f.readlines()
    for line in list:
      rows = rows + 1
      if line == target:
        list1 = list[:rows-1]
        list2 = list[rows:]
        list_in = command(1, 1, 1)
        list_com = list1 + list_in + list2
  # #の番号を昇順にそろえる
  rows = 0
  for line in list_com:
    rows = rows + 1
    if '#' in line: 
      list_com[rows - 1] = '#%d\n' % i
      i = i + 1
  with open(file, mode='w') as f:
    f.writelines(list_com)


A = [1, 32, 1, 1, 32, 1, 1, 32, 1]
B = [16, 16, 1, 16, 16, 1, 16, 16, 1]
file = 'output.txt'
conv1()
set_command(50, x_back)