/*
	Title: Command Functions
		A wrapper set of functions for commands which have an output variable.
	License:
		- Version 1.41 <http://www.autohotkey.net/~polyethene/#functions>
		- Dedicated to the public domain (CC0 1.0) <http://creativecommons.org/publicdomain/zero/1.0/>
*/

Functions() {
	Return, true
}

IfBetween(ByRef var, LowerBound, UpperBound) {
	If var between %LowerBound% and %UpperBound%
		Return, true
}
IfNotBetween(ByRef var, LowerBound, UpperBound) {
	If var not between %LowerBound% and %UpperBound%
		Return, true
}
IfIn(ByRef var, MatchList) {
	If var in %MatchList%
		Return, true
}
IfNotIn(ByRef var, MatchList) {
	If var not in %MatchList%
		Return, true
}
IfContains(ByRef var, MatchList) {
	If var contains %MatchList%
		Return, true
}
IfNotContains(ByRef var, MatchList) {
	If var not contains %MatchList%
		Return, true
}
IfIs(ByRef var, type) {
	If var is %type%
		Return, true
}
IfIsNot(ByRef var, type) {
	If var is not %type%
		Return, true
}

ControlGet(Cmd, Value := "", Control := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	ControlGet, v, %Cmd%, %Value%, %Control%, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
ControlGetFocus(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	ControlGetFocus, v, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
ControlGetText(Control := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	ControlGetText, v, %Control%, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
DriveGet(Cmd, Value := "") {
	DriveGet, v, %Cmd%, %Value%
	Return v
}
DriveSpaceFree(Path) {
	DriveSpaceFree, v, %Path%
	Return v
}

FileGetAttrib(Filename := "") {
	FileGetAttrib, v, %Filename%
	Return v
}
FileGetShortcut(LinkFile, ByRef OutTarget := "", ByRef OutDir := "", ByRef OutArgs := "", ByRef OutDescription := "", ByRef OutIcon := "", ByRef OutIconNum := "", ByRef OutRunState := "") {
	FileGetShortcut, %LinkFile%, OutTarget, OutDir, OutArgs, OutDescription, OutIcon, OutIconNum, OutRunState
}
FileGetSize(Filename := "", Units := "") {
	FileGetSize, v, %Filename%, %Units%
	Return v
}
FileGetTime(Filename := "", WhichTime := "") {
	FileGetTime, v, %Filename%, %WhichTime%
	Return v
}
FileGetVersion(Filename := "") {
	FileGetVersion, v, %Filename%
	Return v
}
FileRead(Filename) {
	FileRead, v, %Filename%
	Return v
}
FileReadLine(Filename, LineNum) {
	FileReadLine, v, %Filename%, %LineNum%
	Return v
}
FileSelectFile(Options := "", RootDir := "", Prompt := "", Filter := "") {
	FileSelectFile, v, % Options, % RootDir, % Prompt, % Filter
	Return v
}
FileSelectFolder(StartingFolder := "", Options := "", Prompt := "") {
	FileSelectFolder, v, % StartingFolder, % Options, % Prompt
	Return v
}
FileCopy(Source, Dest, Overwrite := false) {
	FileCopy, %Source%, %Dest%, %Overwrite%
	Return ErrorLevel
}
FileDelete(FilePattern) {
	FileDelete, % FilePattern
	Return ErrorLevel
}
FileAppend(ByRef Text := "", FileName := "") {
	FileAppend, % Text , % Filename
	Return ErrorLevel
}

FormatTime(YYYYMMDDHH24MISS := "", Format := "") {
	FormatTime, v, %YYYYMMDDHH24MISS%, %Format%
	Return v
}
/*
GetKeyState(WhichKey , Mode := "") {
	GetKeyState, v, %WhichKey%, %Mode%
	Return v
}
*/
; GuiControlGet(Subcommand := "", ControlID := "", Param4 := "") {
; 	GuiControlGet, v, %Subcommand%, %ControlID%, %Param4%
; 	Return v
; }
ImageSearch(ByRef OutputVarX, ByRef OutputVarY, X1, Y1, X2, Y2, ImageFile) {
	ImageSearch, OutputVarX, OutputVarY, %X1%, %Y1%, %X2%, %Y2%, %ImageFile%
}

Input(Options := "", EndKeys := "", MatchList := "") {
	Input, v, %Options%, %EndKeys%, %MatchList%
	Return v
}
InputBox(Title := "", Prompt := "", HIDE := "", Width := "", Height := "", X := "", Y := "", Font := "", Timeout := "", Default := "") {
	InputBox, v, %Title%, %Prompt%, %HIDE%, %Width%, %Height%, %X%, %Y%, , %Timeout%, %Default%
	Return v
}
MouseGetPos(ByRef OutputVarX := "", ByRef OutputVarY := "", ByRef OutputVarWin := "", ByRef OutputVarControl := "", Mode := "") {
	MouseGetPos, OutputVarX, OutputVarY, OutputVarWin, OutputVarControl, %Mode%
}
PixelGetColor(X, Y, RGB := "") {
	PixelGetColor, v, %X%, %Y%, %RGB%
	Return v
}
PixelSearch(ByRef OutputVarX, ByRef OutputVarY, X1, Y1, X2, Y2, ColorID, Variation := "", Mode := "") {
	PixelSearch, OutputVarX, OutputVarY, %X1%, %Y1%, %X2%, %Y2%, %ColorID%, %Variation%, %Mode%
}
Random(Min := "", Max := "") {
	Random, v, %Min%, %Max%
	Return v
}
; RegRead(RootKey, SubKey, ValueName := "") {
; 	RegRead, v, %RootKey%, %SubKey%, %ValueName%
; 	Return v
; }
; Run(Target, WorkingDir := "", Mode := "") {
; 	Run, %Target%, %WorkingDir%, %Mode%, v
; 	Return v
; }
SoundGet(ComponentType := "", ControlType := "", DeviceNumber := "") {
	SoundGet, v, %ComponentType%, %ControlType%, %DeviceNumber%
	Return v
}
SoundGetWaveVolume(DeviceNumber := "") {
	SoundGetWaveVolume, v, %DeviceNumber%
	Return v
}
StatusBarGetText(Part := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	StatusBarGetText, v, %Part%, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
SplitPath(ByRef InputVar, ByRef OutFileName := "", ByRef OutDir := "", ByRef OutExtension := "", ByRef OutNameNoExt := "", ByRef OutDrive := "") {
	SplitPath, InputVar, OutFileName, OutDir, OutExtension, OutNameNoExt, OutDrive
}
StringGetPos(ByRef InputVar, SearchText, Mode := "", Offset := "") {
	StringGetPos, v, InputVar, %SearchText%, %Mode%, %Offset%
	Return v
}
StringLeft(ByRef InputVar, Count) {
	StringLeft, v, InputVar, %Count%
	Return v
}
StringLen(ByRef InputVar) {
	StringLen, v, InputVar
	Return v
}
StringLower(ByRef InputVar, T := "") {
	StringLower, v, InputVar, %T%
	Return v
}
StringMid(ByRef InputVar, StartChar, Count , L := "") {
	StringMid, v, InputVar, %StartChar%, %Count%, %L%
	Return v
}
StringReplace(ByRef InputVar, SearchText, ReplaceText := "", All := "") {
	StringReplace, v, InputVar, %SearchText%, %ReplaceText%, %All%
	Return v
}
StringRight(ByRef InputVar, Count) {
	StringRight, v, InputVar, %Count%
	Return v
}
StringTrimLeft(ByRef InputVar, Count) {
	StringTrimLeft, v, InputVar, %Count%
	Return v
}
StringTrimRight(ByRef InputVar, Count) {
	StringTrimRight, v, InputVar, %Count%
	Return v
}
StringUpper(ByRef InputVar, T := "") {
	StringUpper, v, InputVar, %T%
	Return v
}
SysGet(Subcommand, Param3 := "") {
	SysGet, v, %Subcommand%, %Param3%
	Return v
}
Transform(Cmd, Value1, Value2 := "") {
	Transform, v, %Cmd%, %Value1%, %Value2%
	Return v
}
WinGet(Cmd := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGet, v, %Cmd%, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
WinGetActiveTitle() {
	WinGetActiveTitle, v
	Return v
}
WinGetClass(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGetClass, v, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
WinGetText(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGetText, v, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return v
}
WinGetTitle(ByRef WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGetTitle, v, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return, v
}
WinGetStyle(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	; Somehow this does not work, but WinGet("Style", ...) works
	WinGet, v, Style, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return, v
}
WinGetExStyle(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	; Somehow this does not work, but WinGet("ExStyle", ...) works
	WinGet, v, ExStyle, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	Return, v
}

; added/adjusted by Cü
WinMinimize(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinMinimize, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText
}
WinMove(WinTitle := "", WinText := "", X := "", Y := "", Width := "", Height := "", ExcludeTitle := "", ExcludeText := "") {
	WinMove, % WinTitle, % WinText, % X, % Y , % Width, % Height, % ExcludeTitle, % ExcludeText
}
WinActivate(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinActivate, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText
}
WinRestore(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinRestore, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText
}
WinClose(WinTitle := "", WinText := "", SecondsToWait := "", ExcludeTitle := "", ExcludeText := "") {
	WinClose, %WinTitle%, %WinText%, %SecondsToWait%, %ExcludeTitle%, %ExcludeText%
}
WinShow(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinShow, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText
}
RegRead(KeyName, ValueName := "") {
	RegRead, v, %KeyName%, %ValueName%
	Return v
}
RegWrite(ValueType, KeyName, ValueName := "", Value := "") {
	; ValueType: REG_SZ|REG_EXPAND_SZ|REG_MULTI_SZ|REG_DWORD|REG_BINARY
	; KeyName  : HKLM|HKU|HKCU|HKCR|HKCC\....
	RegWrite, %ValueType%, %KeyName%, %ValueName%, %Value%
	return ErrorLevel
}
EnvGet(EnvVarName) {
	EnvGet, v, %EnvVarName%
	Return v
}
EnvSet(EnvVarName, Value) {
	EnvSet, %EnvVarName%, %Value%
}
IniRead(Filename, Section, Key := "", Default := "") {
	IniRead, v, %Filename%, %Section%, %Key%, %Default%
	Return v
}
IniWrite(Value, Filename, Section, Key) {
	IniWrite, %Value%, %Filename%, %Section%, %Key%
}

WinGetPos(ByRef X := "", ByRef Y := "", ByRef Width := "", ByRef Height := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGetPos, X, Y, Width, Height, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	return { l: X, t: Y, w: Width, h: Height}
}
WinGetMinMax(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGet, v, MinMax, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	return v
}
WinGetProcessName(WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinGet, v, ProcessName, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
	return v
}
WinSetTransparent(N := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	WinSet, Transparent, %N%, %WinTitle%, %WinText%, %ExcludeTitle%, %ExcludeText%
}
Hotkey(KeyName, Label := "", Options := "") {
	Hotkey, %KeyName%, %Label%, %Options%
}
Gui(SubCommand, Param2 := "", Param3 := "", Param4 := "") {
	Gui, %SubCommand%, %Param2%, %Param3%, %Param4%
}
GuiControl(SubCommand, ControlID, Param3 := "") {
	GuiControl, %SubCommand%, %ControlID%, %Param3%
}
GuiControlGet(SubCommand := "", ControlID := "", Param4 := "") {
	GuiControlGet, v, %SubCommand%, %ControlID%, %Param4%
	Return v
}
; copied and renamed from above: Between was IfBetween, Is was IFIs, etc.
Between(ByRef var, LowerBound, UpperBound) {
	If var between %LowerBound% and %UpperBound%
		Return, true
}
NotBetween(ByRef var, LowerBound, UpperBound) {
	If var not between %LowerBound% and %UpperBound%
		Return, true
}
In(ByRef var, MatchList) {
	If var in %MatchList%
		Return, true
}
NotIn(ByRef var, MatchList) {
	If var not in %MatchList%
		Return, true
}
Contains(ByRef var, MatchList) {
	If var contains %MatchList%
		Return, true
}
NotContains(ByRef var, MatchList) {
	If var not contains %MatchList%
		Return, true
}
Is(ByRef var, type) {
	If var is %type%
		Return, true
}
IsNot(ByRef var, type) {
	If var is not %type%
		Return, true
}
IsArray(ByRef var) {
	_non_integer_found := false ; we assume array keys are exclusivley integers
	If (!IsObject(var)) {
		return false
	}
	If (!var.Length()) {
		return false
	}
	for _k, _v in var {
		if(IsNot(_k, "integer")) {
			_non_integer_found := true
		}
	}
	return !_non_integer_found
}
DetectHiddenWindows(pBool) {
	v := A_DetectHiddenWindows
	if (pBool) {
		DetectHiddenWindows, On
	} else {
		DetectHiddenWindows, Off
	}
	return v
}
SetTimer(pLabel, pPeriodOnOffDelete := "", pPriority := 0) {
	_period := pPeriodOnOffDelete
	if (Is(pPeriodOnOffDelete, "integer")) {
		_period := pPeriodOnOffDelete
	} else if (pPeriodOnOffDelete = "Off" || pPeriodOnOffDelete	= false) {
		_period := "Off"
	} else if (pPeriodOnOffDelete = "On" || pPeriodOnOffDelete	= true) {
		_period := "On"
	} else if (pPeriodOnOffDelete = "Delete") {
		_period := "Delete"
	}
	SetTimer, %pLabel%, %pPeriodOnOffDelete%, %pPriority%
}
Run(Target, WorkingDir := "", Mode := "") {
	Run, % Target, % WorkingDir, % Mode, v
	Return v
}
RunWait(Target, WorkingDir := "", Mode := "") {
	RunWait, % Target, % WorkingDir, % Mode, v
	return v
}

ToolTip(Text := "", X := "", Y := "", WhichToolTip := "") {
	ToolTip, % Text , % X , % Y, % WhichToolTip
}
TrayTip(Title := "", Text := "", Seconds := "", Options := "") {
	TrayTip, % Title, % Text, % Seconds, % Options
}
MsgBox(Options := "", Title := "", Text := "", Timeout := "") {
	;Title := StrReplace(Title, "````", "````````")
	MsgBox, % Options, % Title, % Text, % Timeout
}
Send(Keys) {
	Send, % Keys
}
SendInput(Keys) {
	SendInput, % Keys
}
Sleep(Delay) {
	Sleep, % Delay
}
ThreadNoTimers(TrueOrFalse := true) {
	Thread, NoTimers, % TrueOrFalse
}
ThreadPriority(Level) {
	Thread, Priority, % Level
}
ThreadInterrupt(Duration := "", LineCount := "") {
	Thread, Interrupt, % Duration, % LineCount
}
CoordMode(ToolTipPixelMouse, ScreenRelative := "") {
	CoordMode, % ToolTipPixelMouse, % ScreenRelative
}
CoordModeToolTip(ScreenRelative := "") {
	CoordMode, ToolTip, % Screen|Relative
}
CoordModePixel() {
	CoordMode, Pixel, % Screen|Relative
}
CoordModeMouse() {
	CoordMode, Mouse, % Screen|Relative
}
PostMessage(Msg, wParam := "", lParam := "", Control := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "") {
	PostMessage, % Msg, % wParam, % lParam, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText
}
SendMessage(Msg, wParam := "", lParam := "", Control := "", WinTitle := "", WinText := "", ExcludeTitle := "", ExcludeText := "", Timeout := "") {
	SendMessage, % Msg, % wParam, % lParam, % Control, % WinTitle, % WinText, % ExcludeTitle, % ExcludeText, % Timeout
}
Menu(MenuName, SubCommand, Value1 := "", Value2 := "", Value3 := "", Value4 := "") {
	Menu, %MenuName%, %SubCommand%, %Value1%, %Value2%, %Value3%, %Value4%
}

/*
	MonitorGet Checks if the specified monitor exists and optionally retrieves its bounding coordinates.
	IsExisting := MonitorGet([N, Left, Top, Right, Bottom])
	SysGet, OutputVar, Monitor [, N]

	MonitorGetCount Returns the total number of monitors.
	Count := MonitorGetCount()
	SysGet, OutputVar, MonitorCount

	MonitorGetName Returns the operating system's name of the specified monitor.
	Name := MonitorGetName([N])
	SysGet, OutputVar, MonitorName [, N]

	MonitorGetPrimary Returns the number of the primary monitor.
	Primary := MonitorGetPrimary()
	SysGet, OutputVar, MonitorPrimary

	MonitorGetWorkArea Checks
	IsExisting := MonitorGetWorkArea([N, Left, Top, Right, Bottom])
	SysGet, OutputVar, MonitorWorkArea [, N]
*/
MonitorGetCount() {
	SysGet, v, MonitorCount
	return v
}
MonitorGetName(N := 0) {
	SysGet, v, MonitorName, %N%
	return v
}
MonitorGetPrimary() {
	SysGet, v, MonitorPrimary
	return v
}
MonitorGet(N := 0, ByRef Left := "", ByRef Top := "", ByRef Right := "", ByRef Bottom := "") {
	SysGet, v, Monitor, %N%
	if (!vLeft && !vTop && !vRight && !vBottom) {
		return false
	}
	Left   := vLeft
	Top    := vTop
	Right  := vRight
	Bottom := vBottom
	_res   := { left: vLeft, right: vRight, top: vTop, bottom: vBottom }
	return _res
}
MonitorGetWorkArea(N := 0, ByRef Left := "", ByRef Top := "", ByRef Right := "", ByRef Bottom := "") {
	SysGet, v, MonitorWorkArea, %N%
	if (!vLeft && !vTop && !vRight && !vBottom) {
		return false
	}
	Left   := vLeft
	Top    := vTop
	Right  := vRight
	Bottom := vBottom
	_res   := { left: vLeft, right: vRight, top: vTop, bottom: vBottom }
	return _res
}
