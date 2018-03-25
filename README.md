# Docs

https://tolymer.kibe.la/notes/tree/mj-scorekeeper

## Required

- [Docker](https://docs.docker.com/install/)

## Development

```
$ docker-compose up -d
$ bundle install
$ bin/rake db:create
$ bin/rake ridgepole:apply
$ bin/rails server
```
