local ucursor = require "luci.model.uci".cursor()
local json = require "luci.jsonc"

local h_interface = ucursor:get("homebridge", "@homebridge[0]", "interface")

local platform_section=arg[1]

local platform_info = ucursor:get_all("homebridge", platform_section)

local device_type
if platform_info.platform_type == "ReYeelightPlatform" then
device_type = platform_info.platform_yeelight
end
if platform_info.platform_type == "MiPhilipsLightPlatform" then
device_type = platform_info.platform_philips_light
end
if platform_info.platform_type == "MiOutletPlatform" then
device_type = platform_info.platform_mi_plug
end

local platform = {
	mdns = {
		interface = h_interface 
},
	bridge = {
		name=platform_info.name,
		username=platform_info.username,
		port=tonumber(platform_info.port),
		pin=platform_info.pin
},
	accessories = {
},
	platforms = {{
		platform = platform_info.platform_type,
		deviceCfgs = {{
			type = device_type,
			ip = platform_info.ip,
			token = platform_info.token
}}
}}

}

if platform_info.platform_type == "ReYeelightPlatform" then
platform.platforms[1].deviceCfgs[1]["Name"] = platform_info.alias
platform.platforms[1].deviceCfgs[1]["updatetimer"] = (platform_info.updatetimer == "1")
platform.platforms[1].deviceCfgs[1]["interval"] = tonumber(platform_info.interval)
end

if platform_info.platform_type == "MiPhilipsLightPlatform" then
	
	if platform_info.platform_philips_light == "MiPhilipsCeilingLamp" or platform_info.platform_philips_light == "MiPhilipsSmartBulb" then
	platform.platforms[1].deviceCfgs[1]["lightName"] = platform_info.alias
	platform.platforms[1].deviceCfgs[1]["lightDisable"] = false
	end

	if platform_info.platform_philips_light == "MiPhilipsCeilingLamp" then
	platform.platforms[1].deviceCfgs[1]["updatetimer"] = (platform_info.updatetimer == "1") 
	platform.platforms[1].deviceCfgs[1]["interval"] = tonumber(platform_info.interval) 
	end 

	if platform_info.platform_philips_light == "MiPhilipsTableLamp2" then
	platform.platforms[1].deviceCfgs[1]["mainLightName"] = platform_info.main_light_name
	platform.platforms[1].deviceCfgs[1]["secondLightName"] = platform_info.second_light_name
	platform.platforms[1].deviceCfgs[1]["secondLightDisable"] = platform_info.second_light_disable == "1"
	platform.platforms[1].deviceCfgs[1]["eyecareSwitchName"] = platform_info.eyecare_switch_name
	platform.platforms[1].deviceCfgs[1]["eyecareSwitchDisable"] = platform_info.eyecare_switch_disable == "1"
	end
end

if platform_info.platform_type == "MiOutletPlatform" then
platform.platforms[1].deviceCfgs[1]["outletName"] = platform_info.alias
platform.platforms[1].deviceCfgs[1]["outletDisable"] = platform_info.outlet_disable == "1"
platform.platforms[1].deviceCfgs[1]["temperatureName"] = platform_info.temperature_name
platform.platforms[1].deviceCfgs[1]["temperatureDisable"] = platform_info.temperature_disable

	if platform_info.platform_mi_plug == "MiPlugBase" or platform_info.platform_mi_plug == "MiIntelligencePinboard" then
		platform.platforms[1].deviceCfgs[1]["switchLEDName"] = platform_info.switch_LED_name
		platform.platforms[1].deviceCfgs[1]["switchLEDDisable"] = platform_info.switch_LED_disable == "1"
	end
	if platform_info.platform_mi_plug == "MiPlugBaseWithUSB" then
		platform.platforms[1].deviceCfgs[1]["switchUSBName"] = platform_info.switch_USB_name
		platform.platforms[1].deviceCfgs[1]["switchUSBDisable"] = platform_info.switch_USB_disable == "1"
	end

end

print(json.stringify(platform, 1))
