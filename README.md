# 1 summary
Share your Android phone's Wi-Fi conneciton with your Windows desktop! Probably 2.4G+5G networking (on any recent-ish phone), charges phone, and is totally free. Enjoy!

# 2.1 prerequisites
- You run this on a Windows desktop (or laptop with a broken wifi card)
- Windows device has Android ADB drivers installed (very easy to install with [15 seconds ADB installer](https://forum.xda-developers.com/showthread.php?t=2588979)
- Android device has USB debugging enabled (in developer settings - Google this if you're unsure)
- Android device supports USB tethering of Wi-Fi signal

# 2.2 using this tool
1) change ADB_DEVICE_CODE to your device's ADB ID, e.g. 8kwi279l2748. You can get this ID by running "adb devices" (without the double quotation marks) in a command prompt (cmd.exe). This means the script will only try to run for your phone specifically
2) change ANDROID_PIN_CODE to match your Android device's password/PIN
3.1) place the script in your startup folder (You can find this with Win+R "shell:startup")
3.2) you can have the script launched as minimized by placing a shortcut to it in your startup folder, and change the property "Run:" to "Minimized"

# 3 issues
- Non-stock flavours of Android may not interpret the ADB commands as expected (please give me feedback, and I'll try to work around this if that's the case!)
- Android might automatically try to enable USB-tethering back upon a 2nd USB connection event (not sure about this)
- You have to use a PIN or password... and you have to enter this in plaintext to this script
- It might be possible for people to 1) spoof your ADB device code, 2) plug their phone into your PC, 3) activate tethering on their phone (they'd probably have to know you very personally for this to be any kind of vulnerability..?)

# I AM NOT RESPONSIBLE FOR YOU USING ALL YOUR MOBILE DATA BY ACCIDENT! YOU SHOULD VERIFY THAT YOU ARE INDEED USING WI-FI DATA, NOT MOBILE DATA!
