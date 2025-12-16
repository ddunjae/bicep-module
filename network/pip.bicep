param pipName string
param location string

@allowed([
  'Basic'
  'Standard'
])
param pipSKU string = 'Standard'
@allowed([
  'Global'
  'Regional'
])
param pipTier string = 'Regional'
param pipZones array = []

@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Static'

resource pip 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: pipName
  location: location
  sku: {
    name: pipSKU
    tier: pipTier
  }
  zones: pipZones
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
  }
}

output pipId string = pip.id
output pipAddr string = pip.properties.ipAddress
