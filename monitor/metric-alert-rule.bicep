param metricAlertRuleName string
param location string
param actionGroupId string

param severity int
param scopes array

/*
criteria example
[
  {
    threshold: 80
    name: 'Metric1'
    metricNamespace: 'microsoft.compute/virtualmachines'
    metricName: 'Percentage CPU'
    operator: 'GreaterThan'
    timeAggregation: 'Average'
    skipMetricValidation: false
    criterionType: 'StaticThresholdCriterion'
  }
]
*/
param criteria array

//@allowed([
//  'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
//  'Microsoft.Azure.Monitor.SingleResourceMultipleMetricCriteria'
//  'Microsoft.Azure.Monitor.WebtestLocationAvailabilityCriteria'
//])
var odataType = 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'

param desc string = ''
param targetResourceRegion string // 'koreacentral'
param targetResourceType string // 'microsoft.compute/virtualmachines'

var evaluationFrequency = 'PT1M'
var windowSize = 'PT15M'

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: metricAlertRuleName
  location: location
  properties: {
    actions: [
      {
        actionGroupId: actionGroupId
        webHookProperties: {}
      }
    ]
    autoMitigate: true
    criteria: {
      allOf: criteria
      'odata.type': odataType
    }
    description: desc
    enabled: true
    evaluationFrequency: evaluationFrequency
    scopes: scopes
    severity: severity
    targetResourceRegion: targetResourceRegion
    targetResourceType: targetResourceType
    windowSize: windowSize
  }
}
