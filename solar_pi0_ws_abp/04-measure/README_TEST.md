# Description of Solar Pi Platter Test Files
In this folder, we will find different codes in order to test battery/solar panel performance in different operating modes. In fact, we will improve a strategy of battery optimization in order to have a full autonomous node.

## talkpp_py.py
This pyhton code is a communication driver between Pi Platter board and RPi zero.

## meas_batt.sh
This shell script allows you to sent command to Pi Platter board in order to know battery level and write results in a text file (batt.txt). Command line to allow different services like BLE, HDMI, LED and so on should be add to know more accurently the consumption of RPi zero.

## meas_rfm9x.py
This python code allows you to test the different operating mode of the RFM95 chipset and the different configuration of Lora protocol like, spreading factor, power transmit, data rate...

## plot_data.m
Matlab script to plot battery voltage value from text file (batt.txt). A data model explicitly describes a relationship between predictor and response variables. Linear regression fits a data model that is linear in the model coefficients. The most common type of linear regression is a least-squares fit, which can fit both lines and polynomials, among other linear models. Before you model the relationship between pairs of quantities, it is a good idea to perform correlation analysis to establish if a linear relationship exists between these quantities. So, a linear regression has been added into each plot.

## plutoSDR_demod_sig
Matlab script to plot a transmitted packet from antenna. Adalm-Pluto SDR is the ideal learning tool/module for radio frequency (RF), software defined radio (SDR), and wireless communications. Each ADALM-PLUTO is capable of full duplex transmit and receive capabilities and comes with two GSM antennas, covering 824-894 MHz and 1710-2170 MHz. Each unit comes with one 15 cm SMA cable for RF loopback, and is powered via USB. The self-contained RF learning module is supported by MATLAB and Simulink system objects; GNU Radio sink and source blocks, libiio, a library with C, C++, C#, and Python bindings. For more information : https://wiki.analog.com/university/tools/pluto
