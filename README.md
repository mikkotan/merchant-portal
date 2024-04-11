# Merchant Portal

## Quick links

- [Run via Docker](#run-via-docker)
- [Run without Docker](#run-without-docker)
- [API Documentation](#api-endpoints)

## Run via Docker

### Pre-requisites

- Docker
- Docker Compose

### Get Started

1. Clone the project

```
$ git clone git@github.com:mikkotan/merchant-portal.git
```

2. Change directory

```
$ cd merchant-portal
```

3. Build with docker

```
$ docker-compose build
```

4. Create .env file from .sample.env

```
$ cp .sample.env .env
```

5. Open .env file and setup env variables

```
POSTGRES_USER=root
POSTGRES_PASSWORD=root
DATABASE_HOST=db
RSWAG_USERNAME=admin
RSWAG_PASSWORD=admin
SWAGGER_URL=http://localhost:3000
SWAGGER_DEFAULT_HOST=localhost:3000
```

6. Setup database

```
$ docker-compose run --rm web bundle exec rails db:setup
```

7. Run rspec

```
$ docker-compose run --rm web bundle exec rspec
```

8. Run containers

```
$ docker-compose up -d
```

9. Open SwaggerUI in `http://localhost:3000/api-docs` and use credentials from step 5

<img width="364" alt="Screenshot 2024-04-10 at 11 45 48 PM" src="https://github.com/mikkotan/merchant-portal/assets/16665393/4489e09d-e40b-4231-9514-ecc5ca56d205">


## Run without Docker

### Pre-requisites

- ruby-3.2.2
- Rails 7.1.3
- PostgreSQL (latest)

### Get Started

1. Clone the project

```
$ git clone git@github.com:mikkotan/merchant-portal.git
```

2. Change directory

```
$ cd merchant-portal
```

3. Install dependencies

```
$ bundle install
```

4. Create .env file from .sample.env

```
$ cp .sample.env .env
```

5. Open .env file and setup env variables (This connects to your local pg instance, make sure to update variables accordingly)

```
POSTGRES_USER=root
POSTGRES_PASSWORD=root
DATABASE_HOST=localhost
RSWAG_USERNAME=admin
RSWAG_PASSWORD=admin
SWAGGER_URL=http://localhost:3000
SWAGGER_DEFAULT_HOST=localhost:3000
```

6. Setup database

```
$ rails db:setup
```

7. Run specs

```
$ bundle exec rspec
```

8. Run rails server

```
$ rails s
```

9. Open SwaggerUI in `http://localhost:3000/api-docs` and use rswag credentials in step 5

<img width="364" alt="Screenshot 2024-04-10 at 11 45 48 PM" src="https://github.com/mikkotan/merchant-portal/assets/16665393/439aa63b-33ab-4548-82b3-cd7c50b87cc1">


### API Endpoints

For api documentation, navigate to http://localhost:3000/api-docs

<img width="1197" alt="Screenshot 2024-04-10 at 11 23 34 PM" src="https://github.com/mikkotan/merchant-portal/assets/16665393/dbba1a4e-9993-446c-b009-89bf880ad17c">


