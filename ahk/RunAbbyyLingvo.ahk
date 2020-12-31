; Starts Abbyy Lingvo window

; Originally from https://autohotkey.com/board/topic/15574-morse-find-hotkey-press-and-hold-patterns/
Morse(timeout = 400) { ;
   tout := timeout/1000
   key := RegExReplace(A_ThisHotKey,"[\*\~\$\#\+\!\^]")
   Loop {
      t := A_TickCount
      KeyWait %key%
      Pattern .= A_TickCount-t > timeout
      KeyWait %key%,DT%tout%
      If (ErrorLevel)
         Return Pattern
   }
}

RunLingvo() {
  Run, "C:\Program Files (x86)\ABBYY Lingvo x6\Lingvo.exe"
}

; BS::MsgBox % "Morse press pattern " Morse()

^F11::  ; Default hotkey is Ctrl+F11+F11
   p := Morse()
   If (p = "0") {
      MsgBox Short press
      ;Send ^{F11}
   } Else If (p = "00") {
      ;MsgBox Two short presses
      RunLingvo()
   } Else If (p = "01") {
      ;MsgBox Short+Long press
      RunLingvo()
   } Else {
      MsgBox Press pattern %p%
   }
Return
