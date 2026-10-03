Unicode true

!define APP_NAME "Tribals"
!define APP_EXE "Tribals.exe"
!define UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"

Name "${APP_NAME}"
OutFile "C:\TribalsBuild\TribalsSetup.exe"

InstallDir "$PROGRAMFILES64\${APP_NAME}"
RequestExecutionLevel admin

Icon "build\icon.ico"
UninstallIcon "build\icon.ico"

Page directory
Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

Section "Install"

    SetRegView 64

    SetOutPath "$INSTDIR"

    File /r "release\win-unpacked\*.*"

    ; Start Menu shortcut (all users)
    SetShellVarContext all
    CreateShortCut "$SMPROGRAMS\${APP_NAME}.lnk" "$INSTDIR\${APP_EXE}" "" "$INSTDIR\${APP_EXE}" 0 SW_SHOWNORMAL "" "${APP_NAME}"

    WriteUninstaller "$INSTDIR\Uninstall.exe"

    WriteRegStr HKLM "${UNINST_KEY}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKLM "${UNINST_KEY}" "UninstallString" '"$INSTDIR\Uninstall.exe"'
    WriteRegStr HKLM "${UNINST_KEY}" "DisplayIcon" "$INSTDIR\${APP_EXE}"
    WriteRegStr HKLM "${UNINST_KEY}" "InstallLocation" "$INSTDIR"
    WriteRegDWORD HKLM "${UNINST_KEY}" "NoModify" 1
    WriteRegDWORD HKLM "${UNINST_KEY}" "NoRepair" 1

SectionEnd

Section "Uninstall"

    SetRegView 64

    ; Remove the Start Menu shortcut
    SetShellVarContext all
    Delete "$SMPROGRAMS\${APP_NAME}.lnk"

    Delete "$INSTDIR\Uninstall.exe"

    RMDir /r "$INSTDIR"

    DeleteRegKey HKLM "${UNINST_KEY}"

SectionEnd
