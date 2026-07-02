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
    echo Инициализируем репозиторий...

    git init
    if errorlevel 1 (
        echo Ошибка инициализации репозитория.
        pause
        exit /b
    )

    git remote add origin %REPO_URL%
    git fetch --depth 1 origin
    if errorlevel 1 (
        echo Ошибка получения данных из репозитория.
        pause
        exit /b
    )

    git checkout -b main origin/main
    if errorlevel 1 (
        git checkout -b master origin/master
    )

    echo Репозиторий успешно инициализирован.
    pause
    exit /b
)

echo Обновляем файлы из репозитория...
git pull --recurse-submodules

echo Синхронизация завершена!
pause