## Наш скрипт:
```
cd /dir/
#переходим в необходимую директорию
base64 /dev/urandom | head -c 10000000 > file1.txt
#создаем не пустой файл размером 10 мб

#sudo apt install sshpass -y
#устанавливаем sshpass при необходимости

sshpass -p "password" ssh username@ip 'find /dir/ -name file1.txt -mtime +7 -delete'
#находим и при наличии удаляем старый файл
#password - пароль; username - имя пользователя; ip - адрес машины; /dir/ - директория

sshpass -p "password" rsync -avz file1.txt username@ip:/dir/
#передаем файл file1.txt
```


## Добавляем задачу в cron:
nano /etc/crontab

добавляем задачу:

0 0 * * 7	user	/dir/script.sh

Таким образом система будет запускать наш скрипт каждое воскресенье в 0:00

## P.S:
Я немного затянул с заданием и не успел решить проблему с постоянным требованием пароля, для быстрого решения проблемы воспользовался утилитой sshpass.
