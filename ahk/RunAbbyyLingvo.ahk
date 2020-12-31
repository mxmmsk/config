; Starts Abbyy Lingvo window

RunLingvo() {
  Run, "C:\Program Files (x86)\ABBYY Lingvo x6\Lingvo.exe"
}

catch_f11 := true

#If catch_f11
^F11::  ; Default hotkey is Ctrl+F11+F11

  ; Wait for key up
  KeyWait, F11
  ; Wait for F11 down again for 400 ms
  KeyWait, F11, D T0.4
  If (ErrorLevel == 1) {
    ; MsgBox Pressed Ctrl+F11
    catch_f11 := false
    SendInput ^{F11}
    catch_f11 := true
  } Else {
    ; MsgBox Pressed Ctrl+F11+F11
    KeyWait, F11
    RunLingvo()
  }

Return
