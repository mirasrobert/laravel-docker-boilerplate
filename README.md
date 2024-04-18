# Prerequisite
## Install Docker For Ubuntu
1. [Install Docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04)
2. [Install Docker Compose](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04)

# How to use template
## 1. Before build 
Create your laravel project inside "src" folder.

## 2. After cloning or creating your project in "src"
Change db service MYSQL_DATABASE to your desired database.

## 3. Build docker

### For Dev
```bash
docker compose build --no-cache
```

### For Prod
```
docker-compose -f docker-compose.prod.yml build
```

## 4. Up Docker Containers
```bash
docker compose up -d
```

## 5. Change .env database credentials
```bash
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=[your_desired_db_on_your_docker_compose.yml]
DB_USERNAME=root
DB_PASSWORD=secret
```

## 6. Access website URI:
[http://localhost:9090/](http://localhost:9090/)

## 7. Access artisan commands
```bash
docker compose run --rm php php artisan
```
