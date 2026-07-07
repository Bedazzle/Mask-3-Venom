; --- per-theme animated-tile sets (TILE_SET_1..) - tile codes, $00-terminated
TILE_SET_1:
	DB $60,$61,$62,$63,$9C,$9D,$BC,$BD
	DB $E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9
	DB $EB,$EC,$ED,$EE,$00

TILE_SET_2:
	DB $51,$52,$71,$72,$A1,$A2,$C0,$C1
	DB $E0,$E1,$E2,$E3,$E4,$E5,$E6,$E7
	DB $E8,$E9,$00
	
TILE_SET_3:
	DB $6C,$E2,$E3,$E4,$E5,$E6,$E7,$E8
	DB $E9,$00
	
TILE_SET_4:
	DB $E0,$E1,$E2,$E3,$E5,$E6,$E7,$E8
	DB $E9,$EA,$EB,$EC,$00
	
SPECIAL_TILE_TABLES:
	DW TILE_SET_1
	DW TILE_SET_2
	DW TILE_SET_3
	DW TILE_SET_4

SEARCH_TILE:
	DB $00
