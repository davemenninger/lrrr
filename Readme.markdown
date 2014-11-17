# Lrrr: Like [Jrrr](https://github.com/davemenninger/jrrr), but bigger

This is a test app for trying new things in Mojolicious.

[![Lrrr](http://img4.wikia.nocookie.net/__cb20130329124434/en.futurama/images/c/c5/Lurr.png)](http://theinfosphere.org/Lrrr)

## Buttons!

[![Build Status](https://travis-ci.org/davemenninger/lrrr.svg?branch=master)](https://travis-ci.org/davemenninger/lrrr)

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

## Roadmap

* ~~Add simplest authentication~~
* ~~move authentication routes into own controller~~
* ~~create login page ( post )~~
* ~~connect authentication to external database ( mongo )~~
* wait for November 18th, 2014 for mongolab to upgrade default version to 2.6, argh!
* fix travis hack after travis upgrades default mongodb version to 2.6
* ~~register new user~~
* ~~prevent register dupe username~~
* ~~prevent bots with captcha or something ( how to automate tests then? )~~
* ~~script to create default admin user~~
* ~~get default admin user/pass from ENV instead of hardcoded~~
* ~~make authentication more secure ( bcrypt )~~
* ~~more tests for authentication, registration~~
* ~~add authorization ( logged in user can see some things, but not others )~~
* tests for authorization
* catch-all route, switch routes to use over() conditions
* ~~user can create document objects into mongo~~
* roles: ~~admin~~, ~~guest~~, author, reader?
* scripts: setup new db,
* more templates/routes: ~~home~~, ~~user~~, user/:username, "posts" ...
* bootstrap, bower
* Dockerfile; add mongodb setup? fixtures?

## Credits

* http://12factor.net/
* https://github.com/benvanstaveren/Mojolicious-Plugin-Authentication
* https://github.com/byterock/mojolicious-plugin-authorization
* https://github.com/Bivee/mojolicious-project-base
* https://github.com/naturalist/Mojolicious--Plugin--Bcrypt
* https://github.com/oliwer/mango
