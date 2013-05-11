arDrone = require 'ar-drone'

# client = arDrone.createClient()

control = arDrone.createUdpControl()
control.config 'general:navdata_demo', 'TRUE'

dataStream = arDrone.createUdpNavdataStream()

dataStream.on 'data', (navdata) ->
  console.log navdata['demo']['rotation']
  console.log navdata['magneto']['heading']
  console.log navdata['demo']['velocity']

# client.takeoff()

# client.after 1000, ->
#   this.stop()
# client.after 5000, ->
#   this.land()
