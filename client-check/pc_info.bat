@echo off
chcp 65001 >nul
set REPORT=%~dpOpc_report.txt

echo 
ДИАГНОСТИКА СИСТЕМЫ
echo.

echo Операционная система:
wmic os get Caption,Version /format:list | findstr /r "Caption= Version="
echo.


echo Процессор:
wmic cpu get Name /format:list | findstr "Name= "
echo.


echo Оперативная память:

for /f "tokens=2 delims==" %%A in('wmic OS get TotalVisibleMemorySize /value ^| findstr "="') do set TOTAL_MEM=%%A
for /f "tokens=2 delims==" %%A in('wmic OS get FreePhysicalMemory /value ^| findstr "="') do set FREE_MEM=%%A

set /a TOTAL_GB=%TOTAL_MEM% / 1048576
set /a FREE_GB=%FREE_MEM% / 1048576

echo Всего памяти: %TOTAL_GB% ГБ
echo Свободно памяти: %FREE_GB% ГБ
echo.


echo Диск C:

for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get Size /value ^| findstr "="') do set DISK_SIZE=%%A
for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /value ^| findstr "="') do set DISK_FREE=%%A

set /a DISK_SIZE_GB=%DISK_SIZE% / 1073741824
set /a DISK_FREE_GB=%DISK_FREE% / 1073741824

echo Общий размер:  %DISK_SIZE_GB% ГБ
echo Свободно:      %DISK_FREE_GB% ГБ
echo.


echo Установленные программы:
echo Поиск...
wmic product get Name /format:list | findstr "Name="
echo.


wmic os get Caption,Version /format:list | findstr /r "Caption= Version"
wmic os get Caption,Version /format:list | findstr /r "Caption= Version" >> "%REPORT%"


pause
