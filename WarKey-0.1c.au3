; Include Headers
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <Constants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt("SendKeyDelay", 1)
Opt("SendKeyDownDelay", 0)
Opt("TrayMenuMode", 1)

; Setting Up Hot Key
HotKeySet("{Pause}", "Pause")

; Setting Up Version
Global $version = "0.1c"

; Create WarKey Window Function
Global $msg

Global $running       = FALSE

Global $hGUI          = GUICreate("WarKey v" & $version, 180, 272, -1, -1, $WS_SYSMENU)

; Create Menu Bar
Global $mnuFile       = GUICtrlCreateMenu("&File")
Global $mnuFileMinimi = GUICtrlCreateMenuItem("&Minimize to Tray", $mnuFile)
GUICtrlSetState($mnuFileMinimi, $GUI_CHECKED)
Global $mnuFileSepara = GUICtrlCreateMenuItem("", $mnuFile)
Global $mnuFileReset  = GUICtrlCreateMenuItem("&Reset", $mnuFile)
Global $mnuFileExit   = GUICtrlCreateMenuItem("&Exit", $mnuFile)
Global $mnuAction     = GUICtrlCreateMenu("Ac&tion")
Global $mnuActionAct  = GUICtrlCreateMenuItem("&Activate {Pause}", $mnuAction)
Global $mnuActionDea  = GUICtrlCreateMenuItem("&Deactivate {Pause}", $mnuAction)
GUICtrlSetState($mnuActionDea, $GUI_DISABLE)
Global $mnuActionSepa = GUICtrlCreateMenuItem("", $mnuAction)
Global $mnuActionModi = GUICtrlCreateMenu("Modifiers", $mnuAction)
Global $mnuActionMod1 = GUICtrlCreateMenuItem("Ctrl", $mnuActionModi)
GUICtrlSetState($mnuActionMod1, $GUI_DISABLE)
Global $mnuActionMod2 = GUICtrlCreateMenuItem("Alt", $mnuActionModi)
GUICtrlSetState($mnuActionMod2, $GUI_CHECKED)
GUICtrlSetState($mnuActionMod2, $GUI_DISABLE)
Global $mnuActionMod3 = GUICtrlCreateMenuItem("Shift", $mnuActionModi)
GUICtrlSetState($mnuActionMod3, $GUI_DISABLE)
Global $mnuHelp       = GUICtrlCreateMenu("&Help")
Global $mnuHelpCheck  = GUICtrlCreateMenuItem("&Check for Updates", $mnuHelp)
Global $mnuHelpSepara = GUICtrlCreateMenuItem("", $mnuHelp)
Global $mnuHelpAbout  = GUICtrlCreateMenuItem("&About WarKey v" & $version, $mnuHelp)

; Create Status Bar
Global $hStatus       = _GUICtrlStatusBar_Create($hGUI)
setStatusBar("Ready")

; Create Context Menu
Global $contextMenu   = GUICtrlCreateContextMenu()
Global $ctmActivate   = GUICtrlCreateMenuItem("Activate {Pause}", $contextMenu);
Global $ctmDeactivate = GUICtrlCreateMenuItem("Deactivate {Pause}", $contextMenu);
GUICtrlSetState($ctmDeactivate, $GUI_DISABLE)
Global $ctmSeparator  = GUICtrlCreateMenuItem("", $contextMenu);
Global $ctmMinimi     = GUICtrlCreateMenuItem("&Minimize to Tray", $contextMenu)
GUICtrlSetState($ctmMinimi, $GUI_CHECKED)
Global $ctmSeparator  = GUICtrlCreateMenuItem("", $contextMenu);
Global $ctmReset      = GUICtrlCreateMenuItem("Reset", $contextMenu);
Global $ctmSeparator  = GUICtrlCreateMenuItem("", $contextMenu);
Global $ctmAbout      = GUICtrlCreateMenuItem("About WarKey", $contextMenu);

