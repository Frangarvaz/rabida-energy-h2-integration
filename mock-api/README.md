# Mock API · Sensor IoT Simulado

Servidor Node.js que simula los datos del sensor SCADA del electrolizador de Rábida Energy.

## Contenido

- `server.js` → Servidor REST que expone el endpoint POST /h2-production
- `package.json` → Dependencias del proyecto
- `data/sample-payload.json` → Ejemplo de payload del sensor

## Cómo ejecutarlo

```bash
npm install
npm start
```

El servidor arranca en http://localhost:3000
