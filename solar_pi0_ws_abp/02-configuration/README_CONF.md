
# Configuration

## Step 1 : Installation of requirements and dependencies

The script install can be found in the **02-configuration folder**. This script will enable the I2C and SPI interface, install the environment sensor hat requirements, the LoRa Radio Bonnet requirements and the Solar Pi Platter drivers (talkpp and ppd). When the script will be done, we recommend you to test both the LoRa module and the environmental sensor module to verify that everything is working correctly.
All tests can be found in the **01-hardware folder**. We invite you to read the **README_HARD.md** file present in this folder which describes hardware and software of this project.

To run as sudo user, tape : **sudo \\.pp_config_install.sh** or **sudo bash pp_config_install.sh**

## Step 2 : Configuration of the TTN (The Things Network)

To begin, we will need to login into the ttn (https://www.thethingsnetwork.org/) console. Once this is done and as our sensor is only a sender, we need to create both a gateway and an application. Choose a gateway near your country, for example Europe 1, Dublin.

### Application (sender)

You will need to register a new device in your application (with ABP activation method). Once this is done, retain the TTN Device Address(4 Bytes), the TTN Network Key(16 Bytes) and the TTN Application Key (16 Bytes). You also have to make sure that the activation method is ABP.

    - After you account was created, you have to create a new application : Name of this application --> solar-pi0-ws-app

    - After that, you have to add a new end device on this application. You have to complete the various fields using the available data below in manually mode :
        Frequency Plan                  Europe 863-870 MHz (SF9 for RX2 - Recommended)
        LoRaWAN Version                 MAC V1.0
        Regional Parameter Version      PHY V1.0
        Activation by personalization   ABP
        Application ID                  your application ID
        Device UI number 1              random value for 8-byte address (experimental node)
        Device Address                  random value for 4-byte address
        NwkSKey                         random value for 16-byte address
        AppSKey                         random value for 16-byte address

After the test (test_send_ttn_abp.py) purposed in **01-hardware/tests**, you have to paste the **file payload_format.js** into the TTN application decoder function so you can read the packets content in real time already decrypted.

## Step 3 : Configuration of SPIIOT (Youpi Platform Application)

ChirpStack is an open-source LoRaWAN Network Server which can be used to to setup LoRaWAN networks. ChirpStack provides a web-interface for the management of gateways, devices and tenants as well to setup data integrations with the major cloud providers, databases and services commonly used for handling device data. An application for using Solar Pi Platter device has been created, her name is **TRALALA** and you can create and add new devcies into this application. The gateway has also been created : **SPIIOT-Chappe-Indoor-CITI-Level-2**.

### Application (sender)

You have to have the permission of the administrator to enter into the SPIIOT platform. So, you have to ask Login/Password to your administrator in order to use the ChirpStack application (http://spiiot.citi.insa-lyon.fr:8080/#/login). Once this is done, we need to create devices.

    - After you account was created, you have to open tralala application
    - After that, you have to add a new end device on this application. You have to complete the various fields using the available data below in manually mode :
        Device name                     tralala-prodxx
        Device description              tralala production device
        Check the box "Disable frame-counter validation"
        Device EUI                      check "generate random" to obtain random DevEUI address
        check "Create Device"
    - After that, you have to activate the device. So, you have to go to Activation field :
        generate a random Device Adrress
        NwkSKey                         random value for 16-byte address
        AppSKey                         random value for 16-byte address
    
After the test (test_send_lora.py) purposed in **01-hardware/tests**, you have to paste the **file payload_format.js** into the LORAWAN FRAMES application decoder function so you can read the packets content in real time already decrypted.

# Usage 

Once these configuration and installation steps are completed successfully, we will be able to use the connected node autonomously. To do this, we invite you to go to **03-run** folder and read the **READ_RUN.md** document.

# Description of used pins

In this project, we will use :

    - Solar Pi Platter board for Pi Zero V1.3 by danjuliodesigns
    - Raspberry Pi Zero W v1.1
    - Waveshare Sensor hat extended shuttle board
    - Adafruit Lora Radio Bonnet with Oled - RFM95W @ 915MHz

## Solar Pi Platter board

The connectivity between the Solar Pi Platter and the Raspberry Pi Zero W is made with pogo pins, Pi Zero Power for the power and Pi Zero USB for the communication. Power is delivered to the Raspberry Pi Zero using a pair of pogo pins that contact test points on the bottom of the Pi PCB. Connection is made with the Pi’s host USB port via a pair of pogo pins that contact test points on the bottom of the Pi PCB.

## Adafruit LoRa Radio Bonnet

The LoRa Radio Bonnet will be directly plugged into the board (as it is an all-ensemble board) and will make use of :

**(for the radio module)**

    - RST : Radio reset pin, connected to GPIO25 on the Pi
    - CS : Radio SPI Chip Select pin, connected to SPI CE1 on the Pi
    - CLK : Radio SPI Clock pin, connected to SPI SCLK on the Pi
    - DI : Radio SPI data in pin, connected to SPI MOSI on the Pi
    - DO : Radio SPI data out pin, connected to SPI MISO on the Pi
    - DIO0 : Radio digital IO #0 pin, we use this for status or IRQs It's required for all our examples. Connected to GPIO 22 on the Pi.
    - DIO1 : Radio digital IO #1 pin, we use this for status. This is not used for our basic CircuitPython code, but is used by some more advanced libraries. You can cut this trace if you want to use the Pi pin for other devices. Connected to GPIO 23 on the Pi
    - DIO2 : Radio digital IO #2 pin, we use this for status. This is not used for our basic CircuitPython code, but is used by some more advanced libraries. You can cut this trace if you want to use the Pi pin for other devices. Connected to GPIO 24 on the Pi
    - DIO3 : Radio digital IO #3, not connected or used at this time.
    - DIO4 : Radio digital IO #3, not connected or used at this time.

**(for the oled)**

    - SCL is connected to SCL on the Pi.
    - SDA is connected to SDA on the Pi.

**(for the buttons)**

    - Button 1 : Connected to GPIO 5 on the Pi
    - Button 2 : Connected to GPIO 6 on the Pi
    - Button 3 : Connected to GPIO 12 on the Pi

#### LoRa Radio Bonnet breakout pinout

    RFM95W      GPIO       
    RST         25
    CS          7 (SPI CE1)
    CLK         11 (SPI SCLK)
    DI          10 (SPI MOSI)
    DO          9 (SPI MISO)
    DIO0        22
    DIO1        23
    DIO2        24
    DIO3        NC
    DIO4        NC
    SCL         3 (SCL)
    SDA         2 (SDA)
    Button1     5
    Button2     6
    Button3     12

## Waveshare Sensor Hat

This environment sensors module gives Raspberry Pi the ability to collect environmental data like temperature & humidity, air pressure, ambient light intensity, VOC, IR ray, UV ray.

#### Features

    - 40PIN GPIO, Compatible with all the Raspberry Pi Boards.
    - Onboard TSL25911FN digital ambient light sensor, for measuring IR and visible light.
    - Onboard BME280 sensor, for measuring temperature, humidity, and air pressure.
    - Onboard ICM20948 motion sensor, accelerometer, gyroscope, and magnetometer.
    - Onboard LTR390-UV-1 sensor, for measuring UV rays.
    - Onboard SGP40 sensor, for detecting ambient VOC.
    - I2C bus allows reading and displaying data by just using two wires.

#### Sensor breakout pinout

    Sensor      GPIO       
    VDD         2, 4
    GND         6, 9, 14, 20, 25, 30, 34, 39
    SCL         5 (SCL)
    SDA         3 (SDA)

#### Specifications

**TSL25911 digital ambient light sensor**
I2C address                             0x29
Effective range	                        0~88000Lux

**BME280 Temperature, Humidity, and Air pressure sensor**
I2C address	                            0x76
Temperature detection	                -40~85°C (0x01°C resolution, ±1°C accuracy)
Humidity detection	                    0~100%RG (0.008%RH resolution, ±3%RH accuracy, 1s response time, ≤2%RH delay)
Air pressure detection	                300~1100hPa (0x18Pa resolution, ±1hPa accuracy)

**ICM20948 Motion Sensor**
(9-DOF: 3-Axis accelerometer, 3-axis gyroscrope, 3-axis magne tometer)
I2C address	                            0x68
Accelerometer resolution	            16-bit
Accelerometer range (configurable)	    ±2, ±4, ±8, ±16g
Gyroscope resolution	16-bit
Gyroscope range (configurable)	        ±250, ±500, ±1000, ±2000°/sec
Magnetometer resolution	                16-bit
Magnetometer range	                    ±4900µT

**LTR390-UV-1 uv sensor**
I2C Address	                            0x53
Response wavelength	                    280nm - 430nm

**SGP40 VOC sensor**
I2C Address	                            0x60
Measuring range	                        0 ~ 1,000 ppm ethanol equivalent
Limit condition	                        <0.05 ppm ethanol equivalent OR < 10% preset concentration point (the larger one should prevail)
Response time	                        <10 s (tau 63%)
Start time	                            < 60s

# Documentation about talkpp/ppd drivers

This directory contains Raspbian utility software for the Solar Pi Platter board.

## talkpp

talkpp is a utility program to simplify communicating with the Solar Pi Platter board. It provides a simple command-line interface to allow the user to directly (or via scripts) send commands to the board and to easily manage the Real Time Clock.  

It can communicate with the board via either the pseudo-tty /dev/pi-platter if the ppd daemon is running or the actual hardware serial device associated with the board if ppd is not running.  It uses udev to automatically find the correct serial device for the board, independent of other USB serial devices.

### Dependencies install

Install of libudev - API for enumerating and introspecting local devices

    sudo apt-get update
    sudo apt-get install libudev-dev

### Manual install

Both the source and a binary compiled under Raspbian Jessie are included.  The binary can simply be downloaded and installed in /usr/local/bin.  The source is easily compiled in the directory containing the source file.

    gcc -o talkpp talkpp.c -ludev
    sudo cp talkpp /usr/local/bin
    sudo chmod 775 /usr/local/bin/talkpp

### Usage

talkpp takes the following arguments:

    talkpp [-c <command string>]

          [-s] [-t] [-f]

          [-a <alarm timespec>] [-d <delta seconds>] [-w]

          [-u | -h]


    -c <command string> : send the command string.  Command strings without an "=" character cause the utility to echo back a response.

    -s : Set the Device RTC with the current system clock
 
    -t : Get the time from the Device RTC and display it in a form useful to pass to "date" to set the system clock ("+%m%d%H%M%Y.%S")

    -f : Get the time from the Device RTC and display it in a readable form.

    -a <alarm timespec> : Set the Device wakeup value (does not enable the alarm).  <alarm timespec> is the alarm time in date time format ("+%m%d%H%M%Y.%S")

    -d <delta seconds> : Set the Device wakeup to <delta seconds> past the current Device RTC time value (does not enable the alarm)

    -w : Display the wakeup value in a readable form.

    -u, -h : Usage (and optional help)


Example command to Solar Pi Platter: `talkpp -c B`

Setting the Solar Pi Platter RTC from the Pi's RTC: `talkpp -s`

Setting the Pi's RTC from the Solar Pi Platter (using BASH): `sudo date $(talkpp -t)`

talkpp will echo responses from the Solar Pi Platter to stdout.  It will also echo the last warnings or error messages that has been sent.

## ppd

ppd is a daemon for the Solar Pi Platter.  It provides two main functions.  It will execute a controlled shutdown if the Solar Pi_Platter detects a critical battery voltage (and will power-down the entire system after [default] 30 seconds).  Since it opens the serial port associated with the Solar Pi Platter it also provides one or two mechanisms for other applications to communicate with the Solar Pi Platter.  It creates a pseudo-tty device named /dev/pi-platter which can be used just like the hardware serial port.  It also, optionally, can create a TCP port for applications like telnet to connect to.  

It is important that software not open the hardware serial port, /dev/ttyACM<n>, when ppd is running since it is using the port.

### Manual install

Both the source and a binary compiled under Raspbian Jessie are included.  The binary can simply be downloaded and installed in /usr/local/bin.  The source is easily compiled in the directory containing the source file.

    gcc -o ppd ppd.c -ludev
    sudo cp ppd /usr/local/bin
    sudo chmod 775 /usr/local/bin/ppd

### Usage

There are many ways to start a daemon, for example a configuration file in / or a script in /etc/init.d.  A very easy way to start it is to include it in /etc/rc.local.  For example, add the following before the "exit 0" at the end of /etc/rc.local (assuming you have placed the ppd executable in /usr/local/bin).

    /usr/local/bin/ppd -p 23000 -r -d &

It is also possible to create a conf file in /etc/init or a startup script in /etc/init.d.

ppd takes the following command line arguments:

    -d : Run as a daemon program (disconnecting from normal IO, etc).  ppd can be run as a traditional process without this argument.

    -p netport : Enable a TCP socket connection on the specified port.  This is required to enable socket communication with ppd.  Exclude this line to only enable /dev/pi-platter as a mechanism to communicate with the Solar Pi Platter.

    -m max-connections : Specify the maximum number of socket connections that can be made to the port specified with -p.  The default is 1.

    -r : Enable auto-restart on charge (set the Pi Platter "C7=1") after critical battery shutdown.

    -x debuglevel : Set the debug level (ppd uses the system logging facility.  0 is default (only log start-up).  Values of 1 - 3 include progressively more information.

    -h : Display usage and command line options.

This starts ppd with socket communication available on port 23000 and auto-restart in the event of a critical battery shutdown.



