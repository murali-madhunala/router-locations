# Router locations connections
## Description
Router locations connections API provides the connected locations list by accessing the locations and router links from the hosted json server

### Tech

This project uses a number of open-source projects to work properly:

* [Ruby](https://www.ruby-lang.org/en/) - A dynamic, open-source programming language with a focus on simplicity and productivity
* [RubyOnRails](https://rubyonrails.org/) -  A server-side web application framework written in Ruby
* [Docker](https://docs.docker.com/) - A tool designed to make it easier to create, deploy, and run applications by using containers
* [Waterfall](https://github.com/apneadiving/waterfall) - Running the commands in a flow which helps in chaining services/commands

### System dependencies
* [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv)
* [bundler](https://bundler.io/)

### Installation - Configuration

The Application requires `Ruby` & `Docker`.

[Ruby Installation](https://www.ruby-lang.org/en/) - Need to install version 3.2.2

[Docker installation](https://docs.docker.com/engine/install/)

#### Clone the repository, install the dependencies and start the server.

```sh
$ git clone https://github.com/murali-madhunala/router-locations.git
$ cd router-locations
$ git checkout master
$ gem install bundle
$ docker compose up --build
```

### How to run the test suite

To run tests,

cmd: `bundle exec rspec`

### Environment Settings

Edit the .env file in the root directory, to setup the dotenv variables.

```bash
ROUTE_LOCATIONS_URL=https://my-json-server.typicode.com/marcuzh/router_location_test_api/db
RAILS_ENV=development
```

## Todos
* Add static analysis using rubocop
* Devcontainers helps developers in having the project in docker container using VS code extensions
* Authentications & Authorizations which helps in securing the application


