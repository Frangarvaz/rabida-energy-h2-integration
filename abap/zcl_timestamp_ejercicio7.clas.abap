CLASS zcl_timestamp_ejercicio7 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_timestamp_ejercicio7 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA ts1        TYPE utclong.
    DATA ts2        TYPE utclong.
    DATA diferencia TYPE decfloat34.
    DATA fecha_user TYPE d.
    DATA hora_user  TYPE t.

    " Cronomarcador actual
    ts1 = utclong_current( ).
    out->write( |Hora UTC actual: { ts1 }| ).

    " Sumar 7 días
    ts2 = utclong_add( val = ts1  days = 7 ).
    out->write( |UTC + 7 días: { ts2 }| ).

    " Diferencia en segundos → convertir a días
    diferencia = utclong_diff( high = ts2  low = ts1 ).
    out->write( |Diferencia en segundos: { diferencia }| ).
    out->write( |Diferencia en días: { diferencia / 3600 / 24 }| ).

    " Partir en fecha y hora local
CONVERT UTCLONG utclong_current( )
        INTO DATE fecha_user
             TIME hora_user
        TIME ZONE cl_abap_context_info=>get_user_time_zone( ).

    out->write( |Fecha local: { fecha_user DATE = USER }| ).
    out->write( |Hora local:  { hora_user TIME = USER }| ).

  ENDMETHOD.
ENDCLASS.
