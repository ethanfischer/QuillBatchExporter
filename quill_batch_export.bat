@echo off
REM Writing a list of folders in the current directory to quill_projects.txt
break > quill_projects.txt
set location=%~dp0%
for /d %%i in (*) do ( 
    @echo %location:\=/%%%i>>quill_projects.txt
)
REM Read the project path from quill_projects.txt. 
REM Write the settings.json file for the project to be exported. 
REM Export the project.
REM Repeat.
for /F "tokens=*" %%a in (quill_projects.txt) do (
    @echo {                                                  >  settings.json 
    @echo    "Exporter": "FBX",                              >> settings.json
    @echo    "InputFile": "%%a",                             >> settings.json
    @echo    "ExtraInputs": [],                              >> settings.json
    @echo    "Options":                                      >> settings.json      
    @echo    {                                               >> settings.json
    @echo        "BakeTransforms": false,                    >> settings.json      
    @echo        "ExcludeList": [],                          >> settings.json
    @echo        "UseFullNames": false,                      >> settings.json      
    @echo        "ExportCurves": false,                      >> settings.json      
    @echo        "ExportHidden": true,                       >> settings.json      
    @echo        "ExportMeshes": true,                       >> settings.json      
    @echo        "Scale": 100.0,                             >> settings.json      
    @echo        "UVSafetyBandTexels": 8.0,                  >> settings.json      
    @echo        "GroupExtraInputs": false,                  >> settings.json      
    @echo        "Optimize":                                 >> settings.json      
    @echo        {                                           >> settings.json      
    @echo            "Optimize": false,                      >> settings.json      
    @echo            "OptimizeKeepOldLayers": false,         >> settings.json      
    @echo            "OptimizeSimplifyThreshhold": 0.02,     >> settings.json      
    @echo            "OptimizeIncludeList": []               >> settings.json
    @echo        }                                           >> settings.json      
    @echo    },                                              >> settings.json      
    @echo    "OutputFile": "%%a"                             >> settings.json
    @echo }                                                  >> settings.json
    start /b /wait QuillExporter.exe settings.json
)