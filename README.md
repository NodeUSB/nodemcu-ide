# nodemcu-ide
Browser based Lua IDE for ESP8266 SoC based boards

### How to get started (NodeUSB users go to step 6)
1. You need NodeMCU firmware with node.compile() (2015-02-13 and late)

2. If you do not have it, download the firmware from:
https://github.com/nodemcu/nodemcu-firmware/tree/master/pre_build

3. Flash the ESP8266 using nodemcu-flasher:
https://github.com/nodemcu/nodemcu-flasher

4. Upload the init.lua to ESP8266:
https://github.com/NodeUSB/nodemcu-ide/blob/master/init.lua

5. Run init.lua, it will download all the files needed and compile the codes

6. Go to: http://i.nodeusb.com

### Tips
* Only works if ESP8266 is in the same network
* ESP8266 is very memory constrained, use 'Save&Compile' before run Lua codes will use less heap
* Read large file is slow, can takes 10-30 seconds, be patient
* Reboot ESP8266 if no response, or power cycle it
* Due to very limited heap size,I have to use lots of hacks to reduce the heap used,for example,it is very difficult to upload large block of codes to ESP8266 using http post, if I use multi parts, the i.lua in ESP8266 will use more memory, I ended up to let IDE upload to my server's memcache first, then i.lua download from my server, so if you see any funny codes, do let me know.
* Due to the reason above, i.lua is not secure, you can POST lua codes and it will them, please keep that in mind.
