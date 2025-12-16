param localNetworkGwName string
param location string

param gatewayIpAddress string
param localAddressPrefixes array

resource localNetworkGw 'Microsoft.Network/localNetworkGateways@2023-04-01' = {
  name: localNetworkGwName
  location: location
  properties: {
    //bgpSettings: {}
    gatewayIpAddress: gatewayIpAddress
    localNetworkAddressSpace: {
      addressPrefixes: localAddressPrefixes
    }
  }
}

output localNetworkGwId string = localNetworkGw.id
