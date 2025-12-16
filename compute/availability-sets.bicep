
param availSetsName string
param location string

param virtualMachines array
/*
[{
  id: 'string'
},
{
  id: 'string'
}]
*/

//@description('Specifies the number of virtual machines in the scale set')
//param skuCapacity int
//param skuName string

//@allowed([
//  'Basic'
//  'Standard'
//])
//param skuTier string

param platformFaultDomainCount int
param platformUpdateDomainCount int

resource availSets 'Microsoft.Compute/availabilitySets@2023-09-01' = {
  name: availSetsName
  location: location
  properties: {
    platformFaultDomainCount: platformFaultDomainCount
    platformUpdateDomainCount: platformUpdateDomainCount
    virtualMachines: virtualMachines
  }
}
