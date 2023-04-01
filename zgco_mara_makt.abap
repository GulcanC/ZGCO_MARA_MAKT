*&---------------------------------------------------------------------*
*& Report ZGCO_MARA_MAKT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zgco_mara_makt.

INCLUDE zgco_mara_makt_scr.
INCLUDE zgco_mara_makt_f01.



START-OF-SELECTION.
  IF rb_1 = 'X'.
    PERFORM mara_makt_1.
  ENDIF.

* second, select data, display data
  IF rb_2 = 'X'.
    PERFORM mara_makt_2.
  ENDIF.