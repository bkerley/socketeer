arDrone = require 'ar-drone'
http = require 'http'
socket = require 'socket.io'
staticFile = require 'node-static'

client = arDrone.createClient()
console.log client.config 'general:navdata_demo', 'FALSE'

file = new staticFile.Server('./public')

server = http.createServer (req, res) ->
  file.serve req, res, (err, result) ->
    if err
      console.log "error #{req.url} #{err.message}"
      res.writeHead err.status, err.headers
      res.end
server.listen 8080, ->
  console.log "listening"

io = socket.listen(server)

io.sockets.on 'connection', (socket) ->
  socket.on 'client_ok', (data) ->
    console.log client.config 'general:navdata_demo', 'FALSE'
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
