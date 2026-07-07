; --- ATTR_COLOR_LUT ($FD00) ----------------------------------
; Expands one cell attribute (index 0-31) into 8 PER-PIXEL-ROW attribute bytes - the
; multicolour trick where each of a cell's 8 rows carries its own colour. draw_sprite
; reads the 8 bytes at ATTR_COLOR_LUT + attr*8 and copies them (DUP 8 ldi) into the
; colour buffer (it picks COLOR_LUT at $FC00 or this table per a select flag). Built at
; runtime by generate_tables. 32 entries x 8 bytes; one entry per DB line, ; attr $NN =
; the attribute index (row's byte 0 = pixel-row 0's attribute, ... byte 7 = row 7's).
ATTR_COLOR_LUT:
	DB $45,$45,$45,$45,$45,$47,$47,$47	; attr $00 ($FD00)
	DB $47,$47,$47,$47,$47,$47,$47,$47	; attr $01 ($FD08)
	DB $45,$45,$45,$45,$47,$47,$45,$45	; attr $02 ($FD10)
	DB $45,$45,$45,$45,$45,$45,$45,$45	; attr $03 ($FD18)
	DB $45,$45,$45,$45,$90,$94,$98,$9C	; attr $04 ($FD20)
	DB $A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC	; attr $05 ($FD28)
	DB $C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC	; attr $06 ($FD30)
	DB $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC	; attr $07 ($FD38)
	DB $00,$04,$08,$0C,$10,$14,$18,$1C	; attr $08 ($FD40)
	DB $20,$24,$28,$2C,$30,$34,$38,$3C	; attr $09 ($FD48)
	DB $40,$44,$48,$4C,$50,$54,$58,$5C	; attr $0A ($FD50)
	DB $60,$64,$68,$6C,$70,$74,$78,$7C	; attr $0B ($FD58)
	DB $80,$84,$88,$8C,$90,$94,$98,$9C	; attr $0C ($FD60)
	DB $A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC	; attr $0D ($FD68)
	DB $C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC	; attr $0E ($FD70)
	DB $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC	; attr $0F ($FD78)
	DB $00,$04,$08,$0C,$10,$14,$18,$1C	; attr $10 ($FD80)
	DB $20,$24,$28,$2C,$30,$34,$38,$3C	; attr $11 ($FD88)
	DB $40,$44,$48,$4C,$50,$54,$58,$5C	; attr $12 ($FD90)
	DB $60,$64,$68,$6C,$70,$74,$78,$7C	; attr $13 ($FD98)
	DB $80,$84,$88,$8C,$90,$94,$98,$9C	; attr $14 ($FDA0)
	DB $A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC	; attr $15 ($FDA8)
	DB $C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC	; attr $16 ($FDB0)
	DB $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC	; attr $17 ($FDB8)
	DB $00,$04,$08,$0C,$10,$14,$18,$1C	; attr $18 ($FDC0)
	DB $20,$24,$28,$2C,$30,$34,$38,$3C	; attr $19 ($FDC8)
	DB $40,$44,$48,$4C,$50,$54,$58,$5C	; attr $1A ($FDD0)
	DB $60,$64,$68,$6C,$70,$74,$78,$7C	; attr $1B ($FDD8)
	DB $80,$84,$88,$8C,$90,$94,$98,$9C	; attr $1C ($FDE0)
	DB $A0,$A4,$A8,$AC,$B0,$B4,$B8,$BC	; attr $1D ($FDE8)
	DB $C0,$C4,$C8,$CC,$D0,$D4,$D8,$DC	; attr $1E ($FDF0)
	DB $E0,$E4,$E8,$EC,$F0,$F4,$F8,$FC	; attr $1F ($FDF8)
