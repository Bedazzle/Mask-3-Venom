import sys

DEBU = False

TAB = '\t'


MEMSTART = 23296
DUMPFROM = 61440
DUMPFROM = 23296
infile = "mask_3_loaded.bin"

SEPARATE_BYTES = 8
SEPARATOR = "; -------------"

#-------------------------------------------------------------------------------

def tobin(x, count=8):
    """
    Integer to binary
    Count is number of bits
    """
    return "".join(map(lambda y:str((x>>y)&1), range(count-1, -1, -1)))

def getbinary(x, fill_0=".", fill_1="#"):
    x = tobin(x)
    x = x.replace("0", fill_0)
    x = x.replace("1", fill_1)
    return x


def tochar(x):
    if byte>=32 and byte<128:
        if byte == ord('"'):
            char = '\"'
        elif byte == ord("'"):
            char = '\''
        else:
            char = chr(byte)
    else:
        char = ''

    return char


with open(infile, "rb") as f:
    header = '\t;\tBYTE\tBIN\t\tHEXADR\tDECADR\tHEX\tCHAR'
    template = '\tDB\t{BYTE}\t; {BIN}\t${HEXADR:04X}\t{DECADR}\t${HEXVAL:02X}\t{CHAR}'

    print(header)

    addr = MEMSTART

    byte = f.read(1)
    index = 0

    separated = 0

    while byte != b"":
        #print('Index', index)
        index += 1

        if addr < DUMPFROM:
            addr += 1
            byte = f.read(1)
            continue

        byte = ord(byte)
        char = tochar(byte)
        
        xbytes = template.format(BYTE=byte, BIN=getbinary(byte), HEXADR=addr, DECADR=addr, HEXVAL=byte, CHAR=char)
        print(xbytes)

        byte = f.read(1)
        addr += 1

        if SEPARATE_BYTES > 0:
            separated += 1

            if separated == SEPARATE_BYTES:
                print(SEPARATOR)
                separated = 0

#print('DONE')
