# Create Hosting

Script to create all the hosting for Wordpress projects (with Apache / PHP / Mysql)

## Installation

```bash
git clone git@gitlab.com:SimonConan/create-hosting.git
cp .env.dist .env
sudo chown -R root:root * && sudo chown -R root:root .*
sudo chmod -R 700 * && sudo chmod -R 700 .*
```

> Put the mysql root password in the .env file (used to create mysql user and database)


## Usage

```bash
./create-hosting.sh <domain> <user>
```

## Docker

You can use docker to test in a full Linux env.

### Usage
```bash
docker-compose up -d
docker-compose run web_ch bash
```