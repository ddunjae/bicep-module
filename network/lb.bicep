param lbName string
param location string

@allowed([
  'Basic'
  'Standard'
])
param skuName string = 'Standard'

@allowed([
  'Global'
  'Regional'
])
param skuTier string = 'Regional'

/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.network/loadbalancers?pivots=deployment-language-bicep
/loadBalancers/frontendIPConfigurations@ resource cannot be distributed separately (Read-Only)
{
  name: 'lb-front1'
  properties: {
    privateIPAllocationMethod: 'Dynamic'
    publicIPAddress: {
      id: pip.id
    }
  }
}
*/
param frontendIPConfigurations array = []

/*
backendAddressPools: [
  {
    id: 'string'
    name: 'string'
    properties: {
      drainPeriodInSeconds: int
      loadBalancerBackendAddresses: [
        {
          name: 'string'
          properties: {
            adminState: 'string'
            ipAddress: 'string'
            loadBalancerFrontendIPConfiguration: {
              id: 'string'
            }
            subnet: {
              id: 'string'
            }
            virtualNetwork: {
              id: 'string'
            }
          }
        }
      ]
      location: 'string'
      syncMode: 'string'
      tunnelInterfaces: [
        {
          identifier: int
          port: int
          protocol: 'string'
          type: 'string'
        }
      ]
      virtualNetwork: {
        id: 'string'
      }
    }
  }
]
*/
//param backendAddressPools array = []

/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.network/loadbalancers?pivots=deployment-language-bicep
/loadBalancers/loadBalancingRules@ resource cannot be distributed separately (Read-Only)
loadBalancingRules: [
  {
    id: 'string'
    name: 'string'
    properties: {
      backendAddressPool: {
        id: 'string'
      }
      backendAddressPools: [
        {
          id: 'string'
        }
      ]
      backendPort: int
      disableOutboundSnat: bool
      enableFloatingIP: bool
      enableTcpReset: bool
      frontendIPConfiguration: {
        id: 'string'
      }
      frontendPort: int
      idleTimeoutInMinutes: int
      loadDistribution: 'string'
      probe: {
        id: 'string'
      }
      protocol: 'string'
    }
  }
]
*/
param loadBalancingRules array = []

/*
https://learn.microsoft.com/en-us/azure/templates/microsoft.network/loadbalancers?pivots=deployment-language-bicep
/loadBalancers/probes@ resource cannot be distributed separately (Read-Only)
probes: [
  {
    id: 'string'
    name: 'string'
    properties: {
      intervalInSeconds: int
      numberOfProbes: int
      port: int
      probeThreshold: int
      protocol: 'string'
      requestPath: 'string'
    }
  }
]
*/
param probes array = []

param lbBackendAddrPoolsName string = ''

resource lb 'Microsoft.Network/loadBalancers@2023-06-01' = {
  name: lbName
  location: location
  sku: {
    name: skuName
    tier: skuTier
  }
  properties: {
    frontendIPConfigurations: frontendIPConfigurations
    backendAddressPools: []
    loadBalancingRules: loadBalancingRules
    probes: probes
    inboundNatRules: []
    outboundRules: []
    inboundNatPools: []
  }
}

resource lbBackendAddrPools 'Microsoft.Network/loadBalancers/backendAddressPools@2023-04-01' = if (lbBackendAddrPoolsName != '') {
  name: lbBackendAddrPoolsName
  parent: lb
}

output lbId string = lb.id
output lbBackendAddrPoolsId string = lbBackendAddrPools.id
