!ifndef GOG_ENHANCEMENT_PACK_NSI ; If Steam
    !define MUI_WELCOMEPAGE_TEXT "\
    This is an Enhancement Pack for Resident Evil 3 Steam, with:$\r$\n\
    - Downgrade to GOG version (including GOG's DX Wrapper)$\r$\n\
    - Resident Evil 3 Classic REbirth (by Gemini)$\r$\n\
    - Modern Controls Mods$\r$\n\
    - Translation patches$\r$\n\
    - Resident Evil 3 HD Mod (by TeamX)$\r$\n\
    - Seamless HD Project v2.0 Patch 2 (by RESHDP)$\r$\n\
    - RE-Enhance v2.0.1 (by SonicB00M)$\r$\n\
    - High Quality FMVs$\r$\n\
    - High Quality Audio (by lexas87)$\r$\n\
    - MulderConfig$\r$\n\
    $\r$\n\
    ${TXT_WELCOMEPAGE_MULDERLAND_2}$\r$\n\
    $\r$\n\
    Special thanks to the Classic REbirth team!"

    !include "..\..\includes\tools\7z.nsh"
    !include "..\..\includes\tools\XDelta3.nsh"
    !include "..\..\includes\templates\SelectTemplate.nsh"

    Name "Resident Evil 3 [Steam Enhancement Pack]"
!endif

Var /GLOBAL REBIRTHDIR

Section
    !ifdef GOG_ENHANCEMENT_PACK_NSI
        StrCpy $REBIRTHDIR "$INSTDIR"
    !else
        StrCpy $REBIRTHDIR "$INSTDIR\rebirth"
    !endif
SectionEnd

!ifndef GOG_ENHANCEMENT_PACK_NSI
    Section "Downgrade Steam to GOG v1.0 hotfix 4" gog_downgrade
        AddSize 45204
        SetOutPath "$INSTDIR"

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/downgrade/Steam to GOG v1.0 hotfix 4 [MLD].7z" \
                                "Steam to GOG v1.0 hotfix 4 [MLD].7z" \
                                "fcb163b8dc298817f79670e573090dc713e7ec0d"

        !insertmacro NSIS7Z_EXTRACT "Steam to GOG v1.0 hotfix 4 [MLD].7z" ".\" "AUTO_DELETE"
    SectionEnd
!endif

