param botName string
param location string 
param endpoint string
param msaAppId string
param sku string
param msaAppType string
param ownerIds string

resource botService 'Microsoft.BotService/botServices@2022-09-15' = {
  name: 'botServices'
  location: location
  kind: 'azurebot'
  sku: {
    name: sku
  }
  properties: {
    displayName: botName
    endpoint: endpoint
    msaAppId: msaAppId
    msaAppType :msaAppType
    tenantId : ownerIds
  }
  
}
output botServiceEndpoint string = botService.properties.endpoint
