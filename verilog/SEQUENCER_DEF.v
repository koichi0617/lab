//-----------------------------------------------------------------------------
// Title         : Microcode bit definition for SEQUENCER module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : SEQUENCER_DEF.v
// Author        : Qian ZHAO <cho@ai.kyutech.ac.jp>
//                 Yasuhiro NAKAHARA <nakahara@arch.cs.kumamoto-u.ac.jp>
// Created       : 30.07.2019
// Last modified : 30.07.2019
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2019 by Kumamoto Univ. This model is the confidential and
// proprietary property of Kumamoto Univ. and the possession or use of this
// file requires a written license from Kumamoto Univ.
//-----------------------------------------------------------------------------
// Modification history :
//      2019.08.21:  Added WAIT support when transfering memw, memx.
//-----------------------------------------------------------------------------
`define INST_CTRL_WIDTH 144

`define INST_COUNTER0_WE 0
`define INST_COUNTER1_WE 1
`define INST_COUNTER2_WE 2
`define INST_COUNTER3_WE 3
`define INST_JUMP_COUNTER0 4
`define INST_JUMP_COUNTER1 5
`define INST_JUMP_COUNTER2 6
`define INST_JUMP_COUNTER3 7
`define INST_RADDRX_WE 8
`define INST_WADDRX_WE 9
`define INST_RADDRW_WE 10
`define INST_RADDRX_BAK 11
`define INST_RADDRW_BAK 12
`define INST_WBUF_EN_CTRL_WE 13
`define INST_OUTPUT_EN_CTRL_WE 14

`define INST_OP_S 0
`define INST_OP_E 15
`define INST_PC_S 16
`define INST_PC_E 47
`define INST_COUNTER0_S 48
`define INST_COUNTER0_E 63
`define INST_COUNTER1_S 64
`define INST_COUNTER1_E 79
`define INST_COUNTER2_S 80
`define INST_COUNTER2_E 95
`define INST_COUNTER3_S 96
`define INST_COUNTER3_E 111
`define INST_RADDRX_S 112
`define INST_RADDRX_E 127
`define INST_WADDRX_S 128
`define INST_WADDRX_E 143
`define INST_RADDRW_S 144
`define INST_RADDRW_E 159
`define INST_CTRL_S 160
`define INST_CTRL_E 255

//For MEM X
`define INST_BANKX 160
`define INST_WCEBX 161
`define INST_RCEBX 162
`define INST_REQX 163

//For MEM W
`define INST_BANKW 164
`define INST_RCEBW 165
`define INST_REQW 166

//For PB Array
`define INST_WBUF_PURGE 167
`define INST_WBUF_EN 168
`define INST_WBUF_EN_CTRL_S 169
`define INST_WBUF_EN_CTRL_E 174
`define INST_WBUF_ALL_EN 175
`define INST_WBUF_SWITCH 176
`define INST_FC_WEIGHT_EN 177
`define INST_NL_EN 178
`define INST_SHIFT_MODE 179
`define INST_NL_SEL_S 180
`define INST_NL_SEL_E 181
`define INST_MAC_EN 182
`define INST_RESULT_REQ 183
`define INST_OLSB_S 184
`define INST_OLSB_E 187
`define INST_RESULT_PURGE 188
`define INST_OUTPUT_EN 189
`define INST_OUTPUT_EN_CTRL_S 190
`define INST_OUTPUT_EN_CTRL_E 195
`define INST_I_COMPARE_EN 196
`define INST_I_COMPARE_MODE 197
`define INST_I_COMPARE_SWITCH 198
`define INST_O_COMPARE_EN 199
`define INST_O_COMPARE_MODE 200
`define INST_O_COMPARE_SWITCH 201
`define INST_CAL_MODE 202
`define INST_CONV_FC_MODE 203
`define INST_FEEDBACK_MODE 204
`define INST_CONF_EN 205
`define INST_NL_LOOP_SEL_S 206
`define INST_NL_LOOP_SEL_E 207
`define INST_SEQ_LOAD_I 208
`define INST_SEQ_FIN 209
`define INST_SEQ_STARTW 210
`define INST_SEQ_STARTX 211
`define INST_SEQ_STARTX_OUT 212
`define INST_RCEBX0 213
`define INST_I_COMPARE_REGEN 214
`define INST_WAIT_MBUSYW 215
`define INST_WAIT_MBUSYXI 216
`define INST_WAIT_MBUSYXO 217

//Reduction
`define 