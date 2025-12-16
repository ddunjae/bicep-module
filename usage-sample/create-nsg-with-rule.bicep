param vnetName string = 'test-vnet'
param subnetName string = 'snet'
param nsgName string = 'test-nsg'

module vnet '../network/vnet.bicep' = {
  name: 'vnet'
  params: {
    location: 'koreacentral'
    vnetName: vnetName
  }
}

module nsg '../network/nsg.bicep' = {
  name: 'test-nsg'
  params: {
    location: 'koreacentral' 
    nsgName: nsgName
    //securityRules: [nsgRule.outputs.nsgRuleId]
  }
}

module nsgRule '../network/nsg-rule.bicep' = {
  name: 'rule1module'
  params: {
    access: 'Allow'
    direction: 'Inbound'
    dstAddressPrefix: '*'
    priority: 1000
    protocol: 'Tcp'
    ruleName: 'AllowRDPInBound'
    srcAddressPrefix: '*'
    srcPortRange: '*'
    dstPortRange: '3389'
    nsgName: nsgName
  }
  dependsOn: [
    nsg
  ]
}

module subnet '../network/subnet.bicep' = {
  name: subnetName
  params: {
    subnetName: subnetName
    vnetName: vnetName
    nsgId: nsg.outputs.nsgId
  }
  dependsOn:[
    vnet
    nsg
  ]
}
