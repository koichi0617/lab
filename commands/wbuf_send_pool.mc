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
INST_I_COMPARE_EN       0 //比較実行
INST_I_COMPARE_MODE     0 //比較モード
INST_I_COMPARE_SWITCH   0 //比較器のレジスタを切り替え
INST_I_COMPARE_REGEN    0 //SRAMから比較器へのデータ転送
INST_O_COMPARE_EN       0
INST_O_COMPARE_MODE     0
INST_O_COMPARE_SWITCH   0
INST_CAL_MODE           0
INST_CONV_FC_MODE       0
INST_FEEDBACK_MODE      0
INST_CONF_EN            0
INST_NL_LOOP_SEL        00
INST_NL_LOOP_SEL        00
INST_SEQ_LOAD_I         0
INST_SEQ_FIN            0
INST_SEQ_STARTW         0
INST_SEQ_STARTX         0
INST_SEQ_STARTX_OUT     0
INST_RCEBX0             0

//adrs = row0_depth = row1_depth
#1
INST_WBUF_PURGE         1

//wbuf_pool start
#2
INST_I_COMPARE_MODE     1 //縦二つの値を比較するモード
INST_WBUF_PURGE         0 //MAC演算機のレジスタをリセット
INST_RADDRX             0000000000000001
INST_RCEBX              0

#3
INST_WBUF_EN_CTRL_WE    0 //PB列加算モード
INST_I_COMPARE_REGEN    1 //SRAMから比較機へのデータ転送開始(現在のアドレスの値を転送)
INST_WBUF_EN_CTRL       000000 //PBの列指定

#4
INST_WBUF_EN_CTRL       000000 //１サイクルかせぐ

//RADDRX = adrs - 3
#5
INST_RADDRX             0000000001111101 //縦の比較のために125足す

#6
INST_RADDRX             0000000000000001 //アドレスの足す量を１に戻す

//loop to here
#7 PBの前に比較機にデータを送る処理
INST_WBUF_EN            0 //PBへのデータ受け入れ中止
INST_I_COMPARE_SWITCH   1 //比較機のレジスタを切り替え
INST_WBUF_EN_CTRL       000000
INST_RADDRX             0000000000000001

#8
INST_WBUF_EN_CTRL       000000 //かせぎ

//RADDRX = -(adrs - 1)
#9
INST_RADDRX             1000000001111111 //縦の比較のためにアドレスを戻している

#10
INST_RCEBX              1 //データ読み出しを中止
INST_RADDRX             0000000000000000

#11
INST_I_COMPARE_REGEN    0 //比較機への転送を中止

#12
INST_RCEBX              0 //データ読み出し開始
INST_I_COMPARE_EN       1 //比較機で比較（大きい方のデータを返す）
INST_RADDRX             0000000000000001

#13
INST_WBUF_EN            1 //PBへの受け入れ開始
INST_I_COMPARE_EN       0 //比較中止
INST_I_COMPARE_REGEN    1 //比較機へデータ転送
INST_I_COMPARE_SWITCH   0 //比較のレジスタは切り替えない

//COUNTER0 = adrs/4
#14
INST_COUNTER0_WE        1
INST_COUNTER0           0000000000100000 //ループ回数指定

//RADDRX = adrs - 3
#15
INST_COUNTER0_WE        0
INST_JUMP_COUNTER0      1
INST_PC                 00000000000000000000000000000111
INST_RADDRX             0000000001111101 //下の列に移動 +126

#16
INST_JUMP_COUNTER0      0 //ここでループ先にジャンプ
INST_WBUF_EN_CTRL       000001 //PB列移動
INST_RADDRX             0000000000000001
//loop end

#17
INST_WBUF_EN            0 //PB受け入れ中止
INST_RADDRX             1000000000000001
INST_I_COMPARE_REGEN    0 //比較への転送中止
INST_WBUF_EN_CTRL       000000 //PB列固定
INST_I_COMPARE_MODE     0 //比較中止
INST_I_COMPARE_SWITCH   0

#18
INST_RADDRX             0000000000000000
//wbuf_pool end

#
INST_RADDRX             0000000000000000
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0

#
INST_UNUSED             0