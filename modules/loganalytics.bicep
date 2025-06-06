param name string
param location string

resource workspace 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: name
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
  }
}


output workspaceId string = workspace.properties.customerId
output workspaceKey string = listKeys(workspace.id, '2021-12-01-preview').primarySharedKey
