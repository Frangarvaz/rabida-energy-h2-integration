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
2. **iFlow BTP** — recibe, transforma y certifica el lote via Groovy Script
3. **S/4HANA Cloud** — persiste el certificado EU-GreenH2-2024 via OData V4

---

## Stack técnico

| Capa | Tecnología |
|------|-----------|
| Simulación IoT | Node.js · JavaScript · REST/JSON |
| Middleware | SAP BTP Integration Suite |
| Transformación | Groovy Script · Content Modifier |
| Backend SAP | ABAP Cloud · Eclipse ADT |
| Acceso a datos | CDS Views · OData V4 |
| Base de datos | Tabla transparente S/4HANA |

---

## Artefactos ABAP Cloud

Desarrollados en Eclipse ADT y versionados con abapGit:

| Objeto | Tipo | Descripción |
|--------|------|-------------|
| `ZFGV_H2PROD` | Database Table | Almacena lotes de producción certificados |
| `ZI_H2PRODUCTION` | CDS Interface View | Expone los datos con anotaciones OData |
| `ZSD_H2PRODUCTION` | Service Definition | Define el servicio OData |
| `ZSB_H2PRODUCTION` | Service Binding OData V4 | Endpoint REST consumible desde BTP |

---

## Roadmap

- [x] Fase 1 — Diseño y documentación
- [x] Fase 2 — Mock API + iFlow básico
- [x] Fase 3 — Groovy Script + Certificado EU-GreenH2-2024
- [x] Fase 4 — S/4HANA + ABAP Cloud (Tabla + CDS View + OData V4)

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
node server.js
# → http://localhost:3000

# Ejecutar test de integración
bash scripts/test_h2.sh
```

> Requiere acceso a SAP BTP Trial y sistema ABAP Cloud activo.

---

## Portfolio

🌐 **[frangarvaz.github.io](https://frangarvaz.github.io/rabida-energy-h2-integration)**

---

## Autor

**Francisco García Vázquez**  
Desarrollador SAP ABAP Cloud | SAP BTP | Backend Developer  
📍 Huelva, Andalucía, España  
🎯 Certificaciones en proceso: C_ABAPD · C_CPI  

[![LinkedIn](https://img.shields.io/badge/LinkedIn-frangarvaz-0077B5?style=flat-square&logo=linkedin)](https://linkedin.com/in/frangarvaz)
[![GitHub](https://img.shields.io/badge/GitHub-Frangarvaz-181717?style=flat-square&logo=github)](https://github.com/Frangarvaz)
[![Portfolio](https://img.shields.io/badge/Portfolio-frangarvaz.github.io-4A9EFF?style=flat-square)](https://frangarvaz.github.io)

---

*MIT License · 2024 Francisco García Vázquez*
