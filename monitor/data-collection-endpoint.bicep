param dceName string
param location string

//@allowed([
//  'Linux'
//  'Windows'
//])
//param dceKind string

@allowed([
  'None'
  'SystemAssigned'
  'SystemAssigned,UserAssigned'
  'UserAssigned'
])
param dceIdentityType string = 'None'

param desc string = ''

@allowed([
  'Disabled'
  'Enabled'
  'SecuredByPerimeter'
])
param publicNetworkAccess string = 'Enabled'

resource dce 'Microsoft.Insights/dataCollectionEndpoints@2022-06-01' = {
  name: dceName
  location: location
  //kind: dceKind
  identity: {
    type: dceIdentityType
    userAssignedIdentities: {}
  }
  properties: {
    configurationAccess: {}
    description: desc
    logsIngestion: {}
    metricsIngestion: {}
    networkAcls: {
      publicNetworkAccess: publicNetworkAccess
    }
  }
}
