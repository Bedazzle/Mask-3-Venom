; --- calc_frame_addr -----------------------------------------
; @done
; Point ALIEN.spr at the current animation frame's graphics:
;   spr = base + frame * framesize.
; Entered by the SMC computed jr in pick_alien_frame, which patches the jump
; with ALIEN.mode*2 - so mode selects the entry, and thus the frame size:
;   mode 0/1 -> frame*48   mode 2 -> frame/8   mode 3 -> frame*8
;   mode 4   -> frame 0 (static)   mode 5 -> frame*72 (16-bit offset)
; In:  A = mode (already *2 by caller), then A = frame (anim & anim_mask).
;      IX = actor record.
; Out: ALIEN.spr_lo/hi = base + frame*size.
; The 6 entries below are 2 bytes each (a jr) so mode*2 indexes them exactly.
calc_frame_addr:
	jr .x48

.mode1:
	jr .x48

.mode2:
	jr .div8

.mode3:
	jr .x8

.mode4:
	jr .zero

.mode5:
	jr .x72


.x48:
	;mult
	ld l, a
	add a, a	; x2
	add a, l	; x3
	add a, a	; x6
	add a, a	; x12
	add a, a	; x24
	add a, a	; x48
	;mult A=A*48
	jr .store8

.div8:
	rrca
	rrca
	rrca
	jr .store8

.x8:
	;mult
	add a, a
	add a, a
	add a, a
	; mult A=A*8
	jr .store8

.zero:
	xor a
	jr .store8

.x72:
	;mult
	add a, a
	add a, a
	add a, a
	ld l, a
	ld h, $00
	ld e, a
	ld d, h
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, de
	;mult HL=A*72
	jr .store16

.store8:
	add a, (ix+ALIEN.base_lo)
	ld (ix+ALIEN.spr_lo), a
	ld a, $00
	adc a, (ix+ALIEN.base_hi)
	ld (ix+ALIEN.spr_hi), a

	ret

.store16:
	ld e, (ix+ALIEN.base_lo)
	ld d, (ix+ALIEN.base_hi)
	add hl, de
	ld (ix+ALIEN.spr_lo), l
	ld (ix+ALIEN.spr_hi), h

	ret
