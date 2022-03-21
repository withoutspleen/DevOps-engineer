Запись вывода в переменную:
```shell
variable=$(command)
```
Запись inventory:
```shell
sh -c 'cat << EOF >> certification/inventory
[build]
$(terraform output -raw build_instance_dns

[production]
$(terraform output -raw prod_instance_dns'
```