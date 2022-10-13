import sys

fname = sys.argv[1]
	
with open(fname) as f:
	for row in f:
		src = row.strip()

		if not src.startswith('DEFM "'):
			print(row.rstrip())
		else:
			print(f'\t; {src}')
			src = src[6:-1]

			txt = '\tdefb '
			for inx, char in enumerate(src):
				#print(char, ord(char))
				if inx != 0:
					txt = f'{txt},'

				txt = f'{txt}${ord(char):02X}'

			print(txt)
