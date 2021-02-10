#Warn All
#Warn UseUnsetLocal, Off
#Warn LocalSameAsGlobal, Off

;oLogger := new cCuLogger({ level: cCuLogger.LOG_LEVEL_NORMAL, out2sys: true, autoflush: true })
;oLogger.log("hello world")
;return

; convenience functions
; if you define an 'oLogger' object *after* including this file, you can use these
; if you do not define it, a new object will be automatically instantiated
global oLogger := new cCuLogger({ level: cCuLogger.LOG_LEVEL_NORMAL, out2sys: true, autoflush: true, timestamp: false, quoteleft: "{", quoteright: "}" })
$log(pMessage*) {
    oLogger.add_info(pMessage*)
}
$dbg(pMessage*) {
    oLogger.add_dbg(pMessage*)
}
$verbose(pMessage*) {
    oLogger.add_verbose(pMessage*)
}
$dump(pObject, pPrefix := "", pOutput := true) {
    ; if (pPrefix) {
    ;     $log(pPrefix . ":Dump", _DumpRecursively(pObject, "", false))
    ; } else {
    ;     return _DumpRecursively(pObject, "", pOutput)
    ; }
    if (!pOutput) {
        return _DumpRecursively(pObject, pPrefix, pOutput)
    } else {
        $log(pPrefix . ":Dump", _DumpRecursively(pObject, "", false))
    }
}


