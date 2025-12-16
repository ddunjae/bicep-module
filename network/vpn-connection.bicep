param connectionName string
param location string

param virtualNetworkGwId string
param localNetworkGwId string

var connectionType = 'IPsec'
var connectionProtocol = 'IKEv2'

resource connection 'Microsoft.Network/connections@2023-09-01' = {
  name: connectionName
  location: location
  properties: {
    virtualNetworkGateway1: {
      id: virtualNetworkGwId
      properties: {}
    }
    localNetworkGateway2: {
      id: localNetworkGwId
      properties: {}
    }
    connectionType: connectionType
    connectionProtocol: connectionProtocol
    routingWeight: 0
    enableBgp: false
    useLocalAzureIpAddress: false
    usePolicyBasedTrafficSelectors: false
    ipsecPolicies: [
      {
        saLifeTimeSeconds: 27000
        saDataSizeKilobytes: 102400000
        ipsecEncryption: 'AES128'
        ipsecIntegrity: 'SHA256'
        ikeEncryption: 'AES128'
        ikeIntegrity: 'SHA256'
        dhGroup: 'DHGroup2'
        pfsGroup: 'None'
      }
    ]
    trafficSelectorPolicies: []
    expressRouteGatewayBypass: false
    enablePrivateLinkFastPath: false
    dpdTimeoutSeconds: 45
    connectionMode: 'Default'
    gatewayCustomBgpIpAddresses: []
  }
}
