# Technical Architecture

## Introductions

NetAM internal code is fully based on ruby lang.  
Frontend use javascript for certains objects rendering.

All stack will designed to be run in Docker containers. We provide from [Docker Hub](https://hub.docker.com/netam/netam) NetAM image. And in repository a basic [docker-compose.yml](https://github.com/NetAM-OSC/NetAM/blob/master/docker-compose.yml) to could launch NetAM directly in production mode.

## Services

### Lists

NetAM use some software against main code.

| Software   | Usage                                                                        |
| ---------- | ---------------------------------------------------------------------------- |
| PostgreSQL | SGBD to store NetAM datas (sections, usages, vlan, …)                        |
| Redis      | Message broker to send jobs to Sidekiq                                       |
| Sidekiq    | Data processor. Will launch scan jobs and returns datas directly in database |

### Interactions