; show a fancy error
$msgbox(pMessage, pTitle := "", pExitCode := 0) {
    _title := pTitle ? pTitle : A_ThisFunc
    ;TaskDialog(0, _title "||" StrReplace(pMessage, "\", "\\"))
    MsgBox,, % _title, % pMessage
    if (pExitCode) {
        ExitApp, % pExitCode
    }
}

$toast(pMessage, pTitle := "", pOptions := "") {
    if (pOptions < 16) {
        pOptions += 16 ; do not play sound
    }
    _title := pTitle ? pTitle : A_ThisFunc
    TrayTip % _title, % pMessage, , pOptions
}


; in some class, method, etc.:
;
;   oLogger := GetLogger(A_ThisFunc)
;
;
GetLogger(pParam := "") {
    OutputDebug, % "In GetLogger()"
    if(IsObject(pParam)) {
        OutputDebug, % "Caller's class: " pParam.__Class
    } else {
        OutputDebug, % "Called with: " pParam
    }
}

_StrRepeat(pTimes := 1, pString := "") {
    _out_str := ""
    Loop, % pTimes {
        _out_str .= pString
    }
    return _out_str
}

_DumpRecursively(pObject, pPrefix := "", pOutput := true) {
    static _indent_cnt := 0
    static _indent_char := "  "

    _indent_cnt += 1
    _indent := _StrRepeat(_indent_cnt, _indent_char)
    ; Length() is set to "" for empty strings, and 0 for empty objects/arrays
    _length := pObject.Length() ? " [" . pObject.Length() . "]" : ( pObject.Count() ? " [" . pObject.Count() . "]" : "")
    _out_str := pPrefix ? pPrefix _length ":`n" : ( _indent_cnt == 1 ? "`n" : "")
    _class := pObject.__class ? " (" pObject.__class "{})" : ""
    _indent .= "  "
    for _k, _v in pObject {
        if (IsFunc(_v)) {
            _out_str .= _indent _k ": FUNCTION`n"
        ; } else if (IsObject(_v) && _v.Base) {
        ;     _out_str .= _indent _k ": OBJECT with Base: " _v.Base "`n"
        } else if (IsObject(_v)) {
            ; for arrays and objects insert length after the name
            _length := _v.Length() ? " [" . _v.Length() . "]" : ( _v.Count() ? " [" . _v.Count() . "]" : "")
            _out_str .= _indent _k _class ": {`n" _DumpRecursively(_v, "", false) _indent "}`n"
        } else {
            _out_str .= _indent _k ": " _v "`n"
        }
    }
    _indent_cnt -= 1
    if (pOutput) {
        $log(_out_str)
    } else {
        return _out_str
    }
}

class cCuLogger {

    static MY_NAME                  := "CuLogger"

    static LOG_LEVEL_OFF            := 0
    static LOG_LEVEL_NORMAL         := 1
    static LOG_LEVEL_DEBUG          := 2
    static LOG_LEVEL_VERBOSE        := 3

    static SYSLOG_PREFIX_FOR_FILTER := "AHK: "

    ;static OUTPUT_SYS_DEBUG     := 0xdead   ; requires a viewer like SysInternals DebugView.exe
    ;static OUTPUT_SCREEN        := 0xbeef   ; only screen
    ;static OUTPUT_USER_FILE     := 0x1337   ; user file


    /*  Options object:

        level       : LOG_LEVEL_xxx
        out2sys     : true|false           ; System debug - requires a viewer like SysInternals DebugView.exe
        out2file    : D:\mydir\myfile.log
        autoflush   : true|false
        minmem      : true|false
        detect      : true|false
        prefix      : "MyLoggerClient - ... "
        quoteleft   : ( "
        quoteright  : ) "
        timestamp   : true|false
    */
    __New(oOptions) {
        if(!IsObject(oOptions)) {
            this._showError("No or invalid options object passed to constructor", "Error")
            this :=
            return
        }
        this.level          := oOptions.HasKey("level")         ? oOptions.level          : cCuLogger.LOG_LEVEL_OFF
        this.out2sys        := oOptions.HasKey("out2sys")       ? oOptions.out2sys        : false
        this.out2file       := oOptions.HasKey("out2file")      ? oOptions.out2file       : ""
        this.autoflush      := oOptions.HasKey("autoflush")     ? oOptions.autoflush      : true
        this.minmem         := oOptions.HasKey("minmem")        ? oOptions.minmem         : true
        this.detect         := oOptions.HasKey("detect")        ? oOptions.detect         : false
        this.prefix         := oOptions.HasKey("prefix")        ? oOptions.prefix         : ""
        this.quoteleft      := oOptions.HasKey("quoteleft")     ? oOptions.quoteleft      : ""
        this.quoteright     := oOptions.HasKey("quoteright")    ? oOptions.quoteright     : ""
        this.timestamp      := oOptions.HasKey("timestamp")     ? oOptions.timestamp      : true
        this.cleardebugview := oOptions.HasKey("cleardebugview")? oOptions.cleardebugview : false

        this.entries    := []                   ; stores all the log so far
        this.fh         := false                ; file handle for output file if any given
        this._openFile()
        this._clearDebugView(this.cleardebugview)
    }

    set_level(pDebugLevel) {
        this.level  := pDebugLevel
    }
    set_minmem(pMinimizeMem) {
        this.minmem := pMinimizeMem
    }
    set_autodetect(pAutoDetectFormat) {
        this.detect := pAutoDetectFormat
    }

    _showError(pMessage, pTitle := "", pPrefix := "cCuLogger - ") {
        MsgBox,, % pPrefix pTitle, % pMessage
    }

    _join(pSep := "", pQuotes := false, ByRef pParams*) {
        _str := ""
        _cnt := 0
        for idx, val in pParams {
            _str .= (pQuotes ? this.quoteleft : "") val (pQuotes ? this.quoteright : "") pSep
            _cnt++
        }
        ; " -2 for the quotes
        _correction_factor := StrLen(pSep)
        if(pQuotes) {
            _correction_factor := StrLen(this.quoteleft) + StrLen(this.quoteright) - StrLen(pSep)
        }
        if(StrLen(pSep)) {
            _str := SubStr(_str, 1, -_correction_factor) ; " -2 for the quotes
        }
        return _str
    }

    _openFile() {
        if(this.out2file) {
            _fh := FileOpen(this.out2file, "a")
            if(!IsObject(_fh)) {
                this._showError("Cannot write to file (" this.out2file ")", "Error")
                this := {}
                return
            }
            this.fh := _fh
        }
    }

    _collect(pDebugLevel := 0, ByRef pParams*) {
        _entry := { level: pDebugLevel, text: "" }
        if(this.minmem && pDebugLevel > this.level) {
            return _entry
        }
        _log_entry := this.prefix
        if(this.timestamp) {
            FormatTime, _dt, , yyyyMMdd-HHmmss
            _log_entry .= _dt " - "
        }
        if(this.detect) {
            ; TODO - check sprintf-style parameters and substitute variables
        } else {
            _log_entry .= this._join(" ", (StrLen(this.quoteleft) || StrLen(this.quoteright) ? true : false), pParams*)
        }
        if (InStr(_log_entry, "`n")) {
            _log_entry := StrSplit(_log_entry, "`n")
        }
        _entry.text := _log_entry
        this.entries.push(_entry)
        return _entry
    }

    _output(ByRef oLogEntry) {
        if(!IsObject(oLogEntry)) {
            this._showError("Not a log entry: (" oLogEntry ")", "Error")
            return
        }
        if(oLogEntry.level > this.level) {
            return
        }
        if(this.out2sys) {
            if (oLogEntry.text.Count()) { ; array
                for _k in oLogEntry.text {
                    OutputDebug, % cCuLogger.SYSLOG_PREFIX_FOR_FILTER oLogEntry.text[_k]
                }
            } else {
                OutputDebug, % cCuLogger.SYSLOG_PREFIX_FOR_FILTER oLogEntry.text
            }
        }
        if(this.out2file && this.fh) {
            fh.Write(oLogEntry.text)
        }
    }

    get_entries() {
        return this.entries
    }

    add_info(ByRef pParams*) {
        _oLogEntry := this._collect(cCuLogger.LOG_LEVEL_NORMAL,  pParams*)
        if(this.autoflush) {
            this._output(_oLogEntry)
        }
        if(this.minmem) {
            this.reset_log()
        }
    }
    add_dbg(ByRef pParams*) {
        _oLogEntry := this._collect(cCuLogger.LOG_LEVEL_DEBUG,  pParams*)
        if(this.autoflush) {
            this._output(_oLogEntry)
        }
        if(this.minmem) {
            this.reset_log()
        }
    }
    add_verbose(ByRef pParams*) {
        _oLogEntry := this._collect(cCuLogger.LOG_LEVEL_VERBOSE,  pParams*)
        if(this.autoflush) {
            this._output(_oLogEntry)
        }
        if(this.minmem) {
            this.reset_log()
        }
    }

    /*
        write everything to file, close and re-open file
    */
    flush_log() {
        if(!this.fh) {
            this._showError("File handle is invalid for (" this.out2file ")", "Error")
            return
        }
        if(this.entries.Length()) {
            for idx, val in this.entries {
                this._output(val)
            }
        }
        this.fh.Close()
        this._openFile()
    }

    reset_log() {
        this.entries := []
    }

    display() {
        ; TODO - display in Gui
    }

    _clearDebugView(pContinue) {
        if (!pContinue) {
            return
        }
        if (WinExist("DebugView")) {
            _curw := WinExist("A")
            SetTitleMatchMode, 1
            WinActivate, DebugView
            Send, ^x
            WinActivate, % "ahk_id " _curw
        }
    }

}
