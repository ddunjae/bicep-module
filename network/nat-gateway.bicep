param natGatewayName string
param location string
param zones array = []
param publicIpAddresses array = []

var skuName = 'Standard'
var idleTimeoutInMinutes = 30

resource natGateway 'Microsoft.Network/natGateways@2023-06-01' = {
  name: natGatewayName
  location: location
  sku: {
    name: skuName
  }
  zones: zones
  properties: {
    idleTimeoutInMinutes: idleTimeoutInMinutes
    publicIpAddresses: publicIpAddresses
  }
}

output natGwId string = natGateway.id
