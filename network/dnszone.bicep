param dnszoneName string

@description('Tags to add to the resources')
param tags object

@allowed([
  'Private'
  'Public'
])
param dnszoneType string = 'Public'

resource dnszone 'Microsoft.Network/dnszones@2018-05-01' = {
  name: dnszoneName
  location: 'global'
  tags: tags
  properties: {
    zoneType: dnszoneType
  }
}

/*
// Azure Default
resource dnszoneAzureNS 'Microsoft.Network/dnszones/NS@2018-05-01' = {
  parent: dnszone
  name: '@'
  properties: {
    TTL: 172800
    NSRecords: [
      {
        nsdname: 'ns1-34.azure-dns.com.'
      }
      {
        nsdname: 'ns2-34.azure-dns.net.'
      }
      {
        nsdname: 'ns3-34.azure-dns.org.'
      }
      {
        nsdname: 'ns4-34.azure-dns.info.'
      }
    ]
    targetResource: {}
  }
}

// Azure Default
resource dnszoneAzureSOA 'Microsoft.Network/dnszones/SOA@2018-05-01' = {
  parent: dnszone
  name: '@'
  properties: {
    TTL: 3600
    SOARecord: {
      email: 'azuredns-hostmaster.microsoft.com'
      expireTime: 2419200
      host: 'ns1-34.azure-dns.com.'
      minimumTTL: 300
      refreshTime: 3600
      retryTime: 300
      serialNumber: 1
    }
    targetResource: {}
  }
}
*/
