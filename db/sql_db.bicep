param serverName string
param dbName string
param location string



resource sqlDB 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  name: '${serverName}/${dbName}'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

  output sqlDBResourceId string = sqlDB.id

