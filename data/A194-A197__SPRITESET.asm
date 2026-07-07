; --- SPRITESET -------------------------------------------------
; @done


; SPRITESET - active spriteset / environment theme.
;   [0] = index of the currently active theme (0-3)
;   [1..3] = ring of the three currently-inactive banks
; Game logic branches on (SPRITESET): theme 1 is a hazard
; environment that drains energy (see the go_* movers).
SPRITESET:
	DB $00,$01,$02,$03
