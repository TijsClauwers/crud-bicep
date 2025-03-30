@secure()
param acrPassword string
param name string
param location string
param vnetName string
param subnetName string
param acrName string
param imageName string

// New parameters for logging
param logAnalyticsWorkspaceId string
param logAnalyticsKey string

resource aci 'Microsoft.ContainerInstance/containerGroups@2023-05-01' = {
  name: name
  location: location
  properties: {
    subnetIds: [
      {
        id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
      }
    ]
    containers: [
      {
        name: 'crud-container'
        properties: {
          image: imageName
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
          ports: [
            {
              port: 80
              protocol: 'TCP'
            }
          ]
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      type: 'Private'
      ports: [
        {
          protocol: 'TCP'
          port: 80
        }
      ]
    }
    imageRegistryCredentials: [
      {
        server: '${acrName}.azurecr.io'
        username: acrName
        password: acrPassword
      }
    ]
    diagnostics: {
      logAnalytics: {
        workspaceId: logAnalyticsWorkspaceId
        workspaceKey: logAnalyticsKey
      }
    }
  }
}

output privateIP string = aci.properties.ipAddress.ip
