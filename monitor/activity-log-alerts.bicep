param name string
param location string = 'global'
param actionGroupId string
param scopes array
param field string = 'category'
param equals string = 'ServiceHealth'
resource activityLogAlerts 'Microsoft.Insights/activityLogAlerts@2017-04-01' = {
  name: name
  location: location
  properties: {
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroupId
        }
      ]
    }
    condition: {
      allOf: [
        {
          equals: equals
          field: field
        }
      ]
    }
    enabled: true
    scopes: scopes
  }
}

output activityLogAlertsId array = activityLogAlerts.properties.actions.actionGroups
