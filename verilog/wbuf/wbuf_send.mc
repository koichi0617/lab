#0
INST_COUNTER0_WE        0 INST_COUNTER0のEN信号
INST_COUNTER1_WE        0 INST_COUNTER1のEN信号
INST_COUNTER2_WE        0 INST_COUNTER2のEN信号
INST_COUNTER3_WE        0 INST_COUNTER3のEN信号
INST_JUMP_COUNTER0      0 COUNTER0で指定したPCにジャンプ
INST_JUMP_COUNTER1      0 COUNTER1で指定したPCにジャンプ
INST_JUMP_COUNTER2      0 COUNTER2で指定したPCにジャンプ
INST_JUMP_COUNTER3      0 COUNTER3で指定したPCにジャンプ
INST_RADDRX_WE          0 INST_RADDRXのEN信号 0:加算 1:上書き
INST_WADDRX_WE          0 INST_WADDRXのEN信号
INST_RADDRW_WE          0 INST_RADDRWのEN信号
INST_RADDRX_BAK         0 RADDRXのバックアップ用レジスタのEN信号
INST_RADDRW_BAK         0 RADDRWのバックアップ用レジスタのEN信号
INST_WBUF_EN_CTRL_WE    0 INST_WBUF_EN_CTRLのEN信号 0:加算 1:上書き
INST_OUTPUT_EN_CTRL_WE  0 INST_OUTPUT_EN_CTRLのEN信号 0:加算 1:上書き
INST_UNUSED             0 機能なし
INST_PC                 00000000000000000000000000000000 プログラムカウンタ
INST_COUNTER0           0000000000000000 ループ回数
INST_COUNTER1           0000000000000000 ループ回数
INST_COUNTER2           0000000000000000 ループ回数
INST_COUNTER3           0000000000000000 ループ回数
INST_RADDRX             0000000000000000 入力用SRAMの読み込み用アドレス
INST_WADDRX             0000000000000000 入力用SRAMの書き込み用アドレス
INST_RADDRW             0000000000000000 重み用SRAMのアドレス
INST_BANKX              0 入力用SRAMのバンク選択信号
INST_WCEBX              1 重み用SRAMのチップENABLE
INST_RCEBX              1 入力用SRAMのチップENABLE
INST_REQX               0
INST_BANKW              0 重み用SRAMのバンク選択信号
INST_RCEBW              1 重み用SRAMのチップENABLE
INST_REQW               0
INST_WBUF_PURGE         0 WBUF用レジスタのソフトリセット
INST_WBUF_EN            0 PBの入力データ受け取りEN信号 
INST_WBUF_EN_CTRL       000000 どの列のPBに入力データを転送するかを指定 
INST_WBUF_ALL_EN        0 全てのPBに入力データを転送するENABLE信号
INST_SWITCH             0 演算に使う入力X用のレジスタとダブルバッファリングするためのレジスタの役割を切り替える信号
INST_FC_WEIGHT_EN       0 全結合層の重みが転送されたことをアドレスデコーダに伝える信号
INST_NL_EN              0 演算に用いる入力を保存するシフトレジスタのEN信号
INST_SHIFT_MODE         1 全てのPBの入力を同じ方向にシフトさせるシフト命令を有効にするための信号
INST_NL_SEL             11 シフト命令でどの方向のPBから入力Xを受け取るかを選択する信号
INST_MAC_EN             0 MAC演算のENABLE信号
INST_RESULT_REQ         0 MAC演算器に演算結果を出力するよう要求する信号
INST_OLSB               0100 MAC演算器が演算結果を出力する際、17bitの演算結果を8 bitに直す際にどのビットを最下位として切り取るかを指定する信号
INST_RESULT_PURGE       0 MAC演算器に17 bitの演算結果を消去させる信号
INST_OUTPUT_EN          0 PBからSRAMに演算結果を転送する際のENABLE信号
INST_OUTPUT_EN_CTRL     000000 演算結果をSRAMに転送するPBの列を指定する信号
INST_I_COMPARE_EN       0 SRAMからの入力Xを比較する際，比較器が比較を行うタイミングを指定するENABLE信号
INST_I_COMPARE_MODE     0 SRAMからの入力Xを比較する際，比較器が比較を行うかどうかを決定する信号
INST_I_COMPARE_SWITCH   0 比較器の2つあるレジスタのうち，どちらにSRAMからの入力Xを転送するかを決定する信号
INST_O_COMPARE_EN       0 SRAMからの入力Xを比較する際，比較器が比較を行うタイミングを指定するENABLE信号
INST_O_COMPARE_MODE     0 SRAMに演算結果を転送する際，比較器が比較を行うかどうかを決定する信号
INST_O_COMPARE_SWITCH   0 比較器の2つあるレジスタのうち，どちらにPBからの演算結果を転送するかを決定する信号
INST_CAL_MODE           0 全結合層の重み制御において、重み転送モードと演算モードを切り替える信号
INST_CONV_FC_MODE       0 畳み込み層モードと全結合層モードを切り替える信号（畳み込み層：0、全結合層：1）
INST_FEEDBACK_MODE      0 演算結果を入力にフィードバックさせる際に用いるモード選択信号
INST_CONF_EN            0 コンフィギュレーションデータのENABLE信号
INST_I_COMPARE_REGEN    0
INST_NL_LOOP_SEL        00 PB ARRAYのトーラス網の長さを選択する信号
INST_SEQ_LOAD_I         0 //FPGA
INST_SEQ_FIN            0 //FPGA
INST_SEQ_STARTW         0 //FPGA
INST_SEQ_STARTX         0 //FPGA
INST_SEQ_STARTX_OUT     0 //FPGA
INST_RCEBX0             1 //FPGA

//wbuf_send start
#1 データ取り出し
INST_RADDRX             0000000000000001 #取り出し場所指定 1ずつSRAMのアドレスを移動(_WEが０のため加算)
INST_RCEBX              0                #データを取り出す処理

//loop_to_here
#2 データ受け入れ
INST_WBUF_EN            1                #データを受け入れる処理
INST_WBUF_EN_CTRL       000000           #列指定してそこだけで処理

#3 ループの回数指定
INST_COUNTER0_WE        1 #回す回数を上書き
INST_COUNTER0           0000000000100000 #32回まわす

#4 ループのジャンプ先指定
INST_COUNTER0_WE        0
INST_JUMP_COUNTER0      1   #counter0を-1
INST_PC                 00000000000000000000000000000010  #ループのジャンプ場所→#2を指定

#5
INST_JUMP_COUNTER0      0   #counter0を固定
INST_WBUF_EN_CTRL       000001  #次の列に移動

#6 データ受け入れ中止
INST_WBUF_EN            0  #受け入れをやめる
INST_WBUF_EN_CTRL       000000 #PB列を固定（加算しない）
INST_RADDRX             1000000000000001 #SRAMのアドレスをひとつ戻す

#7
INST_RADDRX             0000000000000000 #アドレスを固定（加算しない）
//wbuf_send end
