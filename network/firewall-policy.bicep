param firewallPolicyName string
param location string

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

param snatPrivateRanges array

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2023-04-01' = {
  name: firewallPolicyName
  location: location
  properties: {
    sku: {
      tier: skuTier
    }
    threatIntelMode: threatIntelMode
    snat: {
      privateRanges: snatPrivateRanges
    }
  }
}

output firewallPolicyId string = firewallPolicy.id
