# Kryla API

- [About project](#about-project)
  - [Instruments](#instruments)
  - [Helpful links](#helpful-links)
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

## About project

 This project is a work with the help of which I want to
show what skills I achieved during the course of MasterAcademy courses.

#### Instruments

In this project I am used next instruments:
 * Ruby version: 2.6.1
 * Rails version: 5.2.2
 * PG version: 9.5
 * Grape
 * Grape-Entities
 * Swagger
 * RSpec
 * Docker
 * AWS S3
 * Sidekiq

### Helpful links

 * Admin panel `http://localhost:3000/admin`
 * Swagger documentation `http://localhost:3000/swagger`
 * Sidkiq `http://localhost:3000/sidekiq`

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

### API Documentation
  If you want to see all requests and answers, you can follow to `http://localhost:3000/swagger` after setup application.
  The information below will provide details on each request.

---
