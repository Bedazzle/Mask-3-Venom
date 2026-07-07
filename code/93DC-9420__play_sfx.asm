; --- play_sfx ------------------------------------------------
; @done
; Trigger sound effect A: index SFX_TABLE (14-byte descriptor)
; and hand it to the object-sound engine via load_sfx, which
; sound_tick then plays out over the following frames.
; In: a = sound id (0-17)
; Note: IS_128K is the 48K(0)/128K($FF) flag set by the boot loader.
; On 128K (this snapshot) it queues into SOUND_STATE via load_sfx;
; the SFX_CH1..3 branch below is the 48K sound path (unused here).
play_sfx:
	push af
	push hl
	push de
	push ix
	; mult
	ld l, a
	ld e, a
	ld h, $00
	ld d, h
	add hl, hl		; x2
	add hl, de		; x3
	add hl, hl		; x6
	add hl, de		; x7
	add hl, hl		; x14
	; mult HL=A*14

	ld de, SFX_TABLE
	add hl, de		; HL = SFX_TABLE + A*14

	push hl
	pop ix
	ld a, (IS_128K)
	and a
	jr nz, .queue_128k

	ld a, (ix+SFX.CHANNEL)

	cp $01
	jr nz, .try_ch2

	ld (SFX_CH1), hl
	jr .done

.try_ch2:
	cp $02
	jr nz, .use_ch3

	ld (SFX_CH2), hl
	jr .done

.use_ch3:
	ld (SFX_CH3), hl

.done:
	pop ix
	pop de
	pop hl
	pop af

	ret

.queue_128k:
	call load_sfx

	jr .done


SFX_CH1:
	DB $00,$00
	
SFX_CH2:
	DB $00,$00
	
SFX_CH3:
	DB $00,$00
