; --- work buffers ($F000-$F5FF, 1536 bytes of RAM scratch) ----
; Reused per-frame render/scratch RAM. Some regions OVERLAP (different phases write the
; same bytes), so the sizes below are 'label to next label', not fixed extents. Freeze-time
; contents; MUST stay DB (not DS) to reproduce the snapshot byte-for-byte. Memory map:
;   $F000 DATA_BLOCK1   sprite-composition buffer - draw_sprite builds a sprite's cells here
;                       before blitting; also startup's ldir source (copies $500 -> $5B00,
;                       seeding inactive sprite-bank 1).
;   $F080 ROOM_BLOCKS   draw_room expands each room tile code into its 4x4 cells here.
;   $F0C0 PLAYFIELD_MAP  the live playfield cell map (cell codes, 32 wide) that
;                       playfield_to_screen renders. MAP_CANNON/MAP_LOGO/MAP_MORTAR are
;                       named cells inside it (move_cannon / draw_multi_logo / do_mortar).
;   $F252 BOX_SAVE_1/_2  tiles saved under the two weapon boxes (stamp_boxes/restore_boxes;
;                       BOX_SAVE_1 must sit on an odd address).
;   $F2F0 BUFF_F2F0     multicolour-logo / menu compose buffer (prepare_multicolor, setup_main_menu).
;   $F300 MIRROR_BUFFER  mirror_sprite's bit-mirrored output.
;   $F3BF RENDER_FLAG    playfield-render flag (playfield_to_screen sets $FF).
;   $F3C0 PLAYFIELD     the rendered playfield buffer ($F3C0-$F5FF), cleared each frame by draw_room.
DATA_BLOCK1:	; $F000 sprite-compose buffer / startup bank-1 seed source
	DB $00,$00,$00,$00,$00,$00,$00,$00
	DB $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	DB $FF,$7F,$3F,$0F,$07,$07,$03,$01
	DB $01,$03,$07,$07,$0F,$0F,$0F,$0F
	DB $0F,$1F,$1F,$1F,$3F,$7F,$7F,$FF
	DB $FF,$FF,$FF,$FF,$FF,$FF,$F9,$E0
	DB $01,$03,$03,$07,$07,$0F,$0F,$0F
	DB $1F,$1B,$17,$0F,$1F,$1F,$3F,$3F
	DB $3F,$3F,$7F,$7F,$7F,$FF,$FF,$FF
	DB $80,$80,$80,$C0,$C0,$E0,$E0,$F0
	DB $F0,$F0,$F0,$D0,$E0,$F0,$F8,$F8
	DB $F8,$FC,$FE,$FE,$FE,$FE,$FF,$FF
	DB $F8,$F0,$E0,$E0,$C0,$C0,$80,$00
	DB $80,$80,$C0,$E0,$E0,$E0,$F0,$F0
	DB $F8,$FC,$FC,$FE,$FE,$FE,$FF,$FF
	DB $FF,$7F,$1F,$0F,$0F,$07,$03,$01


; F080 length $280 = 8 cols x 5 rows x (4x4 cells = 16) = 640
; first line of blocks is half vertical size
ROOM_BLOCKS:	; $F080 draw_room tile-expansion buffer
	DB $3F,$1F,$1F,$0F,$0F,$07,$07,$0F,$FF,$FF,$F2,$E4,$04,$84,$C8,$0A

	DB $FF,$FF,$7E,$38,$02,$3C,$38,$3C,$FF,$FE,$7C,$38,$80,$80,$80,$80
	DB $FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE,$FE
	DB $00,$7F,$7F,$7F,$7F,$7F,$7F,$00,$00,$FF,$FF,$FF,$FF,$FF,$FF,$00

PLAYFIELD_MAP:	; $F0C0 live playfield cell map (32 wide)
	DB $00
MAP_CANNON:	; $F0C1 map cell - move_cannon
	DB $00,$00,$30,$68,$64,$64,$74,$01,$02

MAP_LOGO:	; $F0CA map cell - draw_multi_logo
	DB $84,$48,$E8,$D1,$A3,$DF,$00,$03
	DB $05,$09,$13,$13,$21,$47,$00
	
