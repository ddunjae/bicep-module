@description('VNET Name')
param vnetName string

@description('VNET Region')
param location string

@description('VNET address prefix')
param addressPrefix string = '10.0.0.0/16'

//@description('Subnet Array')
//param subnetList array

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    //subnets: subnetList
  }
}

output vnetId string = vnet.id
