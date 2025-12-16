param appName string
param location string
param appType string = 'web'
param kind string = 'web'

resource appInsights 'Microsoft.Insights/components@2020-02-02-preview' = {
  name: appName
  location: location
  properties: {
    Application_Type: appType
  }
  kind:kind
}

output instrumentationKey string = appInsights.properties.InstrumentationKey
output applicationInsightsId string = appInsights.id
//done
