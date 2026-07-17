# iFlows · SAP BTP Integration Suite

Configuración del iFlow desplegado en SAP BTP Integration Suite.

## iFlow: H2-Certification-Flow

El iFlow principal del proyecto recibe datos del sensor SCADA vía HTTPS Sender, los transforma con un Groovy Script (`scripts/GenerateCertificationJSON.groovy`) y los envía al backend S/4HANA Cloud vía HTTP Receiver con OData V4.

### Componentes del iFlow

| Paso | Componente | Función |
|------|-----------|---------|
| 1 | HTTPS Sender | Recibe el POST del dashboard SCADA |
| 2 | Content Modifier | Extrae propiedades del payload (plant, volume, purity) |
| 3 | Groovy Script | Genera el JSON de certificación EU-GreenH2-2024 |
| 4 | HTTP Receiver | Envía el certificado a S/4HANA vía OData V4 |

### Credenciales

El iFlow usa OAuth 2.0 Client Credentials contra el servicio `Process Integration Runtime`. La configuración de credenciales se gestiona en el Security Material de BTP Cockpit.

> **Nota:** El iFlow se configura directamente en SAP BTP Integration Suite y no se exporta como archivo al repositorio por contener configuración de seguridad del tenant.
