# Documentación

Capturas y material visual del proyecto Rábida Energy H₂ Integration Hub.

## Contenido

| Archivo | Descripción |
|---------|-------------|
| `eclipse-abap.png` | Captura del entorno Eclipse ADT con los artefactos ABAP Cloud del proyecto |
| `fiori-preview.png` | Captura del Fiori Elements Preview mostrando los datos de producción H₂ |

## Arquitectura

```
┌─────────────────┐     HTTP POST     ┌──────────────────────────────┐     OData V4     ┌─────────────────┐
│  Dashboard SCADA │  ─────────────►  │   SAP BTP Integration Suite   │  ─────────────►  │  S/4HANA Cloud  │
│   (Node.js)      │                  │   iFlow: H2-Certification     │                  │  ZFGV_H2PROD    │
└─────────────────┘                   └──────────────────────────────┘                   └─────────────────┘
```

1. **Dashboard SCADA** — Node.js simula sensores IoT y envía datos de producción H₂
2. **iFlow BTP** — Recibe, transforma (Groovy Script) y certifica el lote
3. **S/4HANA Cloud** — Persiste el registro certificado EU-GreenH2-2024 vía OData V4

## Validación de negocio

Cada lote pasa por una validación RAP (`validatePurity`) que verifica pureza ≥ 99.97% según el estándar EU-GreenH2-2024. Los lotes que no cumplen se rechazan automáticamente.
