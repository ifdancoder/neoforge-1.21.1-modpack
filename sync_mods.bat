@echo off
chcp 65001 >nul
title Синхронизация модов

set "REPO_URL=https://github.com/ifdancoder/neoforge-1.21.1-modpack"

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
    echo Папка не является Git-репозиторием.
    echo Выполняем первоначальную синхронизацию...

    git clone %REPO_URL% temp_repo
    if errorlevel 1 (
        echo Ошибка клонирования репозитория.
        pause
        exit /b
    )

    xcopy "temp_repo\*" "." /E /H /Y >nul
    if errorlevel 1 (
        echo Ошибка копирования файлов.
        rmdir /S /Q temp_repo
        pause
        exit /b
    )

    xcopy "temp_repo\.git" ".git" /E /H /I /Y >nul

    rmdir /S /Q temp_repo

    echo Репозиторий успешно инициализирован.
    pause
    exit /b
)

echo Обновляем файлы из репозитория...
git pull --recurse-submodules

echo Синхронизация завершена!
pause