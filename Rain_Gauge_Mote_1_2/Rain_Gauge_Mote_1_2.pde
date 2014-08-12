// Waspmote Pro V1.2 
// Save The Rain Project:
// Rain Gauge v1.2
// By: Kyle Nucera
// kjnucera@syr.edu

// Includes the Necessary Libraries 
#include <WaspXBeeDM.h>
#include <myLibrary.h>
#include <WaspFrame.h>

// Change to false to disable debugging. Vise-Versa is true.
bool debug_Mode = true;

// Gateway Mac Addresses ( Wireless Communication )
char* MAC_ADDRESS="0013A20040794BAD"; // new meshlium
//char* MAC_ADDRESS="0013A20040788EE2"; // kyle's usb gateway
//char* MAC_ADDRESS="0013A20040676BE0"; // Nick's USB gateway

// Address of I2C Pressure Transducer
int I2C_ADDRESS1 = 40; // Address 0x28
int I2C_ADDRESS2 = 72; // Address 0x48
int I2C_ADDRESS3 = 88; // Address 0x58
int I2C_ADDRESS4 = 104; //Address 0x68

//Global Names for the location we're sending from
char* loc_0 = "Link+";
char* loc_1 = "Waverly_RG";
char* loc_3 = "Bird_HN_W";


void setup() {
  RainGauge.set_Debug(debug_Mode);
  RainGauge.Init();
  // Setting time [yy:mm:dd:dow:hh:mm:ss]
  RTC.setTime("14:08:09:07:10:37:00");
  if (debug_Mode)
    USB.print(F("Setting time"));
}

void loop() {
  // 3.3VDC Power
  double threeVolt = 3.3;
  PWR.setSensorPower(SENS_3V3,SENS_ON); 
  //5VDC Power
  //double fiveVolt = 5;
  PWR.setSensorPower(SENS_5V,SENS_ON); 
  /////////////////////////////////////////////////////////////  
  // 0. Declarations
  /////////////////////////////////////////////////////////////
  char convertFloat[10];
  char combVal[7] = "000000";
  char temp[5] = "0000";
  int error = 0;
  /////////////////////////////////////////////////////////////
  // 1. Getting Inputs
  /////////////////////////////////////////////////////////////
  //analog voltage between 0 - 3.3v (MAXBOTIX)
  RainGauge.read_Analog(convertFloat, threeVolt);
  delay(500);
  //PWR.setWatchdog( WTD_ON, WTD_8S);
  
  // Read I2C Device
  //RainGauge.read_Pressure(combVal, temp, I2C_ADDRESS2);
  
  //  PWR.setWatchdog( WTD_OFF, WTD_8S);
  //  if( intFlag & WTD_INT )
  //  {
  //    Wire.close(); 
  //    delay(500);
  //    Wire.begin();
  //  }
  //  clearIntFlag();
  //  PWR.clearInterruptionPin(); 
  
  /////////////////////////////////////////////////////////////
  // 2. Send to Gateway
  /////////////////////////////////////////////////////////////
  // myObject.send2mesh(convertFloat,combVal, temp, MAC_ADDRESS);
  RainGauge.send_Frame(convertFloat,loc_1, MAC_ADDRESS);
  delay(1000);
  //RainGauge.send_Frame(temp,loc_1, MAC_ADDRESS);
  delay(1000);
  RainGauge.send_Batt(MAC_ADDRESS, loc_1);
  delay(500);
  /////////////////////////////////////////////////////////////
  // 3. Write to SD card only if the gateway is unavailable
  /////////////////////////////////////////////////////////////
  RainGauge.write_SD(convertFloat,combVal, temp, loc_1);
  //frame.showFrame();
  /////////////////////////////////////////////////////////////
  // 4. Sleep For Fifteen Minutes
  /////////////////////////////////////////////////////////////
  // Days:Hours:Minutes:Seconds
  PWR.deepSleep("00:00:05:00",RTC_OFFSET,RTC_ALM1_MODE1,SENS_OFF);
  delay(2000);
  xbeeDM.ON();
}


