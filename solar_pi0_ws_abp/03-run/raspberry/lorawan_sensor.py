#! /usr/bin/env python3
# send physical data from sensor to LoRaWAN TTN by ABP identification
# Pi Platter board wakes up Pi zero, then Pi zero takes measurements and send to TTN application. Once it's done, Pi Platter board shutdown Pi zero
# version 1.0 - 23/11/21
# version 1.2 - 26/09/22 (ß)
# version 1.3 - 12/12/22 (button off and poweroff the ssd1306 display after test)

import adafruit_ssd1306, board, busio, time
import BME280       # measuring temperature, humidity, and air pressure sensor
import LTR390       # UV sensor
import TSL2591      # digital ambient light sensor, for measuring IR and visible light
import math
import smbus
from digitalio import DigitalInOut, Direction, Pull
from adafruit_tinylora.adafruit_tinylora import TTN, TinyLoRa
from time import sleep
from busio import I2C

def getPayloadMockSensor():

    bme = []
    bme = bme280.readData()
    press_val = round(bme[0], 2) 
    temp_val = round(bme[1], 2) 
    hum_val = round(bme[2], 2)
        
    lux_val = round(light.Lux(), 2)
    uvs_val = uv.UVS()
    
    return encodePayload(press_val,temp_val,hum_val,lux_val,uvs_val)

def encodePayload(pressure,temperature,humidity,luxmen,uvs):
    # encode float as int
    press_val = int(pressure * 100) 
    temp_val = int(temperature * 100)
    abs_temp_val = abs(temp_val)
    hum_val = int(humidity * 100)
    lux_val = int(luxmen * 100)
    uvs_val = int(uvs * 100)

    # encode payload as bytes
    # pressure (needs 2 bytes)
    data[0] = (press_val >> 8) & 0xff
    data[1] = press_val & 0xff

    # temperature (needs 3 bytes 327.67 max value) (signed int)
    if(temp_val < 0):
        data[2] = 1 & 0xff
    else:
        data[2] = 0 & 0xff
    data[3] = (abs_temp_val >> 8) & 0xff
    data[4] = abs_temp_val & 0xff

    # humidity (needs 2 bytes)
    data[5] = (hum_val >> 8) & 0xff
    data[6] = hum_val & 0xff

    # luxmen (needs 2 bytes)
    data[7] = (lux_val >> 8) & 0xff
    data[8] = lux_val & 0xff

    # uv (needs 2 bytes)
    data[9] = (uvs_val >> 8) & 0xff
    data[10] = uvs_val & 0xff

    return data

def sendDataTTN(data):
    lora.set_datarate(SF9BW125)
    lora.send_data(data, len(data), lora.frame_counter)
    lora.frame_counter += 1
    display.fill(0)
    display.text('Packet sent', 10, 0, 1)
    display.show()

# init
devaddr = [0x26, 0x01, 0x3D, 0x54]
nwkey = [0x0F, 0xFE, 0xDF, 0x1D, 0x36, 0x6D, 0x51, 0x89, 0x76, 0xD7, 0x76, 0xBB, 0x92, 0xA5, 0x9A, 0xE9]
app = [ 0x4A, 0xD7, 0xB6, 0x3F, 0x86, 0xAB, 0xC7, 0x54, 0xCF, 0x26, 0x8E, 0xE5, 0x60, 0xDE, 0x1C, 0x99]

# TinyLoRa configuration
spi = busio.SPI(board.SCK, MOSI=board.MOSI, MISO=board.MISO)
cs = DigitalInOut(board.CE1)
irq = DigitalInOut(board.D22)
rst = DigitalInOut(board.D25)

# initialize ThingsNetwork configuration
ttn_config = TTN(devaddr, nwkey, app, country="EU")

# initialize lora object
lora = TinyLoRa(spi, cs, irq, rst, ttn_config)

# create the i2c interface
i2c = board.I2C()   # uses board.SCL and board.SDA
 
# 128x32 OLED display
reset_pin = DigitalInOut(board.D4)
display = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c, reset=reset_pin)

# create library object
bus = smbus.SMBus(1)
bme280 = BME280.BME280()
bme280.get_calib_param()
light = TSL2591.TSL2591()
uv = LTR390.LTR390()
sgp = SGP40.SGP40()

# clear the display.
display.fill(0)
display.show()
width = display.width
height = display.height

# 5b array to store sensor data
data = bytearray(11)

for meas in range (0, 10, 1):
    packet = None
    sendDataTTN(getPayloadMockBMP388())
    time.sleep(30)

display.poweroff()