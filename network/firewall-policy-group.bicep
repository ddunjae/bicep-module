param firewallPolicyName string
param firewallRuleGroupName string
param priority int

param ruleCollections array // Check below format

// Rule Collection API not exists, rulecollections objects depends on ruleCollectionType
/* 
ruleCollectionType: 'FirewallPolicyFilterRuleCollection'
action: {
  type: 'string'
}
rules: [
  {
    description: 'string'
    name: 'string'
    ruleType: 'string'
    // For remaining properties, see FirewallPolicyRule objects
  }
]
-------------------------------------------------------
ruleCollectionType: 'FirewallPolicyNatRuleCollection'
action: {
  type: 'DNAT'
}
rules: [
  {
    description: 'string'
    name: 'string'
    ruleType: 'string'
    // For remaining properties, see FirewallPolicyRule objects
  }
]
*/

// Rule API not exists, rules objects depends on ruleType
/*
ruleType: 'ApplicationRule'
destinationAddresses: [
  'string'
]
fqdnTags: [
  'string'
]
httpHeadersToInsert: [
  {
    headerName: 'string'
    headerValue: 'string'
  }
]
protocols: [
  {
    port: int
    protocolType: 'string'
  }
]
sourceAddresses: [
  'string'
]
sourceIpGroups: [
  'string'
]
targetFqdns: [
  'string'
]
targetUrls: [
  'string'
]
terminateTLS: bool
webCategories: [
  'string'
]
-------------------------------------------------------
ruleType: 'NatRule'
destinationAddresses: [
  'string'
]
destinationPorts: [
  'string'
]
ipProtocols: [
  'string'
]
sourceAddresses: [
  'string'
]
sourceIpGroups: [
  'string'
]
translatedAddress: 'string'
translatedFqdn: 'string'
translatedPort: 'string'
-------------------------------------------------------
ruleType: 'NetworkRule'
destinationAddresses: [
  'string'
]
destinationFqdns: [
  'string'
]
destinationIpGroups: [
  'string'
]
destinationPorts: [
  'string'
]
ipProtocols: [
  'string'
]
sourceAddresses: [
  'string'
]
sourceIpGroups: [
  'string'
]
*/

resource firewallRuleGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2023-09-01' = {
  name: '${firewallPolicyName}/${firewallRuleGroupName}'
  properties: {
    priority: priority
    ruleCollections: ruleCollections
  }
}
