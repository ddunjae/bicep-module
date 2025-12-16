param routeTableName string

param location string

param disableBgpRoutePropagation bool = false

resource routeTable 'Microsoft.Network/routeTables@2023-04-01' = {
  name: routeTableName
  location: location
  properties: {
    disableBgpRoutePropagation: disableBgpRoutePropagation
  }
}

output routeTableId string = routeTable.id
