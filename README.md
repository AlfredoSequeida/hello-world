[Check out the video!](https://youtube.com/alfredosequeida)

# Hello world!
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

This is a 3d printed "hello world!" sign powered by the L0L1n/NodeMCU V3 board, which hosts the ESP8266E board. All of the code, schematics, openSCAD (3D model), and mechanical drawings for the project are open-source for you to modify however you want.

## The model
The model for this design was made using openSCAD. Each letter is meant to be printed individually and then glued together. Because of this, each letter has been split into a module in the openSCAD code. Each letter is between 59.9mm and 205.10mm in length, 184.10mm and 193.3mm in width and 50mm in height in horizontal (laying down) orientation. This model was built with the thought in mind of mounting the letters on a wall, which is why 4 of the letters ("h", "o1", "w", "!", where a letter followed by an integer defines the letter in position to the whole phrase "hello world". Making "o1" the first "o" in "hello") have holes for a screw or nail. With that said, with the letters mounted on the wall split into two rows of the words "hello" and "world!", this entire sign measures a maximum of 790.5mm X 384.2mm X 50 mm (l X w X h) with the letters standing up mounted on a wall.

Every model also has an insert, which is a very thin copy of the letter with half the laying down height which serves as both a cover and a light defuser for the LEDs:

![Insert Demo](https://i.imgur.com/LD4Ne2f.gif)

The inserts fit snug into the letters with a 0.5mm gap, however, you might want to use some sandpaper or a file to create a little more room for letters like the "e", "o", and "d", which have center cutouts since those parts might be a bit more difficult to fit easily.

## Modifying the model
If you want to change the size of the model, this can easily be achieved by changing the attributes at the top of the openSCAD code. All of the measurements are unitless, but mm should be used as those are the units used to measure the electrical components.

`font_size`: The size of the font.

`height`: The height/depth of the model laying down +10mm, so 40mm makes the depth 50mm.

`wall`: The thickness of the walls -5mm, so 10mm makes the walls 5mm thick.

If the size is adjusted, the position of the LED pass through-holes should be modified as well. The same applies to the horizontal and vertical positions of the letters (`h_x`, `w_y`, etc).

The strange adding and subtracting of magical numbers in the measurements is due to the way the walls were created with [openSCAD'S Minkowski method](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Transformations#minkowski).

## Printing the model
In the build for the video, this model was printed using a [Creality Ender3 V2](https://www.amazon.com/Creality-Meanwell-Motherboard-Carborundum-Platform/dp/B08D65ZH5W) with an extruder temperature of 225°C and base temperature of 70°C. Using 5% infill with a wall height of 0.28mm using white Inland PLA+. Each Letter took a maximum of 13 hours to print and each insert took about 2.5 hours to print.

## The Parts used
The following parts (electrical components) were used for this build:
- (3) [WS2812B LED Strip 5m 60leds/m](https://www.amazon.com/BTF-LIGHTING-Flexible-Individually-Addressable-Non-waterproof/dp/B01CDTEJBG)
- (1) [LOL1n/NodeMCU V3 (ESP8266E) board](https://www.amazon.com/HiLetgo-Internet-Development-Wireless-Micropython/dp/B010N1SPRK)
- (1) [LM2596S DC-DC 3A Buck Adjustable Step-down Power Supply Converter Module](https://www.amazon.com/Adjustable-Converter-1-5-35v-Efficiency-Regulator/dp/B07QKHR6PY) Used to step down the voltage to 5V if using a power supply larger than 5V.
- (1) [DC Female adapter](https://www.amazon.com/Ksmile®-Female-2-1x5-5mm-Adapter-Connector/dp/B015OCV5Y8)
- (1) [300 - 500 ohm resistor or combination of resistors to make the needed sum](https://www.amazon.com/Elegoo-Values-Resistor-Assortment-Compliant/dp/B072BL2VX1) To protect the first LED when controlling the strip.
- Wire, soldering iron, solder, shrink tube, and connectors to put everything together. With the exception of the wiring, the other parts are optional but recommended.

Included in the assets directory are SVG [schematics](https://github.com/AlfredoSequeida/hello-world/blob/main/assets/schematics.svg) for putting the parts together and [mechanical drawings](https://github.com/AlfredoSequeida/hello-world/blob/main/assets/mechanical_drawings.svg) for the parts. Since they are SVG files, you can open them using a vector editing program like [inkscape](https://inkscape.org/) or a modern web browser and zoom in very close without losing detail.

## The software
The software is controlled via the web interface hosted by the server on the ESP8266 board. To get the software on the board, it needs to be compiled and uploaded to the board using the [Arduino IDE](https://github.com/arduino/Arduino) or [arduino-cli](https://github.com/arduino/arduino-cli). To do this, you must install the [ESP8266 core for Arduino](https://github.com/esp8266/Arduino) and these other dependencies not included with the ESP8266 core:

- [ArduinoJson](https://github.com/bblanchon/ArduinoJson): Used for handling the data sent via HTTP from the web application.
- [FastLED](https://github.com/FastLED/FastLED) : Used to control the LED strip.

The code should also be modified using your local network's (WiFi) AP name and password. This can be set by modifying the character pointers `const char* ssid` and `const char* password`.

Then the LEDs can be controlled using the web interface accessible using a web browser using the IP address of the ESP8266 board after it has been connected to your network.

## The web interface
![Web Interface Demo](https://i.imgur.com/F5wZiuN.gif)

The web interface is how you can control the LED colors, gradients, and animations of the LEDs. The interface is pretty self-explanatory, however, some of the logic behind it might be useful to explain for modification purposes. All of the HTML, CSS, and JavaScript for the web app can be found in the [index.h](https://github.com/AlfredoSequeida/hello-world/blob/main/ESP8266/LEDController/index.h) file.

The gradients used for the lights are dynamically created at run time and are made using the CSS linear-gradient() function. This makes it easy to create gradients using CSS instead of using FastLED's method for creating gradients. The conversion to something FastLED can understand is handled using JavaScript and then sent over an HTTP POST request to the server as a JSON object with the following format to the `/set-gradient-color` endpoint.

```
{
   "gradient":[
      [
         0,
         255,
         0,
         0
      ],
      [
         255,
         0,
         0,
         255
      ]
   ],
   "brightness":255,
   "animated":true
}
```

`gradient`: Array of arrays containing FastLED formatted gradient.

`brightness` : Integer containing FastLED formatter brightness value.

`animated`: Boolean value declaring if the gradient should be animated or not.

Thank you to Simon R. for his open-source project [pickr](https://github.com/Simonwep/pickr), which provides the color picker for the web app.

## Other notes
The wiring can be made a lot cleaner by rerouting the DC power input to the "W", where all of the electronic components are mounted. However, for my purposes, the exclamation point made a better location for the power input.

You can also use other LED strips, however, the software will need to be modified, and the [chipset must be supported by FastLED](https://github.com/FastLED/FastLED/wiki/Overview#chipsets). Note that the LEDs used in this project were used because they are individually addressable meaning that each LED can be controlled independently of the others, making it possible to create moving animations and gradients with the LEDs.

The font used for the model is [Nooble Wooble](https://www.dafont.com/nooble-wooble.font)

DISCLAIMER: Links included might be affiliate links. If you purchase a product with the links that I provide, I may receive a small commission. There is no additional charge to you!