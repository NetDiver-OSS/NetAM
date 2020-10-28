# NetAM

[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=security_rating)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=alert_status)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)  
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=bugs)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=coverage)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=duplicated_lines_density)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=NetaM-OSC_NetAM&metric=sqale_index)](https://sonarcloud.io/dashboard?id=NetaM-OSC_NetAM)

[![Crowdin](https://badges.crowdin.net/netam/localized.svg)](https://crowdin.com/project/netam)

## Reference

Refer to hackmd pad : [https://hackmd.app.svk.gs/DmYtN5z7SVWwzi2xQGbYSw](https://hackmd.app.svk.gs/DmYtN5z7SVWwzi2xQGbYSw)

## Usage

### Demo / test

1. Clone this repository : `git clone https://git.app.svk.gs/development/netam.git`
2. Startup docker containers : `cd netam && docker-compose up -d redis redis-commander db`
3. Perform gems and node module installation : `bundle install && yarn`
4. Perform database init : `rake db:migrate`
5. Update configuration file (`config/netam.yml`) or use environment variables with your requirements or use environment variables described [here](#configuration)
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

### Backup

| name   | environment variable | default value  | description     |
| ------ | -------------------- | -------------- | --------------- | 
| path   | BACKUP_PATH          | /backups       | Backup path     |

### Otp

| name   | environment variable | default value                    | description     |
| ------ | -------------------- | -------------------------------- | --------------- | 
| secret | OTP_SECRET           | ch@ngeMech@ngeMech@ngeMech@ngeMe | OTP Secret salt |

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

### Notifications

| name           | environment variable | description       |
| -------------- | -------------------- | ----------------- |
| slack webhook  | SLACK_WEBHOOK        | Slack webhook URL |

### Mail

| environment variable | description       |
| -------------------- | ----------------- |
| MAIL_HOST            | SMTP Host         |
| MAIL_POST            | SMTP Port         |
| MAIL_USER            | SMTP User         |
| MAIL_PASS            | SMTP Password     |
| MAIL_AUTH_TYPE       | SMTP Auth Method  |
| MAIL_HELO            | SMTP HELO         |
| MAIL_SSL_ENABLE      | SMTP SSL enabling |
| MAIL_FROM            | From field        |
| MAIL_TO              | Receivers         |

### Logging

| name                  | environment variable  | description                   |
| --------------------- | --------------------- | ----------------------------- |
| enable syslog         | SYSLOG_ENABLED        | Enable Syslog appender        |
| syslog URL            | SYSLOG_URL            | Syslog endpoint               |
| enable splunk         | SPLUNK_ENABLED        | Enable Splunk appender        |
| splunk URL            | SPLUNK_URL            | Splunk endpoint               |
| splunk TOKEN          | SPLUNK_TOKEN          | Splunk token                  |
| enable elasticsearch  | ELASTICSEARCH_ENABLED | Enable elasticsearch appender |
| elasticsearch URL     | ELASTICSEARCH_URL     | elasticsearch endpoint        |
| enable logstash       | LOGSTASH_ENABLED      | Enable logstash appender      |
| logstash HOST         | LOGSTASH_HOST         | logstash endpoint             |
| logstash PORT         | LOGSTASH_PORT         | logstash port                 |

## API

### Get Token

In `1.1.0` NetAM provide new way to get user token. To call an endpoint you must add one request to your workflow.
```bash
curl --location --request POST 'http://localhost:3000/oauth/token' \
--form 'username=toto@me.com' \
--form 'password=azazazazazaz' \
--form 'grant_type=password'
```

This request give you an answer like:
```json
{
    "access_token": "zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o",
    "token_type": "Bearer",
    "expires_in": 430010,
    "created_at": 1597607513
}
```

Now you can request your API with these informations.
```bash
curl --location --request GET 'http://localhost:3000/api/v1/sections' \
--header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1y_o'
```

## License

This software is written under BSD 3-Clause license.
