; --- sound_tick ----------------------------------------------
; @done
; Per-frame object-sound update, called from the interrupt. If a
; sound is active (SOUND_STATE[0] != 0), advance the pitch
; accumulator (SOUND_STATE+1) by the source object's step
; (ix+$07/$08), derive a period from its high nibble, and emit a
; square wave on the ULA speaker (OUT $FE) for that many cycles.
; SOUND_STATE[0]=$FF means play indefinitely; any other value
; counts down.
sound_tick:
	ld a, (SOUND_STATE)
	and a
	ret z

	cp $FF
	jr z, .play

	dec a
	ld (SOUND_STATE), a
.play:
	ld ix, (SOUND_STATE+3)
	ld hl, (SOUND_STATE+1)
	ld e, (ix+SFX.STEP_LO)
	ld d, (ix+SFX.STEP_HI)
	add hl, de
	ld (SOUND_STATE+1), hl
	xor a
	sub l
	srl a
	srl a
	srl a
	srl a
	srl a
	inc a
	ld b, a
.pulse:
    ld a, (BORDER_VALUE)
	or $18
	out ($FE), a	; buzz
	ld h, l
.delay1:
	dec h
	jr nz, .delay1

	ld a, (BORDER_VALUE)
	out ($FE), a	; buzz
	ld h, l
.delay2:
	jr nz, .delay2

	djnz .pulse

	ret