SectionGroup "Resident Evil 3 Classic REbirth (by Gemini)"
    Section
        SetOutPath "$INSTDIR"

        !ifdef GOG_ENHANCEMENT_PACK_NSI
            # If GOG: disable unwanted files
            !insertmacro FORCE_RENAME "$INSTDIR\BH3Launcher.exe" "$INSTDIR\BH3Launcher.exe.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\Bio3_PC.exe" "$INSTDIR\Bio3_PC.exe.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\Bio3_PC_Mercenaries.exe" "$INSTDIR\Bio3_PC_Mercenaries.exe.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\ddraw.dll" "$INSTDIR\ddraw.dll.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\dinput.dll" "$INSTDIR\dinput.dll.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\dshow.dll" "$INSTDIR\dshow.dll.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.exe" "$INSTDIR\dxcfg.exe.bak"
            !insertmacro FORCE_RENAME "$INSTDIR\dxcfg.ini" "$INSTDIR\dxcfg.ini.bak"
        !else
            # If Steam: copy files to a new "rebirth" folder
            AddSize 321536
            CreateDirectory "$INSTDIR\rebirth"
            ${IfNot} ${FileExists} "$INSTDIR\rebirth\*.dat"
                CopyFiles /SILENT /FILESONLY "$INSTDIR\japanese\bio3.ini" "$INSTDIR\rebirth"
                CopyFiles /SILENT /FILESONLY "$INSTDIR\japanese\*.dat" "$INSTDIR\rebirth"
            ${EndIf}
        !endif

        SetOutPath "$REBIRTHDIR"

        # Sourcenext Update
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/update/Sourcenext Update [MLD].7z" \
                                "Sourcenext Update [MLD].7z" \
                                "29f132c9cf36a03f029d78821e2ae2316988276b"

        !insertmacro NSIS7Z_EXTRACT "Sourcenext Update [MLD].7z" ".\" "AUTO_DELETE"
        !insertmacro XDELTA3_GET
        !insertmacro XDELTA3_PATCH_FOLDER "$REBIRTHDIR"
        !insertmacro XDELTA3_REMOVE
        AddSize 94

        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/fix/v1.1.0 Uncensored + Music Loop Fix [Repack-MLD].7z" \
                                "v1.1.0 Uncensored + Music Loop Fix [Repack-MLD].7z" \
                                "c4f52f62732f400aa3230d74291fe93a670f9510"

        !insertmacro NSIS7Z_EXTRACT "v1.1.0 Uncensored + Music Loop Fix [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 11916
        !ifdef GOG_ENHANCEMENT_PACK_NSI
            !insertmacro FORCE_RENAME "bio3 Uncensored.EXE" "BH3Launcher.exe"
        !else
            !insertmacro FORCE_RENAME "bio3 Uncensored.EXE" "BIOHAZARD(R) 3 PC.exe"
        !endif

        # Classic REbirth DLL
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_misc/re3cr-2021-08-04.7z" \
                                "re3cr-2021-08-04.7z" \
                                "6748b432ff69e923d5bf29fccf3e18c68afb218b"

        !insertmacro NSIS7Z_EXTRACT "re3cr-2021-08-04.7z" ".\" "AUTO_DELETE"
        AddSize 4566

        # Clocktower Bug Fix
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/fix/Clocktower Bugfix [MLD].7z" \
                                "Clocktower Bugfix [MLD].7z" \
                                "6fde3f4086573a8bf264192d147dc4d1db8579d4"

        !insertmacro NSIS7Z_EXTRACT "Clocktower Bugfix [MLD].7z" ".\" "AUTO_DELETE"
        AddSize 9

        # Clocktower Bug Fix 2
        !ifdef GOG_ENHANCEMENT_PACK_NSI
            WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$REBIRTHDIR\BH3Launcher.exe" "~ DISABLEDXMAXIMIZEDWINDOWEDMODE"
        !else
            WriteRegStr HKCU "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$REBIRTHDIR\BIOHAZARD(R) 3 PC.exe" "~ DISABLEDXMAXIMIZEDWINDOWEDMODE"
        !endif

        # XAudio DLL
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/tools/xaudio/xaudio2_9.dll" \
                                "xaudio2_9.dll" \
                                "cf9b9ae1237b1094bead8d44ef65c55a19ec325e"

        AddSize 719

        # Apply 4GB Patch
        !insertmacro DOWNLOAD_2 "https://cdn.mulderload.eu/tools/ntcore/4gb_patch.zip" \
                                "https://ntcore.com/files/4gb_patch.zip" \
                                "4gb_patch.zip" \
                                "c8b0d61937cb54fc8215124c0f737a1d29479c97"

        !insertmacro NSISUNZ_EXTRACT "4gb_patch.zip" ".\" "AUTO_DELETE"
        !ifdef GOG_ENHANCEMENT_PACK_NSI
            ExecWait '4gb_patch.exe "BH3Launcher.exe"' $0
        !else
            ExecWait '4gb_patch.exe "BIOHAZARD(R) 3 PC.exe"' $0
        !endif
        Delete "4gb_patch.exe"
        AddSize 5956
    SectionEnd

    Section "Modern Controls+ v1.2 (by X4vv, Rebrond)"
        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevil3nemesis/mods/73?tab=files&file_id=313" \
                                "$REBIRTHDIR\mod_ModernControlsPlus.7z" \
                                "b867d4362b819dd1cfb4894c84213045fa65e823"
        AddSize 68
    SectionEnd

    Section "Quick Knife Mod v1.1 (by X4vv)"
        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevil3nemesis/mods/72?tab=files&file_id=307" \
                                "$REBIRTHDIR\mod_quickknife.7z" \
                                "5366ab0583491baa36ef2ef266a390b0453caa94"
        AddSize 48
    SectionEnd
SectionGroupEnd

