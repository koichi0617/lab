import sys

with open('memiBlock0.dat',mode='w') as w1:
    with open('memiBlock1.dat',mode='w') as w2:
        with open(sys.argv[1]) as r: 
            for i in range(8192):
                s_line = r.readline()
                if i == 0:
                    zero_line = s_line
                if s_line:
                    w1.write(s_line[:128] + str("\n"))
                    w2.write(s_line[128:])
                if not s_line:
                    w1.write(zero_line[:128] + str("\n"))
                    w2.write(zero_line[128:])

with open('memiDDR.dat',mode='w') as w1:
    with open(sys.argv[1]) as r: 
        for i in range(8192):
            s_line = r.readline()
            if i == 0:
                zero_line = s_line
            if s_line:
                w1.write(s_line[128:])
                w1.write(s_line[:128] + str("\n"))
            if not s_line:
                w1.write(zero_line[128:])
                w1.write(zero_line[:128] + str("\n"))
