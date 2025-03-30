param location string = resourceGroup().location
param imageName string
@secure()
param acrPassword string

var name = 'crud-app-aci'
var vnetName = 'vnet-crud'
var subnetName = 'subnet-crud'
var appGwSubnetName = 'subnet-appgw'
var acrName = 'acrtcFINAL'
var logAnalyticsName = 'log-${name}'

module network './modules/network.bicep' = {
  name: 'deploy-network'
  params: {
    location: location
  }
}

module container './modules/aci.bicep' = {
  name: 'deploy-container'
  params: {
    name: name
    location: location
    vnetName: vnetName
    subnetName: subnetName
    acrName: acrName
    imageName: imageName
    acrPassword: acrPassword
    logAnalyticsWorkspaceId: loganalytics.outputs.workspaceId
    logAnalyticsKey: loganalytics.outputs.workspaceKey
  }
}


module appGateway './modules/appgw.bicep' = {
  name: 'deploy-appgw'
  dependsOn: [
    container
  ]
  params: {
    location: location
    subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, appGwSubnetName)
    targetPrivateIp: container.outputs.privateIP
  }
}

module loganalytics './modules/loganalytics.bicep' = {
  name: 'deploy-logs'
  params: {
    name: logAnalyticsName
    location: location
  }
}


output appGwIp string = appGateway.outputs.appGatewayPublicIp
