const { contextBridge } = require('electron')

contextBridge.exposeInMainWorld('desktop', {
  platform: process.platform,
  appName: 'AI Alarm English Pro',
})
