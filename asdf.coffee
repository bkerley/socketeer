arDrone = require('ar-drone')
pngStream = require('ar-drone-png-stream')

client = arDrone.createClient()

pngStream(client, {port: 8080})
