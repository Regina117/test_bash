# test_bash

Написать скрипт на bash для мониторинга процесса `test` в среде Linux. Скрипт должен отвечать следующим требованиям:

1. Запускаться при запуске системы (предпочтительно написать юнит `systemd` в дополнение к скрипту).
2. Отрабатывать каждую минуту.
3. Если процесс запущен, то отправлять запрос по HTTPS на `https://test.com/monitoring/test/api`.
4. Если процесс был перезапущен, писать в лог `/var/log/monitoring.log` (если процесс не запущен, то ничего не делать).
5. Если сервер мониторинга недоступен, также писать в лог.

## Решение

### 1. Bash-скрипт `test.sh`

Для его запуска выполните следующие команды:

Перемещение скрипта в нужное расположение
sudo mv test.sh /usr/local/bin/

Делаем файл исполняемым
sudo chmod +x /usr/local/bin/test.sh

### 2. Создание юнита systemd

Создайте файлы test.service и test.timer в директории /etc/systemd/system.

После создания файлов выполните следующие команды:


Перезагрузка демона systemd
sudo systemctl daemon-reload

Включение таймера
sudo systemctl enable test.timer

Запуск таймера
sudo systemctl start test.timer

### 3. Файлы

test.sh — скрипт для мониторинга процесса.

test.service — юнит для управления скриптом через systemd.

test.timer — таймер для запуска скрипта каждую минуту.

### 4. Логи

Логи будут записываться в файл /var/log/monitoring.log.

### 5. Проверка работы

Запустить скрипт и проверить логи
test.sh
cat /var/log/monitoring.log

sudo systemctl status test.service

проверяем работу таймера:
sudo systemctl list-timers --all | grep test.timer