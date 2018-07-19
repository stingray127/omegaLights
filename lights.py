import os, sys, getopt
import paho.mqtt.client as mqtt

def __main__():
        mqttc = mqtt.Client()

        ## Define the MQTT Callbacks
        # The callback for when the client receives a response from the Server
        def on_connect(client, userdata, flags, rc):
            print("Connected with result code "+str(rc))
            mqttc.subscribe("lightsControl")

        # Subscribe to the MQTT Topic
        def on_subscribe(client, userdata, mid, granted_qos):
            print("Subscribed: " + str(mid) + "; " + str(granted_qos))

        # The callback when a publish message is received from the Server
        def on_message(client, userdata, msg):
            if str(msg.payload) == "on":
                os.system('relay-exp all 1')
            elif str(msg.payload) == "off":
                os.system('relay-exp all 0')
                
                
        # The callback to disconnect and update the user
        def on_disconnect(client, userdata, rc):
            print("Disconnect From Server")

        #Assign the callbacks
        mqttc.on_message = on_message
        mqttc.on_connect = on_connect
        mqttc.on_subscribe = on_subscribe
        mqttc.on_disconnect = on_disconnect
        #Connects directly to the Omega
        mqttc.connect('192.168.50.10')
        # Continue the network infinite loop
        mqttc.loop_forever()

if __name__ == '__main__':
    __main__()