param location string

@description('Data Disk Name')
param dataDiskName string

@description('Data Disk Type')
@allowed([
  'PremiumV2_LRS'
  'Premium_LRS'
  'Premium_ZRS'
  'StandardSSD_LRS'
  'StandardSSD_ZRS'
  'Standard_LRS'
  'UltraSSD_LRS'
])
param dataDiskType string = 'Standard_LRS'

@description('Data Disk Size GB')
param dataDiskSize int = 32

resource managedDisk 'Microsoft.Compute/disks@2023-01-02' = {
  location: location
  name: dataDiskName
  sku: {
    name: dataDiskType
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: dataDiskSize
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}

output diskId string = managedDisk.id
