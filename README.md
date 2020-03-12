# luci-app-homebridge
Used for setup Homebridge on Openwrt platform

Now only test on x86_64 platform

Thanks for [LEDE](https://github.com/coolsnowwolf/lede), [homebridge project](https://github.com/nfarina/homebridge) and [YinHangCode](https://github.com/YinHangCode)

# Pre-Requirements
  Openwrt must support Node module, and make sure have enough space to install node plugins.

# Get token
  If you want to use homebridge platform, at least you should know how to get token and ip of the hardware first.<br>
  If you don't know how to get them, check below guidance first:<br>
  [Token of devices](https://homekit.loli.ren/docs/show/12)

# Supported Devices
1. Mi Philips Light<br>
  MiPhilipsSmartBulb(米家飞利浦智睿球泡灯)<br>
  MiPhilipsTableLamp2(米家飞利浦智睿台灯二代)<br>
  MiPhilipsCeilingLamp(米家飞利浦智睿吸顶灯)<br>
2. Mi Outlet<br>
  MiPlugBase(米家智能插座基础版)<br>
  MiPlugBaseWithUSB(小米智能插座_USB版)<br>
  MiIntelligencePinboard(米家智能插线板)<br>
  MiQingPinboard(青米智能插线板_五孔位版)<br>
  MiQingPinboardWithUSB(青米智能插线板_USB版)<br>
  MiPlugBaseEnhanced(米家智能插座增强版)<br>
3. Mi Yeelight<br>
  ColorLEDBulb(Yeelight智能灯泡)<br>
  DeskLamp(Yeelight台灯)<br>
  ColorLedStrip(Yeelight彩光灯带)<br>
  CeilingLamp(Yeelight吸顶灯)<br>
  <br>
... others ing and I don't own all of these devices to test....

# Installation
  1. If you used for x86_64 platform, download the ipk and install with:
  >opkg install xxx.ipk
  
    If you used other platform, you may need to download the package and try to compile by yourself.
  2. click `Install` Button to check the environment, like node, node-gyp and npm.
  3. If all success, you can continue to configuration step.
  
# Configuration
  There are three kind of startup methods you can choose:
  1. `Main`, which will only start main service and use the configs which not indicate **Independent**, this will useful for the platform with few memories or cpu, but also you will face a problem:<br>
    **If one hardware met problems like couldn't connet to the local network, other hardware won't response well too, because of the architecture of homekit.**
  2. `Independent`, will start multiple homebridge services for every config indicate with **Independt** tag at the same time, and won't meet the problem mentioned above, but will use lots of memories and cpu, please check your hardware at thie model.
  3. `Main + Independent`, will also start multiple homebridge services for every config indicate with **Independent**, as for the configs that not tag will 'Independent' will run at the main service, you can think this as a combine of Main and Independent configs.
  
# Others
  If you meet problems, please feel free to ask.
  
  
  
  
  
  