; Create Combos and Text Boxes
Global $lblString1    = GUICtrlCreateLabel("F5:", 10, 10, 15, -1, $SS_RIGHT)
Global $txtString1    = GUICtrlCreateInput("DJ Blitz -arso Game!", 31, 7, 134)
Global $lblString2    = GUICtrlCreateLabel("F6:", 10, 32, 15, -1, $SS_RIGHT)
Global $txtString2    = GUICtrlCreateInput("No Fucking Noob/Leaver!", 31, 29, 134)
Global $lblString3    = GUICtrlCreateLabel("F7:", 10, 54, 15, -1, $SS_RIGHT)
Global $txtString3    = GUICtrlCreateInput("All Stay and Get Ready!", 31, 51, 134)
Global $lblString4    = GUICtrlCreateLabel("F8:", 10, 76, 15, -1, $SS_RIGHT)
Global $txtString4    = GUICtrlCreateInput("Countdown & Start Game", 31, 73, 134)
GUICtrlSetState($txtString4, $GUI_DISABLE)

; Create Labels
Global $lblNumpad7    = GUICtrlCreateLabel("Num 7:", 10, 102)
Global $lblNumpad8    = GUICtrlCreateLabel("Num 8:", 95, 102)
Global $lblNumpad4    = GUICtrlCreateLabel("Num 4:", 10, 124)
Global $lblNumpad5    = GUICtrlCreateLabel("Num 5:", 95, 124)
Global $lblNumpad1    = GUICtrlCreateLabel("Num 1:", 10, 146)
Global $lblNumpad2    = GUICtrlCreateLabel("Num 2:", 95, 146)

; Create Input Fields
Global $txtNumpad7    = GUICtrlCreateInput("w", 50, 99, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad7, 1)
Global $txtNumpad8    = GUICtrlCreateInput("e", 135, 99, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad8, 1)
Global $txtNumpad4    = GUICtrlCreateInput("s", 50, 121, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad4, 1)
Global $txtNumpad5    = GUICtrlCreateInput("d", 135, 121, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad5, 1)
Global $txtNumpad1    = GUICtrlCreateInput("x", 50, 143, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad1, 1)
Global $txtNumpad2    = GUICtrlCreateInput("c", 135, 143, 28, -1, BitOR($ES_CENTER, $ES_LOWERCASE))
GUICtrlSetLimit($txtNumpad2, 1)

; Create Check Boxes
; Global $chkWithCtrl   = GUICtrlCreateCheckBox("&Ctrl", 10, 168)
; GUICtrlSetState($chkWithCtrl, $GUI_DISABLE)
; Global $chkWithAlt    = GUICtrlCreateCheckBox("A&lt", 70, 168, -1, -1)
; GUICtrlSetState($chkWithAlt, $GUI_CHECKED)
; GUICtrlSetState($chkWithAlt, $GUI_DISABLE)
; Global $chkWithShift  = GUICtrlCreateCheckBox("&Shift", 125, 168)
; GUICtrlSetState($chkWithShift, $GUI_DISABLE)

; Create Buttons
Global $btnActivate   = GUICtrlCreateButton("&Activate {Pause}", 20, 168, 134)
GUICtrlSetState($btnActivate, $GUI_FOCUS)
Global $btnDeactivate = GUICtrlCreateButton("&Deactivate {Pause}", 20, 168, 134)
GUICtrlSetState($btnDeactivate, $GUI_HIDE)

; Create Tray Menu
Global $tryActivate   = TrayCreateItem("Activate {Pause}")
Global $tryDeactivate = TrayCreateItem("Deactivate {Pause}")
TrayItemSetState($tryDeactivate, $TRAY_DISABLE)
TrayCreateItem("")
Global $tryMinimi     = TrayCreateItem("Minimize to Tray")
TrayItemSetState($tryMinimi, $TRAY_CHECKED)
TrayCreateItem("")
Global $tryAbout      = TrayCreateItem("About WarKey")
TrayCreateItem("")
Global $tryExit       = TrayCreateItem("Exit")
TraySetState()
TraySetToolTip("WarKey v" & $version)

; Show WarKey Window
GUISetState(@SW_SHOW);

