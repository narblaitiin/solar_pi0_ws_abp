#! /usr/bin/env python3
# solar_pi0_ws install requirements
# version 1.0 - 19/10/20
# version 1.1 - 26/10/21 (bug fixes of talkpp and ppd path install)
# version 1.2 - 18/11/21 ()
# version 1.3 - 21/07/22 (add commands to disable BLE, HDMI and LED) 
# version 1.4 - 04/11/22 (change talkpp directory)
# version 1.5 - 12/12/22 (add stress packets for CPU testing)
# version 1.6 - 16/12/22 (display current CPU load and CPU temperature)
# version 1.7 - 05/01/23 (change Stress Terminal UI install)
# version 1.8 - 20/01/23 (activate UART)

if [ "$EUID" -ne 0 ]
  then echo "Please this script needs for root authorisations, execute it as root."
  exit
  
fi

wget --spider --quiet http://google.com
if [ "$?" != 0 ]
  then echo "Not internet connection detected, may connect to internet to run this script"
  exit
fi

# raspbian repository update
sudo apt-get update

# talkpp and ppd firmwares install
sudo apt-get install libudev-dev
cd ../solar_pi0_ws_abp/02-configuration/talkpp
gcc -o talkpp talkpp.c -ludev
sudo mv talkpp /usr/local/bin
gcc -o ppd ppd.c -ludev
sudo mv ppd /usr/local/bin
cd ../..

# python install and dependencies
sudo apt-get install -y python3-pip python3-dev i2c-tools python3-smbus python3-spidev python3-setuptools python3-rpi.gpio
sudo pip3 install python-dotenv

# packets to test RPi CPU for stress testing
sudo apt-get -y install stress s-tui

# LoRa Bonnet dependencies 
sudo pip3 install adafruit-circuitpython-ssd1306
sudo pip3 install adafruit-circuitpython-framebuf
sudo pip3 install adafruit-circuitpython-rfm9x
sudo pip3 install adafruit-circuitpython-tinylora

# Waveshare Sensor Hat dependencies
sudo apt-get install python3-smbus
sudo -H apt-get install python3-pil
sudo apt-get install i2c-tools

# activate I2C ports
echo "i2c-dev" >> /etc/modules
echo "i2c-bcm2835" >> /etc/modules
echo "dtparam=i2c_arm=on" >> /boot/config.txt
echo "dtparam=i2c1=on" >> /boot/config.txt
echo "dtparam=i2s=on" >> /boot/config.txt

# activate SPI interface
echo "dtparam=spi=on" >> /boot/config.txt

# activate UART
enable_uart=1
console=serial0

# disable BLE
echo "dtoverlay=disable-bt" >> /boot/config.txt

# disable HDMI output
echo "/usr/bin/tvservice -o" >> /etc/rc.local

# disable LED
#echo "dtparam=act_led_trigger=none" >> /boot/config.txt
#echo "dtparam=act_led_activelow=off" >> /boot/config.txt

sudo reboot