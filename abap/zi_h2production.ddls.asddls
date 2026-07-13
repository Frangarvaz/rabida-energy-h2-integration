 @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'H2 Production Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_H2PRODUCTION as select from zfgv_h2prod
{
  key plant_id        as PlantId,
  key record_date     as RecordDate,
      h2_kg_produced  as H2KgProduced,
      energy_kwh      as EnergyKwh,
      efficiency_pct  as EfficiencyPct,
      status          as Status,
      certificate_id  as CertificateId
}
