#!/bin/bash
PROCESS_NAME=test
LOG_FILE="/var/log/monitoring.log"
URL="https://test.com/monitoring/test/api"
PID_FILE="/tmp/${PROCESS_NAME}_monitor.pid"

#текущий процесс
CURRENT_PID=$(pgrep -o "$PROCESS_NAME")
EARLY_PID=$(cat "$PID_FILE" 2>/dev/null)

#реализация условий
if [[ -n "$CURRENT_PID" ]]; then
    #сравнение процессов
    if [[ "$CURRENT_PID" != "$EARLY_PID" ]]; then 
        #если отличается, то делаем следующие записи
        echo "$(date) - Процесс $PROCESS_NAME был перезапущен. Новый PID: "$CURRENT_PID" >> "$LOG_FILE"
        echo "$CURRENT_PID" > "$PID_FILE"
    fi

    #проверка доступности сервера мониторинга
    if curl -s --head --request GET "$MONITORING_URL" | grep "200 OK" > /dev/null; then
        curl -s -X GET "$MONITORING_URL" > /dev/null
    else 
         echo "$(date) - Сервер мониторинга недоступен" >> "$LOG_FILE"
    fi
fi        