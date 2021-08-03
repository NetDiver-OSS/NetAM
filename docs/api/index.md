# API documentation

All API except token generation are automatically documented directly inside application throught swagger.  
Internal documentation is accessible throught the url `http://<netdiver_host>/docs` when you're logged in.

## Get token

NetDiver use oauth mechanism to provide tokens.  
To request token, you must send POST request to endpoint `http://<netdiver_host>/oauth/token` and fill form datas :

- username : <mail_address\>
- password : <associated_password\>
- grant_type : password

Token validity are limited to one day next to generation.

**The token must be declared in each API request into headers with format `'Authorization: Bearer <getted_token>'`**

### Request answer

This request give you an answer like:

```json
{
    "access_token": "zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o",
    "token_type": "Bearer",
    "expires_in": 430010,
    "created_at": 1597607513
}
```

### Example

```bash
curl --location \
     -XPOST 'http://localhost:3000/oauth/token' \
     --form 'username=toto@me.com' \
     --form 'password=azazazazazaz' \
     --form 'grant_type=password'
```

## Sections

### Get Sections list

You could retrieve a list of all sections you was granted in software.

| Type   | Value                                 |
| ------ | ------------------------------------- |
| Method | GET                                   |
| URL    | http://<netdiver_server\>/api/v1/sections |

#### Request answer

```json
[
  {
    "id": 2,
    "name": "example_v6",
    "description": "This section is designed for example with IPv6",
    "network": "::/124",
    "schedule": ""
  },
  {
    "id": 1,
    "name": "example_v4",
    "description": "This section is designed for example with IPv4",
    "network": "127.0.0.0/24",
    "schedule": ""
  }
]
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/sections' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Create Sections

You could create sections through API if account as required ability.

| Type   | Value                                 |
| ------ | ------------------------------------- |
| Method | POST                                  |
| URL    | http://<netdiver_server\>/api/v1/sections |

#### Request answer

```json
{
    "id": 3,
    "name": "example_api",
    "description": null,
    "network": "127.0.0.0/25",
    "schedule": ""
}
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/sections' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o' \
     -d '{
       "id": 3,
       "name": "example_api",
       "description": null,
       "network": "127.0.0.0/25",
       "schedule": ""
     }'
```

### Get Section details

You could retrieve details of specific section.

| Type   | Value                                                |
| ------ | ---------------------------------------------------- |
| Method | GET                                                  |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\> |

#### Request answer

```json
[
  {
    "id": 1,
    "name": "example_v4",
    "description": "This section is designed for example with IPv4",
    "network": "127.0.0.0/24",
    "schedule": ""
  }
]
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/sections/1' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Launch section scan

You could launch section scan.

| Type   | Value                                                     |
| ------ | --------------------------------------------------------- |
| Method | POST                                                      |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\>/scan |

#### Request answer

```json
{
  "status": "ack"
}
```

#### Example

```bash
curl --location \
     -XPOST 'http://<netdiver_host>/api/v1/sections/1/scan' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Export section usage

You could perform section csv export.

| Type   | Value                                                       |
| ------ | ----------------------------------------------------------- |
| Method | GET                                                         |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\>/export |

#### Request answer

```csv
ID,Section,Address,FQDN,Description,State
1,example_v4,127.0.0.1,,,Active
1,example_v4,127.0.0.2,,,Active
1,example_v4,127.0.0.3,,,Active
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/sections/1/export' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Get section usage

You could get section usage.

| Type   | Value                                                       |
| ------ | ----------------------------------------------------------- |
| Method | GET                                                         |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\>/usages |

#### Request answer

```json
[
    {
        "id": 14,
        "ip_used": "127.0.0.1",
        "fqdn": null,
        "description": null,
        "state": "actived"
    },
    {
        "id": 15,
        "ip_used": "127.0.0.2",
        "fqdn": null,
        "description": null,
        "state": "actived"
    },
    ...
]
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/sections/1/usages' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Create section usage

You could create section usage.

| Type   | Value                                                       |
| ------ | ----------------------------------------------------------- |
| Method | POST                                                        |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\>/usages |

#### Request answer

```json
{
  "id": 274,
  "ip_used": "127.0.0.1",
  "fqdn": "",
  "description": null,
  "state": "actived"
}
```

#### Example

```bash
curl --location \
     -XPOST 'http://<netdiver_host>/api/v1/sections/1/usages' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o' \
     -d '{
       "ip_used": "127.0.0.1",
       "fqdn": "",
       "state": "activated"
     }'
```

### Request IP in section

You could create section usage.

| Type   | Value                                                           |
| ------ | --------------------------------------------------------------- |
| Method | POST                                                            |
| URL    | http://<netdiver_server\>/api/v1/sections/<section_id\>/request_ip |

#### Request answer

```json
{
  "id": 274,
  "ip_used": "127.0.0.2",
  "fqdn": null,
  "description": null,
  "state": "actived"
}
```

#### Example

```bash
curl --location \
     -XPOST 'http://<netdiver_host>/api/v1/sections/1/request_ip' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```


## VLAN

### Get VLANs list

You could retrieve a list of all vlans you was granted in software.

| Type   | Value                                  |
| ------ | -------------------------------------- |
| Method | GET                                    |
| URL    | http://<netdiver_server\>/api/v1/vlans    | 

#### Request answer

```json
[
    {
        "id": 1,
        "vid": 1,
        "name": "default",
        "description": "Default Vlan."
    }
]
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/vlans' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Get VLANs details

You could retrieve a list of all vlans you was granted in software.

| Type   | Value                                  |
| ------ | -------------------------------------- |
| Method | GET                                    |
| URL    | http://<netdiver_server\>/api/v1/vlans/1  | 

#### Request answer

```json
{
    "id": 1,
    "vid": 1,
    "name": "default",
    "description": "Default Vlan."
}
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/vlans/1' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o'
```

### Create VLAN

You could create sections through API if account as required ability.

| Type   | Value                                  |
| ------ | -------------------------------------- |
| Method | POST                                   |
| URL    | http://<netdiver_server\>/api/v1/vlans    |

#### Request answer

```json
{
    "id": 2,
    "vid": 3,
    "name": "example_api",
    "description": null
}
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/vlans' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o' \
     -d '{
       "vid": 3,
       "name": "example_vlan",
       "description": null
     }'
```

## Backups

### List Backup

You could list backups through API if account as required ability

| Type   | Value                                  |
| ------ | -------------------------------------- |
| Method | GET                                    |
| URL    | http://<netdiver_server\>/api/v1/backups  |

#### Request answer

```json
{
    "backups": [
        "1604758813_2020_11_07_1.5.0-pre.sql.gz",
        "1604758815_2020_11_07_1.5.0-pre.sql.gz"
    ]
}
```

#### Example

```bash
curl --location \
     -XGET 'http://<netdiver_host>/api/v1/backups' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o' \
```

### Create Backup

You could create backups through API if account as required ability

| Type   | Value                                  |
| ------ | -------------------------------------- |
| Method | POST                                   |
| URL    | http://<netdiver_server\>/api/v1/backups  |

#### Request answer

```
"7169176bc7e2fddf121264bd"
```

#### Example

```bash
curl --location \
     -XPOST 'http://<netdiver_host>/api/v1/backups' \
     --header 'Authorization: Bearer zmL0UxPjqJhfzSXDcbjJp7Hs6wr6JF6SnHp1ybxBH_o' \
```
