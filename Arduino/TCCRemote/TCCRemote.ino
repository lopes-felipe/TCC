#include <IRremote.h>

#define DEBUG   0
#define RECEIVE 255

//--------------------------------------------------------------------------
// Variáveis
byte manufacturer = 0;
byte nbits = 0;
unsigned long command = 0;

int recievePin = 11;
bool receiving = false;

IRsend irsend;
IRrecv irrecv(recievePin);

void setup() 
{
  // A comunicação serial será feita em 9600 baud
  Serial.begin(9600);
}

void loop() 
{    
  //--------------------------------------------------------
  // Modo de leitura
  if (receiving)
  {    
    decode_results results;        // Somewhere to store the results
    readCommand(&results);
    
    return;
  }
  
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
  // Lê byte recebido
  byte data = Serial.read();

  #if DEBUG
  Serial.print("Received data: ");
  Serial.println(data);
  #endif

  //--------------------------------------------------------
  // Identifica o que representa o dado recebido
  if (manufacturer == 0)
  {
    if (data == RECEIVE)
    {  
      #if DEBUG
      Serial.println("Entering receive mode.");
      #endif
  
      irrecv.enableIRIn();  // Start the receiver
      irrecv.resume();      // Prepare for the next value
      receiving = true;
      
      return;
    }
    
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
  
  delay(10);
}

void sendCommand()
{
  #if DEBUG
  Serial.println("Sending command.");
  
  Serial.print("Manufacturer: ");
  Serial.println(manufacturer);
  
  Serial.print("Command: ");
  Serial.print(command, HEX);
  
  Serial.print(" (");
  Serial.print(nbits, DEC);
  Serial.println(")");
  #endif
    
  //--------------------------------------------------------
  // Envia comando  
  for (int i = 0; i < 3; i++) // Efetua loop de 3 iterações, para  aumentar a chance do comando ser recebido
  { 
    //--------------------------------------------------------
    // Identifica fabricante e envia no protocolo equivalente
    switch (manufacturer)
    {
      case RC5:     irsend.sendRC5(command, nbits);     break;   
      case RC6:     irsend.sendRC6(command, nbits);     break;  
      case NEC:     irsend.sendNEC(command, nbits);     break;  
      case SAMSUNG: irsend.sendSAMSUNG(command, nbits); break;  
      case LG:      irsend.sendLG(command, nbits);      break;  
      case DISH:    irsend.sendDISH(command, nbits);    break;  
    }
        
    delay(50);
  }
  
  #if DEBUG
  Serial.println("Command sent.");
  #endif
      
  //--------------------------------------------------------
  // Reseta dados de comando
  manufacturer = 0;
  nbits = 0;
  command = 0;
}

void readCommand(decode_results *results)
{
  if (irrecv.decode(results)) 
  {
    #if DEBUG
    Serial.println("IR data received.");
    #endif
    
    int len = results->bits / 8;
    byte data[len];
  
    unsigned long resultValue = 0;
    
    // Panasonic has an Address
    if (results->decode_type == PANASONIC) 
      resultValue = results->address;
    else
      resultValue = results->value;
  
    #if DEBUG
    Serial.print("Received data: ");
    Serial.print(resultValue, HEX);
    
    Serial.print(" (");
    Serial.print(results->bits, DEC);
    Serial.println(").");
    #endif
    
    for (int i = 0; i < len; i++)
      data[i] = (byte)(resultValue >> (i * 8));
      
    #if DEBUG
    dumpManufacturer(results);
    #endif

    Serial.write(results->decode_type);
    delay(50);

    #if DEBUG
    Serial.print("Sending ");
    Serial.print(len);
    Serial.println(" bytes through serial.");
    #endif

    Serial.write(results->bits);
    delay(50);
    
    for (int i = len - 1; i >= 0; i--)
    {
      Serial.write(data[i]);
      delay(50);
    }
    
    receiving = false;
    
    #if DEBUG
    Serial.println("Exiting receive mode.");
    #endif
  }
}

void dumpManufacturer(decode_results *results)
{
  Serial.print("Manufacturer: ");
  
  switch (results->decode_type) 
  {
    default:
    case UNKNOWN:      Serial.print("UNKNOWN");       break ;
    case NEC:          Serial.print("NEC");           break ;
    case SONY:         Serial.print("SONY");          break ;
    case RC5:          Serial.print("RC5");           break ;
    case RC6:          Serial.print("RC6");           break ;
    case DISH:         Serial.print("DISH");          break ;
    case SHARP:        Serial.print("SHARP");         break ;
    case JVC:          Serial.print("JVC");           break ;
    case SANYO:        Serial.print("SANYO");         break ;
    case MITSUBISHI:   Serial.print("MITSUBISHI");    break ;
    case SAMSUNG:      Serial.print("SAMSUNG");       break ;
    case LG:           Serial.print("LG");            break ;
    case WHYNTER:      Serial.print("WHYNTER");       break ;
    case AIWA_RC_T501: Serial.print("AIWA_RC_T501");  break ;
    case PANASONIC:    Serial.print("PANASONIC");     break ;
    case DENON:        Serial.print("Denon");         break ;
  }

  Serial.print(" (");
  Serial.print(results->decode_type);
  Serial.println(")");
}
