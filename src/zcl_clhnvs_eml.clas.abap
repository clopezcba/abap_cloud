CLASS zcl_clhnvs_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_clhnvs_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.

    APPEND VALUE #( agencyid = '070010'
                    name     = 'CLHNVS My Airline'
                  ) TO agencies_upd.

    agencies_upd = VALUE #( ( agencyid = '070011' name = 'CLHNVS Some fancy new name' ) ).

    MODIFY ENTITIES OF /dmo/i_agencytp "Interface
    ENTITY /dmo/agency "Alias
    UPDATE FIELDS ( name )
    WITH agencies_upd.

    COMMIT ENTITIES.

    out->write( 'Method execution finished!' ).

  ENDMETHOD.
ENDCLASS.
