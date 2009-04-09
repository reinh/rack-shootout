Rack Shootout
=============

Rack shootout measures performance of various web service components,
including frameworks, application servers and ORMs.

Think you could write a better benchmark suite? Want to test something else?
Fork me and do it!

Setup
-----

Expects a mysql database called rack_shootout (*database.yml support coming soon!*)

Run migrations:

    rake migrate

Frameworks
----------

    rake shootout:frameworks

  * Rails (single file)
  * Sinatra
  * Bare Rack

Application Servers
-------------------

*Coming soon!*

  * Mongrel
  * Thin
  * Webrick


ORMs
----

*Coming soon!*

  * ActiveRecord
  * DataMapper
  * Sequel

Awesome
=======

You know it!

Contributors
============

  * Rein Henrichs