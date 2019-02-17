# Kryla API

- [About project](#about)
  - [Instruments](#instruments)
- [How to setup](#how-to-setup)
- [API Documentation](#api-documentation)
  - [Product](#product)
  - [Category](#category)
  - [Cart](#cart)
  - [Order](#order)
  - [User](#user)
    - [Phone verification](#phone-verification)
    - [Favorites](#favorites)
  - [Session](#session)

---

### About project

 This project is a work with the help of which I want to
show what skills I achieved during the course of MasterAcademy courses.

#### Instruments

In this project I am used next instruments:
 * Ruby version: 2.5.3
 * Rails version: 5.2.2
 * PG version: 9.5
 * Grape
 * Grape-Entities
 * Swagger
 * RSpec
 * Docker

### How to setup

I am use docker to run the application locally. The commands below will help you launch the application.

```bash
  # Build images and start application
  docker-compose up --build
  
  # Created database
  docker-compose run backend rails db:create

  # Run migration  
  docker-compose run backend rails db:migrate

  # Added redords into database
  docker-compose run backend rails db:seed
```

* Go to `http://localhost:3000/swagger`

### API Documentation

  If you want to see all requests and answers, you can follow to `http://localhost:3000/swagger` after setup application.
  The information below will provide details on each request. 

---

#### Product

Product have next request:

* `GET /api/v1/products/list` - Returns an array of all products.
* `GET /api/v1/products/{id}/show` - Returns the hash of the parameters of the selected product.

Requests given above return the parameters described below.

Success response format:

```json
      {
        "id": Integer,
        "title": String,
        "price": Integer,
        "weight": Integer,
        "description": String,
        "category_id": Integer
      }
```