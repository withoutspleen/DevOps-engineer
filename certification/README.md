Запись вывода в переменную:
```shell
variable=$(command)
```
Запись в inventory:
```shell
cat << EOF >> path/to/inventory_file
[build]
$(terraform output -raw build_instance_dns)

[production]
$(terraform output -raw prod_instance_dns)
EOF
```