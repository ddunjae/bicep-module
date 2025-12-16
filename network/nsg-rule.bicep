param nsgName string

param ruleName string

param priority int

param desc string = ''

@description('Allow/Deny')
@allowed([
  'Allow'
  'Deny'
])
param access string

@description('Inbound/Outbound')
@allowed([
  'Inbound'
  'Outbound'
])
param direction string

param destinationPortRange string

@description('*/Ah/Esp/Icmp/Tcp/Udp')
@allowed([
  '*'
  'Ah'
  'Esp'
  'Icmp'
  'Tcp'
  'Udp'
])
param protocol string

param sourcePortRange string

param sourceAddressPrefix string

param destinationAddressPrefix string

param sourcePortRanges array = []
param sourceAddressPrefixes array = []
param destinationPortRanges array = []
param destinationAddressPrefixes array = []


resource nsgRule 'Microsoft.Network/networkSecurityGroups/securityRules@2023-04-01' = {
  name: '${nsgName}/${ruleName}'
  properties: {
    priority: priority
    description: desc
    access: access
    direction: direction
    destinationPortRange: destinationPortRange
    protocol: protocol
    sourcePortRange: sourcePortRange
    sourceAddressPrefix: sourceAddressPrefix
    destinationAddressPrefix: destinationAddressPrefix
    sourcePortRanges: sourcePortRanges
    sourceAddressPrefixes: sourceAddressPrefixes
    destinationPortRanges: destinationPortRanges
    destinationAddressPrefixes: destinationAddressPrefixes
  }
}

output nsgRuleId string = nsgRule.id
