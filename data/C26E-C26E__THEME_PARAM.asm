; THEME_PARAM: the active theme's cannon parameter. swap_spritesheet latches it from
; SPRITESET_PARAM[SPRITESET] (the 4-entry table $A7,$64,$56,$3F) on every theme change.
; move_cannon uses it both as the tile it stamps into the cannon's map column and as that
; column's scan length - so each theme's cannon has a different tile/reach. ($A7 = theme 0.)
THEME_PARAM:
	DB $A7
