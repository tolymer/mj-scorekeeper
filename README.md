# Docs

https://tolymer.kibe.la/notes/tree/tolymer

## .env

https://tolymer.kibe.la/notes/tolymer/9

## Required

- [Docker](https://docs.docker.com/install/)

## Development

```
# Start server
$ docker-compose up

# API access
$ curl -v localhost:3000/users/1

# API document
$ open http://localhost:8080/

# Run commands
$ docker-compose exec app bin/rails console
$ docker-compose exec app bin/rspec
```
