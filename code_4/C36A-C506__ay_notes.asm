; --- ay_notes ($C36A-$C506): note/pitch calc, sample/ornament application (apply_vibrato/apply_ornament), emit_channel
; --- start_note ------------------------------------------------
; @done
; Load a note/instrument descriptor into the channel register set. In: iy=sample def, ix=CHANREG.
start_note:
	di
	ld a, iyl
	ld (ix+CHANREG.nd_lo), a
	ld a, iyh
	ld (ix+CHANREG.nd_hi), a
	ld (ix+CHANREG.per_lo), l
	ld (ix+CHANREG.per_hi), h
	ld (ix+CHANREG.dur), c
	ld a, (iy+5)
	ld (ix+CHANREG.vib_delay), a
	ld a, (iy+6)
	and $7F
	srl a
	jr nz, .vib_min
	ld a, $01
.vib_min:
	ld (ix+CHANREG.vib_half), a
	ld a, (iy+7)
	ld (ix+CHANREG.vstep_lo), a
	ld a, (iy+8)
	ld (ix+CHANREG.vstep_hi), a
	xor a
	ld (ix+CHANREG.vacc_lo), a
	ld (ix+CHANREG.vacc_hi), a
	ld a, (AY_MIXER)
	or (ix+CHANREG.mixmask)
	ld c, (iy+9)
	ld (ix+CHANREG.flags), c
	bit 0, c
	jr z, .chk_noise
	and (ix+CHANREG.tonemask)
.chk_noise:
	bit 1, c
	jr z, .set_mixer
	and (ix+CHANREG.noisemask)
.set_mixer:
	ld (AY_MIXER), a
	bit 2, c
	jr nz, .drum
	ld hl, env_attack
	ld (ix+CHANREG.env_lo), l
	ld (ix+CHANREG.env_hi), h
	ei
	ret

.drum:
	ld hl, $FFBF
	ld c, $FD
	ld a, (iy+0)
	ld e, $0D
	call ay_write_reg
	ld a, (iy+4)
	ld e, $0B
	call ay_write_reg
	inc e
	xor a
	call ay_write_reg
	ld (ix+CHANREG.level), $FF
	ei
	ret

; --- ay_silence ------------------------------------------------
; @done
; Silence all channels: AY mixer off, all volumes 0.
ay_silence:
	ld c, $FD
	ld hl, $FFBF
	ld e, $07
	ld a, (AY_MIXER)
	or $3F
	ld (AY_MIXER), a
	call ay_write_reg
	xor a
	inc e
	call ay_write_reg
	inc e
	call ay_write_reg
	inc e
	ld (CHANREG_A+CHANREG.flags), a
	ld (CHANREG_B+CHANREG.flags), a
	ld (CHANREG_C+CHANREG.flags), a
	ld (CHANREG_A+CHANREG.level), a
	ld (CHANREG_B+CHANREG.level), a
	ld (CHANREG_C+CHANREG.level), a
	jp ay_write_reg

; --- ay_frame_update -------------------------------------------
; @done
; Per-frame: refresh the 3 channel register sets, then write AY reg 7 (mixer).
ay_frame_update:
	ld a, (AY_MIXER)
	and $3F
	cp $3F
	ret z
	ld ix, CHANREG_A
	call emit_channel
	ld ix, CHANREG_B
	call emit_channel
	ld ix, CHANREG_C
	call emit_channel
	ld ix, CHANREG_A
	ld hl, $FFBF
	ld c, $FD
	ld e, $07
	ld a, (AY_MIXER)
	call ay_write_reg
	ld e, $00
	ld a, (CHANREG_A+CHANREG.per_lo)
	add a, (ix+CHANREG.vacc_lo)
	bit 1, (ix+CHANREG.flags)
	jp z, .a_tone
	ld d, a
.a_tone:
	call ay_write_reg
	inc e
	ld a, (CHANREG_A+CHANREG.per_hi)
	adc a, (ix+CHANREG.vacc_hi)
	call ay_write_reg
	inc e
	ld a, (CHANREG_B+CHANREG.per_lo)
	add a, (ix+27)
	bit 1, (ix+35)
	jp z, .b_tone
	ld d, a
.b_tone:
	call ay_write_reg
	inc e
	ld a, (CHANREG_B+CHANREG.per_hi)
	adc a, (ix+28)
	call ay_write_reg
	inc e
	ld a, (CHANREG_C+CHANREG.per_lo)
	add a, (ix+45)
	bit 1, (ix+53)
	jp z, .c_tone
	ld d, a
.c_tone:
	call ay_write_reg
	inc e
	ld a, (CHANREG_C+CHANREG.per_hi)
	adc a, (ix+46)
	call ay_write_reg
	inc e
	ld a, d
	rrca
	rrca
	rrca
	call ay_write_reg
	ld e, $08
	ld a, (CHANREG_A+CHANREG.level)
	srl a
	srl a
	srl a
	call ay_write_reg
	inc e
	ld a, (CHANREG_B+CHANREG.level)
	srl a
	srl a
	srl a
	call ay_write_reg
	inc e
	ld a, (CHANREG_C+CHANREG.level)
	srl a
	srl a
	srl a
	jp ay_write_reg

; --- emit_channel ----------------------------------------------
; @done
; Compute and drive one channel's AY registers from its CHANREG state. In: ix=CHANREG.
emit_channel:
	ld a, (AY_MIXER)
	and (ix+CHANREG.mixmask)
	cp (ix+CHANREG.mixmask)
	ret z
	ld a, (ix+CHANREG.nd_lo)
	ld iyl, a
	ld a, (ix+CHANREG.nd_hi)
	ld iyh, a
	ld a, (ix+CHANREG.dur)
	and a
	jr z, .dispatch
	cp $FF
	jr z, .dispatch
	dec (ix+CHANREG.dur)
.dispatch:
	call apply_vibrato
	bit 2, (iy+CHAN.pat_dur)
	jp nz, silence_channel.if_expired
	ld l, (ix+CHANREG.env_lo)
	ld h, (ix+CHANREG.env_hi)
	jp (hl)

