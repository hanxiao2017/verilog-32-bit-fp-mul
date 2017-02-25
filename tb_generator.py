import bitstring, random 

spread = 10000000
n = 100000

def ieee754(flt):
    b = bitstring.BitArray(float=flt, length=32)
    return b

if __name__ == "__main__":

    with open("TestVector", "w") as f:

        for i in range(n):
            a = ieee754(random.uniform(-spread, spread))
            b = ieee754(random.uniform(-spread, spread))

            # calculate desired product based on 32-bit ieee 754 
            # representation of the floating point of each operand
            ab = ieee754(a.float * b.float)

            f.write(a.bin + "_" + b.bin + "_" + ab.bin + "\n")
