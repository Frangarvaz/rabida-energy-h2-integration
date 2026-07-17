# Postman · Tests de integración

Guía para testear el flujo de integración con Postman o cURL.

## Endpoints

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `POST` | `/http/h2-certification` | Envía un lote de producción H₂ al iFlow de BTP |
| `GET`  | `/odata/v4/ZSD_H2PRODUCTION/H2Production` | Consulta los registros en S/4HANA vía OData V4 |

## Ejemplo de payload

```json
{
  "sensor": "SCADA-001",
  "plant": "RABIDA-H2-01",
  "h2_volume_kg": 4200,
  "purity_pct": 99.98,
  "energy_source": "solar"
}
```

## Autenticación

Ambos endpoints requieren un Bearer token OAuth 2.0. Para obtenerlo:

1. Crear una service key del servicio `Process Integration Runtime` en BTP Cockpit
2. Hacer un POST al token endpoint con `grant_type=client_credentials`
3. Usar el `access_token` en la cabecera `Authorization: Bearer <token>`

> Para automatizar el test, usa el script `scripts/test_h2.sh` que gestiona la autenticación automáticamente.
