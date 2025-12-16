
param name string
param location string
param severity string = 'Sev4'
param state string = 'Enabled'
param groupIds string
param detector string
param scope string
param frequency string
param decription string



resource smartDetectorAlertRules 'microsoft.alertsManagement/smartDetectorAlertRules@2021-04-01' = {
  name: name
  location: location
  properties: {
    actionGroups: {
      //customEmailSubject: 'string'
      //customWebhookPayload: 'string'
      groupIds: [
        groupIds
      ]
    }
    description: decription
    //description: 'string'
    detector: {
      id: detector
    }
    frequency: frequency
    scope: [
      scope
    ]
    severity: severity
    state: state

  }
}

output smartDetectorAlertRuleId string = smartDetectorAlertRules.id
output smartDetectorAlertRuleGroupId array = smartDetectorAlertRules.properties.actionGroups.groupIds
