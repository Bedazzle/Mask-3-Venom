; ----------------------------
; the 6 alien actor slots (ALIEN.1..6), initial state. Each is a 38-byte ALIEN
; record: +3/+4 = x/y spawn pos, +5/+6 = size params, +$20 = sprite code ($41-$46),
; +$23 = slot index 1-6. All start inactive (state 0); choose_alien_routine fills them.
; ----------------------------
ALIEN.1:
	DB $00,$00,$00,$00,$00,$01,$01
	DS 25, 0
	DB $46,$00,$00,$01,$00,$00

ALIEN.2:
	DB $00,$00,$00,$3A,$23,$03,$02
	DS 25, 0
	DB $45,$00,$00,$02,$00,$00

ALIEN.3:
	DB $00,$00,$00,$68,$3F,$03,$02
	DS 25, 0
	DB $44,$00,$00,$03,$00,$00

ALIEN.4:
	DB $00,$00,$00,$50,$2D,$03,$05
	DS 25, 0
	DB $43,$00,$00,$04,$00,$00

ALIEN.5:
	DB $00,$00,$00,$72,$28,$03,$02
	DS 25, 0
	DB $42,$00,$00,$05,$00,$00

ALIEN.6:
	DB $00,$00,$00,$72,$0D,$03,$02
	DS 25, 0
	DB $41,$00,$00,$06,$00,$00
