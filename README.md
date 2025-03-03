# test_bash
Написать скрипт на bash для мониторинга процесса test в среде linux. Скрипт должен отвечать следующим требованиям:
    1.  Запускаться при запуске системы (предпочтительно написать юнит systemd в дополнение к скрипту)
    2.  Отрабатывать каждую минуту
    3.  Если процесс запущен, то стучаться(по https) на https://test.com/monitoring/test/api
    4.  Если процесс был перезапущен, писать в лог /var/log/monitoring.log (если процесс не запущен, то ничего не делать) 
    5.  Если сервер мониторинга не доступен, так же писать в лог.


1. bash файл test.sh
для его запуска нужны следующие команды:
#расположение 
sudo mv test.sh /usr/local/bin/ 
#делаем файл исполняемым
sudo chmod +x /usr/local/bin/test.sh

2. Создание юнит systemd
файл test.service и test.timer в /etc/systemd/system

sudo systemctl daemon-reload
sudo systemctl enable test.timer
sudo systemctl start test.timer
