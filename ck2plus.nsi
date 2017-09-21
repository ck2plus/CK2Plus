; ck2plus.nsi
;
; Simple CK2 mod manual installer for Windows

; To generate the installer, download NSIS Unicode 2.46.5 from https://code.google.com/p/unsis/downloads/list
; and launch "Compile NSIS Unicode script" from context menu.
; Unicode is needed to support French accents.
; NSIS documentation:
; - MUI: http://nsis.sourceforge.net/Docs/Modern%20UI/Readme.html
; - Scripting reference: http://nsis.sourceforge.net/Docs/Chapter4.html

!include "MUI2.nsh"

; Mod configuration defined in .mod file, to know which folders to cleanup.
!define mod_path "CK2Plus"
!define mod_india_path "CK2Plus_India"

; The name of the installer
Name "CK2 Plus Mod"
; The file to write
OutFile "CK2Plus.exe"

; The default installation directory
InstallDir "$DOCUMENTS\Paradox Interactive\Crusader Kings II\mod"

; Request application privileges for Windows Vista/7/8/10
RequestExecutionLevel admin

; ---------------------------
; Interface settings (optional)
; ---------------------------

!define MUI_ICON "CK2Plus_misc\installer\ck2plus.ico"
; Bitmap for the Welcome page and the Finish page (164x314 pixels)
!define MUI_WELCOMEFINISHPAGE_BITMAP "CK2Plus_misc\installer\ck2pluswelcome.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH

; ---------------------------
; Pages: Language -> Welcome -> Directory -> Install -> Finish
; ---------------------------

!define MUI_WELCOMEPAGE_TITLE $(MUI_WELCOMEPAGE_TITLE)
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT $(MUI_WELCOMEPAGE_TEXT)
!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_LICENSE $(license)

!define MUI_DIRECTORYPAGE_TEXT_DESTINATION $(MUI_DIRECTORYPAGE_TEXT_DESTINATION)
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_TITLE $(MUI_FINISHPAGE_TITLE)
!define MUI_FINISHPAGE_TEXT $(MUI_FINISHPAGE_TEXT)
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\CK2PlusReadme.txt"
;!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
!define MUI_FINISHPAGE_SHOWREADME_TEXT $(MUI_FINISHPAGE_SHOWREADME_TEXT)
!define MUI_FINISHPAGE_LINK $(MUI_FINISHPAGE_LINK)
!define MUI_FINISHPAGE_LINK_LOCATION "https://forum.paradoxplaza.com/forum/index.php?forums/ck2-plus-mod.841/"
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!insertmacro MUI_PAGE_FINISH

;Languages - needs to be after page declarations
!insertmacro MUI_LANGUAGE English ;First language is the default if a better match is not found

; Un-install main mod 
Section "Uninstall previous"

  ; Remove directories and files recursively
  ; Only delete <path> folder of main mod, in case some files are removed from folders
  ; .mod files and other sub-mod files will always get overwritten during install.
  RMDir /r "$INSTDIR\${mod_path}"
  RMDir /r "$INSTDIR\${mod_india_path}"

SectionEnd

; Clean gfx cache
Section "Clean gfx cache"

  ; Delete <user_dir>/gfx folder
  RMDir /r "$INSTDIR\..\gfx"

SectionEnd

;--------------------------------

; Install mod and sub-mods
Section "Install"

  ; Set output path to the installation directory.
  SetOutPath "$INSTDIR"
  
  ; Copy mod files (excluding configuration files)
  File "CK2Plus_misc\installer\CK2PlusReadme.txt" ; Copy readme to open it after installation
  File "${mod_path}.mod" ; Copy main .mod descriptor
  File "${mod_india_path}.mod" ; Copy submod .mod descriptor
  CreateDirectory "$INSTDIR\${mod_path}"
  CreateDirectory "$INSTDIR\${mod_india_path}"
  SetOutPath "$INSTDIR\${mod_path}"
  File /r "${mod_path}\*"
  SetOutPath "$INSTDIR\${mod_india_path}"
  File /r "${mod_india_path}\*"
  
SectionEnd

; ---------------------------
; Localization
; ---------------------------

LangString MUI_WELCOMEPAGE_TITLE ${LANG_ENGLISH} "CK2 Plus"
LangString MUI_WELCOMEPAGE_TEXT ${LANG_ENGLISH} "This installer will:$\r$\n \
1) Remove any previously installed version of the CK2 Plus mod$\r$\n \
2) Clean the mod gfx cache$\r$\n \
3) Install CK2 Plus to your mod folder$\r$\n"
LangString MUI_DIRECTORYPAGE_TEXT_DESTINATION ${LANG_ENGLISH} "Please select your CK2 mod folder"
LangString MUI_FINISHPAGE_TITLE ${LANG_ENGLISH} "CK2 Plus has been installed"
LangString MUI_FINISHPAGE_TEXT ${LANG_ENGLISH} "To play:$\r$\n \ 
- Open CK2 launcher.$\r$\n \
- Select the mod 'CK2Plus' in the Mod tab of the launcher.$\r$\n \
- Enjoy !$\r$\n"
LangString MUI_FINISHPAGE_SHOWREADME_TEXT ${LANG_ENGLISH} "Open the Changelog"
LangString MUI_FINISHPAGE_LINK ${LANG_ENGLISH} "Go to CK2Plus forum"
LicenseLangString license ${LANG_ENGLISH} "CK2Plus_misc\installer\CK2PlusReadme.txt"