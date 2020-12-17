@echo off

mkdir "en projet"
echo en projet > "en projet"/"en projet".txt
call :END

:COMMENT1
i = 1
ajoute i + ". " + ligne
i+=1
if (je rencontre un nombre) // chapitre
alors i = 1

:COMMENT2
for /f "delims=*" %%a in (rename.txt) do (

ren * "%%a".mp4
move "*.mp4" "/test/"*.mp4"

)

:END
EXIT /B 0