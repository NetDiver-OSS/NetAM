# Configuration

NetDiver is designed to use environment variables and/or configuration file.

All application configuration is set into `config/netdiver.yml`

# Environment variables

## Application
| name       | environment variable  | description                    |
| ---------- | --------------------- | ------------------------------ |
| name       | APP_NAME              | Override application name      |


## Authentication
### LDAP

| name       | environment variable  | default value              | description                    |
| ---------- | --------------------- | -------------------------- | ------------------------------ |
| host       | LDAP_HOST             | localhost                  | LDAP host                      |
| port       | LDAP_PORT             | 389                        | LDAP port                      |
| encryption | LDAP_ENCRYPTION       | false                      | LDAPS encryption               |
| base       | LDAP_BASE             | dc=example,dc=com          | LDAP base DN                   |
| uid        | LDAP_UID              | uid                        | LDAP attribute to map username |
| bind_dn    | LDAP_BIND_USER        | cn=admin,dc=example.dc=com | LDAP user to bind              |
| password   | LDAP_BIND_PASSWORD    | password                   | LDAP bind password             |

## Sentry

| name   | environment variable | description     |
| ------ | -------------------- | --------------- | 
| sentry | SENTRY_DSN           | Sentry full DSN |

## Backup

| name   | environment variable | default value  | description     |
| ------ | -------------------- | -------------- | --------------- | 
| path   | BACKUP_PATH          | /backups       | Backup path     |

## Otp

| name   | environment variable | default value                    | description     |
| ------ | -------------------- | -------------------------------- | --------------- | 
| secret | OTP_SECRET           | ch@ngeMech@ngeMech@ngeMech@ngeMe | OTP Secret salt |

## Redis

| name | environment variable | default value | description       |
| ---- | -------------------- | ------------- | ----------------- |
| host | REDIS_HOST           | localhost     | Redis server      |
| port | REDIS_PORT           | 6379          | Redis server port |
| db   | REDIS_DB             | 0             | Redis DB name     |

## Database

| name     | environment variable | default value | description                  |
| -------- | -------------------- | ------------- | ---------------------------- |
| pool     | DB_MAX_THREADS       | 5             | Max connection threads to DB |
| host     | DB_HOST              | localhost     | Database host                |
| port     | DB_PORT              | 5432          | Database post                |
| username | DB_USER              | admin         | Database username            |
| password | DB_PASS              | password      | Database password            |
| database | DB_NAME              | netdiver      | Database name                |

## Puma

| name       | environment variable | default value | description                  |
| ---------- | -------------------- | ------------- | ---------------------------- |
| max_thread | PUMA_MAX_THREADS     | 5             | Puma max threads             |
| min_thread | PUMA_MIN_THREADS     | 1             | Puma min threads             |
| port       | PUMA_PORT            | 3000          | Puma listen port             |

## Sidekiq

| name           | environment variable | default value | description                |
| -------------- | -------------------- | ------------- | -------------------------- |
| threads        | SIDEKIQ_MAX_THREADS  | 5             | Sidekiq threads number     |
| concurent jobs | SIDEKIQ_PARALLEL     | 10            | Sidekiq max parallels jobs |

## Notifications

| name           | environment variable | description       |
| -------------- | -------------------- | ----------------- |
| slack webhook  | SLACK_WEBHOOK        | Slack webhook URL |

## Typesense
| name           | environment variable | default value | description                      |
| -------------- | -------------------- | ------------- | -------------------------------- |
| enabled        | TYPESENSE_ENABLED    | true          | Typesense search switch          |
| protocol       | TYPESENSE_PROTOCOL   | http          | Typesense protocol               |
| host           | TYPESENSE_HOST       | localhost     | Typesense hostname               |
| port           | TYPESENSE_PORT       | 8108          | Typesense port                   |
| api_key        | TYPESENSE_API_KEY    | managementkey | Typesense API key for management |


## Mail

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

## Logging

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
