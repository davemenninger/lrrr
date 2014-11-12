# Lrrr: Like [Jrrr](https://github.com/davemenninger/jrrr), but bigger

This is a test app for trying new things in Mojolicious.

[![Lrrr](http://img4.wikia.nocookie.net/__cb20130329124434/en.futurama/images/c/c5/Lurr.png)](http://theinfosphere.org/Lrrr)


[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

# Roadmap

* ~~Add simplest authentication~~
* ~~move authentication routes into own controller~~
* ~~create login page ( post )~~
* ~~connect authentication to external database ( mongo )~~
* wait for November 18th, 2014 for mongolab to upgrade default version to 2.6, argh!
* create authentication plugin
* make authentication more secure ( hash, salt )
* tests for authentication
* add authorization ( logged in user can see some things, but not others )
* tests for authorization
* user can create document objects into mongo
* roles: admin, author, reader?
* more templates/routes: ~~home~~, ~~user~~, user/:username, "posts" ...
* Dockerfile; add mongodb setup? fixtures?
