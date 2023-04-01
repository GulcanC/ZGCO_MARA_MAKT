*&---------------------------------------------------------------------*
*& Include          ZGCO_MARA_MAKT_F01
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form mara_makt_1
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*



FORM mara_makt_1 .

    * This example is simple inner join between tables MARA and MAKT
    * Define a structured type, a model for internal table
    * MARA, donné article general
    * MAKT, désignation des article
    
    
      TYPES : BEGIN OF ty_mara_makt,
                matnr TYPE mara-matnr, "Article
                mtart TYPE mara-mtart, "Type d'article
                mbrsh TYPE mara-mbrsh, "Branche
                meins TYPE mara-meins, "UQ base, unité de quantité de base
                spras TYPE makt-spras, "langue, code langue
                maktx TYPE makt-maktx, "désignation des article
              END OF ty_mara_makt.
    
    * declare structure and internal table
      DATA : lt_mara_makt TYPE TABLE OF ty_mara_makt,
             ls_mara_makt TYPE ty_mara_makt.
    
    
    * select data from these two tables
      SELECT mara~matnr,
             mara~mtart,
             mara~mbrsh,
             mara~meins,
             makt~spras,
             makt~maktx
      FROM mara
      INNER JOIN makt ON mara~matnr = makt~matnr
      WHERE makt~spras IN @s_spras
      AND mara~mtart = @p_mtart
      ORDER BY mara~matnr DESCENDING
      INTO TABLE @lt_mara_makt.
    
      IF sy-subrc <> 0.
        MESSAGE e013(zgco_msg).
        LEAVE LIST-PROCESSING.
      ELSE.
        MESSAGE s014(zgco_msg).
      ENDIF.
    
      LOOP AT lt_mara_makt INTO ls_mara_makt.
        WRITE :/ ls_mara_makt-matnr COLOR 1,
                 ls_mara_makt-mtart COLOR 2,
                 ls_mara_makt-mbrsh COLOR 3,
                 ls_mara_makt-meins COLOR 4,
                 ls_mara_makt-spras COLOR 5,
                 ls_mara_makt-maktx COLOR 6.
      ENDLOOP.
    
    * Create objcet alv for factory and display method
      DATA : lo_alv TYPE REF TO cl_salv_table.
    
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_mara_makt.
    
      CALL METHOD lo_alv->display.
    
    
    
    ENDFORM.
    *&---------------------------------------------------------------------*
    *& Form mara_makt_2
    *&---------------------------------------------------------------------*
    *& text
    *&---------------------------------------------------------------------*
    *& -->  p1        text
    *& <--  p2        text
    *&---------------------------------------------------------------------*
    FORM mara_makt_2 .
    
    * Besoin exprimé par le Client
    * Le client souhaite disposer d'un report lui permettant d'afficher certaines informations concernant les articles
    
    *1-- Liste des informations à afficher :
    *  - le numéro d'article, MARA-MATNR
    *  - le type d'article,  MARA-MTART
    *  - son poids net, MARA-NTGEW
    *  - unité de poids, MARA-GEWEI
    *  - la description (designation) de l'article, MARA-MAKTX
    
    *2-- L'utilisateur souhaite pouvoir afficher ces informations en fonction du type d'article et du numéro d'article
    
      TYPES : BEGIN OF ty_mara_makt_2,
                matnr TYPE Mara-matnr,
                mtart TYPE Mara-mtart,
                ntgew TYPE Mara-ntgew,
                gewei TYPE Mara-gewei,
                maktx TYPE Makt-maktx,
              END OF ty_mara_makt_2.
    
      DATA : lt_mara_makt_2 TYPE TABLE OF ty_mara_makt_2,
             ls_mara_makt_2 TYPE ty_mara_makt_2.
    
      SELECT mara~matnr,
             mara~mtart,
             mara~ntgew,
             mara~gewei,
             makt~maktx
        FROM mara
        INNER JOIN makt ON mara~matnr = makt~matnr
        WHERE  mara~matnr IN @s_matnr
        AND mara~mtart = @p_mtart2
        ORDER BY mara~matnr ASCENDING
        INTO TABLE @lt_mara_makt_2.
    
      IF sy-subrc <> 0.
        MESSAGE e013(zgco_msg).
        LEAVE LIST-PROCESSING.
      ELSE.
        MESSAGE s014(zgco_msg).
      ENDIF.
    
    * Create objcet alv for factory and display method
      DATA : lo_alv TYPE REF TO cl_salv_table.
    
      CALL METHOD cl_salv_table=>factory
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_mara_makt_2.
    
      CALL METHOD lo_alv->display.
    
    
    ENDFORM.