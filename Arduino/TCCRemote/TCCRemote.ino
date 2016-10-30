#include <IRremote.h>
IRsend irsend;

#define DEBUG

//--------------------------------------------------------------------------
// Manufacturers
//#define SAMSUNG 1
//#define LG      2
#define RECEIVE 255

//--------------------------------------------------------------------------
// Variáveis
byte manufacturer = 0;
byte nbits = 0;
unsigned long command = 0;

int recievePin = 11;
IRrecv irrecv(recievePin);

void setup() {
  // A comunicação serial será feita em 9600 baud
  Serial.begin(9600);

}

void loop() 
{  
  //--------------------------------------------------------
  // Valida se recebeu algum dado
  if (Serial.available() == 0)
  {
    if (command == 0)
      return; // Não foi recebido nenhum dado e não há comando à ser enviado

    //--------------------------------------------------------
    // Envia comando
    sendCommand();      
    return;
  }

  //--------------------------------------------------------
  // Lê dado recebido
  readData();
}

void readData()
{
  //--------------------------------------------------------
  // Lê byte da porta Serial
  byte data = Serial.read();
  Serial.println(data);

  //--------------------------------------------------------
  // Identifica o que representa o dado recebido
  if (manufacturer == 0)
  {
    manufacturer = data;
    return;
  }
  else if (nbits == 0)
  {
    nbits = data;
    return;  
  }
  
  //--------------------------------------------------------
  // Soma dado recebido com comando atual
  command = command<<8;
  command |= data;

  Serial.println(command);
  delay(10);
}

void sendCommand()
{
  //--------------------------------------------------------
  // Envia comando  
  for (int i = 0; i < 3; i++) // Efetua loop de 3 iterações, para  aumentar a chance do comando ser recebido
  { 
    //--------------------------------------------------------
    // Identifica fabricante e envia no protocolo equivalente
    switch (manufacturer)
    {
      case RC5:           irsend.sendRC5(command, nbits);           break;   
      case RC6:           irsend.sendRC6(command, nbits);           break;  
      case NEC:           irsend.sendNEC(command, nbits);           break;  
      //case SONY:          irsend.sendSONY(command, nbits);          break;  
      //case PANASONIC:     irsend.sendPANASONIC(command, nbits);     break;  
      //case JVC:           irsend.sendJVC(command, nbits);           break;  
      case SAMSUNG:       irsend.sendSAMSUNG(command, nbits);       break;  
      //case WHYNTER:       irsend.sendWHYNTER(command, nbits);       break;  
      //case AIWA_RC_T501:  irsend.sendAIWA_RC_T501(command, nbits);  break;  
      case LG:            irsend.sendLG(command, nbits);            break;  
      //case SANYO:         irsend.sendSANYO(command, nbits);         break;  
      //case MITSUBISHI:    irsend.sendMITSUBISHI(command, nbits);    break;  
      case DISH:          irsend.sendDISH(command, nbits);          break;  
      //case SHARP:         irsend.sendSHARP(command, nbits);         break;  
      //case DENON:         irsend.sendDENON(command, nbits);         break;  
      //case PRONTO:        irsend.sendPRONTO(command, nbits);        break;  
      //case LEGO_PF:       irsend.sendLEGO_PF(command, nbits);       break;  
    }
        
    delay(50);
  }
      
  //--------------------------------------------------------
  // Reseta dados de comando
  manufacturer = 0;
  nbits = 0;
  command = 0;
}
