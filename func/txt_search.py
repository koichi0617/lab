#指定文字列を含む行の行数を得る
def aaa(name)
with open('sample.txt') as f:
    for row, text in enumerate(f, start=1):
        text = text.rstrip()
        if "a" in text:
            dst_row["a"] = row
            break
    else:
        raise ValueError('Not Found')
print(row)

#指定行に追記

with open('sample.txt') as f:
    data = f.readlines()
data.insert(row, 'aaa')
with open('sample.txt', mode = 'w') as f:
    f.writelines(data)

