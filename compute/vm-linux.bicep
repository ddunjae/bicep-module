@description('VM Name')
param vmName string

@description('VM Region')
param location string

@description('VM Availability Zones')
param zones array = []

@description('VM SKU')
param vmSKU string

@description('OS Host Name')
@maxLength(15)
param hostName string

@description('VM Admin User')
param adminUsername string

@description('VM Admin Password')
@minLength(12)
@secure()
param adminPassword string

param osImageSKU string = '22_04-lts-gen2'
param osImagePublisher string = 'Canonical'
param osImageOffer string = '0001-com-ubuntu-server-jammy'
param osImageVersion string = 'latest'

@description('OS Disk Name')
param osDiskName string

@description('OS Disk Type')
@allowed([
  'PremiumV2_LRS'
  'Premium_LRS'
  'Premium_ZRS'
  'StandardSSD_LRS'
  'StandardSSD_ZRS'
  'Standard_LRS'
  'UltraSSD_LRS'
])
param osDiskType string = 'Standard_LRS'

@description('Specifies whether OS Disk should be deleted or detached upon VM deletion')
@allowed([
  'Delete'
  'Detach'
])
param osDiskDeletionOption string = 'Delete'

@description('OS Disk Size GB')
param osDiskSize int = 30

@description('Condition to Use Data Disk')
param useDataDisk bool = false

@description('Condition to Use Multi Data Disk')
param useMultiDataDisk bool = false
/*
Multi Data Disk Config format
[{
  lun: 0
  name: 'datadisk1'
  createOption: 'Attach'
  caching: 'ReadOnly'
  writeAcceleratorEnabled: false
  managedDisk: {
    storageAccountType: 'Standard_LRS'
    id: managedDisk.id
  }
  deleteOption: 'Detach'
  diskSizeGB: 128
}]
*/

param multiDataDisk array = []

@description('Data Disk LUN')
param dataDiskLun int = 0

@description('Data Disk Name')
param dataDiskName string = 'tmpDataDiskName'

@description('Specifies how the virtual machine should be created')
@allowed([
  'Attach'
  'Empty'
  'FromImage'
])
param dataDiskCreateOption string = 'Attach'

@description('Data Disk Type')
@allowed([
  'PremiumV2_LRS'
  'Premium_LRS'
  'Premium_ZRS'
  'StandardSSD_LRS'
  'StandardSSD_ZRS'
  'Standard_LRS'
  'UltraSSD_LRS'
])
param dataDiskType string = 'Standard_LRS'

@description('Specifies whether Data Disk should be deleted or detached upon VM deletion')
@allowed([
  'Delete'
  'Detach'
])
param dataDiskDeletionOption string = 'Detach'

@description('Data Disk Size GB')
param dataDiskSize int = 1024

@description('Security Type of the Virtual Machine')
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'TrustedLaunch'

var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}

@description('Condition to Use Public IP')
param usePublicIP bool = false

@description('Public IP Name')
param pipName string = ''

@description('Public IP SKU')
@allowed([
  'Basic'
  'Standard'
])
param pipSKU string = 'Standard'

@description('Public IP Allocation Method')
@allowed([
  'Dynamic'
  'Static'
])
param pipAllocMethod string = 'Static'

@description('Subnet Resource ID connected to NIC')
param subnetId string

@description('NSG Resource ID connected to NIC')
param nsgId string = ''

@description('Loadbalancer Inbound NAT Rules connected to NIC')
param lbInboundNatRule array = []

param lbBackendAddressPools array = []

resource pip 'Microsoft.Network/publicIPAddresses@2023-04-01' = if (usePublicIP) {
  name: pipName != '' ? pipName : '${vmName}-pip'
  location: location
  sku: {
    name: pipSKU
  }
  properties: {
    publicIPAllocationMethod: pipAllocMethod
  }
}

resource managedDisk 'Microsoft.Compute/disks@2023-01-02' = if (useDataDisk) {
  location: location
  name: dataDiskName
  sku: {
    name: dataDiskType
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: dataDiskSize
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-04-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: usePublicIP ? {
            id: pip.id
          } : null
          subnet: {
            //id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
            id: subnetId
          }
          loadBalancerInboundNatRules: lbInboundNatRule
          loadBalancerBackendAddressPools: lbBackendAddressPools
        }
      }
    ]
    networkSecurityGroup: (nsgId != '') ? { id: nsgId } : null
  }
}
resource vm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  zones: zones
  properties: {
    hardwareProfile: {
      vmSize: vmSKU
    }
    osProfile: {
      computerName: hostName
      adminUsername: adminUsername
      adminPassword: adminPassword
      linuxConfiguration: {
        disablePasswordAuthentication: false
        provisionVMAgent: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
    }
    storageProfile: {
      imageReference: {
        publisher: osImagePublisher
        offer: osImageOffer
        sku: osImageSKU
        version: osImageVersion
      }
      osDisk: {
        osType: 'Linux'
        name: osDiskName
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: osDiskDeletionOption
        diskSizeGB: osDiskSize
      }
      dataDisks: useDataDisk ? (useMultiDataDisk ? multiDataDisk : [
        {
          lun: dataDiskLun
          name: dataDiskName
          createOption: dataDiskCreateOption
          caching: 'ReadOnly'
          writeAcceleratorEnabled: false
          managedDisk: {
            storageAccountType: dataDiskType
            id: managedDisk.id
          }
          deleteOption: dataDiskDeletionOption
          diskSizeGB: dataDiskSize
        }
      ]) : []
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

resource vmTrustedLaunchExtension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = if ((securityType == 'TrustedLaunch') && ((securityProfileJson.uefiSettings.secureBootEnabled == true) && (securityProfileJson.uefiSettings.vTpmEnabled == true))) {
  parent: vm
  name: 'GuestAttestation'
  location: location
  properties: {
    publisher: 'Microsoft.Azure.Security.LinuxAttestation'
    type: 'GuestAttestation'
    typeHandlerVersion: '1.0'
    autoUpgradeMinorVersion: true
    enableAutomaticUpgrade: true
    settings: {
      AttestationConfig: {
        MaaSettings: {
          maaEndpoint: substring('emptyString', 0, 0)
          maaTenantName: 'GuestAttestation'
        }
      }
    }
  }
}

output pipId string = pip.id
output osDiskId string = vm.properties.storageProfile.osDisk.managedDisk.id
output vmId string = vm.id
output nicId string = nic.id
output nicName string = nic.name
output nicPrivateIp string = nic.properties.ipConfigurations[0].properties.privateIPAddress
