@echo off
chcp 65001 >nul
title Синхронизация модов

echo Поиск Git...
where git >nul 2>nul
if errorlevel 1 (
    echo ОШИБКА: Git не установлен или не добавлен в PATH.
    echo Скачайте: https://git-scm.com/download/win
    pause
    exit /b
)

echo Проверяем репозиторий...
if not exist ".git" (
    echo Папка .git не найдена. Клонируем репозиторий...
    git clone --depth 1 %~dp0 temp_repo
    if errorlevel 1 (
        echo Ошибка клонирования. Проверьте URL вручную.
        pause
        exit /b
    )
    xcopy /E /I /Y "temp_repo\mods" "mods"
    xcopy /E /I /Y "temp_repo\config" "config" 2>nul
    rd /S /Q "temp_repo"
    echo Готово!
    pause
    exit /b
)

echo Обновляем файлы из репозитория...
git pull --recurse-submodules

echo Копируем папку mods в корень...
xcopy /E /I /Y ".git\..\mods" "mods" 2>nul
echo Копируем config (если есть)...
xcopy /E /I /Y ".git\..\config" "config" 2>nul

echo Синхронизация завершена!
pause