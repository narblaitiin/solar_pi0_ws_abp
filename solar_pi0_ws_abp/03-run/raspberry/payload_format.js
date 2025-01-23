function Decoder(bytes, port) {
    var decoded = {};
    decoded.Pressure = ((bytes[0] << 8) | bytes[1])/100
    if(bytes[2] === 0){
        decoded.Temperature = ((bytes[3] << 8) | bytes[4])/100
    }else{
        decoded.Temperature = (((bytes[3] << 8)| bytes[4]) * -1)/100
    }

    decoded.Humidity = ((bytes[5] << 8) | bytes[6])/100
    decoded.Luxmen = ((bytes[7] << 8) | bytes[8])/100
    decoded.UV = ((bytes[9] << 8) | bytes[10])/100
    return decoded;
  }
