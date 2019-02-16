## Kryla API

- [About project](#about)
- [How to setup?](#how-to-setup)
- [API Documantation](#api-documantation) 
    - [Product](#product)
    - [Category](#category)
    - [Cart](#cart)
    - [Order](#order)
    - [User](#user)
        - [Phone verification](#phone-verification)
        - [Favorites](#favorites)
    - [Session](#session)

###How to setup?

```bash
  docker-compose build                                                                                                                                                          

  docker-compose run backend rails db:create

  docker-compose run backend rails db:migrate
 
  docker-compose run backend rails db:seed
  
  docker-compose up
```

* Go to http://localhost:3000/swagger

