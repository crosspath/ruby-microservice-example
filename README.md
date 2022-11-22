# README

An example of a microservice written on [Ruby](https://www.ruby-lang.org) and [Rails framework](https://rubyonrails.org/).

The idea beside this project is to show, how to create real-life web applications on different languages.  
It will help me to choose better programming language for my needs.

See also this microservice written on other languages:

* [Microservice on Crystal](https://github.com/crosspath/crystal-microservice-example)

This project does not have any GUI or front-end. So, take your terminal to run this project!

## Setting up the project

Copy sources & install required libraries:

```
git clone git@github.com:crosspath/ruby-microservice-example.git
cd ruby-microservice-example
bundle install
```

Configurate: copy file `.env.template` to `.env` & replace params `RAILS_ENV`, `DATABASE_URL` & `API_KEY`

Create database:

```
bin/rails db:create
```

Initialise database for this microservice:

```
bin/rails db:migrate
  # or #
bin/rails db:schema:load
```

and then:

```
bin/rails db:seed
```

## Usage

Run server once before sending HTTP requests:

```
bin/rails s
```

Make a HTTP request with this template (assuming you ran this project on `localhost:3000`):

```
curl -X POST http://localhost:3000/api/v1/referrals \
     -d "api_key=<your-API_KEY-here>" \
     -d "order=<UserOrder.id>" \
     -d "referrer=<User.id>"
```

If your `API_KEY` is not valid, you'll get message:

    {"status":100,"error":"Not Authorised"}

If you try to add bonuses to the user, who does not exist in the database, then you'll get message:

    {"status":110,"error":"User Not Found"}

When user order is not found, you'll get this message:

    {"status":111,"error":"UserOrder Not Found"}

Selected `order` should not belong to the selected `referrer`. Otherwise you'll get this message:

    {"status":112,"error":"User Cannot Invite Himself"}

If selected user order is referenced with another user already, then you'll get this:

    {"status":113,"error":"This UserOrder Is Already Referenced For Bonuses"}

And if everything is correct, then you'll get this message (value of `bonuses` may be different, depending on the price of user order):

    {"status":200,"bonuses":0.28}
