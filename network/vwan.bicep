param vwanName string
param location string
param allowBranchToBranchTraffic bool
param allowVnetToVnetTraffic bool
param disableVpnEncryption bool
param type string = 'Standard'

resource vwan 'Microsoft.Network/virtualWans@2023-04-01' = {
  name: vwanName
  location: location
  properties: {
    allowBranchToBranchTraffic: allowBranchToBranchTraffic
    allowVnetToVnetTraffic: allowVnetToVnetTraffic
    disableVpnEncryption: disableVpnEncryption
    type: type
  }
}
