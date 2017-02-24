import bitstring, random 

spread = 10000000
n = 100000

def ieee754(float):
    b = bitstring.pack('>f', float)
    sbit, wbits, pbits = b[:1], b[1:12], b[12:]
    return sbit.bin + wbits.bin + pbits.bin

if __name__ == "__main__":
    for i in range(n):
        a = random.uniform(-spread, spread)
        b = random.uniform(-spread, spread)

        print(ieee754(a) + "_" + ieee754(b) + "_" + ieee754(a*b))