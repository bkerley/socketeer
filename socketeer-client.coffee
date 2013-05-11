socket = io.connect "http://localhost"
clunkbin = $ '#clunkbin'
copter = $ '#nodecopter'
compass = $ '#compass'
socket.on 'navdata', (data) ->
  clunkbin.html JSON.stringify data
  if (x = data.rotation.x) && (y = data.rotation.y) && (z = data.rotation.z)
    css = "rotateX(#{x * 180}deg) rotateY(#{y * 180}deg) rotateZ(#{z * 180}deg)"
    copter.css '-webkit-transform', css

  if h = data.heading.fusionUnwrapped
    compass.css '-webkit-transform', "rotateZ(#{h}deg)"

socket.emit 'client_ok', true
