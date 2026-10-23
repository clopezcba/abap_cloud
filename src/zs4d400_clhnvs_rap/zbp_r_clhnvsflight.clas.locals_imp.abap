CLASS lhc_zr_clhnvsflight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrClhnvsflight
        RESULT result,
      validatePrice FOR VALIDATE ON SAVE
       keys FOR ZrClhnvsflight~validatePrice.
ENDCLASS.

CLASS lhc_zr_clhnvsflight IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD validatePrice.

    DATA failed_record LIKE LINE OF failed-zrclhnvsflight.
    DATA reported_record LIKE LINE OF reported-zrclhnvsflight.

    READ ENTITIES OF zr_clhnvsflight IN LOCAL MODE
    ENTITY ZrClhnvsflight
    FIELDS ( Price  )
    WITH CORRESPONDING #( keys )
    RESULT DATA(flights).

    LOOP AT flights INTO DATA(flight).

      IF flight-price <= 0.
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-zrclhnvsflight.

        reported_record-%tky = flight-%tky.
        reported_record-%msg = new_message( id = '/LRN/S4D400' number = '101' severity = ms-error ).
        APPEND reported_record TO reported-zrclhnvsflight.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
