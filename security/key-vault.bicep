@description('Name of the key vault')
param vaultName string

@description('Azure region of the deployment')
param location string
@allowed([
  'premium'
  'standard'
])
param vaultSkuName string = 'standard'


@description('Tags to add to the resources')
param tags object


/* ====== Key vault properties ====== */
@allowed([
  'default'
  'recover'
])
param create_mode string = 'default'
param enabled_for_deployment bool = false
param enabled_for_disk_encryption bool = true
param enabled_for_template_deployment bool = false
param enable_purge_protection bool = true
param enable_rbac_authorization bool = true
param enable_soft_delete bool = true
/*@allowed([
  'RegisteringDns'
  'Succeeded'
])
param provision_state string = 'Succeeded'*/


/* ====== Key vault properties - networkAcls ====== */
@allowed([
  'AzureServices'
  'None'
])
param by_pass string = 'AzureServices'
@allowed([
  'Allow'
  'Deny'
])
param default_action string = 'Allow'
param soft_delete_retention_in_days int = 90
param tenant_id string = tenant().tenantId
//param vault_uri string


resource symbolicname 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: vaultName
  location: location
  tags: tags
  properties: {
    /*accessPolicies: [
      {
        applicationId: 'string'
        objectId: 'string'
        permissions: {
          certificates: [
            'string'
          ]
          keys: [
            'string'
          ]
          secrets: [
            'string'
          ]
          storage: [
            'string'
          ]
        }
        tenantId: 'string'
      }
    ]*/
    createMode: create_mode
    enabledForDeployment: enabled_for_deployment
    enabledForDiskEncryption: enabled_for_disk_encryption
    enabledForTemplateDeployment: enabled_for_template_deployment
    enablePurgeProtection: enable_purge_protection
    enableRbacAuthorization: enable_rbac_authorization
    enableSoftDelete: enable_soft_delete
    networkAcls: {
      bypass: by_pass
      defaultAction: default_action
      /*ipRules: [
        {
          value: 'string'
        }
      ]
      virtualNetworkRules: [
        {
          id: 'string'
          ignoreMissingVnetServiceEndpoint: bool
        }
      ]*/
    }
    //provisioningState: 'string'
    //publicNetworkAccess: 'string'
    sku: {
      family: 'A'
      name: vaultSkuName
    }
    softDeleteRetentionInDays: soft_delete_retention_in_days
    tenantId: tenant_id
  }
}
