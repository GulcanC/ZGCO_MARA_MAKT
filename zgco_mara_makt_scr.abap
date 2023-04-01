*&---------------------------------------------------------------------*
*& Include          ZGCO_MARA_MAKT_SCR
*&---------------------------------------------------------------------*


************************************************ PERFORM mara_makt_1 **************************************************************
* I CREATED THIS SCREEN BECAUSE IN THE FILE ZGCO_MARA_MAKT SELECTION6OPTIONS ARE NOT ALLOWED

* declare tables which will be used in screen

TABLES : mara, makt.

* select options FOR, parameters TYPE

  SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE TEXT-001.

 PARAMETERS: rb_1  RADIOBUTTON GROUP rb1 USER-COMMAND test DEFAULT 'X'.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-002.

    SELECT-OPTIONS : s_spras FOR makt-spras OBLIGATORY DEFAULT 'FR'.
    PARAMETERS : p_mtart TYPE mara-mtart OBLIGATORY DEFAULT 'ROH'.

  SELECTION-SCREEN END OF BLOCK b1.


************************************************ PERFORM mara_makt_2 **************************************************************

 PARAMETERS: rb_2  RADIOBUTTON GROUP rb1.

  SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-003.

    SELECT-OPTIONS : s_matnr FOR mara-matnr OBLIGATORY DEFAULT 'AELION06'.
    PARAMETERS : p_mtart2 TYPE mara-mtart OBLIGATORY DEFAULT 'ROH'.

  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN END OF BLOCK b0.

* 10- Loop the screen
  LOOP AT SCREEN.

* 11- Active screen "1"
    IF rb_1 EQ 'X' AND screen-group1 = 'ABC'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF rb_2 EQ 'X' AND screen-group1 = 'XYZ'.
      screen-active = 1.
      MODIFY SCREEN.
      CONTINUE.

* 12- Hide screen "0"
    ELSEIF rb_1 EQ ' ' AND screen-group1 = 'ABC'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.

    ELSEIF rb_2 EQ ' ' AND screen-group1 = 'XYZ'.
      screen-active = 0.
      MODIFY SCREEN.
      CONTINUE.

    ENDIF.

  ENDLOOP.