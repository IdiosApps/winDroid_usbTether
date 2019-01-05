# Get powershell to listen for USB device changes
Register-WmiEvent -Class win32_DeviceChangeEvent -SourceIdentifier deviceChange
do { # huge do-while loop to keep USB detection alive
    $newEvent = Wait-Event -SourceIdentifier deviceChange
    $eventType = $newEvent.SourceEventArgs.NewEvent.EventType
    $eventTypeName = switch($eventType)
    {
        1 {"Configuration changed"}
    }
    if ($eventType -eq 1){
        # a USB device has been inserted - let's see if it's our Android device
        timeout -t 5 # give adb daemon a little time to initialise
        $pluggedInCheck = Invoke-Expression "cmd /c adb devices | out-string"
        if ($pluggedInCheck.Contains('ADB_DEVICE_CODE')) { ### USE YOUR DEVICE'S ADB HERE (run "adb devices" in a command prompt to get this - requires adb drivers)
            # when phone is plugged in, check if we have internet
            $pingTest = Invoke-Expression "cmd /c ping 1.1.1.1 -n 1 | out-string"
            if ($pingTest.Contains("PING: transmit failed")) {
                # we don't have internet, so let's enable USB tethering
                # first, let's unlock
                adb shell input keyevent KEYCODE_WAKEUP
                adb shell input touchscreen swipe 1 479 1 0
                adb shell input text ANDROID_PIN_CODE ### CHANGE THIS TO YOUR PHONE'S PIN
                adb shell input keyevent 66
                adb shell am force-stop com.android.settings

                # then, let's enable USB tethering
                adb shell am start -a android.intent.action.MAIN -n com.android.settings/.TetherSettings
                timeout -t 1
                adb shell input keyevent 19
                timeout -t 1
                adb shell input keyevent 20
                timeout -t 1
                adb shell input keyevent 66
                timeout -t 1
                adb shell input keyevent 3
                adb shell input keyevent 26
                timeout -t 15
            }
        }
    }   
Remove-Event -SourceIdentifier deviceChange
} while (1-eq1) #Loop until next event
Unregister-Event -SourceIdentifier deviceChange