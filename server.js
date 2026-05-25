const express = require('express');
const path = require('path');
const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

function generateH2Data() {
  return {
    plant_id: "RABIDA-H2-01",
    record_date: new Date().toISOString().split('T')[0],
    h2_kg_produced: parseFloat((Math.random() * 500 + 3800).toFixed(3)),
    energy_kwh: parseFloat((Math.random() * 1000 + 18000).toFixed(3)),
    efficiency_pct: parseFloat((Math.random() * 2 + 78).toFixed(2)),
    status: "CERTIFIED",
    certificate_id: "EU-GreenH2-2024-" + Date.now()
  };
}

app.get('/sensor/data', (req, res) => {
  const data = generateH2Data();
  console.log('📡 Sensor data:', JSON.stringify(data));
  res.json(data);
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK', system: 'Rábida Energy H2 SCADA Mock', timestamp: new Date().toISOString() });
});

app.listen(3000, () => {
  console.log('🚀 Rábida Energy SCADA Mock running on http://localhost:3000');
});
