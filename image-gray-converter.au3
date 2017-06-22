#include <Array.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#pragma compile(Icon, 'icon.ico')

$imagemagick_cmd = IniRead ( @ScriptDir & "\config.ini", "config", "imagemagick_cmd", "1" )
; convert logot.png -colorspace gray logotg.png

For $i = 1 To $CmdLine[0]
    IF FileExists($CmdLine[$i]) and StringInStr(FileGetAttrib($CmdLine[$i]),"D") Then
        $filesList = _FileListToArray($CmdLine[$i])
        For $j = 1 To $filesList[0]
		    $f = $CmdLine[$i] & '\' & $filesList[$j]
			FileCopy($f, $f & ".tmp")
			FileRecycle($f & ".tmp")
			$cmd = '"' & @ScriptDir & '\image_magick\convert.exe" "' & $f & '" ' & $imagemagick_cmd & ' "' & $f & '"'
            RunWait($cmd , @ScriptDir, @SW_HIDE)
        Next
	 Else
		$f = $CmdLine[$i]
		FileCopy($f, $f & ".tmp")
		 FileRecycle($f & ".tmp")
		$cmd = '"' & @ScriptDir & '\image_magick\convert.exe" "' & $f & '" ' & $imagemagick_cmd & ' "' & $f & '"'
		;MsgBox($MB_SYSTEMMODAL, "msg", $cmd)
        RunWait($cmd , @ScriptDir, @SW_HIDE)
    EndIf
Next