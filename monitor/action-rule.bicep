param actionRuleName string
param desc string = ''
param connectionScope array

param conditionField string = 'Severity'
param conditionOperator string = 'Equals'
param conditionValues array = ['Sev1']

param actionGroupIds array

resource actionRule 'Microsoft.AlertsManagement/actionRules@2023-05-01-preview' = {
  name: actionRuleName
  location: 'Global'
  properties: {
    description: desc
    scopes: connectionScope
    conditions: [
      {
        field: conditionField
        operator: conditionOperator
        values: conditionValues
      }
    ]
    enabled: true
    actions: [
      {
        actionGroupIds: actionGroupIds
        actionType: 'AddActionGroups'
      }
    ]
  }
}
