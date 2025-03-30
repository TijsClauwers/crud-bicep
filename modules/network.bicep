param location string = resourceGroup().location

resource publicIp 'Microsoft.Network/publicIPAddresses@2023-04-01' = {
  name: 'pip-nat'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource natGateway 'Microsoft.Network/natGateways@2023-04-01' = {
  name: 'nat-crud'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIpAddresses: [
      {
        id: publicIp.id
      }
    ]
    idleTimeoutInMinutes: 10
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-04-01' = {
  name: 'vnet-crud'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'subnet-crud'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: [
            {
              name: 'aci-delegation'
              properties: {
                serviceName: 'Microsoft.ContainerInstance/containerGroups'
              }
            }
          ]
        }
      }
      {
        name: 'subnet-appgw'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}


