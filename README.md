# 🌊 Huelva H₂ Integration Hub

> SAP BTP Integration Suite · ABAP Cloud · S/4HANA Cloud · Hidrógeno Verde

![SAP BTP](https://img.shields.io/badge/SAP%20BTP-Integration%20Suite-0099D6)
![ABAP Cloud](https://img.shields.io/badge/ABAP-Cloud-00A878)
![License](https://img.shields.io/badge/License-MIT-blue)

## 📌 Descripción

Integración end-to-end entre los sensores IoT del electrolizador de **Rábida Energy** y **SAP S/4HANA Cloud** usando **SAP BTP Integration Suite**.

El sistema recibe datos de producción de hidrógeno verde en tiempo real, los valida, genera el certificado EU-GreenH2 y crea la orden de producción en S/4HANA de forma automática.

## 🏗️ Arquitectura

Sensor IoT / SCADA
↓ REST/JSON
SAP BTP Integration Suite (CPI)
├─ HTTP Adapter (inbound)
├─ Groovy Script (validación + CO₂)
├─ Message Mapping (JSON → OData)
└─ OData Adapter (outbound)
↓
SAP S/4HANA Cloud
├─ Production Order
└─ CDS View ZI_H2Production

## 🛠️ Stack Técnico

| Capa | Tecnología |
|---|---|
| Datos entrada | REST · JSON · SCADA IoT |
| Integración | SAP BTP · Integration Suite (CPI) |
| Transformación | Groovy Scripts · Message Mapping |
| Certificación | EU-GreenH2 · Groovy |
| Destino | SAP S/4HANA Cloud · OData V4 |
| ABAP Cloud | CDS Views · RAP Business Object |

## 🗺️ Roadmap

- [x] Fase 1 · Diseño y documentación
- [ ] Fase 2 · Mock API + iFlow básico
- [ ] Fase 3 · Groovy + Mapping + Certificado EU
- [ ] Fase 4 · S/4HANA + ABAP Cloud

## 👤 Autor

**Francisco García Vázquez** · SAP Developer · ABAP Cloud · BTP Integration · Huelva, Andalucía

Certificaciones en progreso: C_CPI · C_ABAPD · C_CPE

## 📄 Licencia

MIT License · Proyecto de portfolio