While 1
  $msg = GUIGetMsg()
  $try = TrayGetMsg()
  
  ; If (WinGetTitle("Warcraft III") <> "This Gui Title" AND $running) Then
    Select
      Case $msg = $GUI_EVENT_CLOSE OR $msg = $mnuFileExit OR $try = $tryExit
        ; Status Bar
        setStatusBar("Terminating WarKey")
        
        Sleep(500)
        
        Exit
      Case $msg = $mnuActionAct OR $msg = $ctmActivate OR $msg = $btnActivate OR $try = $tryActivate
        doActivate()
      Case $msg = $mnuActionDea OR $msg = $ctmDeactivate OR $msg = $btnDeactivate OR $try = $tryDeactivate
        doDeactivate()
      Case $msg = $mnuFileMinimi OR $msg = $ctmMinimi OR $try = $tryMinimi
        doMinimizeToTray()
      Case $msg = $mnuFileReset OR $msg = $ctmReset
        ; Status Bar
        setStatusBar("Resetting WarKey")
        
        ; Reset Input Boxes
        GUICtrlSetData($txtString1, "DJ Blitz -arso Game!")
        GUICtrlSetData($txtString2, "No Fucking Noob/Leaver!")
        GUICtrlSetData($txtString3, "All Stay and Get Ready!")
        GUICtrlSetData($txtNumpad7, "w")
        GUICtrlSetData($txtNumpad8, "e")
        GUICtrlSetData($txtNumpad4, "s")
        GUICtrlSetData($txtNumpad5, "d")
        GUICtrlSetData($txtNumpad1, "x")
        GUICtrlSetData($txtNumpad2, "c")
        
        ; Status Bar
        setStatusBar("WarKey resetted")
      Case $msg = $mnuHelpCheck
        ; Status Bar
        setStatusBar("Checking Latest WarKey")
        
        $bData = StringTrimRight(InetRead("http://warkey.echin.net/warkey.ver?" & TimerInit()), 2)
        $sData = BinaryToString($bData)
        
        If (StringCompare($sData, $version) == 0) Then
          MsgBox(8256, "WarKey v" & $version, "No Updates Found!")
        Else
          MsgBox(8208, "WarKey v" & $version, "New Update Found!" & @CRLF & "Current Version: " & $version & @CRLF & "Latest Version: " & $sData)
        EndIf
        
        ; Status Bar
        setStatusBar("Ready")
      Case $msg = $mnuHelpAbout OR $msg = $ctmAbout OR $try = $tryAbout
        TrayItemSetState($tryAbout, $TRAY_UNCHECKED)
        MsgBox(8256, "WarKey v" & $version, "WarKey v" & $version & " - by Chin")
    EndSelect
  ; EndIf
WEnd

GUIDelete()

; Set Status Bar Function
Func setStatusBar($status)
  Sleep(250)
  _GUICtrlStatusBar_SetText($hStatus, "Status: " & $status & ".")
  Sleep(250)
  
  Return
EndFunc

Func sendNumPad7()
  Send("{NumPad7}")
  
  Return
EndFunc

Func sendNumPad8()
  Send("{NumPad8}")
  
  Return
EndFunc

Func sendNumPad4()
  Send("{NumPad4}")
  
  Return
EndFunc

Func sendNumPad5()
  Send("{NumPad5}")
  
  Return
EndFunc

Func sendNumPad1()
  Send("{NumPad1}")
  
  Return
EndFunc

Func sendNumPad2()
  Send("{NumPad2}")
  
  Return
EndFunc

Func doMinimizeToTray()
  If (BitAnd(GUICtrlRead($mnuFileMinimi), $GUI_CHECKED)) Then
    GUICtrlSetState($mnuFileMinimi, $GUI_UNCHECKED)
    GUICtrlSetState($ctmMinimi, $GUI_UNCHECKED)
    TrayItemSetState($tryMinimi, $TRAY_UNCHECKED)
  Else
    GUICtrlSetState($mnuFileMinimi, $GUI_CHECKED)
    GUICtrlSetState($ctmMinimi, $GUI_CHECKED)
    TrayItemSetState($tryMinimi, $TRAY_CHECKED)
  EndIf
EndFunc

