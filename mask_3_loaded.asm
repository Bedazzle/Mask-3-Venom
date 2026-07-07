; ZX-M8XXX helpers
; @main
; @entry startup
; @define _128K
; ^ conditional build toggle. In ZX-M8XXX pick "_128K" from the defines dropdown to
;   build the 128K/AY version (bank-4 music player); leave it unselected for 48K.
;   On the command line: sjasmplus --syntax=abF -D_128K mask_3_loaded.asm  (128K)
;                        sjasmplus --syntax=abF        mask_3_loaded.asm  (48K, byte-exact)
;   _128K switches the device, IS_128K ($FFFE), and includes mask_3_bank4.asm.

	IFNDEF _128K
		device zxspectrum48
	ELSE
		device zxspectrum128		; 128K: adds the bank-4 AY player (venom2.c)
	ENDIF

; sp 24576
;STARTGAME	EQU startup	; 9100	; 37120

	include "mask_3_constants.asm"


	ORG $6000

STARTBLOCK:
	include "data/6000-60FF__sprites.asm"
	include "data/6100-61FF__sprites.asm"
	include "data/6200-62FF__sprites.asm"
	include "data/6300-75FF__spritesheet_banks.asm"
	include "data/7600-84FF__rooms.asm"
	include "data/8500-90FF__backgr_tiles.asm"
	include "code/9100-915A__startup.asm"
	include "code/915B-9207__new_game.asm"
	include "code/9208-920F__deadly_loop.asm"
	include "code/9210-9221__striped_border.asm"
	include "data/9222-9225__SND_TRIG_1.asm"
	include "code/9226-92C2__interrupt.asm"
	include "code/92C3-92DF__generate_random.asm"
	include "data/92E0-93DB__SFX_TABLE.asm"
	include "code/93DC-9420__play_sfx.asm"
	include "code/9421-946B__process_sfx_channels.asm"
	include "data/946C-946E__RESET_JUMPER_SND.asm"
	include "code/946F-949E__clear_alien_vectors.asm"
	include "code/949F-94AE__silence_sfx_if_flagged.asm"
	include "code/94AF-94C2__load_sfx.asm"
	include "code/94C3-94C7__stop_sfx.asm"
	include "code/94C8-9509__sound_tick.asm"
	include "data/950A-953A__LEVEL_NUMBER.asm"
	include "data/953B-95FA__levels.asm"
	include "data/95FB-967C__font_chars.asm"
	include "data/967D-96AE__font_digits.asm"
	include "data/96AF-96BD__font_symbols.asm"
	include "code/96BE-970C__find_char_gfx.asm"
	include "data/970D-9722__HUD_ACTIVE.asm"
	include "code/9723-9774__setup_main_menu.asm"
	include "code/9775-9875__main_menu_loop.asm"
	include "code/9876-9898__col_row_to_attr.asm"
	include "code/9899-992E__draw_main_menu.asm"
	include "code/992F-9950__clear_scr_more.asm"
	include "code/9951-999D__draw_multi_logo.asm"
	include "code/999E-99B7__find_bmp_addr.asm"
	include "code/99B8-99EF__draw_block.asm"
	include "data/99F0-9C9F__menu_banner.asm"
	include "code/9CA0-9CBE__panel_to_buffer.asm"
	include "code/9CBF-9CD8__print_string.asm"
	include "code/9CD9-9D00__print_char.asm"
	include "data/9D01-9D19__MAINMENU_ICONS.asm"
	include "code/9D1A-9E0F__show_main_menu.asm"
	include "code/9E10-9E3A__clear_screen_pixels.asm"
	include "code/9E3B-9E7A__redefine_keys.asm"
	include "code/9E7B-9E8F__enter_new_key.asm"
	include "data/9E90-9EAE__WORD_FIRE.asm"
	include "code/9EAF-9ED2__copy_F2F0_buff.asm"
	include "data/9ED3-9F2D__multicolor.asm"
	include "code/9F2E-9F61__prepare_multicolor.asm"
	include "code/9F62-9F6C__detect_kempston.asm"
	include "data/9F6D-9F81__TELEPORT_1.asm"
	include "code/9F82-9FF8__enter_password.asm"
	include "data/9FF9-A032__WORD_DOTS.asm"
	include "code/A033-A03F__match_buffer.asm"
	include "code/A040-A080__wipe_screen.asm"
	include "data/A081-A08F__SINCLAIR_KEYS.asm"
	include "code/A090-A0B1__read_key.asm"
	include "code/A0B2-A0F0__scan_keyboard.asm"
	include "data/A0F1-A118__KEYBOARD.asm"
	include "code/A119-A137__decode_char.asm"
	include "data/A138-A13A__KEY_FIRE_CURRENT.asm"
	include "code/A13B-A14F__is_fire_pressed.asm"
	include "data/A150-A154__KEY_FIRE.asm"
	include "code/A155-A193__test_keys.asm"
	include "data/A194-A197__SPRITESET.asm"
	include "code/A198-A1EF__swap_spritesheet.asm"
	include "code/A1F0-A252__playfield_to_screen.asm"
	include "data/A253-A2CF__SAVED_BOX_TILES.asm"
	include "code/A2D0-A348__draw_all_actors.asm"
	include "code/A349-A3ED__pick_actor_sprite.asm"
	include "data/A3EE-A3F1__pad_A3EE.asm"
	include "code/A3F2-A43E__calc_frame_addr.asm"
	include "data/A43F-A48A__PLAYER.asm"
	include "data/A48B-A56E__aliens.asm"
	include "code/A56F-A776__draw_sprite.asm"
	include "code/A777-A7F2__expand_sprite.asm"
	include "code/A7F3-A85F__mirror_sprite.asm"
	include "code/A860-A898__generate_tables.asm"
	include "code/A899-A9BD__draw_room.asm"
	include "code/A9BE-AA71__draw_boxes.asm"
	include "data/AA72-AA74__BRIDGE_PTR.asm"
	include "code/AA75-AAA0__find_bridge.asm"
	include "code/AAA1-ABB4__list_special_tiles.asm"
	include "data/ABB5-ABFC__TILE_SET_1.asm"
	include "code/ABFD-AC2E__find_room_tile.asm"
	include "code/AC2F-AC41__find_room_tile_next.asm"
	include "code/AC42-AC7E__do_cannon.asm"
	include "data/AC7F-AC7F__GROUND_ROW.asm"
	include "code/AC80-AC9B__find_ground_row.asm"
	include "code/AC9C-ACBB__find_volcanoes.asm"
	include "code/ACBC-ACD9__check_teleports.asm"
	include "code/ACDA-AD27__find_rotators.asm"
	include "code/AD28-ADBE__welcome_message.asm"
	include "code/ADBF-ADD1__decode_pass.asm"
	include "code/ADD2-ADF5__decrease_penetrator.asm"
	include "code/ADF6-AE1C__game_finished.asm"
	include "data/AE1D-AE44__FOUND_SCOTT.asm"
	include "code/AE45-AE5F__increase_score.asm"
	include "code/AE60-AEA5__print_score.asm"
	include "data/AEA6-AEA7__ENERGY.asm"
	include "code/AEA8-AF0B__draw_energy.asm"
	include "data/AF0C-AF52__SLOT.BLINK.asm"
	include "code/AF53-AF81__show_weapon_slot.asm"
	include "code/AF82-AFF9__message_scroller.asm"
	include "code/AFFA-B023__slot_blinking.asm"
	include "code/B024-B088__show_slot_box.asm"
	include "code/B089-B0CD__select_weapon_slot.asm"
	include "code/B0CE-B0FA__update_weapon_panel.asm"
	include "data/B0FB-B0FE__MESSAGE_ADDRESS.asm"
	include "code/B0FF-B11A__set_new_message.asm"
	include "code/B11B-B20F__collect_box.asm"
	include "code/B210-B237__consume_ammo.asm"
	include "code/B238-B275__tick_active_weapon.asm"
	include "code/B276-B2C4__stamp_boxes.asm"
	include "code/B2C5-B2F0__restore_boxes.asm"
	include "code/B2F1-B2F7__tick_hazards.asm"
	include "code/B2F8-B33C__check_drowning.asm"
	include "code/B33D-B3E5__spawn_alien_at_rotator.asm"
	include "data/B3E6-B3EA__PLAYER_CELL_LEAD.asm"
	include "code/B3EB-B4BF__update_player.asm"
	include "code/B4C0-B5FC__player_walk.asm"
	include "code/B5FD-B628__find_player_cell.asm"
	include "code/B629-B646__calc_player_map_ptr.asm"
	include "code/B647-B658__player_recoil.asm"
	include "code/B659-B6D7__change_room.asm"
	include "code/B6D8-B6E7__dead_exit4.asm"
	include "code/B6E8-B705__start_fall.asm"
	include "code/B706-B72C__check_ground.asm"
	include "code/B72D-B75A__action_by_accum.asm"
	include "code/B75B-B79D__go_stairs.asm"
	include "code/B79E-B7B4__go_sit_down.asm"
	include "code/B7B5-B840__go_jump.asm"
	include "code/B841-B8DD__go_fall.asm"
	include "code/B8DE-B8E6__start_fly.asm"
	include "code/B8E7-B99A__go_fly.asm"
	include "code/B99B-B9B7__player_standing.asm"
	include "code/B9B8-B9C4__player_dying.asm"
	include "code/B9C5-B9D7__start_teleport.asm"
	include "code/B9D8-BA20__teleport_to_level.asm"
	include "code/BA21-BA3D__give_bonus_weapon.asm"
	include "code/BA3E-BA5F__mark_backlash_slots.asm"
	include "code/BA60-BA67__refresh_weapon_panel.asm"
	include "code/BA68-BA7A__go_appear.asm"
	include "code/BA7B-BA92__finish_appear.asm"
	include "code/BA93-BAA6__apply_hazard_damage.asm"
	include "data/BAA7-BAA7__INPUT_LOCK.asm"
	include "code/BAA8-BB12__lose_life.asm"
	include "code/BB13-BB4B__term_print.asm"
	include "code/BB4C-BB77__check_cheat_password.asm"
	include "code/BB78-BC57__death_explosion.asm"
	include "code/BC58-BC95__plot_particle.asm"
	include "code/BC96-BCDF__bullet_hits_alien.asm"
	include "code/BCE0-BD7E__fire_weapon.asm"
	include "code/BD7F-BD83__reset_bullet.asm"
	include "code/BD84-BDA3__move_bullet.asm"
	include "code/BDA4-BE0C__use_weapon.asm"
	include "data/BE0D-BE0D__WEAPON_AUTOFIRE.asm"
	include "code/BE0E-BE3A__fire_penetrator.asm"
	include "data/BE3B-BF2A__alien_templates.asm"
	include "code/BF2B-BFD1__choose_alien_routine.asm"
	include "code/BFD2-C04A__do_rockets.asm"
	include "code/C04B-C07D__do_spheres.asm"
	include "code/C07E-C0A5__do_jumpers.asm"
	include "code/C0A6-C0D5__do_mushrooms.asm"
	include "data/C0D6-C0D8__BOSS_ACTIVE.asm"
	include "code/C0D9-C0F6__do_harrier.asm"
	include "code/C0F7-C115__do_bomber.asm"
	include "code/C116-C166__do_volcano.asm"
	include "code/C167-C18B__do_bomb.asm"
	include "code/C18C-C19D__kill_all_aliens.asm"
	include "code/C19E-C1F0__do_mortar.asm"
	include "data/C1F1-C1F2__pad.asm"
	include "code/C1F3-C26D__do_snake.asm"
	include "data/C26E-C26E__THEME_PARAM.asm"
	include "code/C26F-C283__start_vanish.asm"
	include "code/C284-C2C0__hit_alien.asm"
	include "code/C2C1-C2C9__award_alien_score.asm"
	include "code/C2CA-C2D8__decrease_energy.asm"
	include "code/C2D9-C314__alien_hits_player.asm"
	include "code/C315-C361__alien_vectors.asm"
	include "code/C362-C374__move_alien.asm"
	include "code/C375-C3A5__move_sphere.asm"
	include "code/C3A6-C3F0__move_rocket.asm"
	include "code/C3F1-C400__state_vanish.asm"
	include "code/C401-C456__alien_hits_wall.asm"
	include "code/C457-C520__move_cannon.asm"
	include "code/C521-C561__move_cannonball.asm"
	include "code/C562-C5D8__move_jumper.asm"
	include "code/C5D9-C64D__move_mushroom.asm"
	include "code/C64E-C6B6__move_harrier.asm"
	include "code/C6B7-C6B7__just_a_ret.asm"
	include "code/C6B8-C6D3__alien_killed.asm"
	include "code/C6D4-C6F1__state_rise.asm"
	include "code/C6F2-C73E__move_bomber_bomb.asm"
	include "code/C73F-C788__move_volcano.asm"
	include "code/C789-C789__pad_ret.asm"
	include "code/C78A-C7F3__state_bomb.asm"
	include "code/C7F4-C81A__move_bomb.asm"
	include "code/C81B-C85F__move_mortar.asm"
	include "code/C860-C89A__move_mortar_shell.asm"
	include "code/C89B-C921__move_bomber.asm"
	include "code/C922-C97F__state_explosion.asm"
	include "code/C980-C9B7__move_snake_head.asm"
	include "code/C9B8-C9E9__move_snake_body.asm"
	include "code/C9EA-CA3C__toggle_anim_tiles.asm"
	include "code/CA3D-CAAC__move_bridge.asm"
	include "code/CAAD-CACC__mark_special_tiles.asm"
	include "code/CACD-CB41__animate_playfield.asm"
	include "code/CB42-CC5B__animate_water_lava.asm"
	include "data/CC5C-CD5F__menu_icons.asm"
	include "data/CD60-CDDF__sprites_player_01.asm"
	include "data/CDE0-CE5F__sprites_player_02.asm"
	include "data/CE60-CEDF__sprites_player_03.asm"
	include "data/CEE0-CF5F__sprites_player_04.asm"
	include "data/CF60-CFDF__sprites_player_05.asm"
	include "data/CFE0-D05F__sprites_player_06.asm"
	include "data/D060-D0DF__sprites_player_07.asm"
	include "data/D0E0-D15F__sprites_player_08.asm"
	include "data/D160-D1DF__sprites_player_09.asm"
	include "data/D1E0-D25F__sprites_player_10.asm"
	include "data/D260-D39F__sprites.asm"
	include "data/D3A0-D43F__font_big.asm"
	include "data/D440-D57F__sprites.asm"
	include "data/D580-D6DF__sprites_weapons.asm"
	include "data/D6E0-D79F__sprites_bullets.asm"
	include "data/D7A0-D97F__sprites.asm"
	include "data/D980-DBBF__sprites.asm"
	include "data/DBC0-E7FF__sprites.asm"
	include "data/E800-EDFF__particles.asm"
	include "data/EE00-EEFF__colors_player.asm"
	include "data/EF00-EFFF__colors_backgr.asm" 
	include "data/F000-F5FF__work_buffers.asm"
	include "data/F600-F7FF__multicolor_luts.asm"
	include "data/F800-FCFF__color_luts.asm"
	include "data/FD00-FDFF__attr_color_lut.asm"


