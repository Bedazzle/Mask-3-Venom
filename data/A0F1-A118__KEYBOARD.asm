; --- ZX keyboard matrix -> character map (half-rows x 5 keys) used by the key reader
KEYBOARD:
	DB $40, "ZXCV"		; Caps Shift
	DB "ASDFG"
	DB "QWERT"
	DB "12345"
	DB "09876"
	DB "POIUY"
	DB $0D, "LKJH"		; Enter
	DB " ", $40, "MNB"		; Symbol Shift
