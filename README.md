# NetAM

## Reference

Refer to hackmd pad : [https://hackmd.app.svk.gs/DmYtN5z7SVWwzi2xQGbYSw](https://hackmd.app.svk.gs/DmYtN5z7SVWwzi2xQGbYSw)

## Usage

### Demo / test

**Require LDAP or Active Directory server**

1. Clone this repository : `git clone https://git.app.svk.gs/development/netam.git`
2. Startup docker containers : `cd netam && docker-compose up -d redis redis-commander db`
3. Perform gems and node module installation : `bundle install && yarn`
4. Perform database init : `rake db:migrate`
5. Update configuration file (`config/netam.yml`) with your requirements or use environment variables described [here](#configuration)
6. Start rails server : `rails s --environment=development`
7. Connect to interface : `http://localhost:3000`
8. Setup local administrator
9. Restart rails server
10. Enjoy ! 

### Production

All NetAM stack is designed to run in docker stack.  
For performance reasons, we recommend to use separate postgresql database with setting `max_connection` set to more than 1500.  
This to could increase sidekiq threads and parallels executions.

You'll find a `docker-compose.yml` file in repository root folder.  
To run NetAM, you must configuration environment variables you need according to [configuration](#configuration).
and run command :

```bash
docker-compose pull && docker-compose up -d
```

By design, application run on port 3000. Application can be accessed by [http://localhost:3000](http://localhost:3000).

## Configuration

All application configuration is set into `config/netam.yml`

### Authentication

#### LDAP

| name       | environment variable  | default value              | description                    |
| ---------- | --------------------- | -------------------------- | ------------------------------ |
| host       | LDAP_HOST             | localhost                  | LDAP host                      |
| port       | LDAP_PORT             | 389                        | LDAP port                      |
| encryption | LDAP_ENCRYPTION       | false                      | LDAPS encryption               |
| base       | LDAP_BASE             | dc=example,dc=com          | LDAP base DN                   |
| uid        | LDAP_UID              | uid                        | LDAP attribute to map username |
| bind_dn    | LDAP_BIND_USER        | cn=admin,dc=example.dc=com | LDAP user to bind              |
| password   | LDAP_BIND_PASSWORD    | password                   | LDAP bind password             |

### Sentry

| name   | environment variable | description     |
| ------ | -------------------- | --------------- | 
| sentry | SENTRY_DSN           | Sentry full DSN |

### Redis

| name | environment variable | default value | description       |
| ---- | -------------------- | ------------- | ----------------- |
| host | REDIS_HOST           | localhost     | Redis server      |
| port | REDIS_PORT           | 6379          | Redis server port |
| db   | REDIS_DB             | 0             | Redis DB name     |

### Database

| name     | environment variable | default value | description                  |
| -------- | -------------------- | ------------- | ---------------------------- |
| pool     | DB_MAX_THREADS       | 5             | Max connection threads to DB |
| host     | DB_HOST              | localhost     | Database host                |
| port     | DB_PORT              | 5432          | Database post                |
| username | DB_USER              | admin         | Database username            |
| password | DB_PASS              | password      | Database password            |
| database | DB_NAME              | netam         | Database name                |

### Puma

| name       | environment variable | default value | description                  |
| ---------- | -------------------- | ------------- | ---------------------------- |
| max_thread | PUMA_MAX_THREADS     | 5             | Puma max threads             |
| min_thread | PUMA_MIN_THREADS     | 1             | Puma min threads             |
| port       | PUMA_PORT            | 3000          | Puma listen port             |

### Sidekiq

| name           | environment variable | default value | description                |
| -------------- | -------------------- | ------------- | -------------------------- |
| threads        | SIDEKIQ_MAX_THREADS  | 5             | Sidekiq threads number     |
| concurent jobs | SIDEKIQ_PARALLEL     | 10            | Sidekiq max parallels jobs |

## License

This software is written under BSD 3-Clause license.
