# ABAP Cloud · S/4HANA Cloud

Artefactos ABAP Cloud desarrollados en Eclipse ADT para SAP S/4HANA Cloud (sistema TRL, paquete `ZFGV_ABAP`). Sincronizados con abapGit.

## Artefactos

| Objeto | Tipo | Archivo(s) | Descripción |
|--------|------|-----------|-------------|
| `ZFGV_H2PROD` | Database Table | `zfgv_h2prod.tabl.xml` | Tabla transparente que almacena los lotes de producción H₂ certificados |
| `ZI_H2PRODUCTION` | CDS Interface View | `zi_h2production.ddls.*` | Vista CDS de interfaz con anotaciones OData |
| `ZR_H2PRODUCTION` | Root View Entity | `zr_h2production.ddls.*` | Vista raíz del RAP Business Object |
| `ZC_H2PRODUCTION` | Projection View | `zc_h2production.ddls.*` | Vista de proyección con anotaciones UI para Fiori Elements |
| `ZR_H2PRODUCTION` | Behavior Definition | `zr_h2production.bdef.*` | Define operaciones CRUD, validación y determinación |
| `ZBP_H2PRODUCTION` | Behavior Implementation | `zbp_h2production.clas.*` | Implementación: `validatePurity` + `setStatus` |
| `ZSD_H2PRODUCTION` | Service Definition | `zsd_h2production.srvd.*` | Definición del servicio OData |
| `ZSB_H2PRODUCTION` | Service Binding | `zsb_h2production.srvb.xml` | Service Binding OData V4 |
| `ZUI_H2PRODUCTION_O4` | UI Service Binding | `zui_h2production_o4.srvb.xml` | Service Binding UI — Published, Fiori Preview funcional |

## Arquitectura RAP

```
ZI_H2PRODUCTION (Interface View)
       │
ZR_H2PRODUCTION (Root View Entity + Behavior Definition)
       │
ZC_H2PRODUCTION (Projection View + UI Annotations)
       │
ZSD / ZSB / ZUI (Service Definition → Service Binding → Fiori Preview)
```

## Lógica de negocio

### Validación `validatePurity`

Verifica que cada lote cumpla el estándar **EU-GreenH2-2024** (pureza ≥ 99.97%). Si no cumple, se rechaza con un mensaje de error.

### Determinación `setStatus`

Calcula automáticamente el estado de certificación:
- `EU_GREENH2_COMPLIANT` — pureza ≥ 99.97%
- `NOT_COMPLIANT` — pureza < 99.97%

## Requisitos

- Eclipse ADT con conexión a SAP S/4HANA Cloud
- Paquete ABAP Cloud habilitado
- abapGit para sincronización
