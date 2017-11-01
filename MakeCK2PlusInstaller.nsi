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

; Get git tag
; if there is a tag on current commit just the tag will be used
; else use last tag + number of commits since the tag + short commit id.
!tempfile StdOut
!echo "${StdOut}"
!system '"git" describe --tags HEAD > "${StdOut}"'
!searchparse /file  "${StdOut}" "" VERSION_TAG
!delfile "${StdOut}"
!undef StdOut

; The name of the installer
Name "CK2Plus Mod"
; The file to write
OutFile "CK2Plus_${VERSION_TAG}.exe"

SetCompressor /SOLID lzma

; The default installation directory
InstallDir "$DOCUMENTS\Paradox Interactive\Crusader Kings II\mod"

; Request application privileges for Windows Vista/7/8/10
RequestExecutionLevel user

; ---------------------------
; Interface settings (optional)
; ---------------------------

!define MUI_ICON "CK2Plus_misc\installer\ck2plus.ico"
; Bitmap for the Welcome page and the Finish page (164x314 pixels)
!define MUI_WELCOMEFINISHPAGE_BITMAP "CK2Plus_misc\installer\ck2pluswelcome.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH

; ---------------------------
; Pages: Language -> Welcome -> License -> Directory -> Install -> Finish
; ---------------------------

!define MUI_WELCOMEPAGE_TITLE $(MUI_WELCOMEPAGE_TITLE)
!define MUI_WELCOMEPAGE_TITLE_3LINES
!define MUI_WELCOMEPAGE_TEXT $(MUI_WELCOMEPAGE_TEXT)
!insertmacro MUI_PAGE_WELCOME

!define MUI_PAGE_HEADER_TEXT $(MUI_PAGE_HEADER_TEXT)
!define MUI_PAGE_HEADER_SUBTEXT $(MUI_PAGE_HEADER_SUBTEXT)
!define MUI_LICENSEPAGE_TEXT_TOP $(MUI_LICENSEPAGE_TEXT_TOP)
!define MUI_LICENSEPAGE_TEXT_BOTTOM $(MUI_LICENSEPAGE_TEXT_BOTTOM)
!insertmacro MUI_PAGE_LICENSE $(license)

!define MUI_DIRECTORYPAGE_TEXT_DESTINATION $(MUI_DIRECTORYPAGE_TEXT_DESTINATION)
!define MUI_DIRECTORYPAGE_TEXT_TOP $(MUI_DIRECTORYPAGE_TEXT_TOP)
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_FINISHPAGE_TITLE $(MUI_FINISHPAGE_TITLE)
!define MUI_FINISHPAGE_TEXT $(MUI_FINISHPAGE_TEXT)
!define MUI_FINISHPAGE_TEXT_LARGE
!define MUI_FINISHPAGE_SHOWREADME "$INSTDIR\CK2PlusReadme.txt"
!define MUI_FINISHPAGE_SHOWREADME_NOTCHECKED
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

LangString MUI_WELCOMEPAGE_TITLE ${LANG_ENGLISH} "CK2Plus"
LangString MUI_WELCOMEPAGE_TEXT ${LANG_ENGLISH} "Hello and welcome to Plus!$\r$\n \
$\r$\n \
This installer will:$\r$\n \
- REMOVE ANY PREVIOUS VERSION of Plus$\r$\n \
- Clean the mod gfx cache$\r$\n \
- Install CK2Plus to your mod folder$\r$\n"
LangString MUI_DIRECTORYPAGE_TEXT_DESTINATION ${LANG_ENGLISH} "Please select your CK2 mod folder"
LangString MUI_FINISHPAGE_TITLE ${LANG_ENGLISH} "CK2Plus has been installed"
LangString MUI_FINISHPAGE_TEXT ${LANG_ENGLISH} "To play:$\r$\n \ 
- Open CK2 launcher.$\r$\n \
- Select the mod 'CK2Plus' in the Mod tab of the launcher.$\r$\n \
- Enjoy !$\r$\n \
$\r$\n \
CK2Plus Team"
LangString MUI_FINISHPAGE_SHOWREADME_TEXT ${LANG_ENGLISH} "Open the Readme"
LangString MUI_FINISHPAGE_LINK ${LANG_ENGLISH} "Go to CK2Plus forum"
LangString MUI_PAGE_HEADER_TEXT ${LANG_ENGLISH} "Disclaimer"
LangString MUI_PAGE_HEADER_SUBTEXT ${LANG_ENGLISH} "Please review the disclaimer file before installing CK2Plus mod."
LangString MUI_LICENSEPAGE_TEXT_TOP ${LANG_ENGLISH} "$\r$\n" ;"Press Page Down to see the rest of the disclaimer" - Our disclaimer fits perfectly
LangString MUI_LICENSEPAGE_TEXT_BOTTOM ${LANG_ENGLISH} "You must agree to this disclaimer before installing the mod."
LangString MUI_DIRECTORYPAGE_TEXT_TOP ${LANG_ENGLISH} "Setup will install CK2Plus Mod in the following folder.$\r$\n\
If this value is changed the game will not be able to locate the mod.$\r$\n\
$\r$\n\
WARNING: This action will remove any previous version of CK2Plus from CK2 mod folder!$\r$\n"
LicenseLangString license ${LANG_ENGLISH} "CK2Plus_misc\installer\CK2PlusDisclaimer.txt"