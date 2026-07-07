; --- ay_output ($C564-$C5C5): AY register output: ay_write_reg (out $FFFD/$BFFD) + tone/noise/envelope
; --- silence_channel -------------------------------------------
; @done
; Silence one channel (set its mixer bits, clear level).
silence_channel:
	ld (ix+CHANREG.level), $00
	ld a, (AY_MIXER)
	or (ix+CHANREG.mixmask)
	ld (AY_MIXER), a
	res 7, (ix+CHANREG.flags)
	ret

.if_expired:
	ld a, (ix+CHANREG.dur)
	and a
	ret nz
	jr silence_channel

; --- apply_vibrato ---------------------------------------------
; @done
; Vibrato / pitch-slide: step the 16-bit accumulator, reverse at the half-period.
apply_vibrato:
	ld a, (ix+CHANREG.vib_delay)
	and a
	jr z, .step
	cp $FF
	ret z
	dec (ix+CHANREG.vib_delay)
	ret nz
.step:
	ld l, (ix+CHANREG.vacc_lo)
	ld h, (ix+CHANREG.vacc_hi)
	ld c, (ix+CHANREG.vstep_lo)
	ld b, (ix+CHANREG.vstep_hi)
	add hl, bc
	ld (ix+CHANREG.vacc_lo), l
	ld (ix+CHANREG.vacc_hi), h
	dec (ix+CHANREG.vib_half)
	ret nz
	ld a, (iy+CHAN.cur_hi)
	and a
	ret z
	jp p, .reverse
	ld (ix+CHANREG.vib_delay), $FF
	ret

.reverse:
	ld (ix+CHANREG.vib_half), a
	ld a, c
	cpl
	ld c, a
	ld a, b
	cpl
	ld b, a
	inc bc
	ld (ix+CHANREG.vstep_lo), c
	ld (ix+CHANREG.vstep_hi), b
	ret

; --- ay_write_reg ----------------------------------------------
; @done
; Write one AY register: out ($FFFD),reg=e ; out ($BFFD),val=a. In: hl=$FFBF, c=$FD.
ay_write_reg:
	ld b, h
	out (c), e
	ld b, l
	out (c), a
	ret

