param automationAccountName string
param location string
param runbookName string
param runbookType string

resource automationAccount 'Microsoft.Automation/automationAccounts@2023-11-01' = {
  name: automationAccountName
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
    publicNetworkAccess: false 
    disableLocalAuth: true
}
}
resource runbook 'Microsoft.Automation/automationAccounts/runbooks@2023-11-01' = {
  name: runbookName
  location: location
  parent: automationAccount
  properties: {
    runbookType: runbookType
  }
}
