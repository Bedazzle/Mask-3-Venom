; --- boot loader (DEAD CODE) ---------------------------------
; @done
; The original tape loader, left in the image; NOT executed at
; runtime (the game runs as a loaded snapshot). $FF00-$FF0E is the
; bootstrap: copy the body to $5E00 and run it there. The body
; loads the screen and the main code from tape via ROM LD-BYTES
; ($0556), detects 48K/128K (result -> IS_128K), and jumps to
; startup. (mirror_sprite only uses this label's *address* as an
; SMC placeholder value; the code below never runs.)
tape_loader:
	di
	ld hl, loader_body	; source ($FF0F)
	ld de, $5E00		; copied to + run at $5E00
	ld bc, $0200
	ldir
	jp $5E00

; loader body (stored here, copied to and run at $5E00)
loader_body:
	ld ix, SCREEN		; $4000
	ld de, SCREEN_LEN	; $1B00 - load the loading screen
	ld a, $FF
	scf
	call $0556		; ROM LD-BYTES
	jp nc, $0000		; reset on tape error

	ld a, $FF
	ld (IS_128K), a		; assume 128K
	ld sp, $6000
	ld bc, $7FFD		; 128K memory-paging port
	ld hl, $C000
	ld a, $10
	out (c), a
	ld (hl), $2A
	ld a, $14
	out (c), a
	ld a, (hl)
	cp $2A
	jr z, .load_main	; paging worked -> 128K

	xor a
	ld (hl), a
	dec (hl)
	or (hl)
	inc a
	jr nz, .load_main

	ld a, $10
	out (c), a
	ld a, (hl)
	cp $2A
	jr nz, .load_main

	xor a
	ld (IS_128K), a		; 48K
.load_main:
	ld ix, STARTBLOCK	; $6000
	ld de, $9E00		; main code length
	ld a, $FF
	scf
	call $0556		; load main code
	jp nc, $0000

	ld a, (IS_128K)
	and a
	jp nz, startup		; 128K -> run the game

	ld bc, $7FFD
	ld a, $14
	out (c), a
	ld ix, $C000
	ld de, $0FA0
	ld a, $FF
	scf
	call $0556		; 48K path: load one more block
	jp nc, $0000

	ld bc, $7FFD
	ld a, $10
	out (c), a
	jp startup


	DS $2E, 0		; $FF88-$FFB5 padding


; leftover data in the dead loader region ($FFB6-$FFEF)
	DB $54,$00,$9E,$92,$2F,$AF,$33,$AF
	DB $F0,$84,$00,$F3,$D0,$87,$02,$02
	DB $54,$00,$44,$92,$3A,$5C,$06,$13
	DB $21,$11,$3B,$F3,$01,$9F,$59,$9F
	DB $47,$92,$3A,$5C,$06,$13,$21,$11
	DB $9B,$36,$58,$FF,$0A,$00,$38,$40
	DB $00,$00,$8A,$A1,$0A,$00,$0B,$98
	DB $00,$CC

STACK:
	DB $4D,$00,$38,$80