Func doActivate()
  If ProcessExists("war3.exe") Then
    ; Status Bar
    setStatusBar("Activating WarKey")
    
    ; Toggle Activate / Deactivate Buttons
    GUICtrlSetState($mnuFileMinimi, $GUI_DISABLE)
    GUICtrlSetState($mnuActionAct, $GUI_DISABLE)
    GUICtrlSetState($mnuActionDea, $GUI_ENABLE)
    GUICtrlSetState($ctmActivate, $GUI_DISABLE)
    GUICtrlSetState($ctmDeactivate, $GUI_ENABLE)
    GUICtrlSetState($ctmMinimi, $GUI_DISABLE)
    GUICtrlSetState($btnActivate, $GUI_HIDE)
    GUICtrlSetState($btnDeactivate, $GUI_SHOW)
    GUICtrlSetState($btnDeactivate, $GUI_FOCUS)
    TrayItemSetState($tryActivate, BitOR($TRAY_DISABLE, $TRAY_UNCHECKED))
    TrayItemSetState($tryDeactivate, BitOR($TRAY_ENABLE, $TRAY_UNCHECKED))
    TrayItemSetState($tryMinimi, $TRAY_DISABLE)
    
    ; Disable Reset Buttons
    GUICtrlSetState($mnuFileReset, $GUI_DISABLE)
    GUICtrlSetState($ctmReset, $GUI_DISABLE)
    
    ; Disable Input Fields
    GUICtrlSetState($txtString1, $GUI_DISABLE)
    GUICtrlSetState($txtString2, $GUI_DISABLE)
    GUICtrlSetState($txtString3, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad7, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad8, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad4, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad5, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad1, $GUI_DISABLE)
    GUICtrlSetState($txtNumpad2, $GUI_DISABLE)
    
    ; Disable Check Boxes
    ; GUICtrlSetState($chkWithCtrl, $GUI_DISABLE)
    ; GUICtrlSetState($chkWithAlt, $GUI_DISABLE)
    ; GUICtrlSetState($chkWithShift, $GUI_DISABLE)
    
    ; Enable HotKey
    HotKeySet("{F5}", "doString1")
    HotKeySet("{F6}", "doString2")
    HotKeySet("{F7}", "doString3")
    HotKeySet("{F8}", "doStartGame")
    HotKeySet("!" & GUICtrlRead($txtNumpad7), "sendNumPad7")
    HotKeySet("!" & GUICtrlRead($txtNumpad8), "sendNumPad8")
    HotKeySet("!" & GUICtrlRead($txtNumpad4), "sendNumPad4")
    HotKeySet("!" & GUICtrlRead($txtNumpad5), "sendNumPad5")
    HotKeySet("!" & GUICtrlRead($txtNumpad1), "sendNumPad1")
    HotKeySet("!" & GUICtrlRead($txtNumpad2), "sendNumPad2")
    
    ; Status Bar
    setStatusBar("WarKey activated")
    
    ; GUI Set State
    If (BitAnd(GUICtrlRead($mnuFileMinimi), $GUI_CHECKED)) Then
      GUISetState(@SW_HIDE)
    EndIf
    
    ; Tray Bar
    TrayTip("WarKey", "WarKey has been activated", 3)
  Else
    MsgBox(8208, "Warcraft III Not Found", "Please run Warcraft III before activating WarKey.")
    $running = FALSE
  EndIf
EndFunc

