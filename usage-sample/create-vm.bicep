param vmName string = 'test-vm'
param vnetName string = 'test-vnet'
param subnetName string = 'test-snet'
param nsgName string = 'test-nsg'

module vnet '../network/vnet.bicep' = {
  name: 'vnet'
  params: {
    location: 'koreacentral'
    vnetName: vnetName
  }
}

module nsg '../network/nsg.bicep' = {
  name: 'nsg'
  params: {
    location: 'koreacentral' 
    nsgName: nsgName
  }
}

module nsgRule '../network/nsg-rule.bicep' = {
  name: 'nsgrule'
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
  }
  dependsOn:[
    vnet
  ]
}

module vm '../compute/vm-windows.bicep' = {
  name: 'sample-vm'
  params: {
    adminPassword: '!Qaz2wsx3edc'
    adminUsername: 'spinadmin'
    hostName: vmName
    location: 'koreacentral'
    osDiskName: '${vmName}-osdisk'
    vmName: vmName
    vmSKU: 'Standard_B2ms'
    usePublicIP: true
    nsgId: nsg.outputs.nsgId
    subnetId: subnet.outputs.subnetId
  }
  dependsOn:[
    subnet
  ]
}
