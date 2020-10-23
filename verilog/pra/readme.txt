1: ○○.vと○○_test.vを作成

2: コンパイル＆実行
iverilog -o 実行ファイル名 counter.v counter_test.v
→実行ファイルを作成

3: シミュレーションの実行
vvp 実行ファイル名
→vcdファイルが生成

4: gtkwaveで波形出力
open dump.vcd