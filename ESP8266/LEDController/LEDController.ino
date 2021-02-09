#define FASTLED_ALLOW_INTERRUPTS 0

// using the ESP8266 nodemcu pin order
// without this the currently used pin 'D5' corresponds to GPIO pin '14' on an
// ESP8266 board
#define FASTLED_ESP8266_NODEMCU_PIN_ORDER
#include <FastLED.h>

#define NUM_LEDS 300
#define DATA_PIN 5
#define CHIPSET WS2812B
#define COLOR_ORDER GRB

#define DEFAULT_R 255
#define DEFAULT_G 255
#define DEFAULT_B 255

#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>
#include <ArduinoJson.h>

// this is where the HTML, CSS, and JavaScript for the webapp can be found
#include "index.h"

const char* ssid = "";
const char* password = "";

// LED
CRGB leds[NUM_LEDS];

// color pallet
CRGBPalette16 currentPalette;

// default pallet values
uint8_t paletteIndex = 0;
uint8_t brightness = 255;

bool animated = false;

ESP8266WebServer server(80);

void setup() {
    Serial.begin(115200);
    delay(300);

    // LED setup
    FastLED.addLeds<CHIPSET, DATA_PIN, COLOR_ORDER>(leds, NUM_LEDS);
    FastLED.setBrightness(50);

    // setting the default color on boot
    LEDColor(DEFAULT_R, DEFAULT_G, DEFAULT_B);

    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    }
    
    // home page
    server.on("/", home);

    // server endpoints for HTTP POST requests
    server.on("/set-solid-color", setSolidColor);
    server.on("/set-gradient-color", setGradientColor);

    server.begin();
}
void loop() {
    Serial.println("server running ...");
    server.handleClient();

    if (animated){
        fill_palette(leds,
                     NUM_LEDS,
                     paletteIndex,
                     1,
                     currentPalette,
                     brightness,
                     LINEARBLEND);

        EVERY_N_MILLISECONDS(10){
            Serial.println(paletteIndex);
            paletteIndex++;
        }

        FastLED.show();
    }
}

void home() {
    server.send(200, "text/html", indexHTML); 
}

/*
handle color change request
@return void
*/
void setSolidColor() {
    server.sendHeader("Access-Control-Allow-Origin", "*");

    // solid colors are not animated
    animated = false;

    if (server.hasArg("plain")){
        DynamicJsonDocument doc(1024);
        deserializeJson(doc, server.arg("plain"));
        JsonObject body = doc.as<JsonObject>();

        int r = body[String("r")];
        int g = body[String("g")];
        int b = body[String("b")];

        LEDColor(r,g,b);
        server.send(200);
    }
    else{
        server.send(400);
    }
}

/*
handle gradient color change request
@return void
*/
void setGradientColor(){
    server.sendHeader("Access-Control-Allow-Origin", "*");

    if (server.hasArg("plain")){
        DynamicJsonDocument doc(1024);
        deserializeJson(doc, server.arg("plain"));
        JsonObject body = doc.as<JsonObject>();

        LEDGradient(body);
        server.send(200);
    }
    else{
        server.send(400);
    }
}

/*
handle page not found
@return void
*/
void handle_NotFound(){
  server.send(404, "text/plain", "Not found");
}

/*
set LED strip color for the entire strip
@param r integer red value (min: 0, max:255)
@param g integer green value (min: 0, max:255)
@param b integer blue value (min: 0, max:255)
*/
void LEDColor(int r, int g,int b){
    fill_solid(leds, NUM_LEDS, CRGB(r,g,b));
    FastLED.show();
}

/*
set LED gradient color, brightnes, and animation
@param gradient the JsonObject containing the gradient information
*/
void LEDGradient(JsonObject gradient){
    // each gradient index has 4 values
    // 1) the index itself
    // 2) the red value
    // 3) the green value
    // 4) the blue value

    int values = 4;
    int gradientSize = gradient["gradient"].size();
    int numOfIndex = gradientSize * values;
    int maxPaletteIndex = 255;
    
    animated = gradient["animated"];
    brightness = gradient["brightness"];

    typedef unsigned char byte;
    byte bytes[numOfIndex];

    int indexNum = 0;
    for (int j = 0; j < gradientSize; j++){
        for (int k = 0; k < values; k++){
            bytes[indexNum] = gradient["gradient"][j][k];
            indexNum ++;
        }
    }

    // update pallet with gradient info
    currentPalette.loadDynamicGradientPalette(bytes);
    
    fill_palette(leds,
                 NUM_LEDS,
                 paletteIndex,
                 1,currentPalette,
                 brightness,
                 LINEARBLEND);

    FastLED.show();
}
