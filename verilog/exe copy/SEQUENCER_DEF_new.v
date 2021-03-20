//LOOP
`define INST_PC_S           0
`define INST_PC_E           15 
`define INST_COUNTER0_S     16
`define INST_COUNTER0_E     23
`define INST_COUNTER1_4_S   24
`define INST_COUNTER1_4_E   31
`define INST_COUNTER1_WE    32
`define INST_COUNTER2_WE    33
`define INST_COUNTER3_WE    34
`define INST_COUNTER4_WE    35
`define INST_JUMP_COUNTER1  36
`define INST_JUMP_COUNTER2  37
`define INST_JUMP_COUNTER3  38
`define INST_JUMP_COUNTER4  39

//WBUF_SEND
`define INST_WBUF_SEND      40
`define INST_WBUF_EN_CTRL_S 41
`define INST_WBUF_EN_CTRL_E 46
`define INST_RADDRX_WE      47
`define INST_RADDRX_S       48 
`define INST_RADDRX_E       63

//OUTPUT_SEND
`define INST_OUTPUT_SEND    64
`define INST_OUTPUT_EN_CTRL_S 65
`define INST_OUTPUT_EN_CTRL_E 70
`define INST_WADDRX_WE      71
`define INST_WADDRX_S       72
`define INST_WADDRX_E       87

//CONV_CAL
`define INST_CONV_CAL       88
`define INST_RADDRW_WE      89
`define INST_RADDRW_S       90 
`define INST_RADDRW_E       105

//WBUF_SEND_POOL
`define INST_WBUF_SEND_POOL   106

//OUTPUT_SEND_POOL
`define INST_OUTPUT_SEND_POOL 107

//FC
`define INST_FC_CAL           108

//その他
`define INST_BANKW              109
`define INST_BANKX              110
`define INST_REQX               111
`define INST_REQW               112
`define INST_WBUF_PURGE         113
`define INST_WBUF_ALL_EN        114
`define INST_WBUF_SWITCH        115
`define INST_SHIFT_MODE         116
`define INST_NL_SEL_S           117
`define INST_NL_SEL_E           118
`define INST_RESULT_REQ         119
`define INST_OLSB_S             120
`define INST_OLSB_E             123
`define INST_RESULT_PURGE       124
`define INST_CONV_FC_MODE       125
`define INST_FEEDBACK_MODE      126
`define INST_CONF_EN            127
`define INST_RCEBX0             128