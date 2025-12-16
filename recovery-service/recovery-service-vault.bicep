@description('Azure region of the deployment')
param location string

@description('Tags to add to the resources')
param tags object

@description('Name of the Recovery Service Vault')
param vaultName string

@description('Enable CRR (Works if vault has not registered any backup instance)')
param enableCRR bool = false

@description('Change Vault Storage Type (Works if vault has not registered any backup instance)')
@allowed([
  'LocallyRedundant'
  'GeoRedundant'
  'ZoneRedundant'
  'ReadAccessGeoZoneRedundant'
])
param vaultStorageType string = 'LocallyRedundant'

var skuName = 'RS0'
var skuTier = 'Standard'
//var identityType = 'None'

//var softDeleteDays = 14
//var softDeleteState = 'Enabled'
var publicNetworkAccess = 'Enabled'
//var crossSubsRestoreState = 'Enabled'
//var immutabilitySettingState = 'Disabled'

resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2023-06-01' = {
  name: vaultName
  location: location
  tags: tags
  sku: {
    name: skuName
    tier: skuTier
  }
  properties: {
    publicNetworkAccess: publicNetworkAccess
  }
  /*identity: {
    type: identityType
  }
  properties: {
    securitySettings: {
      softDeleteSettings: {
        softDeleteRetentionPeriodInDays: softDeleteDays
        softDeleteState: softDeleteState
      }
      immutabilitySettings: {
        state: immutabilitySettingState
      }
    }
    redundancySettings: {}
    publicNetworkAccess: publicNetworkAccess
    restoreSettings: {
      crossSubscriptionRestoreSettings: {
        crossSubscriptionRestoreState: crossSubsRestoreState
      }
    }
  }*/
}

resource vaultStorageConfig 'Microsoft.RecoveryServices/vaults/backupstorageconfig@2023-06-01' = {
  parent: recoveryServicesVault
  name: 'vaultstorageconfig'
  properties: {
    storageModelType: vaultStorageType
    crossRegionRestoreFlag: enableCRR
  }
}
/*
resource vaultAlertSetting 'Microsoft.RecoveryServices/vaults/replicationAlertSettings@2023-06-01' = {
  parent: recoveryServicesVault
  name: 'defaultAlertSetting'
  properties: {
    sendToOwners: 'DoNotSend'
    customEmailAddresses: []
  }
}

resource valutReplicationSetting 'Microsoft.RecoveryServices/vaults/replicationVaultSettings@2023-06-01' = {
  parent: recoveryServicesVault
  name: 'default'
  properties: {}
}
*/

output rsvId string = recoveryServicesVault.id
