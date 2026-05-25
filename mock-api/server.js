const express = require('express');
const app = express();
app.use(express.json());

// Datos simulados del sensor SCADA de Rábida Energy
const generateH2Batch = () => ({
  batchId: `H2-${new Date().getFullYear()}-${String(Math.floor(Math.random() * 999) + 1).padStart(3, '0')}`,
  plant: "Rábida Energy · Palos de la Frontera",
  timestamp: new Date().toISOString(),
  production: {
    h2_volume_kg: Math.floor(Math.random() * 3000) + 2000,
    purity_pct: (99.90 + Math.random() * 0.09).toFixed(2),
    pressure_bar: Math.floor(Math.random() * 50) + 300,
    temperature_celsius: Math.floor(Math.random() * 10) + 70,
  },
  energy: {
    source: "renewable",
    type: "solar",
    consumed_kwh: Math.floor(Math.random() * 8000) + 10000,
  },
  certification: {
    standard: "EU-GreenH2",
    co2_saved_t: ((Math.floor(Math.random() * 3000) + 2000) * 8.9 / 1000).toFixed(1),
    origin: "Huelva, Andalucía, ES",
  }
});

// Endpoint principal — simula el sensor IoT enviando datos a BTP
app.post('/h2-production', (req, res) => {
  const batch = generateH2Batch();
  console.log(`[${new Date().toISOString()}] Lote enviado: ${batch.batchId}`);
  res.status(200).json({
    status: "success",
    message: "Datos de producción enviados a SAP BTP Integration Suite",
    data: batch
  });
});

// Endpoint de health check
app.get('/health', (req, res) => {
  res.json({ status: "online", plant: "Rábida Energy", system: "SCADA Mock v1.0" });
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`🌊 Rábida Energy · Mock SCADA Server corriendo en http://localhost:${PORT}`);
});
