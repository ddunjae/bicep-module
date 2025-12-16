param vpnName string
param location string
param pipId string
param subnetId string

@allowed([
  //'Basic' Only Allowed with AZ CLI or Powershell
  'ErGw1AZ'
  'ErGw2AZ'
  'ErGw3AZ'
  'HighPerformance'
  'Standard'
  'UltraPerformance'
  'VpnGw1'
  'VpnGw1AZ'
  'VpnGw2'
  'VpnGw2AZ'
  'VpnGw3'
  'VpnGw3AZ'
  'VpnGw4'
  'VpnGw4AZ'
  'VpnGw5'
  'VpnGw5AZ'
])
param skuName string

@allowed([
  //'Basic' Only Allowed with AZ CLI or Powershell
  'ErGw1AZ'
  'ErGw2AZ'
  'ErGw3AZ'
  'HighPerformance'
  'Standard'
  'UltraPerformance'
  'VpnGw1'
  'VpnGw1AZ'
  'VpnGw2'
  'VpnGw2AZ'
  'VpnGw3'
  'VpnGw3AZ'
  'VpnGw4'
  'VpnGw4AZ'
  'VpnGw5'
  'VpnGw5AZ'
])
param skuTier string

@allowed([
  'Generation1'
  'Generation2'
  'None'
])
param vpnGatewayGeneration string

@allowed([
  'PolicyBased'
  'RouteBased'
])
param vpnType string = 'RouteBased'

param isBgpEnable bool = false
param isActiveActive bool = false

var allowRemoteVnetTraffic = false
var allowVirtualWanTraffic = false

resource vpn 'Microsoft.Network/virtualNetworkGateways@2023-06-01' = {
  name: vpnName
  location: location
  properties: {
    enablePrivateIpAddress: false
    ipConfigurations: [
      {
        name: 'default'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: pipId
          }
          subnet: {
            id: subnetId
          }
        }
      }
    ]
    natRules: []
    virtualNetworkGatewayPolicyGroups: []
    enableBgpRouteTranslationForNat: false
    disableIPSecReplayProtection: false
    sku: {
      name: skuName
      tier: skuTier
    }
    gatewayType: 'Vpn'
    vpnType: vpnType
    enableBgp: isBgpEnable
    activeActive: isActiveActive
    vpnGatewayGeneration: vpnGatewayGeneration
    allowRemoteVnetTraffic: allowRemoteVnetTraffic
    allowVirtualWanTraffic: allowVirtualWanTraffic
  }
}

output vpnId string = vpn.id
