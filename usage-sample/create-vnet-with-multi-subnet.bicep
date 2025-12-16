param subnetPrefixes array = ['10.0.1.0/24','10.0.2.0/24','10.0.3.0/24']
param vnetName string = 'myVnet'

module vnet '../network/vnet.bicep' = {
  name: 'vnet'
  params: {
    location: 'koreacentral'
    vnetName: vnetName
  }
}

module subnets '../network/subnet.bicep' = [for i in range(0,3): {
  name: 'subnet${i}'
  params: {
    subnetName: 'subnet${i}'
    vnetName: vnetName
    subnetPrefix: subnetPrefixes[i]
  }
  dependsOn:[
    vnet
  ]
}] 
