; --- setup_main_menu: draw the main-menu screen (banner/logo/hiscore panel) (@done)
setup_main_menu:
	ld a, $FF
	ld (HUD_ACTIVE), a
	ld a, (PANEL_DRAWN)
	and a
	call z, panel_to_buffer
	xor a
	ld (PANEL_DRAWN), a
	call menu_wipe_in
	call clear_scr_more
	ld hl, BUFF_F2F0
	ld de, BUFF_F2F0+1
	ld bc, $0050
	ld (hl), $00
	ldir
	ld hl, MENU_BANNER
	ld de, $000B
	ld bc, $0A06
	call draw_block
	ld hl, MENU_MID
	ld de, $0613
	ld bc, $0201
	call draw_block
	ld hl, $52E0
	ld b, $20
	or $FF
.fill:
	ld (hl), a
	inc l
	djnz .fill

	ld hl, MENU_TITLE
	ld de, $160A
	ld bc, $0C02
	call draw_block
