
# coding: UTF-8

#ファイルから文字を取り出す
f = open('output.txt')
s = f.read()
l = f.readlines()
print('=======================')
print(f)
print(type(f))
print('=======================')
print(s)
print(type(s))
print('=======================')
print(l)
print(type(l))
f.close()

#ファイルに出力
# f = open('sample.txt')
# print(f.read())
# f = open('sample.txt', mode='w')
# f.write('aaa')
# f.close()