MAP_MORTAR:	; $F0D9 map column - do_mortar ground scan
	DB $18
	DB $34,$34,$24,$62,$62,$72,$00,$30
	DB $68,$74,$3A
	DB $1D,$0F,$04,$00,$00,$00,$00,$00
	DB $00,$1C,$72,$00,$28,$4C,$1E,$4F
	DB $27,$12,$08,$00,$00,$01,$02,$0C
	DB $11,$63,$9B,$F8,$F0,$E0,$E0,$C0
	DB $C0,$80,$00,$8F,$83,$00,$1C,$1E
	DB $18,$1E,$0D,$FF,$FE,$F1
	DB $7A,$32,$24
	DB $18,$00,$FF,$FF,$7F,$1F,$0F,$00
	DB $00,$00,$F8,$F0,$E4,$C8,$18,$1E
	DB $18,$08,$F8,$F1,$C1,$FD
	DB $61,$72,$62,$62
	DB $FF,$7F,$7F,$3F,$3F,$0F,$07,$03
	DB $FF,$FF,$FF,$FF,$F0,$FC,$E8,$80
	DB $46,$0E,$1E,$3E,$7C,$78,$70,$62
	DB $00,$00,$00,$01,$04,$0A,$17,$2E
	DB $00,$5E,$00,$2C,$AD,$2C,$2C,$2C
	DB $00,$00,$00,$80,$20,$50,$E8,$74
	DB $5C,$B8,$D2,$E6,$F6,$FA,$FC,$FE
	DB $00,$FF,$7E,$3C,$99,$C3,$FF,$00
	DB $3A,$1D,$4B,$67,$6F
	DB $5F,$3F,$7F,$FD,$FB,$F7,$EF,$DE
	DB $BD,$78,$00,$7F,$0C,$C2,$F1,$F8
	DB $E0,$F2,$E4,$8A,$32,$44,$A4
	DB $74,$64,$78,$30,$31
	DB $19,$1D,$09,$06,$00,$00,$00,$3F
	DB $5F,$4F,$47,$4B
	DB $0D,$0E,$2F,$00,$80,$C0,$E0,$F0
	DB $F8,$FC,$7E,$EB,$C1,$5D,$2B,$17
	DB $4F,$67,$03,$06,$0D,$1C,$18,$1E
	DB $1C,$3E,$3E,$00,$18,$A4,$A4
	DB $52,$52,$5A,$2A,$64,$62
	DB $E2,$CA,$D1,$E1,$C9,$F0,$30,$68
	DB $C8,$64,$40,$06,$19,$63,$87,$33
	DB $1F,$5F,$FF,$FF,$FF,$FF
	DB $72,$62,$7A
	DB $E2,$F2,$C2,$F2,$F9,$71,$E9,$EB
	DB $CB,$E7,$C7,$EF,$5F,$FD,$F8,$F7
	DB $FE,$FF,$FF,$FF,$FF,$C1,$E7,$1F
	DB $FF,$FF,$FF,$FF,$FF,$F7,$FF,$FF
	DB $FF,$FF,$FF,$FF,$FF,$00,$01,$03
	DB $07,$0F,$1F,$3F,$7E,$0F,$0E,$0F
	DB $04,$07,$06,$03,$00,$20,$20,$40
	DB $40,$40,$80,$00,$00,$FC,$FA,$F2
	DB $E2,$D2,$B0,$70,$F4,$0C,$0E,$0C

	DB $0F,$06,$00,$00,$00
	DB $72,$72,$7A,$32,$34,$34
	DB $18,$00,$11,$19,$1C,$08,$0C,$08
	DB $0C,$0F,$F1,$D9,$C1,$E2,$F2,$E2
	DB $72,$62,$7F,$7F,$3F,$3F,$1F,$87
	DB $C3,$E3,$FE,$FC,$F0,$F8,$C1,$F2


	DB $C2,$E4,$FF,$7F
	
BOX_SAVE_1:	; $F252 saved tiles under weapon box 1 (odd-aligned)
	DB $3C,$BE,$3C,$3E