SectionGroup "Translation patches"
    Section /o "French patch (by GazousGit)"
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/translation/mod_fr_v20260518.7z" \
                                "mod_fr_v20260518.7z" \
                                "dcdbc5ad6569ea55065ae2ca7ce51b19a9fec258"
        AddSize 342
    SectionEnd

    Section /o "German patch (by Accandon)"
        SetOutPath "$REBIRTHDIR"
        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevil3nemesis/mods/5?tab=files&file_id=123" \
                                "Mod_BH3_DEU_1_2-5-1-2-0-1727483006.zip" \
                                "c8bffda3ecae81f27ae88db1212095aab15c8d4d"

        !insertmacro NSISUNZ_EXTRACT "Mod_BH3_DEU_1_2-5-1-2-0-1727483006.zip" ".\" "AUTO_DELETE"
        AddSize 2817
    SectionEnd

    Section /o "Spanish HD patch (by LeigiBoy, DannyDMF)"
        SetOutPath "$REBIRTHDIR"

        !insertmacro 7Z_GET

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevil3nemesis/mods/4?tab=files&file_id=11" \
                                "RE3 Spanish Tranlation-4-1-0-1622918098.rar" \
                                "59a6a98b23eb2045c8abfbd9f4828f8c330498f2"

        !insertmacro 7Z_EXTRACT "RE3 Spanish Tranlation-4-1-0-1622918098.rar" ".\" "AUTO_DELETE"
        AddSize 2975

        !insertmacro DOWNLOAD_1 "https://www.nexusmods.com/residentevil3nemesis/mods/31?tab=files&file_id=94" \
                                "RE3 Nemesis Spanish HD-31-1-02-1703275848.rar" \
                                "adf0cd5430a717180a6ae0ad58965958da9de147"

        !insertmacro 7Z_EXTRACT "RE3 Nemesis Spanish HD-31-1-02-1703275848.rar" ".\" "AUTO_DELETE"
        !insertmacro FOLDER_MERGE "$REBIRTHDIR\RE3 Nemesis Castellano HD" "$REBIRTHDIR"
        AddSize 8684

        !insertmacro 7Z_REMOVE
    SectionEnd
SectionGroupEnd

