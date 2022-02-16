___
### Сами файлы [здесь](https://github.com/withoutspleen/DevOps-engineer/tree/main/practice9/roles)

### Содержимое всех затронутых мной файлов:
___
### /roles/docker-prepare/tasks/main.yml:
```yaml
---
# tasks file for docker-prepare
- name: Ensure packages is present
  apt: 
    name: ['python3-pip', 'docker.io']
    update_cache: yes
    state: present

- name: Ensure docker API is present
  pip:
    name: docker
    state: present
...
```
___
### /roles/docker-build/tasks/main.yml:
```yaml
---
# tasks file for docker-build
- name: Ensure docker dir is present
  ansible.builtin.file:
    path: "{{ docker_dir }}"
    state: directory

- name: copy container
  copy: src=Dockerfile dest={{ docker_dir }}

- name: Log into DockerHub with token access
  docker_login:
    username: withoutspleen
    password: fe95f4c1-8a35-41a3-b264-756d5c6cd7f1

- name: Tag and push image
  docker_image:
    path: "{{ docker_dir }}"
    name: withoutspleen/build-1
    repository: withoutspleen/build
    tag: 1.0
    push: yes

...
```
___
### /roles/docker-build/files/Dockerfile:
```dockerfile
FROM maven:3.8.4-jdk-11 as build
COPY . .
RUN apt-get update; \
    apt install git;
RUN cd /tmp/ ; \
    git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git; \
    cd boxfuse-sample-java-war-hello; \
    mvn package
FROM jetty:9.3.21-alpine as production
EXPOSE 8080
COPY --from=build /tmp/boxfuse-sample-java-war-hello/target/ /var/lib/jetty/webapps/
```
___
### /roles/docker-build/vars/main.yml:
```yaml
---
# vars file for docker-prepare
docker_dir: /tmp/docker
...
```
___
### /roles/docker-prod/tasks/main.yml:
```yaml
---
# tasks file for docker-prod
- name: Log into DockerHub with token access
  docker_login:
    username: withoutspleen
    password: fe95f4c1-8a35-41a3-b264-756d5c6cd7f1

- name: Create container
  docker_container:
    name: production
    image: withoutspleen/build:1.0
    ports:
      - 8080:8080
...
```
___
### /roles/rolebook.yml:
```yaml
---
- name: Prepare remote servers
  hosts: build, production
  become: yes

  roles:
    - docker-prepare

- name: Build
  hosts: build
  become: yes

  roles:
    - docker-build

- name: Prod
  hosts: production
  become: yes

  roles:
    - docker-prod
...
```
___