param firewallName string
param location string

@allowed([
  'AZFW_Hub'
  'AZFW_VNet'
])
param skuName string

@allowed([
  'Basic'
  'Premium'
  'Standard'
])
param skuTier string

@allowed([
  'Alert'
  'Deny'
  'Off'
])
param threatIntelMode string = 'Alert'

param pipId string
param subnetId string
param firewallPolicyId string

resource firewall 'Microsoft.Network/azureFirewalls@2023-04-01' = {
  name: firewallName
  location: location
  properties: {
    sku: {
      name: skuName
      tier: skuTier
    }
    threatIntelMode: threatIntelMode
    additionalProperties: {}
    ipConfigurations: [
      {
        name: '${firewallName}-pip'
        properties: {
          publicIPAddress: {
            id: pipId
          }
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    //networkRuleCollections: []
    //applicationRuleCollections: []
    //natRuleCollections: []
    firewallPolicy: {
      id: firewallPolicyId
    }
  }
}

output firewallId string = firewall.id