SectionGroup "Graphical improvements"
    Section "RE 3 HD Mod v20220716 (by TeamX)" gfx1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-3-hd-mod/downloads/resident-evil-3-hd-mod (repacked, see README for more information)
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_gfx/Resident_Evil_3_HD_mod_v20220716 [Repack-MLD].7z" \
                                "Resident_Evil_3_HD_mod_v20220716 [Repack-MLD].7z" \
                                "fd86b5ba762a7caea237610154737f44fe5a1a15"

        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_3_HD_mod_v20220716 [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 83064

        # Get latest Ultimate ASI Loader
        !insertmacro DOWNLOAD_1 "https://github.com/ThirteenAG/Ultimate-ASI-Loader/releases/download/Win32-latest/dinput8-Win32.zip" \
                                "dinput8-Win32.zip" \
                                ""

        !insertmacro NSISUNZ_EXTRACT_ONE "dinput8-Win32.zip" ".\" "dinput8.dll" "AUTO_DELETE"
        AddSize 5264

        # Get patched asi for Linux/Deck
        !insertmacro DETECT_OS $R0
        ${If} $R0 == "Linux"
            DetailPrint " // HD Mod: Linux/Deck detected, download patched asi"
            !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_gfx/RE3-Linux.zip" \
                                    "RE3-Linux.zip" \
                                    "70ccfce8c1d3946c2bb1757116cb4e2d21ea254f"

            !insertmacro NSISUNZ_EXTRACT_ONE "RE3-Linux.zip" ".\" "bio3hd.asi" "AUTO_DELETE"
        ${EndIf}
        Pop $R0
    SectionEnd

    Section "Seamless HD Project v2.0 (by RESHDP)" gfx2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-3-nemesis-seamless-hd-project/downloads/resident-evil-3-nemesis-seamless-hd-project-for-pc-sourcenext (repacked, see README for more information)
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_gfx/RE3_SHDP_2.0_update_for_TeamX_HD_patch [Repack-MLD].7z" \
                                "RE3_SHDP_2.0_update_for_TeamX_HD_patch [Repack-MLD].7z" \
                                "ac731650f2310e3174c5dea459e98af4e7f953ca"

        !insertmacro NSIS7Z_EXTRACT "RE3_SHDP_2.0_update_for_TeamX_HD_patch [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 78926
    SectionEnd

    Section "RE-Enhance RE3 v2.2 (by SonicB00M)" gfx3
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/reenhance-re3/downloads/re-enhance-re3-v22" \
                                "RE-ENHANCE_RE3_v2.2.zip" \
                                "41d9137e2a5250740bde71da3dc4eb11"

        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE3_v2.2.zip" ".\" "AUTO_DELETE"
        AddSize 1357902
    SectionEnd
SectionGroupEnd

SectionGroup "High Quality FMVs" fmv
    Section "960p - RE-Enhance FMV 1.0 (by SonicB00M)" fmv1
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_1 "https://www.moddb.com/mods/reenhance-re3/downloads/re-enhance-re3-fmv-pack-v10" \
                                "RE-ENHANCE_RE3_FMV-Pack_V1.0.zip" \
                                "2ecba4d9ed4699e89b41d1d23f7d260d"

        !insertmacro NSISUNZ_EXTRACT "RE-ENHANCE_RE3_FMV-Pack_V1.0.zip" ".\" "AUTO_DELETE"
        Delete "zmovie\snl_SOURCENEXT.dat"
        AddSize 837305
    SectionEnd

    Section /o "960p - FMVs from HD Mod (by TeamX)" fmv2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/resident-evil-hd-mod (repacked to keep only videos)
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_video/Resident_Evil_3_HD_mod_v20220716 [Videos-MLD].7z" \
                                "Resident_Evil_3_HD_mod_v20220716 [Videos-MLD].7z" \
                                "9f0a30d1887728b3f6852c79e7c8b164cc9ae2eb"

        !insertmacro NSIS7Z_EXTRACT "Resident_Evil_3_HD_mod_v20220716 [Videos-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 430347
    SectionEnd

    Section /o "480p - FMVs from Sourcenext release" fmv3
        SetOutPath "$REBIRTHDIR"

        !insertmacro DOWNLOAD_RANGE "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_video/Sourcenext Videos [MLD].7z.001" \
                                    "Sourcenext Videos [MLD].7z.001" \
                                    "360467c3d9c6141d6e0aa60884dc6ad2eb19486c" \
                                    3

        !insertmacro NSIS7Z_EXTRACT "Sourcenext Videos [MLD].7z.001" ".\" ""
        !insertmacro DELETE_RANGE "Sourcenext Videos [MLD].7z.001" 3
        AddSize 1668823
    SectionEnd
SectionGroupEnd

SectionGroup "High Quality Audio v2023 (by lexas87)" audio
    # https://archive.org/download/resident-evil-classic-trilogy-hd-mod/Resident%20Evil%203%20-%20Classic%20REbirth%20HQ%20%5BOST%20%26%20OST%20ARRANGED%5D%2008-11-2023.zip/ (repacked)

    Section "High Quality Audio - Lossless version" audio1
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/re3-high-quality-audio/downloads/re3-high-quality-audio-v2023 (Repack)
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_audio/Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Lossless [Repack-MLD].7z" \
                                "Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Lossless [Repack-MLD].7z" \
                                "54fe9c29600371410128f98266a54923348b4bbb"

        !insertmacro NSIS7Z_EXTRACT "Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Lossless [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 727083
    SectionEnd

    Section /o "High Quality Audio - Dreamcast version" audio2
        SetOutPath "$REBIRTHDIR"

        # https://www.moddb.com/mods/re3-high-quality-audio/downloads/re3-high-quality-audio-v2023 (Repack)
        !insertmacro DOWNLOAD_1 "https://cdn.mulderload.eu/games/resident-evil-3-nemesis/impr_audio/Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Dreamcast [Repack-MLD].7z" \
                                "Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Dreamcast [Repack-MLD].7z" \
                                "21ba9a3d4e825b5028e0a6d8b0dccd3a2f4f8810"

        !insertmacro NSIS7Z_EXTRACT "Resident Evil 3 Classic REbirth HQ Audio 08-11-2023 Dreamcast [Repack-MLD].7z" ".\" "AUTO_DELETE"
        AddSize 715313
    SectionEnd
SectionGroupEnd

!ifdef GOG_ENHANCEMENT_PACK_NSI
    Section
        # Copy readme
        SetOutPath "$INSTDIR\@mulderload"
        File "resources\gog\README.txt"
    SectionEnd
!else
    Section
        # Copy readme
        SetOutPath "$INSTDIR\@mulderload"
        File "resources\steam\README.txt"
    SectionEnd

    Section "MulderConfig (latest)"
        !insertmacro INSTALL_MULDERCONFIG "$INSTDIR" "resources\steam"
    SectionEnd

    SectionGroup "Free space by removing Non-REbirth files"
        Section /o "Remove english files (keep saves)"
            RMDir /r "$INSTDIR\english\zmovie"
            Delete "$INSTDIR\english\*.*"
        SectionEnd

        Section /o "Remove french files (keep saves)"
            RMDir /r "$INSTDIR\french\zmovie"
            Delete "$INSTDIR\french\*.*"
        SectionEnd

        Section /o "Remove german files (keep saves)"
            RMDir /r "$INSTDIR\german\zmovie"
            Delete "$INSTDIR\german\*.*"
        SectionEnd

        Section /o "Remove italian files (keep saves)"
            RMDir /r "$INSTDIR\italian\zmovie"
            Delete "$INSTDIR\italian\*.*"
        SectionEnd

        Section /o "Remove japanese files (keep saves)"
            RMDir /r "$INSTDIR\japanese\zmovie"
            Delete "$INSTDIR\japanese\*.*"
        SectionEnd

        Section /o "Remove spanish files (keep saves)"
            RMDir /r "$INSTDIR\spanish\zmovie"
            Delete "$INSTDIR\spanish\*.*"
        SectionEnd
    SectionGroupEnd

    Function .onInit
        StrCpy $8 ${audio1} ; Radio Button
        StrCpy $9 ${fmv1} ; Radio Button
        StrCpy $SELECT_FILENAME "4249120_Launcher.exe"
        StrCpy $SELECT_STEAM_FOLDER "4249120_Biohazard3"
    FunctionEnd
!endif

Function .onSelChange
    # Graphics options are a dependency chain: gfx1 <- gfx2 <- gfx3
    # Selecting a later layer force-selects its prerequisite(s).
    ${If} ${SectionIsSelected} ${gfx3}
        !insertmacro SelectSection ${gfx2}
    ${EndIf}
    ${If} ${SectionIsSelected} ${gfx2}
        !insertmacro SelectSection ${gfx1}
    ${EndIf}
    # Deselecting an earlier layer force-deselects everything built on top of it.
    ${IfNot} ${SectionIsSelected} ${gfx1}
        !insertmacro UnselectSection ${gfx2}
        !insertmacro UnselectSection ${gfx3}
    ${EndIf}
    ${IfNot} ${SectionIsSelected} ${gfx2}
        !insertmacro UnselectSection ${gfx3}
    ${EndIf}

    # FMV options are strict radio buttons (1 mandatory choice)
    ${If} ${SectionIsSelected} ${fmv}
        !insertmacro UnSelectSection ${fmv}
        !insertmacro SelectSection $9
    ${Else}
        !insertmacro StartRadioButtons $9
            !insertmacro RadioButton ${fmv1}
            !insertmacro RadioButton ${fmv2}
            !insertmacro RadioButton ${fmv3}
        !insertmacro EndRadioButtons
    ${EndIf}

    # Audio options are lax radio buttons (0 or 1 choice)
    ${If} ${SectionIsSelected} ${audio}
        !insertmacro UnSelectSection ${audio}
    ${Else}
        ${If} ${SectionIsSelected} ${audio1}
        ${OrIf} ${SectionIsSelected} ${audio2}
            !insertmacro StartRadioButtons $8
                !insertmacro RadioButton ${audio1}
                !insertmacro RadioButton ${audio2}
            !insertmacro EndRadioButtons
        ${EndIf}
    ${EndIf}
FunctionEnd
