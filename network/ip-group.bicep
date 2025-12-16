param ipGroupName string
param location string
param ipAddresses array

resource ipGroup 'Microsoft.Network/ipGroups@2023-04-01' = {
  name: ipGroupName
  location: location
  properties: {
    ipAddresses: ipAddresses
  }
}
