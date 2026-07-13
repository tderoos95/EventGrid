@echo off
    setlocal enableextensions disabledelayedexpansion
        set "systemDir=%~dp0\..\System"
        call :resolve "%systemDir%" resolvedDir

        echo Copying %resolvedDir%\EventBus.u to steam directory...
        echo Copying %resolvedDir%\EventBus.ucl to steam directory...

        del "D:\SteamLibrary\steamapps\common\Unreal Tournament 2004\System\EventBus.u"
        del "D:\SteamLibrary\steamapps\common\Unreal Tournament 2004\System\EventBus.ucl"
        copy %resolvedDir%\EventBus.u "D:\SteamLibrary\steamapps\common\Unreal Tournament 2004\System\EventBus.u"
        copy %resolvedDir%\EventBus.ucl "D:\SteamLibrary\steamapps\common\Unreal Tournament 2004\System\EventBus.ucl"
    endlocal
    goto :EOF
:resolve file/folder returnVarName
    rem Set the second argument (variable name) 
    rem to the full path to the first argument (file/folder)
    set "%~2=%~f1"
    goto :EOF