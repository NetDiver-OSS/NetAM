# Architecture documentation

Actual NetDiver architecture is similar to monolithic pattern. 
We have two services (control node and worker node) around two databases (Redis and PostgreSQL).

For the moment these two services contacts the twice databases. 
in the future, only control node will use databases. All workers nodes will be use API to send data.

## Nodes
### Control node
The control node is a [Ruby on Rails](https://rubyonrails.org/) webservice with puma HTTP server.
To ensure security, this service use [devise gem](https://rubygems.org/gems/devise).

This service use PostgreSQL database to store all information about sections, vlans and usages.
The communication between worker node and this control node is made via Redis database. 

### Worker node
This node use [Sidekiq](https://sidekiq.org/) system to background run jobs.
Sidekiq process scans of network.
These configurations was stored by control node in Redis database, and used by Sidekiq.

At the end of the scan Sidekiq sends all datas to PostgreSQL database.

## Databases
### PostgreSQL
PostgreSQL database was used to store permanently all datas of NetDiver.
We use it to store and link section, vlan and usages.
In addition, PostgreSQL was also used to store permissions and users information.

### Redis
In NetDiver use Redis database only for Sidekiq usage.
This database give to sidekiq an ability to retry, order and queue jobs.
