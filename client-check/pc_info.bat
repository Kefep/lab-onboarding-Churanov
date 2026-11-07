@echo off
chcp 65001

set "REPORT=%~dp0pc_report.txt"

echo              Диагностика компьютера
echo.

for /f "tokens=2 delims==" %%A in ('wmic os get Caption /format:list ^| more ^| findstr "Caption="') do set "OS_NAME=%%A"
for /f "tokens=2 delims==" %%A in ('wmic os get Version /format:list ^| more ^| findstr "Version="') do set "OS_VER=%%A"
echo Операционная система
echo --------------------
echo Название: %OS_NAME%
echo Версия:   %OS_VER%
echo.

for /f "tokens=2 delims==" %%A in ('wmic cpu get Name /format:list ^| more ^| findstr "Name="') do set "CPU_NAME=%%A"
echo Процессор
echo --------------------
echo %CPU_NAME%
echo.

for /f "tokens=2 delims==" %%A in ('wmic OS get TotalVisibleMemorySize /format:list ^| more ^| findstr "TotalVisibleMemorySize="') do set /a TOTAL_MEM=%%A/1048576
for /f "tokens=2 delims==" %%A in ('wmic OS get FreePhysicalMemory /format:list ^| more ^| findstr "FreePhysicalMemory="') do set /a FREE_MEM=%%A/1048576
echo Оперативная память
echo --------------------
echo Всего памяти: %TOTAL_MEM% ГБ
echo Свободно памяти: %FREE_MEM% ГБ
echo.

for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get Size /format:list ^| more ^| findstr "Size="') do set /a DISK_SIZE=%%A/1048576/1024
for /f "tokens=2 delims==" %%A in ('wmic logicaldisk where "DeviceID='C:'" get FreeSpace /format:list ^| more ^| findstr "FreeSpace="') do set /a DISK_FREE=%%A/1048576/1024
echo Диск C
echo --------------------
echo Всего на диске: %DISK_SIZE% ГБ
echo Свободно на диске: %DISK_FREE% ГБ
echo.

echo Установленные программы
echo --------------------
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName"
reg query "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName"
echo.

(
echo              Диагностика компьютера
echo.
echo Операционная система
echo --------------------
echo Название: %OS_NAME%
echo Версия:   %OS_VER%
echo.
echo Процессор
echo --------------------
echo %CPU_NAME%
echo.
echo Оперативная память
echo --------------------
echo Всего памяти: %TOTAL_MEM% ГБ
echo Свободно памяти: %FREE_MEM% ГБ
echo.
echo Диск C
echo --------------------
echo Всего на диске: %DISK_SIZE% ГБ
echo Свободно на диске: %DISK_FREE% ГБ
echo.
echo Установленные программы
echo --------------------
reg query "HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName"
reg query "HKLM\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall" /s | findstr "DisplayName"
) > "%REPORT%"

echo Отчёт сохранён
pause
