@description('Parent dnszone Name')
param dnsName string

@allowed([
  'A'
  'CNAME'
  'MX'
  'NS'
  'TXT'
  //  'SOA'
])
param recordType string

param recordName string = ''
param recordTTL int = 3600

param ARecordIPAddr string = ''

param CNAMERecordCNAME string = ''

param MXRecordExchange string = ''
param MXRecordPreference int = 0

param NSRecordNsdName string = ''

param TXTRecordValue string = ''

resource ARecord 'Microsoft.Network/dnszones/A@2018-05-01' = if (recordType == 'A') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
    ARecords: [
      {
        ipv4Address: ARecordIPAddr
      }
    ]
    targetResource: {}
  }
}

resource CNAMERecord 'Microsoft.Network/dnszones/CNAME@2018-05-01' = if (recordType == 'CNAME') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
    CNAMERecord: {
      cname: CNAMERecordCNAME
    }
    targetResource: {}
  }
}

resource MXRecord 'Microsoft.Network/dnszones/MX@2018-05-01' = if (recordType == 'MX') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
    MXRecords: [
      {
        exchange: MXRecordExchange
        preference: MXRecordPreference
      }
    ]
    targetResource: {}
  }
}

resource NSRecord 'Microsoft.Network/dnszones/NS@2018-05-01' = if (recordType == 'NS') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
    NSRecords: [
      {
        nsdname: NSRecordNsdName
      }
    ]
    targetResource: {}
  }
}

resource TXTRecord 'Microsoft.Network/dnszones/TXT@2018-05-01' = if (recordType == 'TXT') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
    TXTRecords: [
      {
        value: [
          TXTRecordValue
        ]
      }
    ]
    targetResource: {}
  }
}

/*
// Not allowed to create multi SOA record. Azure default SOA exists.
resource SOARecord 'Microsoft.Network/dnszones/SOA@2018-05-01' = if (recordType == 'SOA') {
  name: '${dnsName}/${recordName}'
  properties: {
    TTL: recordTTL
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
