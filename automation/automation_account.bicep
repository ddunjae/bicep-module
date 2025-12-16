param automationAccountName string
param location string

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

output automationAccountId string = automationAccount.id
