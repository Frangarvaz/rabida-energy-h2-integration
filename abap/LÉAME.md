# ABAP Cloud · S/4HANA · Rábida Energy H₂

Artefactos ABAP Cloud desarrollados en Eclipse ADT para SAP S/4HANA Cloud.

---

## Arquitectura RAP


---

## ZR_H2PRODUCTION — Root View Entity

```abap
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'H2 Production Root View Entity'
define root view entity ZR_H2PRODUCTION
  as select from zfgv_h2prod
{
  key plant_id          as PlantId,
  key record_date       as RecordDate,
      h2_kg_produced    as H2KgProduced,
      energy_kwh        as EnergyKwh,
      efficiency_pct    as EfficiencyPct,
      status            as Status,
      certificate_id    as CertificateId
}
```

---

## ZR_H2PRODUCTION — Behavior Definition

```abap
managed implementation in class ZBP_H2PRODUCTION unique;
strict ( 2 );

define behavior for ZR_H2PRODUCTION alias H2Production
persistent table zfgv_h2prod
lock master
authorization master ( instance )
{
  create;
  update;
  delete;

  validation validatePurity on save { create; update; }
  determination setStatus on modify { create; update; }

  field ( readonly ) PlantId;
  field ( readonly ) RecordDate;
  field ( readonly ) CertificateId;
}
```

---

## ZBP_H2PRODUCTION — Behavior Implementation

Valida que cada lote cumpla el estándar EU-GreenH2-2024 (pureza >= 99.97%) y calcula automáticamente el estado de certificación.

```abap
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
    ENDIF.
  ENDLOOP.
ENDMETHOD.

METHOD set_status.
  DATA(lv_status) = COND #(
    WHEN ls_h2-EfficiencyPct >= '99.97' THEN 'EU_GREENH2_COMPLIANT'
    ELSE                                     'NOT_COMPLIANT'
  ).
ENDMETHOD.
```

---

## ZC_H2PRODUCTION — Projection View

Vista de proyección con anotaciones UI para Fiori Elements.

---

## ZUI_H2PRODUCTION_O4 — Service Binding OData V4

Service Binding tipo OData V4 - UI publicado en S/4HANA Cloud.
Estado: Published
