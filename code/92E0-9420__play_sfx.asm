; --- SFX_TABLE (the sound-effect table) ----------------------
; 18 sound effects, one 14-byte descriptor each (index = the id
; passed to play_sfx). The beeper engine (sound_tick) uses:
;   byte 7..8  = pitch step per frame (signed; negative = falling)
;   byte 10    = channel (used only by the dead 48K SFX_CH path)
;   byte 11    = duration in frames
;   byte 12..13= start pitch
; Bytes 0..6 (and 9) look like AY-sound register presets - unused
; by the beeper path in this (128K) build.
; The inline notes below give each sound's use + step/dur/pitch.
SFX_TABLE:
	DB $7F,$FD,$01,$FF,$7F,$00,$00,$0F,$00,$03,$01,$1E,$06,$01	;  0 move A        step 15 dur 30 pitch $0106
	DB $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$A8,$00	;  1 move B        step 13 dur 30 pitch $00A8
	DB $7F,$FD,$01,$FF,$7F,$02,$00,$21,$00,$03,$01,$1E,$44,$02	;  2 move C        step 33 dur 30 pitch $0244
	DB $7F,$FD,$01,$FF,$7F,$02,$00,$03,$00,$03,$01,$1E,$44,$00	;  3 move D        step 3 dur 30 pitch $0044
	DB $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$44,$00	;  4 move E        step 13 dur 30 pitch $0044
	DB $7F,$FD,$01,$FF,$7F,$02,$00,$0D,$00,$03,$01,$1E,$44,$00	;  5 move F        step 13 dur 30 pitch $0044
	DB $7F,$FB,$01,$FF,$7F,$00,$00,$EC,$FF,$01,$02,$0F,$00,$04	;  6 jump          step -20 dur 15 pitch $0400
	DB $08,$FF,$01,$FF,$28,$FF,$00,$00,$00,$05,$01,$FF,$AC,$01	;  7 weapon fire   step 0 dur 255 pitch $01AC
	DB $03,$81,$01,$FF,$7F,$24,$00,$F9,$FF,$02,$03,$28,$FF,$00	;  8 lose life     step -7 dur 40 pitch $00FF
	DB $08,$FF,$01,$FF,$05,$00,$00,$FF,$FF,$05,$01,$82,$8C,$00	;  9 teleport      step -1 dur 130 pitch $008C
	DB $01,$FF,$01,$FF,$7F,$00,$06,$12,$00,$01,$02,$E6,$8D,$00	; 10 bomber        step 18 dur 230 pitch $008D
	DB $7F,$FF,$01,$FF,$7F,$00,$00,$FF,$FF,$02,$03,$05,$6B,$00	; 11 pop/vanish    step -1 dur 5 pitch $006B
	DB $7F,$FE,$01,$FF,$7F,$00,$00,$FF,$FF,$02,$03,$05,$FF,$00	; 12 pop/vanish    step -1 dur 5 pitch $00FF
	DB $7F,$FF,$01,$FF,$7F,$00,$04,$14,$00,$02,$03,$05,$6B,$03	; 13 pop/vanish    step 20 dur 5 pitch $036B
	DB $7F,$FF,$01,$FF,$7F,$00,$00,$05,$00,$03,$03,$05,$6B,$03	; 14 pop/vanish    step 5 dur 5 pitch $036B
	DB $0A,$FF,$01,$FF,$2F,$FF,$00,$00,$00,$05,$02,$64,$EA,$03	; 15 harrier       step 0 dur 100 pitch $03EA
	DB $7F,$FF,$01,$FF,$7F,$00,$00,$04,$00,$03,$01,$64,$14,$00	; 16 player death 1 step 4 dur 100 pitch $0014
	DB $7F,$FF,$01,$FF,$7F,$00,$00,$04,$00,$03,$02,$64,$1E,$00	; 17 player death 2 step 4 dur 100 pitch $001E


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
