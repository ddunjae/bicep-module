param logWSDataCollectionName string
param location string
param desc string = ''
param logWSId string

var performanceCounterName = 'VMInsightsPerfCounters'
var performanceCounterStream = 'Microsoft-InsightsMetrics'
var performanceCounterSpecifier = '\\VmInsights\\DetailedMetrics'
var performanceCounterFreqSec = 60
var logAnalyticsName = 'VMInsightsPerf-Logs-Dest'

resource logWSDataCollection 'Microsoft.Insights/dataCollectionRules@2022-06-01' = {
  name: logWSDataCollectionName
  location: location
  properties: {
    description: desc
    dataSources: {
      performanceCounters: [
        {
          streams: [
            performanceCounterStream
          ]
          samplingFrequencyInSeconds: performanceCounterFreqSec
          counterSpecifiers: [
            performanceCounterSpecifier
          ]
          name: performanceCounterName
        }
      ]
    }
    destinations: {
      logAnalytics: [
        {
          workspaceResourceId: logWSId
          name: logAnalyticsName
        }
      ]
    }
    dataFlows: [
      {
        streams: [
          performanceCounterStream
        ]
        destinations: [
          logAnalyticsName
        ]
      }
    ]
  }
}
