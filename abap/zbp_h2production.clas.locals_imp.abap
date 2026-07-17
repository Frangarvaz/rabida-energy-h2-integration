 CLASS lhc_h2production DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS validate_purity FOR VALIDATE ON SAVE
      IMPORTING keys FOR H2Production~validatePurity.
    METHODS set_status FOR DETERMINE ON MODIFY
      IMPORTING keys FOR H2Production~setStatus.
    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR H2Production
      RESULT result.
ENDCLASS.

CLASS lhc_h2production IMPLEMENTATION.

  METHOD validate_purity.
    READ ENTITIES OF ZR_H2PRODUCTION IN LOCAL MODE
      ENTITY H2Production
        FIELDS ( EfficiencyPct )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_h2).

    LOOP AT lt_h2 INTO DATA(ls_h2).
      IF ls_h2-EfficiencyPct < '99.97'.
        APPEND VALUE #(
          %tky = ls_h2-%tky
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Purity below EU-GreenH2-2024 threshold (99.97%)'
          )
        ) TO reported-h2production.
        APPEND VALUE #( %tky = ls_h2-%tky ) TO failed-h2production.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD set_status.
    READ ENTITIES OF ZR_H2PRODUCTION IN LOCAL MODE
      ENTITY H2Production
        FIELDS ( EfficiencyPct )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_h2).

    LOOP AT lt_h2 INTO DATA(ls_h2).
      DATA(lv_status) = COND #(
       WHEN ls_h2-EfficiencyPct >= '99.97' THEN 'EU_GREENH2_COMPLIANT'
        ELSE                                   'NOT_COMPLIANT'
      ).

      MODIFY ENTITIES OF ZR_H2PRODUCTION IN LOCAL MODE
        ENTITY H2Production
          UPDATE FIELDS ( Status )
          WITH VALUE #( (
            %tky   = ls_h2-%tky
            Status = lv_status
          ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