BOX_SAVE_2:	; $F256 saved tiles under weapon box 2
	DB $3E,$18,$90,$20
	

	DB $20,$20,$20,$20,$20
	DB $40,$F8,$F8,$F0,$E0,$E0,$D0,$B0
	DB $F0,$E0,$C0,$C0,$C0,$80,$80,$80
	DB $80,$FF,$FF,$7F,$7F,$3F,$1F,$1F
	DB $1F,$EE,$DE,$8C,$40,$E0,$E0,$C0
	DB $00,$F4,$44,$64,$68,$68,$30
	DB $00,$00,$00,$00
	DB $31,$5A,$4A,$31
	DB $00,$31,$00,$00,$8C,$D6,$52,$8C
	DB $00,$8C,$77,$7B,$31,$02,$07,$07
	DB $03,$00,$BF,$DF,$EF,$F7,$7B,$BD
	DB $1E,$00
	DB $6D,$66,$6B,$6D,$66,$6B,$6D
	DB $0E,$3D,$3F,$7E,$7C,$79,$7F,$FF
	DB $FF,$2A,$10,$08,$04,$04,$02,$82
	DB $25,$F0,$E3,$C4,$C8,$89,$1F,$7F
	DB $FF,$8F,$03,$1E,$7F,$3F,$FF,$FF
	DB $FF,$CC,$3E,$FD,$FD,$FB,$FF,$FF
	DB $FF,$F1,$E1,$F8,$FC,$FF,$FF,$FF
	DB $FF,$3F,$7F,$BF,$DF,$FF,$FF,$FF
	DB $FF,$80,$70,$08,$86,$01,$B0,$E2
	DB $FF

BUFF_F2F0:	; $F2F0 multicolour-logo / menu compose buffer
    DB $00,$00,$00,$00,$0E,$B1,$58,$2F
    DB $00,$00,$00,$00,$00,$80,$40,$30

MIRROR_BUFFER:	; $F300 mirror_sprite output
	DB $00,$27,$00,$27,$27,$27,$27,$00
	DB $00,$FF,$00,$7E,$66,$5A,$4A,$66
	DB $00,$FC,$00,$FC,$FC,$FC,$FC,$00
	DB $1C,$1C,$38,$3B,$73,$77,$E0,$E0
	DB $7E,$7E,$7E,$7E,$7E,$7E,$7E,$00
	DB $38,$38,$1C,$DC,$CE,$EE,$07,$07
	DB $0E,$06,$03,$00,$00,$00,$00,$00
	DB $72,$74,$34,$18,$00,$00,$00,$00
; buffer BUFF_F2F0 end, length $50

	DB $C1,$60,$48,$68,$30,$00,$00,$00
	DB $84,$98,$60,$00,$00,$00,$00,$00
	DB $1E,$1A,$18,$0E,$0C,$0E,$07,$00
	DB $40,$40,$40,$40,$80,$80,$00,$00
	DB $0F,$07,$0B,$0F,$07,$07,$03,$01
	DB $FF,$FF,$FE,$FC,$F2,$EE,$DC,$DC
	DB $F8,$F0,$F0,$F0,$E0,$E0,$C0,$80
	DB $00,$03,$67,$4F,$17,$2B,$5D,$C1
	DB $00,$0B,$6D,$66,$6B,$6D,$66,$6B
	DB $31,$31,$35,$35,$00,$7F,$7F,$00
	DB $8C,$8C,$AC,$AC,$00,$FE,$FE,$00
	DB $00,$70,$B6,$D6,$66,$B6,$D6,$66
	DB $00,$C0,$E6,$F2,$E8,$D4,$BA,$83
	DB $B6,$D6,$66,$B6,$D6,$66,$B6,$D0
	DB $00,$FE,$FE,$FE,$FE,$FE,$FE,$00
	DB $59,$A7,$DF,$BF,$FF,$FF,$FF

RENDER_FLAG:	; $F3BF playfield-render flag
	DB $FF

