param recoveryServiceName string

param backupPolicyName string

@allowed([
  'AzureIaasVM'
  'AzureWorkload'
])
param backupType string

@allowed([
  'SAPHanaDatabase'
  'SQLDataBase'
])
param workloadType string = 'SQLDataBase'

@allowed([
  'Invalid'
  'V1'
  'V2'
])
param policyType string = 'V1'

@allowed([
  'Daily'
  'Hourly'
  'Weekly'
  'Invalid'
])
param scheduleRunFrequency string = 'Daily'

@description('List of times of day this schedule has to be run')
param scheduleRunTimes array = []

param retentionTimes array = []

param retentionDurationCnt int = 7
@allowed([
  'Days'
  'Invalid'
  'Months'
  'Weeks'
  'Years'
])
param retentionDurationType string = 'Days'

param instantRpRetentionRangeInDays int = 5

@description('Number of items associated with this policy')
param protectedItemsCount int = 0

var schedulePolicyType = 'SimpleSchedulePolicy'
var retentionPolicyType = 'LongTermRetentionPolicy'
var logSchedulePolicyType = 'LogSchedulePolicy'
var logRetentionPolicyType = 'SimpleRetentionPolicy'
var timeZone = 'Korea Standard Time'

resource VMBackupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = if (backupType == 'AzureIaasVM') {
  name: '${recoveryServiceName}/${backupPolicyName}'
  properties: {
    backupManagementType: 'AzureIaasVM'
    policyType: policyType
    instantRPDetails: {}
    schedulePolicy: {
      schedulePolicyType: schedulePolicyType
      scheduleRunFrequency: scheduleRunFrequency
      scheduleRunTimes: scheduleRunTimes
      scheduleWeeklyFrequency: 0
    }
    retentionPolicy: {
      retentionPolicyType: retentionPolicyType
      dailySchedule: {
        retentionTimes: retentionTimes
        retentionDuration: {
          count: retentionDurationCnt
          durationType: retentionDurationType
        }
      }
    }
    instantRpRetentionRangeInDays: instantRpRetentionRangeInDays
    timeZone: timeZone
    protectedItemsCount: protectedItemsCount
  }
}

resource WorkloadBackupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-06-01' = if (backupType == 'AzureWorkload'){
  name: '${recoveryServiceName}/${backupPolicyName}'
  properties: {
    backupManagementType: 'AzureWorkload'
    workLoadType: workloadType
    settings: {
      timeZone: timeZone
      issqlcompression: false
      isCompression: false
    }
    subProtectionPolicy: [
      {
        policyType: 'Full'
        schedulePolicy: {
          schedulePolicyType: schedulePolicyType
          scheduleRunFrequency: scheduleRunFrequency
          scheduleRunTimes: scheduleRunTimes
          scheduleWeeklyFrequency: 0
        }
        retentionPolicy: {
          retentionPolicyType: retentionPolicyType
          dailySchedule: {
            retentionTimes: retentionTimes
            retentionDuration: {
              count: retentionDurationCnt
              durationType: retentionDurationType
            }
          }
        }
      }
      {
        policyType: 'Log'
        schedulePolicy: {
          schedulePolicyType: logSchedulePolicyType
          scheduleFrequencyInMins: 15
        }
        retentionPolicy: {
          retentionPolicyType: logRetentionPolicyType
          retentionDuration: {
            count: retentionDurationCnt
            durationType: retentionDurationType
          }
        }
      }
    ]
    protectedItemsCount: protectedItemsCount
  }
}
