; PLAYER: the player's 38-byte actor record (same ALIEN layout as ALIEN.1..6)

PLAYER:
	DB $01
	
	DB $00

PLAYER_FACING: 
	DB $C8
PLAYER_X_COORD:
	DB $64
PLAYER_Y_COORD:
	DB $60


PLAYER_WIDTH:
	DB $04
	
	DB $04,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
PLAYER_FRAME_COUNT:
	DB $00 			; number of frames?
	
PLAYER_JUMP_IDX:	; vertical jump/fall arc offset - added to the player's base Y; advances each frame (go_jump/go_fall)
	DB $00,$00
PLAYER_MAP_X:
	DB $00,$00,$00

PLAYER_SPRITEADR:
	DB $00,$00

	DB $00,$01,$00
PLAYER_X_DISP:
	DB $00  			; x displacement

	DB $00,$00,$00

L_A45E:
	DB $00,$47,$00,$00,$00,$00,$00
PLAYER_BULLET:
	DB $01,$00
	DB $00
BULLET_X:
	DB $00
BULLET_Y:
	DB $00,$02,$02,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$00,$00,$00,$00,$00,$00,$04
	DB $FF,$00,$00,$00,$00,$00,$46,$00
BULLET_HIT:
	DB $00,$00,$00,$00
