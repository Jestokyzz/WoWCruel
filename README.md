# WoWCruel

Актуальная серверная сборка JestokyCraft для World of Warcraft 3.3.5a (build 12340).

Готовый комплект опубликован в GitHub Release и разделён на архивы бинарников, данных карт и установочных файлов. Архив не содержит игровых аккаунтов, персонажей, паролей, приватных конфигураций, журналов или дампов рабочей базы.

## Состав

- Собранные `authserver.exe`, `worldserver.exe`, `dbimport.exe` и runtime DLL.
- `dbc`, `maps`, `vmaps`, `mmaps`.
- MySQL Community Server 8.4.10 с лицензией.
- Чистые схемы AzerothCore и Playerbots, миграция актуального игрового мира.
- Исходники собственных модулей и патчи к закреплённым версиям AzerothCore/Playerbots.
- Шаблоны конфигурации без секретов.

## Установка

1. Распакуйте все архивы Release в одну папку `WoWCruel`.
2. Запустите PowerShell от обычного пользователя и выполните `Set-ExecutionPolicy -Scope Process Bypass`.
3. Выполните `./Initialize-Server.ps1`. Скрипт создаёт локальные пустые базы и случайный пароль.
4. Проверьте адрес realm и сетевые порты в `bin/configs`, затем запустите `Start-Server.ps1`.

Это серверный комплект. Клиент JestokyCraft распространяется отдельно.

## Происхождение

База: AzerothCore ветка Playerbot и mod-playerbots. Точные upstream commit указаны в `upstream.json`. Лицензии зависимостей находятся в `LICENSES` и в соответствующих каталогах.
