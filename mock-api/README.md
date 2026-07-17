# Mock API · Sensor IoT Simulado

Servidor Node.js que simula los datos del sensor SCADA del electrolizador de Rábida Energy.

## Contenido

| Archivo | Descripción |
|---------|-------------|
| `server.js` | Servidor Express que expone endpoints REST para simular el sensor IoT |
| `package.json` | Dependencias del proyecto (Express, Nodemon) |
| `data/sample-payload.json` | Ejemplo de payload completo del sensor |

## Endpoints

| Método | Ruta | Descripción |
|--------|------|-------------|
| `POST` | `/h2-production` | Genera y devuelve un lote simulado de producción H₂ |
| `GET`  | `/health` | Health check del servidor |

## Cómo ejecutarlo

```bash
cd mock-api
npm install
npm start
```

El servidor arranca en `http://localhost:3000`.

## Ejemplo de respuesta

```json
{
  "status": "success",
  "message": "Datos de producción enviados a SAP BTP Integration Suite",
  "data": {
    "batchId": "H2-2026-042",
    "plant": "Rábida Energy · Palos de la Frontera",
    "production": {
      "h2_volume_kg": 4200,
      "purity_pct": "99.97"
    }
  }
}
```
