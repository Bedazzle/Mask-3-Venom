; --- SPRITESET -------------------------------------------------
; @done


; SPRITESET - active spriteset / environment theme.
;   [0] = index of the currently active theme (0-3)
;   [1..3] = ring of the three currently-inactive banks
; Game logic branches on (SPRITESET): theme 1 is a hazard
; environment that drains energy (see the go_* movers).
SPRITESET:
	DB $00,$01,$02,$03


; --- swap_spritesheet -----------------------------------------
; @done
; Make theme A the active one by swapping its stored bank into
; the live sprite area (SPRITE_E000, 2048 bytes) and background
; colour table (COLORS_BACKGR, 256 bytes). The inactive banks
; are held back-to-back from $5B00 ($0900 bytes each). The ring
; in SPRITESET[1..3] is updated so [0] always names the active
; theme, and the per-theme parameter is latched into THEME_PARAM.
; In:  a = desired theme index (0-3)
; Out: SPRITESET updated; live sprites/colours swapped; THEME_PARAM set
; Note: runs with interrupts off (di..ei); no-op if already active
swap_spritesheet:
	ld hl, SPRITESET

	cp (hl)
	ret z

	di
	ld e, (hl)		; e = old (currently active) index
	inc hl
	ld b, $01
.find:
	cp (hl)			; scan ring for the desired index
	jr z, .found

	inc hl
	inc b
	jr .find

.found:
	ld d, a			; d = new index, b = its ring slot (1-3)
	push de
	push hl
	ld hl, $5B00		; base of the inactive-bank storage
	ld de, $0900		; 2304 bytes per bank
	jr .buf_skip

.buf_add:
	add hl, de

.buf_skip:
	djnz .buf_add		; hl = storage buffer for slot b

	ld de, SPRITE_E000
	ld bc, $0800		; 2048 sprite bytes
.swap_sprite:
	ld a, (hl)		; exchange stored <-> live sprite byte
	ex af, af'
	ld a, (de)
	ld (hl), a
	ex af, af'
	ld (de), a
	inc hl
	inc de
	dec bc
	ld a, b
	or c
	jp nz, .swap_sprite

	ld de, COLORS_BACKGR
.swap_color:
	ld c, (hl)		; exchange stored <-> live colour byte
	ex de, hl
	ld b, (hl)
	ld (hl), c
	ex de, hl
	ld (hl), b
	inc l
	inc e
	jr nz, .swap_color	; 256 bytes

	pop hl
	pop de
	ld (hl), e		; retire old index into the freed ring slot
	ld a, d
	ld (SPRITESET), a	; new index is now active
	ld e, a
	ld d, $00
	ld hl, SPRITESET_PARAM
	add hl, de
	ld a, (hl)
	ld (THEME_PARAM), a		; latch this theme's parameter
	ei

	ret



; per-theme parameter, indexed by active SPRITESET, copied to THEME_PARAM
SPRITESET_PARAM:
	DB $A7,$64,$56,$3F
