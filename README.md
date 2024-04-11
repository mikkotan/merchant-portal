# Merchant Portal

## Quick links

- [Run via Docker](#run-via-docker)
- [Run without Docker](#run-without-docker)
- [API Documentation](#api-endpoints)
- [Curl commands](#some-useful-things-for-testing)
- [Design decisions](https://github.com/mikkotan/merchant-portal/wiki/Design-Decisions)

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

3. Create .env file from .sample.env

```
$ cp .sample.env .env
```

4. Open .env file and setup env variables

```
POSTGRES_USER=root
POSTGRES_PASSWORD=root
DATABASE_HOST=db
RSWAG_USERNAME=admin
RSWAG_PASSWORD=admin
SWAGGER_URL=http://localhost:3000
SWAGGER_DEFAULT_HOST=localhost:3000
```

5. Build with docker

```
$ docker-compose build
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

### Some useful things for testing

- Staff User ID: `450f9854-ab1f-4c04-94f2-a651fda030dc`
- Merchant User A ID: `cd7f33cb-c483-451d-b995-1730b2a580cd` - (Belongs to MerchantA)
- Merchant User B ID: `58894254-b0a7-4550-a42a-f774ceb4512d` - (Belongs to MerchantB)
- Merchant A ID: `10452350-147e-1234-a15b-503ba451f379`
- Merchant B ID: `1bde0977-e3b2-2222-8c7c-fe3a7cbb98bb`
- Pipelines IDs
  - `004acfe5-4334-1234-9498-28add7f4674a` - active for MerchantA
  - `cd8469d7-3daf-43dd-9ee5-1966ba53db89` - active for MerchantB
  - `004acfe5-4334-5678-9498-28add7f4674a`
  - `ede3a8f9-4fd5-4a44-8d36-4077b3a82211`
  - `829ca84f-9000-43df-a572-7dd13b1a22f8`

**Curl commands**

Using Staff User as current user

**GET /api/v1/merchants**

200 - Staff User queries for merchants for context of MerchantUserA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/merchants?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

401 Unauthorized Request - Invalid `access-token`
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/merchants?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030d1'
```

**GET /api/v1/pipelines**

200 - Staff User queries for pipelines for context of MerchantUserA for MerchantA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd&merchant_id=10452350-147e-1234-a15b-503ba451f379' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

200 - Staff User queries for active pipeline for context of MerchantUserA for MerchantA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd&merchant_id=10452350-147e-1234-a15b-503ba451f379&active=false' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

200 but empty - Staff User queries for active pipelines for context of MerchantUserB for MerchantA (MerchantUserB does not belong to MerchantA, so result will be empty)
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=58894254-b0a7-4550-a42a-f774ceb4512d&merchant_id=10452350-147e-1234-a15b-503ba451f379&active=true' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

**GET /api/v1/pipelines/:id**

200 - Pipeline exists
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines/ede3a8f9-4fd5-4a44-8d36-4077b3a82211' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

404 - Pipeline does not exists
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines/ede3a8f9-4fd5-4a44-8d36-4077b3a8221a' \
  -H 'accept: application/json' \
  -H 'access-token: 450f9854-ab1f-4c04-94f2-a651fda030dc'
```

Using Merchant User as current user

**GET /api/v1/merchants**

200 - MerchantUserA queries for merchant list for himself
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/merchants?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

403 - MerchantUserA queries for merchant list for another user
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/merchants?user_id=58894254-b0a7-4550-a42a-f774ceb4512d' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

**GET /api/v1/pipelines**

200 - MerchantUserA queries for pipelines for MerchantA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd&merchant_id=10452350-147e-1234-a15b-503ba451f379' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

200 - MerchantUserA queries for active pipelines for MerchantA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd&merchant_id=10452350-147e-1234-a15b-503ba451f379&active=true' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

403 - MerchantUserA queries for pipelines for another user for MerchantA
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=58894254-b0a7-4550-a42a-f774ceb4512d&merchant_id=10452350-147e-1234-a15b-503ba451f379&active=true' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'

```

403 - MerchantUserA queries for pipelines from another Merchant
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines?user_id=cd7f33cb-c483-451d-b995-1730b2a580cd&merchant_id=1bde0977-e3b2-2222-8c7c-fe3a7cbb98bb&active=true' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

**GET /api/v1/pipelines/:id**

200 - Pipeline exists
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines/ede3a8f9-4fd5-4a44-8d36-4077b3a82211' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```

404 - Pipeline does not exists
```
curl -X 'GET' \
  'http://localhost:3000/api/v1/pipelines/ede3a8f9-4fd5-4a44-8d36-4077b3a8221a' \
  -H 'accept: application/json' \
  -H 'access-token: cd7f33cb-c483-451d-b995-1730b2a580cd'
```