Func doDeactivate()
  ; Status Bar
  setStatusBar("Deactivating WarKey")
  
  ; Toggle Activate / Deactivate Buttons
  GUICtrlSetState($mnuFileMinimi, $GUI_ENABLE)
  GUICtrlSetState($mnuActionAct, $GUI_ENABLE)
  GUICtrlSetState($mnuActionDea, $GUI_DISABLE)
  GUICtrlSetState($ctmActivate, $GUI_ENABLE)
  GUICtrlSetState($ctmDeactivate, $GUI_DISABLE)
  GUICtrlSetState($ctmMinimi, $GUI_ENABLE)
  GUICtrlSetState($btnActivate, $GUI_SHOW)
  GUICtrlSetState($btnActivate, $GUI_FOCUS)
  GUICtrlSetState($btnDeactivate, $GUI_HIDE)
  TrayItemSetState($tryActivate, BitOR($TRAY_ENABLE, $TRAY_UNCHECKED))
  TrayItemSetState($tryDeactivate, BitOR($TRAY_DISABLE, $TRAY_UNCHECKED))
  TrayItemSetState($tryMinimi, $TRAY_ENABLE)
  
  ; Enable Reset Buttons
  GUICtrlSetState($mnuFileReset, $GUI_ENABLE)
  GUICtrlSetState($ctmReset, $GUI_ENABLE)
  
  ; Enable Input Fields
  GUICtrlSetState($txtString1, $GUI_ENABLE)
  GUICtrlSetState($txtString2, $GUI_ENABLE)
  GUICtrlSetState($txtString3, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad7, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad8, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad4, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad5, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad1, $GUI_ENABLE)
  GUICtrlSetState($txtNumpad2, $GUI_ENABLE)
  
  ; Enable Check Boxes
  ; GUICtrlSetState($chkWithCtrl, $GUI_ENABLE)
  ; GUICtrlSetState($chkWithAlt, $GUI_ENABLE)
  ; GUICtrlSetState($chkWithShift, $GUI_ENABLE)
  
  ; Disable HotKey
  HotKeySet("{F5}")
  HotKeySet("{F6}")
  HotKeySet("{F7}")
  HotKeySet("{F8}")
  HotKeySet("!" & GUICtrlRead($txtNumpad7))
  HotKeySet("!" & GUICtrlRead($txtNumpad8))
  HotKeySet("!" & GUICtrlRead($txtNumpad4))
  HotKeySet("!" & GUICtrlRead($txtNumpad5))
  HotKeySet("!" & GUICtrlRead($txtNumpad1))
  HotKeySet("!" & GUICtrlRead($txtNumpad2))
  
  ; Status Bar
  setStatusBar("WarKey deactivated")
  
  ; GUI Set State
  GUISetState(@SW_SHOW)
  
  ; Tray Bar
  TrayTip("WarKey", "WarKey has been deactivated", 3)
EndFunc

Func doString1()
  If (WinGetTitle("Warcraft III") <> "This Gui Title" AND $running) Then
    Sleep(50)
    Send(GUICtrlRead($txtString1) & @CRLF)
    Sleep(50)
    Send("{Enter}")
    Sleep(50)
  EndIf
  
  Return
EndFunc

Func doString2()
  If (WinGetTitle("Warcraft III") <> "This Gui Title" AND $running) Then
    Sleep(50)
    Send(GUICtrlRead($txtString2) & @CRLF)
    Sleep(50)
    Send("{Enter}")
    Sleep(50)
  EndIf
  
  Return
EndFunc

Func doString3()
  If (WinGetTitle("Warcraft III") <> "This Gui Title" AND $running) Then
    Sleep(50)
    Send(GUICtrlRead($txtString3) & @CRLF)
    Sleep(50)
    Send("{Enter}")
    Sleep(50)
  EndIf
  
  Return
EndFunc

Func doStartGame()
  If (WinGetTitle("Warcraft III") <> "This Gui Title" AND $running) Then
    HotKeySet("!s")
    Sleep(1000)
    Send("Counting Down 5..")
    Sleep(250)
    Send("{Enter}")
    Sleep(750)
    Send("Counting Down 4..")
    Sleep(250)
    Send("{Enter}")
    Sleep(750)
    Send("Counting Down 3..")
    Sleep(250)
    Send("{Enter}")
    Sleep(750)
    Send("Counting Down 2..")
    Sleep(250)
    Send("{Enter}")
    Sleep(750)
    Send("Counting Down 1..")
    Sleep(250)
    Send("{Enter}")
    Sleep(250)
    Send("!s")
    Sleep(250)
    HotKeySet("!s", "sendNumPad4")
  EndIf
  
  Return
EndFunc

Func Pause()
  $running = NOT $running
  
  If ($running) Then
    doActivate()
  Else
    doDeactivate()
  EndIf
  
  Return
EndFunc