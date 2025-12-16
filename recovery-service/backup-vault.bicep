param backupVaultName string
param location string

@allowed([
  'ArchiveStore'
  'SnapshotStore'
  'VaultStore'
])
param datastoreType string = 'VaultStore'

@allowed([
  'GeoRedundant'
  'LocallyRedundant'
  'ZoneRedundant'
])
param storageType string = 'LocallyRedundant'

resource backupVault 'Microsoft.DataProtection/backupVaults@2022-11-01-preview' = {
  name: backupVaultName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    storageSettings: [
      {
        datastoreType: datastoreType
        type: storageType
      }
    ]
  }
}

output backupVaultId string = backupVault.id
