#include <IRremote.h>

IRsend irsend;

#define DEBUG

//--------------------------------------------------------------------------
// Manufacturers (1-9)
#define SAMSUNG 1
#define LG      2

//--------------------------------------------------------------------------
// Commands (10-254)
#define POWER       10
#define VOLUMEUP    11
#define VOLUMEDOWN  12
#define CHANNELUP   12
#define CHANNELDOWN 12

void setup()
{
  Serial.begin(9600);   // Status message will be sent to PC at 9600 baud
}

void loop() 
{
  // Verifica se recebeu algum dado na porta serial (módulo Bluetooth). Caso não tenha recebido, sai do método
  if (Serial.available() == 0)
    return;
    
  byte manufacturer = Serial.read(); // Lê byte relativo ao fabricante
  delay(1000);
  
  #ifdef DEBUG
  Serial.print("Manufacturer: ");
  Serial.println(manufacturer);
  #endif
  
  byte command = Serial.read(); // Lê byte relativo ao comando a ser enviado ao dispositivo
  delay(1000);
  
  #ifdef DEBUG
  Serial.print("Command: ");
  Serial.println(command);
  #endif
  
  // Efetua loop de 3 iterações, para  aumentar a chance do comando ser recebido
  for (int i = 0; i < 3; i++) 
  { 
    // Identifica fabricante do aparelhos
    if (manufacturer == SAMSUNG)
      sendSamsungCommand(command);
    else if (manufacturer == LG)
      sendLG(command);

    delay(50);
  }
}

void sendSamsungCommand(byte command)
{
  if (command == POWER)
    sendSamsung(0xE0E040BF, 32, "Power");
  else if (command == VOLUMEUP)
    sendSamsung(0xE0E0E01F, 32, "Volume Up");
  else if (command == VOLUMEDOWN)
    sendSamsung(0xE0E0D02F, 32, "Volume Down");  
  else if (command == CHANNELUP)
    sendSamsung(0xE0E048B7, 32, "Channel Up");  
  else if (command == CHANNELDOWN)
    sendSamsung(0xE0E008F7, 32, "Channel Down");  
}

void sendSamsung(unsigned long data,  int nbits, String command)
{
    #ifdef DEBUG
    Serial.print("Sending " + command + " command (");
    Serial.print(data, HEX);
    Serial.print(nbits);
    Serial.println(") to Samsung manufacturer.");
    #endif
    
    irsend.sendSAMSUNG(data, nbits);  
}

void sendLG(byte command)
{
  // TODO: Implementar comandos LG  
}
