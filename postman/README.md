# Postman · Colección de Tests

Esta carpeta contiene la colección Postman para testear el flujo completo de integración.

## Contenido

- `RabidaEnergy-H2-Integration.postman_collection.json` → Colección completa de tests
- `RabidaEnergy-ENV.postman_environment.json` → Variables de entorno (BTP URL, credenciales)

## Tests incluidos

- POST /h2-production → Envío de datos del sensor al iFlow
- GET /h2-batches → Consulta de lotes certificados en S/4HANA
- GET /h2-certificates → Consulta de certificados EU-GreenH2 generados