PLAYFIELD:	; $F3C0 rendered playfield buffer, cleared each frame
	DB $FF,$FF,$FE,$FC,$F0,$E0,$80,$00,$00,$1C,$E2,$F9,$F0,$FC,$FF,$FE,$00,$38,$65,$31,$87,$5F,$BF,$7F,$30,$6C,$C2,$F1,$FC,$F8,$FE,$FF
	DB $00,$00,$00,$80,$78,$07,$48,$FF,$00,$00,$00,$00,$00,$00,$C0,$E0,$F6,$FB,$FC,$FF,$FF,$FF,$FF,$FF,$08,$C8,$E4,$33,$E7,$1F,$FF,$FF
	DB $30,$58,$48,$31,$02,$32,$31,$30,$00,$00,$00,$80,$C0,$40,$8C,$16,$31,$31,$35,$35,$00,$4F,$4F,$00,$92,$8C,$A0,$AC,$00,$FE,$FE,$00
	DB $00,$31,$5A,$4A,$31,$00,$31,$31,$00,$80,$C0,$40,$80,$0C,$96,$92,$31,$31,$35,$35,$00,$4F,$4F,$00,$8C,$80,$AC,$AC,$00,$FE,$FE,$00
	DB $01,$02,$02,$31,$58,$49,$31,$01,$80,$C0,$40,$8C,$16,$92,$8C,$80,$31,$31,$35,$35,$00,$4F,$4F,$00,$8C,$8C,$AC,$AC,$00,$FE,$FE,$00
	
	DB $00,$01,$02,$02,$01,$30,$59,$49,$00,$8C,$D6,$52,$8C,$00,$8C,$8C,$31,$01,$35,$35,$00,$4F,$4F,$00,$8C,$8C,$AC,$AC,$00,$FE,$FE,$00
	DB $00,$00,$00,$01,$02,$02,$31,$58,$0C,$16,$12,$8C,$C0,$4C,$8C,$0C,$49,$31,$05,$35,$00,$4F,$4F,$00,$8C,$8C,$AC,$AC,$00,$FE,$FE,$00
	DB $00,$00,$00,$00,$00,$31,$5A,$4A,$00,$0C,$16,$12,$0C,$80,$CC,$4C,$31,$00,$35,$35,$00,$4F,$4F,$00,$8C,$0C,$AC,$AC,$00,$FE,$FE,$00
	DB $00,$00,$00,$30,$58,$48,$31,$02,$00,$00,$00,$0C,$16,$12,$8C,$C0,$32,$31,$34,$35,$00,$4F,$4F,$00,$4C,$8C,$2C,$AC,$00,$FE,$FE,$00
	DB $00,$30,$58,$48,$30,$01,$32,$32,$00,$00,$00,$00,$00,$8C,$D6,$52,$31,$30,$35,$35,$00,$4F,$4F,$00,$8C,$00,$AC,$AC,$00,$FE,$FE,$00

	DB $0B,$C1,$E0,$00,$00,$00,$00,$00,$03,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$16,$EE,$FF,$FF,$3F,$EC,$68,$00
	DB $0F,$3E,$FF,$EC,$1D,$87,$B0,$70,$70,$F0,$00,$5D,$DF,$8E,$6C,$33,$50,$F6,$B4,$19,$EE,$00,$00,$00,$08,$7F,$F3,$FF,$04,$FB,$90,$00
	DB $0E,$FF,$FF,$B9,$EC,$E7,$E7,$80,$FF,$FF,$00,$D1,$8D,$6C,$33,$4C,$C6,$83,$35,$AD,$63,$56,$B5,$A3,$05,$1E,$FF,$E0,$3F,$E1,$A0,$00
	DB $04,$0F,$1C,$38,$1F,$67,$B8,$04,$0F,$70,$00,$D6,$BC,$19,$AF,$0C,$6B,$D8,$F6,$98,$C1,$EC,$00,$00,$F7,$E7,$F7,$FF,$FF,$FD,$00,$00
	DB $0F,$00,$00,$3B,$C0,$F7,$1F,$1C,$78,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$F8,$E0,$F0,$00,$20,$00,$00

	DB $0F,$00,$00,$3E,$7B,$9F,$79,$1C,$78,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	DB $00,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$C0,$00,$7B,$D6,$D7,$BD,$A8,$1E,$B6,$B5,$81,$AD,$EB,$7B,$06,$61,$8C,$7B,$9A,$B1,$B4,$37,$BD,$E0
	DB $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00