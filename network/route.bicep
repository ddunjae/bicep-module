param routeTableName string

param routeName string

param addressPrefix string

param hasBgpOverride bool = false

param nextHopIpAddress string

@allowed([
  'Internet'
  'None'
  'VirtualAppliance'
  'VirtualNetworkGateway'
  'VnetLocal'
])
param nextHopType string

resource route 'Microsoft.Network/routeTables/routes@2023-04-01' = {
  name: '${routeTableName}/${routeName}'
  properties: {
    addressPrefix: addressPrefix
    hasBgpOverride: hasBgpOverride
    nextHopIpAddress: nextHopIpAddress
    nextHopType: nextHopType
  }
}
