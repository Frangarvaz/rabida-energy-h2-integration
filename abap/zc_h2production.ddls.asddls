@EndUserText.label: 'H2 Production Projection View'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@UI.headerInfo: {
  typeName: 'H2 Production',
  typeNamePlural: 'H2 Productions',
  title: { type: #STANDARD, value: 'PlantId' }
}

define root view entity ZC_H2PRODUCTION
  provider contract transactional_query
  as projection on ZR_H2PRODUCTION
{
  @UI.facet: [{
    id: 'H2Production',
    purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE,
    label: 'H2 Production',
    position: 10
  }]

  @UI: { identification: [{ position: 10 }],
         lineItem:       [{ position: 10 }] }
  key PlantId,

  @UI: { identification: [{ position: 20 }],
         lineItem:       [{ position: 20 }] }
  key RecordDate,

  @UI: { identification: [{ position: 30 }],
         lineItem:       [{ position: 30 }] }
      H2KgProduced,

  @UI: { identification: [{ position: 40 }],
         lineItem:       [{ position: 40 }] }
      EnergyKwh,

  @UI: { identification: [{ position: 50 }],
         lineItem:       [{ position: 50 }] }
      EfficiencyPct,

  @UI: { identification: [{ position: 60 }],
         lineItem:       [{ position: 60 }] }
      Status,

  @UI: { identification: [{ position: 70 }],
         lineItem:       [{ position: 70 }] }
      CertificateId
}
