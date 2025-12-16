param snapshotName string
param location string
param diskSizeGB int
param sourceResourceId string

resource snapshot 'Microsoft.Compute/snapshots@2023-10-02' = {
  name: snapshotName
  location: location
  properties: {
    creationData: {
      createOption: 'Copy'
      sourceResourceId : sourceResourceId
    }
    diskSizeGB: diskSizeGB
  }
}
output snapshotId string = snapshot.id
