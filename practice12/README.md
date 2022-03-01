## Сборка устаревшего приложения в Maven:

---
Исправляем файл pom.xml, в частности устаревшие, отсутствующие в [репозитории](https://mvnrepository.com/), зависимости. 
Заменяем на новые, руководствуясь [репозиторием](https://mvnrepository.com/).

Пример изменений dependencies в pom.xml:

<details>
  <summary>Old</summary>

```xml
  <dependencies>
		<dependency>
			<groupId>org.apache.tomcat</groupId>
			<artifactId>servlet-api</artifactId>
			<version>6.0.16</version>
		</dependency>
		<!-- Mail Dependency -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>5.1.8</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>3.2.0.RELEASE</version>
		</dependency>

		<!-- Spring Integration -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring</artifactId>
			<version>2.5.6</version>
		</dependency>

		<!-- Logging -->

		<dependency>
			<groupId>commons-logging</groupId>
			<artifactId>commons-logging</artifactId>
			<version>1.1.3</version>
		</dependency>

	</dependencies>
```
</details>
<details>
  <summary>New</summary>

```xml
  <dependencies>
		<dependency>
			<groupId>org.apache.tomcat</groupId>
			<artifactId>tomcat-servlet-api</artifactId>
			<version>9.0.17</version>
		</dependency>
		<!-- Mail Dependency -->
		<dependency>
			<groupId>mysql</groupId>
			<artifactId>mysql-connector-java</artifactId>
			<version>8.0.28</version>
		</dependency>
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-jdbc</artifactId>
			<version>5.2.19.RELEASE</version>
		</dependency>

		<!-- Spring Integration -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-core</artifactId>
			<version>5.2.19.RELEASE</version>
		</dependency>

		<!-- Logging -->

		<dependency>
			<groupId>commons-logging</groupId>
			<artifactId>commons-logging</artifactId>
			<version>1.2</version>
		</dependency>

	</dependencies>
```
</details>


Значения для Config.properties:

```properties
app42.paas.db.username = db-username
app42.paas.db.port = db-port
app42.paas.db.password = db-password
app42.paas.db.ip = db-service-name
app42.paas.db.name = db-name
```

apt install mysql-server

default port 3306

CREATE DATABASE app42;

CREATE USER 'app42-admin'@'localhost' IDENTIFIED BY '123456';

GRANT ALL PRIVILEGES ON app42.* TO 'app42-admin'@'localhost';

FLUSH PRIVILEGES;

wget https://downloads.mysql.com/archives/get/p/23/file/mysql-server_8.0.27-1debian11_amd64.deb-bundle.tar


