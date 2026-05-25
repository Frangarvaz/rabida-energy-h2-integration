import com.sap.gateway.ip.core.customdev.util.Message

def Message processData(Message message) {
    def map = message.getProperties()
    
    def batchId = map.get("h2_batch_id")
    def plant = map.get("h2_plant")
    def volume = map.get("h2_volume_kg")
    def purity = map.get("h2_purity_percent")
    
    def json = """{
  "certification": {
    "batch_id": "${batchId}",
    "plant": "${plant}",
    "volume_kg": ${volume},
    "purity_percent": ${purity},
    "energy_source": "Renewable",
    "status": "CERTIFIED",
    "standard": "EU-GreenH2-2024"
  }
}"""
    
    message.setBody(json)
    return message
}
