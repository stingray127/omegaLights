var mqtt = require('mqtt');
var client  = mqtt.connect('mqtt:192.168.3.1');
 
client.on('connect', function () {
  client.subscribe('presence');
})
 
client.on('message', function (topic, message) {
  // message is Buffer
  console.log(message.toString());
  if(message == 'on'){
  	exec('relay-exp all 1');
  } else if(message == 'off'){
  	exec('relay-exp all 0');
  }
})