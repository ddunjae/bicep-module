param logWSSolutionName string
param location string
param planName string
param planProduct string = 'OMSGallery/VMInsights'
param planPublisher string = 'Microsoft'
param logWSId string

resource logWSSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: logWSSolutionName
  location: location
  plan: {
    name: planName
    promotionCode: ''
    product: planProduct
    publisher: planPublisher
  }
  properties: {
    workspaceResourceId: logWSId
    containedResources: []
  }
}
