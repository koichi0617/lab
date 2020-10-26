#0
INST_COUNTER0_WE        0
INST_COUNTER1_WE        0
INST_COUNTER2_WE        0
INST_COUNTER3_WE        0
INST_JUMP_COUNTER0      0
INST_JUMP_COUNTER1      0
INST_JUMP_COUNTER2      0
INST_JUMP_COUNTER3      0
INST_RADDRX_WE          0 # SRAM 0:加算 1:上書き
INST_WADDRX_WE          0
INST_RADDRW_WE          0
INST_RADDRX_BAK         0
INST_RADDRW_BAK         0
INST_WBUF_EN_CTRL_WE    0 # PB列について
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
INST_RCEBX0             1
INST_I_COMPARE_REGEN    0

//wbuf_send start
#1 データ取り出し
INST_RADDRX             0000000000000001 #取り出し場所指定 1ずつSRAMのアドレスを移動(_WEが０のため加算)
INST_RCEBX              0                #データを取り出す処理

//loop_to_here
#2 データ受け入れ
INST_WBUF_EN            1                #2bitずらすことでデータを受け入れる処理
INST_WBUF_EN_CTRL       000000           #列指定してそこだけで処理

#3 ループの回数指定
INST_COUNTER0_WE        1 #回す回数を固定
INST_COUNTER0           0000000000100000 #32回まわす

#4 ループのジャンプ先指定
INST_COUNTER0_WE        0
INST_JUMP_COUNTER0      1
INST_PC                 00000000000000000000000000000010  #ループのジャンプ場所→#2を指定

#5
INST_JUMP_COUNTER0      0   #INST_PCで指定した先にジャンプ
INST_WBUF_EN_CTRL       000001  #次の列に移動

#6 データ受け入れ中止
INST_WBUF_EN            0  #受け入れをやめる
INST_WBUF_EN_CTRL       000000 #PB列を固定（加算しない）
INST_RADDRX             1000000000000001 #SRAMのアドレスをひとつ戻す

#7
INST_RADDRX             0000000000000000 #アドレスを固定（加算しない）
//wbuf_send end