INT_VECTORS:	; must be aligned
	DS $100, 0

	include "data/FF00-FFF3__boot_loader.asm"

to_interrupt:
	jp interrupt

	DB $5A,$A5,$80,$E2,$88,$E2,$3C
	
; IS_128K: machine flag. The tape loader POKEs $FFFE with 0 for 128K, 1 for 48K
; (its BASIC: "REM 0 for 128K, 1 for 48K"); the game uses 0 => AY player in bank 4,
; non-zero => 48K beeper. The default image ships $FF (loader overwrites it).
IS_128K:
	IFDEF _128K
		DB $00		; 128K build: drive the AY music player in bank 4
	ELSE
		DB $FF		; 48K build: byte-exact to the original image (beeper path)
	ENDIF


last_jump:
	DB $18	; jr to_interrupt

	IFDEF _128K
; --- 128K build only: the AY music player in RAM bank 4 ($C000) -------
; (the 48K build omits this; the 128K loader LOAD "venom2.c"CODE puts it here)
		include "mask_3_bank4.asm"			; ends with slot 3 = bank 0 (main game)
		savebin "recompile/mask_3_128k.bin",STARTBLOCK,$FFFF-STARTBLOCK+1	; md5 check: f5f2fa34f5faa9b1913c63a995e9174d  (main game $6000-$FFFF, IS_128K=0)
		SLOT 3
		PAGE 4
		savebin "recompile/mask_3_128k_bank4.bin",$C000,$CFA0-$C000		; md5 check: a110a2b07a80945ddddaca724c9b5a02  (AY player venom2.c, bank 4)
		SLOT 3
		PAGE 0
		savesna "recompile/mask_3_128k.sna",startup
	ELSE
		savebin "recompile/mask_3_loaded.bin",STARTBLOCK,$FFFF-STARTBLOCK+1	; md5 check: 19bc11db626363a574876062784c5294
		savesna "recompile/mask_3_loaded.sna",startup				; md5 check: 0c6b5a5f7109c6b0f5bf446cbb51affd
	ENDIF





