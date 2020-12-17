@echo off

REM Replace ':' by '-'
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=feed_me.txt"
set "OUTTEXTFILE=del_str.txt"
set "SEARCHTEXT=:"
set "REPLACETEXT= -"

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Replace '/' by '-'
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=feed_me.txt"
set "OUTTEXTFILE=del_str.txt"
set "SEARCHTEXT=/"
set "REPLACETEXT=-"

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Replace '?' by ''
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=feed_me.txt"
set "OUTTEXTFILE=del_str.txt"
set "SEARCHTEXT=?"
set "REPLACETEXT="

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Replace '(In Progress)' by ''
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=feed_me.txt"
set "OUTTEXTFILE=del_str.txt"
set "SEARCHTEXT=(In Progress)"
set "REPLACETEXT="

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Replace '(Viewed)' by ''
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=feed_me.txt"
set "OUTTEXTFILE=del_str.txt"
set "SEARCHTEXT=(Viewed)"
set "REPLACETEXT="

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Deleting lines for output
FINDSTR /v "Save" feed_me.txt > 1st_change.txt
FINDSTR /v "[0-9]m [0-9]s" 1st_change.txt > 2nd_change.txt
FINDSTR /v "Chapter Quiz" 2nd_change.txt > 3th_change.txt
FINDSTR /v "question" 3th_change.txt > 4th_change.txt

REM Partie Dossiers
echo 0. Introduction > folders.txt
FINDSTR /b "[0-9]" 4th_change.txt >> folders.txt
REM echo Conclusion >> folders.txt

REM Count how many line
@echo off
cls
setlocal EnableDelayedExpansion
set "cmd=findstr /R /N "^^" folders.txt | find /C ":""

for /f %%a in ('!cmd!') do set number=%%a

echo %number%. Conclusion >> folders.txt

REM Creating folders
@echo off
REM "delims" ou "tokens"
for /f "delims=*" %%a in (folders.txt) do (

mkdir "%%a"

)

del 1st_change.txt
del 2nd_change.txt
del 3th_change.txt

REM Modifier uniquement la première ligne
REM ))>"%newfile%"
set "search=Introduction"
set "replace=0. Introduction"
set "textfile=4th_change.txt"
set "newfile=final.txt"
set lineNr=0
(for /f "delims=" %%i in (%textfile%) do (
    set /a lineNr+=1
    set "line=%%i"
    setlocal enabledelayedexpansion
    if !lineNr!==1 set "line=!line:%search%=%replace%!"
    echo(!line!
    endlocal
)>>"%newfile%")

del 4th_change.txt

REM Replace 'Conclusion' by '%number%. Conclusion'
@echo off
setlocal EnableExtensions EnableDelayedExpansion
set "INTEXTFILE=final.txt"
set "OUTTEXTFILE=perfect.txt"
set "SEARCHTEXT=Conclusion"
set "REPLACETEXT=%number%. Conclusion"

for /f "delims=" %%A in ('type "%INTEXTFILE%"') do (
    set "string=%%A"
    set "modified=!string:%SEARCHTEXT%=%REPLACETEXT%!"
    echo !modified!>>"%OUTTEXTFILE%"
)

del "%INTEXTFILE%"
rename "%OUTTEXTFILE%" "%INTEXTFILE%"
endlocal

REM Retirer les noms des chapitres (affiche uniquement les lignes NE commançant PAS (^) par un nombre ([0-9])
FINDSTR /b "[^0-9]" final.txt > "LLV Download/rename.txt

del folders.txt

REM ren final.txt mon_doc.doc