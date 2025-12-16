@description('Subnet Name')
param subnetName string

@description('VNET Name to Connect')
param vnetName string

@description('Subnet address prefix')
param subnetPrefix string = '10.0.0.0/24'

@description('NSG resource ID to connect if needed')
param nsgId string = ''

@description('NAT GW ID to connect if needed')
param natGwId string = ''

param routeTableId string = ''

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2023-04-01' = {
  name: '${vnetName}/${subnetName}'
  properties: {
    addressPrefix: subnetPrefix
    routeTable:(routeTableId != '') ? {id: routeTableId} : null
    networkSecurityGroup: (nsgId != '') ? {id: nsgId} : null
    natGateway: (natGwId != '') ? {id: natGwId} : null
  }
}

output subnetId string = subnet.id
