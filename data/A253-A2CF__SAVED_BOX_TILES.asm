; --- box-restore buffer (tiles saved under a drawn box) + draw destination/colour scratch
SAVED_BOX_TILES:
	DS $70
	DS $08

DRAW_DEST:
	DB $00,$00
    
DRAW_COLOR:
	DB 0
DRAW_COLOR_BASE:
	DB 0
DISSOLVE:
	DB 0
