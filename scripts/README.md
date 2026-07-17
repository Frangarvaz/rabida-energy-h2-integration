# Scripts

Scripts de soporte para el flujo de integración.

## Contenido

| Archivo | Descripción |
|---------|-------------|
| `GenerateCertificationJSON.groovy` | Groovy Script usado en el iFlow de BTP. Transforma las propiedades del mensaje en el JSON de certificación EU-GreenH2-2024 |
| `test_h2.sh` | Script bash para testear el flujo completo de integración contra BTP. Requiere variables de entorno (ver abajo) |

## Configuración del test

El script `test_h2.sh` necesita 4 variables de entorno con las credenciales de tu service key de BTP:

```bash
export BTP_AUTH_URL="https://<subaccount>.authentication.<region>.hana.ondemand.com/oauth/token"
export BTP_CLIENT_ID="sb-..."
export BTP_CLIENT_SECRET="..."
export BTP_IFLOW_URL="https://<subaccount>.it-cpitrial05-rt.cfapps.<region>.hana.ondemand.com/http/h2-certification"

bash scripts/test_h2.sh
```

> Las credenciales se obtienen desde la service key del servicio `Process Integration Runtime` en BTP Cockpit.
