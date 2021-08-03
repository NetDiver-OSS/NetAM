# NetAM

[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Security Rating](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=security_rating)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Vulnerabilities](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=vulnerabilities)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=alert_status)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)  
[![Bugs](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=bugs)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=coverage)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Duplicated Lines (%)](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=duplicated_lines_density)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)
[![Technical Debt](https://sonarcloud.io/api/project_badges/measure?project=NetDiver-OSS_NetAM&metric=sqale_index)](https://sonarcloud.io/dashboard?id=NetDiver-OSS_NetAM)

[![Crowdin](https://badges.crowdin.net/netam/localized.svg)](https://crowdin.com/project/netam)

## Join Us

You could join us onto our slack channel :  
[![Slack](https://cdn.brandfolder.io/5H442O3W/at/pl546j-7le8zk-btwjnu/Slack_RGB.png?height=30)](https://join.slack.com/t/netcore-oss/shared_invite/zt-p0jkj2qo-cnvwVXJrx659D2upP_iXDg)

## Indroduction

NetAM (a.k.a. Network Address Manager) is a network address management tool.  
Software usage is designed to be easy to use and keep only most important informations of your network ranges.

Core product is developed in ruby on rails and is fully designed to run in Docker containers.

## RoadMap

### Version 2.0.0

- Worker management into admin interface
- Worker deportation

### Version 3.0.0

- Graphical interface refactor

### Version 4.0.0

- Transform NetAM into NetCore plugin

## Reference

NetAM usage documented [here](https://docs.netam.site/)

## Usage

### Production

All NetAM stack is designed to run in docker stack.  
For performance reasons, we recommend to use separate postgresql database with setting `max_connection` set to more than 1500.  
This to could increase sidekiq threads and parallels executions.

You'll find a `docker-compose.yml` file in repository root folder.  
To run NetAM, you must configuration environment variables you need according to [configuration](https://docs.netam.site).
and run command :

```bash
docker-compose pull && docker-compose up -d
```

By design, application run on port 3000. Application can be accessed by [http://localhost:3000](http://localhost:3000).

## License

This software is written under BSD 3-Clause license.
