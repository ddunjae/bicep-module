param lbName string
param inboundNatRuleName string

param frontendPort int
param backendPort int
param idleTimeoutInMinutes int = 4
param frontendIPId string

@allowed([
  'All'
  'Tcp'
  'Udp'
])
param protocol string = 'Tcp'

var enableFloatingIP = false

resource inboundNatRule 'Microsoft.Network/loadBalancers/inboundNatRules@2023-06-01' = {
  name: '${lbName}/${inboundNatRuleName}'
  properties: {
    frontendPort: frontendPort
    backendPort: backendPort
    enableFloatingIP: enableFloatingIP
    idleTimeoutInMinutes: idleTimeoutInMinutes
    protocol: protocol
    frontendIPConfiguration: {
      id: frontendIPId
    }
  }
}
