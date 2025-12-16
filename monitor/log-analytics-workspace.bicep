@description('Azure region of the deployment')
param location string

@description('Tags to add to the resources')
param tags object

@description('Name of the storage account')
param lawName string

// Workspaces cannot be created or updated to free, standard or premium tiers
@description('sku')
@allowed([
  'CapacityReservation'
  'LACluster'
  'PerGB2018'
  'PerNode'
  'Standalone'
])
param sku string = 'PerGB2018'

@description('Data retention (Days)')
param retentionInDays int = 90

@description('Daily volume cap(Gb)')
param dailyQuotaGb int = 1

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: lawName
  location: location
  tags: tags
  properties: {
    sku: {
      name: sku
    }
    retentionInDays: retentionInDays
    workspaceCapping: {
      dailyQuotaGb: dailyQuotaGb
    }
  }
}

output logWSId string = logAnalyticsWorkspace.id
