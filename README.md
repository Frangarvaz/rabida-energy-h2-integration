# Rábida Energy H₂ Integration Hub

> Certificación automática de hidrógeno verde · SAP BTP Integration Suite → S/4HANA Cloud

![SAP BTP](https://img.shields.io/badge/SAP%20BTP-Integration%20Suite-0070f3?style=flat-square&logo=sap)
![ABAP Cloud](https://img.shields.io/badge/ABAP-Cloud-0070f3?style=flat-square&logo=sap)
![S/4HANA](https://img.shields.io/badge/S%2F4HANA-Cloud-0070f3?style=flat-square&logo=sap)
![Node.js](https://img.shields.io/badge/Node.js-SCADA-339933?style=flat-square&logo=nodedotjs)
![OData](https://img.shields.io/badge/OData-V4-orange?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)

---

![Demo SCADA en tiempo real](demo.gif)

---

## ¿Qué es este proyecto?

Integración **end-to-end** que automatiza la certificación de lotes de hidrógeno verde producidos en plantas de Huelva (Andalucía). Los datos viajan desde un sensor SCADA simulado hasta SAP S/4HANA Cloud, donde quedan registrados con su certificado **EU-GreenH2-2024** sin intervención humana.

---

## Arquitectura del flujo

```
┌─────────────────┐     HTTP POST     ┌──────────────────────────────────────┐     OData V4     ┌─────────────────┐
│  Dashboard SCADA │  ─────────────►  │       SAP BTP Integration Suite       │  ─────────────►  │  S/4HANA Cloud  │
│   (Node.js)      │                  │  HTTPS Sender → Groovy → HTTP Receiver │                  │  ZFGV_H2PROD    │
└─────────────────┘                   └──────────────────────────────────────┘                   └─────────────────┘
```

1. **Dashboard SCADA** (Node.js) — simula sensores IoT y envía datos de producción H₂
2. **iFlow BTP** — recibe, transforma y certifica el lote vía Groovy Script
3. **S/4HANA Cloud** — persiste el certificado EU-GreenH2-2024 vía OData V4

---

## Stack técnico

| Capa | Tecnología |
|------|-----------|
| Simulación IoT | Node.js · Express · REST/JSON |
| Middleware | SAP BTP Integration Suite · iFlow |
| Transformación | Groovy Script · Content Modifier |
| Backend SAP | ABAP Cloud · Eclipse ADT · abapGit |
| Modelo de datos | RAP Business Object · CDS Views |
| Acceso a datos | OData V4 · Service Binding |
| UI | SAP Fiori Elements Preview |
| Base de datos | Tabla transparente S/4HANA Cloud |

---

## Artefactos ABAP Cloud

12 objetos desarrollados en Eclipse ADT, sistema TRL, paquete `ZFGV_ABAP`:

| Objeto | Tipo | Descripción |
|--------|------|-------------|
| `ZFGV_H2PROD` | Database Table | Almacena lotes de producción H₂ certificados |
| `ZI_H2PRODUCTION` | CDS Interface View | Expone los datos con anotaciones OData |
| `ZR_H2PRODUCTION` | Root View Entity | Vista raíz del RAP Business Object |
| `ZC_H2PRODUCTION` | Projection View | Vista de proyección con anotaciones UI Fiori Elements |
| `ZR_H2PRODUCTION` | Behavior Definition | Validación EU-GreenH2-2024 (pureza ≥ 99.97%) + determinación de estado |
| `ZBP_H2PRODUCTION` | Behavior Implementation | Lógica de `validatePurity` y `setStatus` |
| `ZSD_H2PRODUCTION` | Service Definition | Define el servicio OData |
| `ZSB_H2PRODUCTION` | Service Binding | Endpoint OData V4 consumible desde BTP |
| `ZUI_H2PRODUCTION_O4` | UI Service Binding | Binding UI publicado — Fiori Preview funcional |

> Código fuente ABAP disponible en [`abap/`](abap/)

---

## Estructura del repositorio

```
rabida-energy-h2-integration/
├── abap/                    # Artefactos ABAP Cloud (abapGit)
│   ├── zfgv_h2prod.*        # Tabla transparente
│   ├── zi_h2production.*    # CDS Interface View
│   ├── zr_h2production.*    # Root View + Behavior Definition
│   ├── zc_h2production.*    # Projection View (Fiori)
│   ├── zbp_h2production.*   # Behavior Implementation
│   ├── zsd_h2production.*   # Service Definition
│   ├── zsb_h2production.*   # Service Binding OData V4
│   └── zui_h2production_o4.* # UI Service Binding
├── docs/                    # Capturas y documentación visual
├── iflows/                  # Documentación del iFlow BTP
├── mock-api/                # Servidor SCADA simulado (Node.js)
├── postman/                 # Guía de tests de integración
├── scripts/                 # Groovy Scripts + test de integración
├── public/                  # Dashboard SCADA (HTML)
├── server.js                # Servidor Express principal
├── index.html               # Portfolio web (GitHub Pages)
└── README.md
```

---

## Roadmap

- [x] Fase 1 — Diseño y documentación
- [x] Fase 2 — Mock API + iFlow básico
- [x] Fase 3 — Groovy Script + Certificado EU-GreenH2-2024
- [x] Fase 4 — S/4HANA + ABAP Cloud (Tabla + CDS + RAP + OData V4)
- [x] Fase 5 — Fiori Elements Preview + UI Service Binding

---

## Resultado

```json
{
  "certificate_id": "CERT-2024-H2-00847",
  "standard": "EU-GreenH2-2024",
  "status": "EU_GREENH2_COMPLIANT",
  "h2_volume_kg": 4200,
  "purity_pct": 99.98,
  "timestamp": "2024-11-15T10:30:00Z"
}
```

**HTTP 200 OK** · Tiempo de proceso: ~894ms · Datos persistidos en S/4HANA ✅

---

## Cómo ejecutarlo localmente

```bash
# Instalar dependencias
npm install

# Arrancar el dashboard SCADA
npm start
# → http://localhost:3000

# Arrancar solo el mock API
npm run mock

# Ejecutar test de integración (requiere credenciales BTP)
npm run test:integration
```

> Requiere acceso a SAP BTP Trial y sistema ABAP Cloud activo para el flujo completo. El dashboard SCADA y el mock API funcionan de forma independiente.

---

## Portfolio

🌐 **[frangarvaz.github.io/rabida-energy-h2-integration](https://frangarvaz.github.io/rabida-energy-h2-integration)**

---

## Autor

**Francisco García Vázquez**
SAP ABAP Cloud & BTP Integration Developer
📍 Huelva, Andalucía, España
🎓 C_ABAPD Certified · SAP Certified Development Associate — ABAP Cloud

[![LinkedIn](https://img.shields.io/badge/LinkedIn-frangarvaz-0077B5?style=flat-square&logo=linkedin)](https://linkedin.com/in/frangarvaz)
[![GitHub](https://img.shields.io/badge/GitHub-Frangarvaz-181717?style=flat-square&logo=github)](https://github.com/Frangarvaz)
[![Portfolio](https://img.shields.io/badge/Portfolio-frangarvaz.github.io-4A9EFF?style=flat-square)](https://frangarvaz.github.io/rabida-energy-h2-integration)

---

*MIT License · 2026 Francisco García Vázquez*
