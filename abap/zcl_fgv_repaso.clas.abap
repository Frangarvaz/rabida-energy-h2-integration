CLASS zcl_fgv_repaso DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_fgv_repaso IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

DATA fecha TYPE d.
DATA anio  TYPE c LENGTH 4.
DATA mes   TYPE c LENGTH 2.
DATA dia   TYPE c LENGTH 2.

" Obtenemos la fecha de hoy
fecha = cl_abap_context_info=>get_system_date( ).

" Extraemos las partes
anio = fecha(4).
mes  = fecha+4(2).
dia  = fecha+6(2).

" Mostramos el resultado
out->write( |Fecha completa: { fecha date = user }| ).
out->write( |Año:  { anio }| ).
out->write( |Mes:  { mes }| ).
out->write( |Día:  { dia }| ).
out->write( |Fecha en formato español: { dia }/{ mes }/{ anio }| ).

DATA ts TYPE utclong.
DATA diff TYPE decfloat34.
DATA ts_mas_30 TYPE utclong.

ts = utclong_current( ).
ts_mas_30 = utclong_add( val = ts  days = 30 ).
diff = utclong_diff( high = ts_mas_30  low = ts ).

out->write( |Diferencia en segundos: { diff }| ).
out->write( |Diferencia en minutos:  { diff / 60 }| ).
out->write( |Diferencia en horas:    { diff / 3600 }| ).
out->write( |Diferencia en días:     { diff / 3600 / 24 }| ).





      endmethod.
ENDCLASS.
