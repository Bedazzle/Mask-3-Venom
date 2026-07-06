; --- alien_vectors -------------------------------------------
; @done
; Per-frame update dispatcher for the alien state machine. Reads
; this alien's state (ALIEN.state), masks off the flag bits, and
; jumps through ALIEN_STATE_TABLE to the handler for states 0-19.
; State 0 (and the flag-only case) is inactive. Each handler is a
; move_* / state_* routine; the do_* spawners set the initial
; state when an alien appears.
; In: ix = alien
alien_vectors:
	IFNDEF DESERT
		ld a, (ix+ALIEN.state)
	ELSE
		ret
		nop
		nop
	ENDIF

	and $3F
	ret z

	ld l, a
	add a, a
	add a, l
	ld l, a
	ld h, $00
	ld de, ALIEN_STATE_TABLE
	add hl, de

	jp (hl)


ALIEN_STATE_TABLE:
	jp deadly_loop		; 0  inactive

vec_sphere:
	jp move_sphere		; 1

vec_rocket:
	jp move_rocket		; 2

vec_vanish:
	jp state_vanish		; 3  disappearing animation

vec_cannon:
	jp move_cannon		; 4

vec_cannonball:
	jp move_cannonball	; 5

vec_jumper:
	jp move_jumper		; 6

vec_mushroom:
	jp move_mushroom	; 7

vec_harrier:
	jp move_harrier		; 8

vec_idle:
	jp just_a_ret		; 9  idle

vec_rise:
	jp state_rise		; 10 death rise (after being shot)

vec_bomber_bomb:
	jp move_bomber_bomb	; 11

vec_volcano:
	jp move_volcano		; 12

vec_bomb:
	jp state_bomb		; 13

vec_mortar:
	jp move_mortar		; 14

vec_mortar_shell:
	jp move_mortar_shell	; 15

vec_bomber:
	jp move_bomber		; 16

vec_explosion:
	jp state_explosion	; 17

vec_snake_head:
	jp move_snake_head	; 18

vec_snake_body:
	jp move_snake_body	; 19
