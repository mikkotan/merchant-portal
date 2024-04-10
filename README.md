# Merchant Portal

## Run via Docker (TODO)

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

5. Open .env file and setup env variables

```
PSQL_USERNAME=psql_user
PSQL_PASSWORD=psql_password
RSWAG_USERNAME=sample
RSWAG_PASSWORD=sample
```

6. Create database

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

9. Navigate to /api-docs use rswag credentials in step 5

### API Endpoints

For api documentation, navigate to http://localhost:3000/api-docs

<img width="1197" alt="Screenshot 2024-04-10 at 11 23 34 PM" src="https://github.com/mikkotan/merchant-portal/assets/16665393/dbba1a4e-9993-446c-b009-89bf880ad17c">


