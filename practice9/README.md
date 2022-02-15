##Использование переменных и хэндлеров в ansible
Пример использования переменых для применения правильных пакетных менеджеров, в зависимости от 
семейства ОС, а также хэндлера для автоматического перезапуска сервиса Apache:

```yaml
- name: Ensure Apache packages is present
  apt: name=apache2 state=present
  when: ansible_os_family == "Debian"

- name: Ensure Apache package is present
  yum: name=httpd state=present
  when: ansible_os_family == "RedHat"
  notify:
  - Restart Apache
    
    
  Handlers:
  - name: Restart Apache
    service: name=httpd state=restarted
```

## Использование шаблонов
Задание переменных для хостов в /etc/ansible/hosts:
```
[web]
192.168.0.1 state=first

[db]
192.168.0.2 state=Second
```
пример шаблона jinja2 `index.j2`:
```html
<html>
<body text="red">
<h1> Hello World! I'm {{ state }} and my ip = {{ ansible_all_ipv4_addresses }}</h1>
</body>
</html>
```
пример плейбука, который использует этот шаблон:
```yaml
- name: Install nginx
  hosts: all
  become: yes

  vars:
    source_folder: ./dir
    dest_folder: /var/www/html
  tasks:
  - name: Ensure nginx package is present
  apt:
    name: nginx
    state: presemt

 - name: teamplaing
   template: src={{ source_folder }}/imdex.j2 dest={{ dest_folder }}/index.html mode=8555
# при замене html страничек nginx'у не нужен перезапуск  
  notify:
    - restart nginx

  handlers:
  - name: restart nginx
    service: name=nginx state=restarted
```