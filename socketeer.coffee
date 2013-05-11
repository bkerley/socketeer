arDrone = require 'ar-drone'
http = require('http')
socket = require('socket.io')
fs = require('fs')
haml = require('haml')


client = arDrone.createClient()
client.config 'general:navdata_demo', 'FALSE'
# control.config 'general:navdata_options', '105971713'

source = fs.readFileSync(__dirname + '/public/index.html.haml').toString()

index = haml(source)()

handler = (req, res) ->
  res.writeHead 200
  res.end index

server = http.createServer handler
server.listen 8080

io = socket.listen(server)

io.sockets.on 'connection', (socket) ->
  socket.on 'client_ok', (data) ->
    dataStream = arDrone.createUdpNavdataStream()

    dataStream.on 'data', (navdata) ->
      console.log navdata
      try
        parcel = 
          'rotation': navdata['demo']['rotation'] || undefined
          'heading': navdata['magneto']['heading']
          'velocity': navdata['demo']['velocity']
      catch TypeError
        parcel = 
          'rotation': {}
          'heading': {}
          'velocity': {}
          'navdata': navdata

      console.log parcel

      socket.emit 'navdata', parcel
