## Наш скрипт:
```
cd /dir/
#переходим в необходимую директорию
for i in {1..7}
#указываем необходимое количество файлов в переменной i
do
base64 /dev/urandom | head -c 10000000 > file$i.txt
#создаем не пустой файл размером 10 мб
done

#sudo apt install sshpass -y
#устанавливаем sshpass при необходимости

ssh username@ip 'find /dir/ -mtime +7 -delete'
#находим и при наличии удаляем старые файлы
#password - пароль; username - имя пользователя; ip - адрес машины; /dir/ - директория

rsync -avz file$i.txt username@ip:/dir/
#передаем файлы 
```


## Добавляем задачу в cron:
nano /etc/crontab

добавляем задачу:

0 0 * * 7	user	/dir/script.sh

Таким образом система будет запускать наш скрипт каждое воскресенье в 0:00
