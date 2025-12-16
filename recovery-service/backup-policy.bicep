param backupVaultName string
param backupPolicyName string

param datasourceTypes string // 'Microsoft.Compute/disks'

param policyRuleName string
param repeatingTimeIntervals string // ISO 8601 Format - e.g) 'R/2021-07-15T01:00:00+09:00/P1D'
param timeZone string // 'Korea Standard Time'


resource backupPolicy 'Microsoft.DataProtection/backupVaults/backupPolicies@2022-11-01-preview' = {
  name: '${backupVaultName}/${backupPolicyName}'
  properties: {
    datasourceTypes: [
      datasourceTypes
    ]
    objectType: 'BackupPolicy'
    policyRules: [
      {
        name: policyRuleName
        objectType: 'AzureBackupRule'
        backupParameters: {
          objectType: 'AzureBackupParams'
          backupType: 'Incremental'
        }
        dataStore: {
          dataStoreType: 'OperationalStore'
          objectType: 'DataStoreInfoBase'
        }
        trigger: {
          objectType: 'ScheduleBasedTriggerContext'
          schedule: {
            repeatingTimeIntervals: [
              repeatingTimeIntervals
            ]
            timeZone: timeZone
          }
          taggingCriteria: []
        }
      }
      //{
      //  name: 'Default'
      //  objectType: 'AzureRetentionRule'
      //  lifecycles: [
      //    {
      //      deleteAfter: {
      //        objectType: 'AbsoluteDeleteOption'
      //        duration: 'P30D'
      //      }
      //      targetDataStoreCopySettings: []
      //      sourceDataStore: {
      //        dataStoreType: 'OperationalStore'
      //        objectType: 'DataStoreInfoBase'
      //      }
      //    }
      //  ]
      //  isDefault: true
      //}
    ]
  }
}
