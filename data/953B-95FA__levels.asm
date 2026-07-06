; --- level table (ROOMS_EXITS) - the level-design database ---
; 16 levels, one 12-byte ROOM_EXITS record each; draw_room indexes it as
; ROOMS_EXITS + LEVEL_NUMBER*12. The row order is LEVEL_NUMBER 0..15, but the
; player-visible level numbers (the ; N tags) run in a scrambled order - the
; exits chain them 1->2->...->16 (level 16 = LEVEL_NUMBER 15 = the last, see
; game_finished).
;   byte 0  LEFT     level reached by the left exit   ($FF = none)
;   byte 1  RIGHT    level reached by the right exit
;   byte 2  TRANSFER level reached by the transfer/down exit
;   byte 3  unused ($FF)
;   byte 4  THEME    spritesheet 0-3
;   byte 5  TRANSFER_DEST  room|x for the transfer exit
;   byte 6..11  ALIEN_SET  enemy per room (0=none 1=rockets 2=spheres 3=jumpers
;               4=mushrooms 5=harrier 6=bomber 7=volcano 8=bomb 9=mortar 10=snake)
; The inline note per row: display level, theme, exits (as display levels), and
; the 6 rooms' enemies.
ROOMS_EXITS:	; 1		;L953B:
	DB $FF,$FF,$0A,$FF,$00,$44,$00,$02,$00,$02,$08,$00	; lvl 1   theme 0  exits L=- R=- T=2    rooms: - spheres - spheres bomb -
LEVEL_03: ; 3
	DB $FF,$02,$FF,$FF,$00,$01,$01,$00,$06,$00,$00,$09	; lvl 3   theme 0  exits L=- R=4 T=-    rooms: rockets - bomber - - mortar
LEVEL_04:	; 4
	DB $FF,$FF,$0B,$FF,$00,$00,$00,$02,$00,$00,$00,$05	; lvl 4   theme 0  exits L=- R=- T=5    rooms: - spheres - - - harrier
LEVEL_10:	; 10
	DB $FF,$FF,$0D,$FF,$00,$00,$00,$00,$03,$08,$09,$05	; lvl 10  theme 0  exits L=- R=- T=11   rooms: - - jumpers bomb mortar harrier
LEVEL_06:	; 6
	DB $FF,$FF,$0C,$FF,$01,$04,$00,$01,$02,$00,$00,$00	; lvl 6   theme 1  exits L=- R=- T=7    rooms: - rockets spheres - - -
LEVEL_08:	; 8
	DB $FF,$06,$FF,$FF,$01,$00,$00,$07,$01,$00,$00,$00	; lvl 8   theme 1  exits L=- R=9 T=-    rooms: - volcano rockets - - -
LEVEL_09:	; 9
	DB $05,$FF,$03,$FF,$01,$00,$07,$07,$00,$00,$00,$00	; lvl 9   theme 1  exits L=8 R=- T=10   rooms: volcano volcano - - - -
LEVEL_13:	; 13
	DB $08,$FF,$0E,$FF,$02,$04,$00,$00,$0A,$0A,$00,$00	; lvl 13  theme 2  exits L=12 R=- T=14  rooms: - - snake snake - -
LEVEL_12:	; 12
	DB $FF,$07,$FF,$FF,$02,$04,$00,$00,$00,$02,$02,$02	; lvl 12  theme 2  exits L=- R=13 T=-   rooms: - - - spheres spheres spheres
LEVEL_15:	; 15
	DB $FF,$FF,$0F,$FF,$02,$04,$02,$01,$02,$01,$02,$01	; lvl 15  theme 2  exits L=- R=- T=16   rooms: spheres rockets spheres rockets spheres rockets
LEVEL_02:	; 2
	DB $FF,$FF,$01,$FF,$03,$04,$00,$00,$00,$04,$00,$00	; lvl 2   theme 3  exits L=- R=- T=3    rooms: - - - mushrooms - -
LEVEL_05:	; 5
	DB $FF,$FF,$04,$FF,$03,$00,$00,$00,$00,$03,$00,$00	; lvl 5   theme 3  exits L=- R=- T=6    rooms: - - - jumpers - -
LEVEL_07:	; 7
	DB $FF,$FF,$05,$FF,$03,$00,$04,$00,$00,$03,$03,$00	; lvl 7   theme 3  exits L=- R=- T=8    rooms: mushrooms - - jumpers jumpers -
LEVEL_11:	; 11
	DB $FF,$FF,$08,$FF,$03,$00,$03,$00,$00,$00,$04,$04	; lvl 11  theme 3  exits L=- R=- T=12   rooms: jumpers - - - mushrooms mushrooms
LEVEL_14:	; 14
	DB $FF,$FF,$09,$FF,$03,$00,$04,$00,$00,$00,$00,$05	; lvl 14  theme 3  exits L=- R=- T=15   rooms: mushrooms - - - - harrier
LEVEL_16:	; 16
	DB $FF,$FF,$FF,$FF,$03,$FF,$00,$03,$00,$04,$03,$00	; lvl 16  theme 3  exits L=- R=- T=-    rooms: - jumpers - mushrooms jumpers -
;ROOMS_EXITS_END:
