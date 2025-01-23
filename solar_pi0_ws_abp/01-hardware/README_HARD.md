# Description of Solar Pi Platter board
The Solar Pi Platter is a versatile expansion board for the Raspberry Pi Zero W computers that provides power from a single-cell rechargeable Lithium-Ion battery, additional peripherals including analog inputs, PWM outputs, USB ports and optional hardwired ethernet. A real-time clock allows for scheduled power cycling. Dual charging sources support both low-impedance devices like common USB chargers and high-impedance devices like solar panels. The Solar Pi Platter allows the Pi Zero to be used in a wide variety of applications ranging from solar-powered remote data acquisition systems to battery-backed file servers. See more and buy: http://danjuliodesigns.com/products/solar_pi_platter.html

# Features of Solar Pi Platter board

    - Single-cell Lithium-Ion battery management system supplying up to 10W power at 5V
    - Low impedance charging input with Un-interruptible Power Supply (UPS) functionality
    - High impedance charging input for use with solar or inductive power sources
    - Real-Time Clock with Alarm Power Control
    - Battery charged power-up control
    - Automatic low battery power-down control
    - Three high-speed USB expansion ports with per-port transaction translator
    - Power control for two USB expansion ports
    - Expansion port for RJ45 Ethernet jack
    - Two analog inputs with configurable reference
    - Two PWM outputs with configurable period and support for Servo mode
    - Simple command interface via a USB serial port
    - Programmable power-on default operation
    - User-accessible EEPROM configuration settings
    - Watchdog timer

# Description of basic tests
In basic tests folder, several tests written on python are purposed in order to test separately the sensor module and the LoRa protocol. These tests come directly from the manufacturers.

## Test I2C bus in parallel mode
According to python3 is installed, run the script **test_parallel_i2c.py** to check if I2C bus can work on parallel mode (screen display of Adafruit LoRa Radio Bonnet). To verify that they are working properly, we just have to watch if on the screen display there is the same temperature as on the command line. If it is the case, and the temperature is not a nonsense, this would mean that your BME280 sensor is measuring while the display is done, so it all works well. To verify if the values of your BME280 sensor are real you can try to touch the sensor and the temperature should increase.

## Test LoRa chipset radio RFM95W and the TTN application
According to python3 is installed, run these scripts to chipset radio (RFM95) and the TTN communication :
    
    - test_rfm9x.py to check the Adafruit radio+oled Bonnet
    - test_send_ttn_abp.py to check if a random data can be transmitted on the TTN network application

To test the LoRa device (both sending and receiving), we need to execute the **test_rfm9x.py**. Then, after that, we have to look at the screen and see the output. If the radio module is not detected, it will display RFM69: ERROR. However, if everything works correctly and you press the three buttons (one by one) you should see "ada fruit radio". If you are able to see these messages the hardware should be ready to start working as well as the libraries and dependencies..

To verify that you receive the packets on your TTN application, run **test_send_ttn_abp.py**.

## Test Waveshare Sensor Hat module
According to python3 is installed, run **test_sensors.py** to test if the environment sensor module gives good values. Then the values related to the current environment will be printed.

# Description of datasheet/schematic/tutorial
This folder contains datasheet of the only environment sensors module of our project (Waveshare Environment Sensor Hat) and the LoRa chipset radio (RFM95W inlcude on Adafruit's LoRa Radio Bonnet).
It also contains the schematic of the Solar Pi Platter board and different tutorials in order to understand I2C bus and use Solar Pi Platter drivers. A brief description of Raspberry Pi Zero W  GPIO board is added.

**Datasheet**

    - BME280 : Measuring temperature, humidity, and air pressure sensor
    - ICM-20948 : 3-axis accelerometer, 3-axis gyroscrope, 3-axis magnetometer
    - LTR-390UV-01 : UV sensor
    - RFM95W.pdf : RFM95/96/97/98(W) - Low Power Long Range Transceiver Module
    - SGP40 : VOC sensor
    - TSL2591 : Digital ambient light sensor, for measuring IR and visible light

**Schematic**

This file (pi_platter_sch.pdf) contains the electrical schematic of Solar Pi Platter board from danjuliodesigns. According https://www.waveshare.com/wiki/Environment_Sensor_HAT, environment_sensor_hat_sch.pdf give you the schematic of the module.

**Tutorial**

These files contain some information about I2C bus, the pin configuration of a Pi Zero W board and the comunication by talkpp driver :

    - i2c_bus.pdf : Application report in order to understanding the I2C Bus (Texas Instrument)
    - pi_zero_w_gpio.pdf : Description of GPIO bus and Pi Zero pin descriptions (Sparkfun Electronics)
    - pi_platter_man.pdf : User Nanual of the Solar Pi Platter board