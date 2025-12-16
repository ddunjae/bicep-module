@description('Name of the key vault')
param agName string
 
@description('Tags to add to the resources')
param tags object
 
@description('Email address')
param email string
 
@description('Email receiver name')
param emailReceiverName string
 
@description('Use Common Alert Schema')
param useCommonAlertSchema bool = true
 
@description('Indicates whether this action group is enabled')
param enableAg bool = true
 
@description('Short name of the action group')
param groupShortName string = 'testag'
 
param useEmailReceiver bool = true
 
param roleReceiverName string = ''
param roleReceiverId string = ''
 
resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: agName
  location: 'global'
  tags: tags
  properties: {
    enabled: enableAg
    groupShortName: groupShortName
    emailReceivers: useEmailReceiver ? [
      {
        emailAddress: email
        name: emailReceiverName
        useCommonAlertSchema: useCommonAlertSchema
      }
    ] : []
    armRoleReceivers: useEmailReceiver ? [] : [
      {
        name: roleReceiverName
        roleId: roleReceiverId
        useCommonAlertSchema: useCommonAlertSchema
      }
    ]
  }
}
 
output actionGroupId string = actionGroup.id

