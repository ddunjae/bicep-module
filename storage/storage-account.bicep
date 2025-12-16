/* Parameters */
/* ----------------------------------------------------------------------------------- */
@description('Azure region of the deployment')
param location string

@description('Tags to add to the resources')
param tags object = {}

@description('Name of the storage account')
param storageName string

param enableBlob bool = true
param enableFile bool = true
param enableQueue bool = true
param enableTable bool = true
param allowBlobPublicAccess bool = true
param allowCrossTenantReplication bool = false
param allowSharedKeyAccess bool = true
param requireInfrastructureEncryption bool = false
param isHnsEnabled bool = false
param isNfsV3Enabled bool = false
param largeFileSharesState string = 'Disabled'
param minimumTlsVersion string = 'TLS1_2'
param supportsHttpsTrafficOnly bool = true

@allowed([
  'Standard_LRS'
  'Standard_ZRS'
  'Standard_GRS'
  'Standard_GZRS'
  'Standard_RAGRS'
  'Standard_RAGZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
@description('Storage SKU')
param storageSkuName string = 'Standard_LRS'

@allowed([
  'BlobStorage'
  'BlockBlobStorage'
  'FileStorage'
  'Storage'
  'StorageV2'
])
@description('Type of storage account')
param storageKind string = 'StorageV2'

@allowed([
  'Cool'
  'Hot'
  'Premium'
])
@description('Access tier of storage account')
param storageAccessTier string = 'Hot'

@allowed([
  'Microsoft.Keyvault'
  'Microsoft.Storage'
])
@description('Encryption KeySource')
param storageKeySource string = 'Microsoft.Storage'


/*
@description('Name of the storage blob private link endpoint')
param storagePleBlobName string

@description('Name of the storage file private link endpoint')
param storagePleFileName string

@description('Resource ID of the subnet')
param subnetId string

@description('Resource ID of the virtual network')
param virtualNetworkId string
*/

/* Variables */
/* ----------------------------------------------------------------------------------- */
var storageNameCleaned = replace(storageName, '-', '') // Cannot use '-' in a Storage Account name.

//var blobPrivateDnsZoneName = 'privatelink.blob.${environment().suffixes.storage}'
//var filePrivateDnsZoneName = 'privatelink.file.${environment().suffixes.storage}'

resource storage 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageNameCleaned
  location: location
  tags: tags
  sku: {
    name: storageSkuName
  }
  kind: storageKind
  properties: {
    accessTier: ((storageKind == 'BlobStorage') ? storageAccessTier : null)
    allowBlobPublicAccess: allowBlobPublicAccess
    allowCrossTenantReplication: allowCrossTenantReplication
    allowSharedKeyAccess: allowSharedKeyAccess
    encryption: {
      keySource: storageKeySource
      requireInfrastructureEncryption: requireInfrastructureEncryption
      services: {
        blob: {
          enabled: enableBlob
          keyType: 'Account'
        }
        file: {
          enabled: enableFile
          keyType: 'Account'
        }
        queue: {
          enabled: enableQueue
          keyType: 'Service'
        }
        table: {
          enabled: enableTable
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: isHnsEnabled
    isNfsV3Enabled: isNfsV3Enabled
    keyPolicy: {
      keyExpirationPeriodInDays: 7
    }
    largeFileSharesState: largeFileSharesState
    minimumTlsVersion: minimumTlsVersion
    /*networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }*/
    supportsHttpsTrafficOnly: supportsHttpsTrafficOnly
  }
}

/*
resource storagePrivateEndpointBlob 'Microsoft.Network/privateEndpoints@2022-01-01' = {
  name: storagePleBlobName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      { 
        name: storagePleBlobName
        properties: {
          groupIds: [
            'blob'
          ]
          privateLinkServiceId: storage.id
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource storagePrivateEndpointFile 'Microsoft.Network/privateEndpoints@2022-01-01' = {
  name: storagePleFileName
  location: location
  tags: tags
  properties: {
    privateLinkServiceConnections: [
      {
        name: storagePleFileName
        properties: {
          groupIds: [
            'file'
          ]
          privateLinkServiceId: storage.id
          privateLinkServiceConnectionState: {
            status: 'Approved'
            description: 'Auto-Approved'
            actionsRequired: 'None'
          }
        }
      }
    ]
    subnet: {
      id: subnetId
    }
  }
}

resource blobPrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: blobPrivateDnsZoneName
  location: 'global'
}

resource privateEndpointDns 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-01-01' = {
  name: '${storagePrivateEndpointBlob.name}/blob-PrivateDnsZoneGroup'
  properties:{
    privateDnsZoneConfigs: [
      {
        name: blobPrivateDnsZoneName
        properties:{
          privateDnsZoneId: blobPrivateDnsZone.id
        }
      }
    ]
  }
}

resource blobPrivateDnsZoneVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${blobPrivateDnsZone.name}/${uniqueString(storage.id)}'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}

resource filePrivateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: filePrivateDnsZoneName
  location: 'global'
}

resource filePrivateEndpointDns 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2022-01-01' = {
  name: '${storagePrivateEndpointFile.name}/flie-PrivateDnsZoneGroup'
  properties:{
    privateDnsZoneConfigs: [
      {
        name: filePrivateDnsZoneName
        properties:{
          privateDnsZoneId: filePrivateDnsZone.id
        }
      }
    ]
  }
}

resource filePrivateDnsZoneVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${filePrivateDnsZone.name}/${uniqueString(storage.id)}'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: virtualNetworkId
    }
  }
}
*/

output storageId string = storage.id
