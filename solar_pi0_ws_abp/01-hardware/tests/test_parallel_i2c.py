#! /usr/bin/env python3
# test for parallel communication between sensor and radio bonnet i2c bus
# version 1.0 - 19/11/21
# version 1.1 - 25/11/21 (delete link buttons)
# version 1.2 - 28/11/22 (poweroff the ssd1306 display after test)
# version 1.3 - 23/01/25 (change with bme280 mounted on wvashare environment hat)

# import time, busio, board, adafruit_ssd1306, adafruit_bmp3xx
import time, busio, board, adafruit_ssd1306, BME280
from digitalio import DigitalInOut
from busio import I2C
from time import sleep
 
# create the I2C interface.
#i2c = busio.I2C(board.SCL, board.SDA)

# create library object using our Bus I2C port
#bmp = adafruit_bmp3xx.BMP3XX_I2C(i2c)
bme280 = BME280.BME280()

# change this to match the location's pressure (hPa) at sea level
#bmp.sea_level_pressure = 1013.25

# no IIR filter, no osr for lowest power (case of weather monitoring)
#bmp.pressure_oversampling = 1
#bmp.temperature_oversampling = 1

# calibrate bme280 sensor
bme280.get_calib_param()

# you will usually have to add an offset to account for the temperature of
# the sensor. This is usually around 5 degrees but varies by use. Use a
# separate temperature sensor to calibrate this one.
#temperature_offset = -5

# 128x32 OLED display
reset_pin = DigitalInOut(board.D4)
display = adafruit_ssd1306.SSD1306_I2C(128, 32, i2c, reset=reset_pin)

# clear the display.
display.fill(0)
display.show()
width = display.width
height = display.height

print("bme280 T&H I2C address:0X76") 
for meas in range (0,5,1):
    bme = []
    bme = bme280.readData()
    pressure = round(bme[0], 2) 
    temp = round(bme[1], 2) 
    hum = round(bme[2], 2)
    
    print("==================================================")
    msg = ''
    msg += "Temperature: %-6.2f C\n" % temp
    msg += "Pressure: %7.2f hPa\n" % pressure
    msg += "Humidity %6.2f ％\n" % hum
    msg += "Gas: %6.2f\n" % gas

    display.fill(0)
    display.text(msg, 0, 0, 1)
    display.show()
    print(msg)

    time.sleep(1)

display.poweroff()