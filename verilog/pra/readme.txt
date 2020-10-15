1: ○○.vと○○_test.vを作成

2: コンパイル＆実行
iverilog -o counter_test.out counter.v counter_test.v
→counter_test.outという実行ファイルが作成される

3: シミュレーションの実行
vvp counter_test.out