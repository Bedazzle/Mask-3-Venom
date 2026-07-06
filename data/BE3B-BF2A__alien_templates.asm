; --- alien / effect templates --------------------------------
; Each 12-byte template is the "stat block" (type definition) for one alien
; or death effect. When an alien spawns, copy_alien_template stamps these
; bytes straight into its actor record, so a template fully defines that
; enemy type: its score, sprite, contact damage, animation, size, hit points
; and colour.
;
;   byte 0..1  score awarded when killed (BCD, lo:hi)  -> ALIEN.score_lo/hi
;   byte 2..3  sprite graphics pointer (lo:hi)         -> ALIEN.base_lo/hi
;   byte 4     ENERGY drained from player on contact   -> ALIEN.damage  ($FF = instant kill)
;   byte 5     starting animation frame                -> ALIEN.anim
;   byte 6     animation frame mask ($03=4, $07=8 fr)  -> ALIEN.anim_mask
;   byte 7..8  sprite size in cells (width, height)    -> ALIEN.width/height
;   byte 9     render / behaviour mode                 -> ALIEN.mode
;   byte 10    hit points (shots to kill)              -> ALIEN.hp  (0 = a death effect, not an enemy)
;   byte 11    colour attribute                        -> ALIEN.color  ($FF = random bright)
;
; So e.g. the HARRIER is worth 5000 pts, instant-kills on contact, and takes
; 30 hits (a mini-boss); the VANISH_* entries have score/dmg/hp = 0 - they are
; the pop/disappear animations shown when something is destroyed.

TEMPLATE_SPHERE:
	DB $33,$00,$60,$D2,$0A,$00,$03,$02,$02,$04,$01,$FF   ; score 33   dmg 10  hp 1   col rnd

TEMPLATE_ROCKET:
	DB $00,$02,$E0,$D2,$32,$00,$03,$03,$02,$02,$01,$FF   ; score 200  dmg 50  hp 1   col rnd

TEMPLATE_CANNON:
	DB $00,$05,$A0,$D7,$64,$03,$03,$03,$02,$02,$05,$05   ; score 500  dmg 100 hp 5   col 5

TEMPLATE_ROUND:
	;    14  15  16  17  1E  18  1A  05  06  19  21
	DB $10,$00,$60,$D8,$0A,$00,$07,$01,$01,$05,$01,$FF   ; score 10   dmg 10  hp 1   col rnd

TEMPLATE_JUMPER:
	DB $50,$01,$A0,$D8,$32,$00,$07,$02,$02,$04,$01,$FF   ; score 150  dmg 50  hp 1   col rnd

TEMPLATE_MUSHROOM:
	DB $00,$01,$60,$D9,$03,$00,$07,$02,$02,$04,$0A,$04   ; score 100  dmg 3   hp 10  col 4 (green)

TEMPLATE_HARRIER:
	DB $00,$50,$E0,$D9,$FF,$00,$00,$08,$03,$06,$1E,$02   ; score 5000 dmg inst hp 30  col 2 (red) - mini-boss

TEMPLATE_BOMBER_BOMB:
	DB $00,$05,$A0,$DA,$32,$00,$03,$02,$03,$02,$01,$FF   ; score 500  dmg 50  hp 1   col rnd

TEMPLATE_VOLCANO:
	DB $00,$01,$60,$D2,$14,$00,$03,$02,$02,$04,$01,$FF   ; score 100  dmg 20  hp 1   col rnd

TEMPLATE_BOMB:
	;    14  15  16  17  1E  18  1A  05  06  19  21
	DB $00,$10,$C0,$DB,$64,$00,$00,$04,$04,$06,$0A,$04   ; score 1000 dmg 100 hp 10  col 4

TEMPLATE_MORTAR:
	DB $00,$10,$E0,$DE,$FF,$00,$00,$04,$04,$06,$0A,$05   ; score 1000 dmg inst hp 10  col 5

TEMPLATE_MORTAR_SHELL:
	DB $50,$00,$60,$DF,$1E,$00,$00,$02,$02,$06,$02,$05   ; score 50   dmg 30  hp 2   col 5

TEMPLATE_BOMBER:
	DB $00,$80,$60,$DB,$FF,$00,$00,$04,$03,$06,$05,$07   ; score 8000 dmg inst hp 5   col 7 (white)

TEMPLATE_SNAKE1:
	DB $00,$10,$80,$DE,$3C,$00,$00,$02,$02,$06,$FF,$07   ; score 1000 dmg 60  hp 255 col 7
TEMPLATE_SNAKE2:
	DB $00,$02,$A0,$DE,$28,$00,$00,$02,$02,$06,$FF,$07   ; score 200  dmg 40  hp 255 col 7
TEMPLATE_SNAKE3:
	DB $00,$05,$C0,$DE,$3C,$00,$00,$02,$02,$06,$FF,$07   ; score 500  dmg 60  hp 255 col 7

; death / disappear effects (hp 0 -> not real enemies, just the pop animation)
VANISH_SMALL:
	DB $00,$00,$40,$D4,$00,$00,$03,$02,$02,$04,$00,$FF

VANISH_MED:
	DB $00,$00,$C0,$D4,$00,$00,$03,$03,$02,$02,$00,$FF

; bomber bomb disappearing
VANISH_BOMB1:
	DB $00,$00,$40,$DC,$00,$00,$03,$03,$03,$07,$00,$FF
; bomber bomb disappearing
VANISH_BOMB2:
	DB $00,$00,$60,$DD,$00,$00,$03,$03,$03,$07,$00,$FF
