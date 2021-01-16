#0
INST_COUNTER0_WE        0
INST_COUNTER1_WE        0
INST_COUNTER2_WE        0
INST_COUNTER3_WE        0
INST_JUMP_COUNTER0      0
INST_JUMP_COUNTER1      0
INST_JUMP_COUNTER2      0
INST_JUMP_COUNTER3      0
INST_RADDRX_WE          0
INST_WADDRX_WE          0
INST_RADDRW_WE          0
INST_RADDRX_BAK         0
INST_RADDRW_BAK         0
INST_WBUF_EN_CTRL_WE    0
INST_OUTPUT_EN_CTRL_WE  0
INST_UNUSED             0
INST_PC                 00000000000000000000000000000000
INST_COUNTER0           0000000000000000
INST_COUNTER1           0000000000000000
INST_COUNTER2           0000000000000000
INST_COUNTER3           0000000000000000
INST_RADDRX             0000000000000000
INST_WADDRX             0000000000000000
INST_RADDRW             0000000000000000
INST_BANKX              0
INST_WCEBX              1
INST_RCEBX              1
INST_REQX               0
INST_BANKW              0
INST_RCEBW              1
INST_REQW               0
INST_WBUF_PURGE         0
INST_WBUF_EN            0
INST_WBUF_EN_CTRL       000000
INST_ALL_EN             0
INST_SWITCH             0
INST_FC_WEIGHT_EN       0
INST_NL_EN              0
INST_SHIFT_MODE         1
INST_NL_SEL             11
INST_MAC_EN             0
INST_RESULT_REQ         0
INST_OLSB               0100
INST_RESULT_PURGE       0
INST_OUTPUT_EN          0
INST_OUTPUT_EN_CTRL     000000
INST_I_COMPARE_EN       0
INST_I_COMPARE_MODE     0
INST_I_COMPARE_SWITCH   0
INST_O_COMPARE_EN       0
INST_O_COMPARE_MODE     0
INST_O_COMPARE_SWITCH   0
INST_CAL_MODE           0
INST_CONV_FC_MODE       0
INST_FEEDBACK_MODE      0
INST_CONF_EN            0
INST_NL_LOOP_SEL        00
INST_SEQ_LOAD_I         0
INST_SEQ_FIN            0
INST_SEQ_STARTW         0
INST_SEQ_STARTX         0
INST_SEQ_STARTX_OUT     0
INST_RCEBX0             0
INST_I_COMPARE_REGEN    0

#1
INST_WADDRX             0000000000000000  #書き込むSRAMアドレスを指定
INST_WADDRX_WE          1 #SRAMのアドレスを上書き

//output_send start loop to here
#2
INST_OUTPUT_EN          1 #SRAMからPBが受け取る
INST_OUTPUT_EN_CTRL     000000  #PBの取り出す列を指定
INST_RESULT_PURGE       0 
INST_WCEBX              0 #SRAMにデータを書き込む処理
INST_WADDRX             0000000000000001  #書き込むSRAMアドレスを指定  1ずつ加算することでSRAMのアドレスを移動
INST_WADDRX_WE          0 #SRAMのアドレスを加算

#3 ループ回数指定
INST_WBUF_EN_CTRL       000000 #列指定してそこだけで処理
INST_COUNTER0_WE        1
INST_COUNTER0           00000000000000000000000001000000

#4 ループのジャンプ先指定
INST_WBUF_EN_CTRL       000000
INST_COUNTER0_WE        0
INST_JUMP_COUNTER0      1
INST_PC                 00000000000000000000000000000010  # ループ先に#2を指定

#5
INST_OUTPUT_EN          1
INST_JUMP_COUNTER0      0 #ジャンプ
INST_OUTPUT_EN_CTRL     000001  #次の列に移動

#6
INST_WBUF_EN_CTRL       000000
//output_send end

#7
INST_WBUF_EN_CTRL       000000