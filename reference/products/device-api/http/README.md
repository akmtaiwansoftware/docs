---
title: HTTPS
---

# HTTPS Device API Overview

This is the HTTPS Device API for the Murano Platform. Device firmware implementations should use this API to provision and interact with the Murano platform.  Authenticated devices post sensor and status data and retrieve configuration and control commands using this API.

When used in this document, "timestamp" is a unix timestamp, defined as the number of seconds that have elapsed since 00:00:00 Coordinated Universal Time (UTC), Thursday, 1 January 1970.

## HTTPS Device APIs
### Provisioning and OTA updates
* [Provision](#provision) - Securely provision authentication credentials for a device
* [List Available Content](#list-available-content) - Retrieve a listing of available content
* [Get Content Info](#get-content-info) - Retrieve meta information (content-type, size, updated timestamp, description) for a specific content identifier
* [Download Content](#download-content) - Download a specific content file

### Data reporting and retrieval
* [Post](#post-sensor-data) - Report sensor data to Murano
* [Get](#get-configuration-data) - Retrieve configuration and control data from Murano
* [Combined Post/Get](#combined-post-get) - Use a single request to report and retrieve data from Murano
* [Long Polling](#long-polling) - Retrieve the lastest data available, or wait to receive an update

### Misc
* [Timestamp](#timestamp) - Get the current unix timestamp

## HTTP Responses

Typical HTTP response codes include:

| Code   | Response      | Description                                          |
| ------ |:--------------|:-----------------------------------------------------|
| 200    | OK            | Successful request, returning requested values       |
| 204    | No Content    | Successful request, nothing will be returned         |
| 4xx    | Client Error  | There was an error\* with the request by the client  |
| 401    | Unauthorized  | Missing or invalid credentials                       |
| 5xx    | Server Error  | Unhandled server error. Contact support.             |

**Note:** Aliases that are not found are not considered errors in the request. See the documentation for [post](#post-sensor-data), [get](#get-configuration-data), and [post/get](#combined-post-get) for details.

## Libraries and Sample Code

Sample code that uses this API can be found on the Murano Getting Started product examples:

* [Murano Quickstarts](/quickstarts/)

## Notational Conventions

This document uses the following notational conventions:

* A name in angle brackets (e.g., `<myvar>` is a placeholder that will be defined elsewhere)
* `...` represents one or more of the previous items
* Curly brackets around HTTP headers represent optional or conditional headers.

## Connection Domain
Each Murano device gateway instance receives a unique API domain for devices to connect to. Your unique domain (endpoint) can be retrieved from your account page. In this document, we will use the example domain of "example.m2.exosite.io". Replace the example domain with your unique domain when using the API.

When making a secure TLS connection attempt to the API domain, it is required to specify the domain as the SNI field in the TLS connection request. The HTTP "Host" header must also be set to the domain name. Any mismatch or use of an invalid domain will result in the connection being terminated without response.

## Authentication
A device may authenticate with either a TLS Client Certificate during the TLS connection handshake or by using a secret Token sent in the "X-Exosite-CIK" HTTP header.

When using a TLS Client Certificate for authentication, the certificate "Subject" CommonName (CN) must hold the connecting device's identity.

To establish a device's identity and authorization on the Murano device gateway, a device's identity must be whitelisted with pre-shared authentication credentials set for the device, or the gateway must be configured to enable provisioning, allowing a device to connect and provision its identity and credentials.

For device gateways configured to enable provisioning and TLS client certificate authentication, a device that connects with a TLS client certificate of a whitelisted identity will be auto-associated with the device gateway. For device gateways that disallow provisioning, the device's client certificate will have to be pre-associated with the identity in the gateway.

For device gateways configured to enable provisioning and Token authentication, a device must make a request to the [provision](#provision) API to receive a secret token that can be used for subsequent authenticated API requests. The device gateway can be configured to whitelist allowed identities, provision time windows, and restrict IP addresses to manufacturing facilities for device provisioning.

# Provisioning and OTA updates

## Provision
When the Murano device gateway is configured for Token authentication, calling this endpoint will provision credentials for the given `<identity>` and returns the secret `<token>` the device will use for all subsequent API requests. It is typical that the Murano device gateway is configured to only allow whitelisted identities to provision. Identities must also conform to the identity format specification defined in the device gateway settings.

### request
```
POST /provision/activate HTTP/1.1
Host: example.m2.exosite.io
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Content-Length: <length>

id=<identity>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Keep-Alive
Content-Length: <length>
Content-Type: text/plain; charset=utf-8

<token>
```

Response may also be:

* `HTTP/1.1 404 Not Found` if whitelisting is required and the `<identity>` is not whitelisted.
* `HTTP/1.1 409 Conflict` if the `<identity>` has already been provisioned.
* See [HTTP Responses](#http-responses) for a full list of responses

### example
Provision identity `12345678`
```
$ curl -i 'https://example.m2.exosite.io/provision/activate' \
    -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
    -d 'id=12345678'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 40
Content-Type: text/plain; charset=utf-8

22596363b3de40b06f981fb85d82312e8c0ed511
```

## List Available Content
List available content `<content-id>`s.

```
GET /provision/download HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
<blank line>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Keep-Alive
Content-Length: <length>
Content-Type: text/csv; charset=utf-8

<content-id 1>
<content-id 2...>
<content-id n>
```

Response may also be:

* See [HTTP Responses](#http-responses) for a full list of responses

### example
```
$ curl -i 'https://example.m2.exosite.io/provision/download' \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 71
Content-Type: text/csv; charset=utf-8

MANIFEST
fw_20150519_rev01b.bin
fw_20160101_rev02.bin
splash01.png
splash02.png
```

## Get Content Info
Retrieve meta information (content-type, size, updated timestamp, description) for the specified `<content-id>`.

```
GET /provision/download?id=<content-id>&info=true HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
<blank line>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Keep-Alive
Content-Length: <length>
Content-Type: text/csv; charset=utf-8

<content-type>,<byte-size>,<updated-timestamp>,<description>
```

Response may also be:

* See [HTTP Responses](#http-responses) for a full list of responses

### example
```
$ curl -i 'https://example.m2.exosite.io/provision/download?id=splash01.png&info=true' \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 45
Content-Type: text/csv; charset=utf-8

image/png,23427,1462500951,Boot splash screen
```

## Download Content
Download the content `<content-id>` in full or in part.  To request chunks of the content, use the header `Range: bytes=<range-specifier>`. `<range-specifier>` takes the form of `X-Y` where both `X` and `Y` are optional but at least one of them must be present. `X` is the start byte position to return. `Y` is the end position. Both are 0 based. If `X` is omitted, `Y` will request the last `Y` count of bytes of the content. If `Y` is omitted, it will default to the end of the content. The response `Content-Type` header will be as defined in the content meta info.

```
GET /provision/download?id=<content-id> HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
{Range: bytes=<range-specifier>}
<blank line>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Keep-Alive
Content-Length: <number of bytes being returned>
Content-Type: <content-type>
{Accept-Ranges: bytes}
{Content-Range: bytes <first position>-<last position>/<total length>}

<blob>
```

Response may also be:

* `HTTP/1.1 206 Partial Content` if the response is partial.
* See [HTTP Responses](#http-responses) for a full list of responses

### example
Download entire file
```
$ curl -i 'https://example.m2.exosite.io/provision/download?id=splash01.png' \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 23427
Content-Type: image/png

<23427-byte-blob>
```
Download first 1024 bytes of the file
```
$ curl -i -r 0-1023 https://example.m2.exosite.io/provision/download?id=splash01.png \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 1024
Content-Type: image/png
Accept-Ranges: bytes
Content-Range: bytes 0-1023/23427

<1024-byte-blob>
```

# Data Reporting and Retrieval

## Post Sensor Data
Report sensor data to Murano. Post data for one or more resources identified by `<alias>` with the given `<value>`. The connecting device is identified and authenticated with the secret `<token>`. If the Murano Device Gateway has defined resources with matching aliases, then the reported values are stored in the device state with the server timestamp at which the data was received by Murano. If multiple aliases are specified, they are written at the same timestamp. Regardless of whether the gateway resources are defined, reported data generate an event type of "data_in" on the Murano Device2 Gateway service and may be used to store the data in Timeseries database or alerted upon.

### request
```
POST /onep:v1/stack/alias HTTP/1.1 
Host: example.m2.exosite.io 
{X-Exosite-CIK: <token>}
Content-Type: application/x-www-form-urlencoded; charset=utf-8 
Content-Length: <length> 
<blank line>
<alias 1>=<value 1>&<alias 2...>=<value 2...>&<alias n>=<value n>
```

### response
```
HTTP/1.1 204 No Content 
Date: <date> 
Server: Murano
Connection: Keep-Alive
<blank line>
```

* See [HTTP Responses](#http-responses) for a full list of responses.

### example
```
$ curl -i 'https://example.m2.exosite.io/onep:v1/stack/alias' \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511' \
    -d 'temperature=63'
```
```
HTTP/1.1 204 No Content
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive

```

## Get Configuration Data
Retrieve configuration and control data from Murano. Get the latest set value from the authenticated device's state for one or more resources specified by `<alias>`. If at least one `<alias>` resource definition exists, the set value will be returned.

### request
```
GET /onep:v1/stack/alias?<alias 1>&<alias 2...>&<alias n> HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
Accept: application/x-www-form-urlencoded; charset=utf-8
<blank line>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Close
Content-Length: <length>
<blank line>
<alias 1>=<value 1>&<alias 2...>=<value 2...>&<alias n>=<value n>
```

* Response may also be `HTTP/1.1 204 No Content` if either none of the aliases are found or the device state for the given aliases are empty
* See [HTTP Responses](#http-responses) for a full list of responses

### example
```
$ curl -i 'https://example.m2.exosite.io/onep:v1/stack/alias?thermostat' \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511' \
    -H 'Accept: application/x-www-form-urlencoded; charset=utf-8'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 13
Content-Type: application/x-www-form-urlencoded; charset=utf-8

thermostat=65
```

## Combined Post Get
Report one or more values with `<alias w>` with given `<value>` and then retrieve the most recent set values from the authenticated device's state with the specified `<alias r>`.  

**Note:** The reported data is stored before retrieving the latest set state.

### request
```
POST /onep:v1/stack/alias?<alias r1>&<alias r2...>&<alias rn> HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
Accept: application/x-www-form-urlencoded; charset=utf-8
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Content-Length: <length>
<blank line>
<alias w1>=<value 1>&<alias w2...>=<value 2...>&<alias wn>=<value n>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Close
Content-Length: <length>
<blank line>
<alias r1>=<value 1>&<alias r2...>=<value 2...>&<alias rn>=<value n>
```

* Response may also be `HTTP/1.1 204 No Content` if either none of the aliases are found or the device state for the given aliases are empty
* See [HTTP Responses](#http-responses) for a full list of responses

### example
```
$ curl https://example.m2.exosite.io/onep:v1/stack/alias?thermostat \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511' \
    -H 'Accept: application/x-www-form-urlencoded; charset=utf-8' \
    -d 'temperature=63'
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 13
Content-Type: application/x-www-form-urlencoded; charset=utf-8

thermostat=65
```

## Long Polling
The [post](#post-sensor-data) endpoint also supports long polling. Long polling is a method of getting a server push without the complexities of setting up publicly accessible HTTP server endpoints on your device. As the name suggests, long polling is similar to normal polling of an HTTP resource, but instead of requiring the client to make a new request to the server constantly, the server will wait to return until it has new information to return to the client (or a timeout has been reached).

To perform a request with long polling, simply add the header `Request-Timeout: <miliseconds>` to your request. The server will then wait until a new datapoint is written to the given resource and will then immediately return the value. If no datapoint is written before that time, a `304 Not Modified` is returned and the client may make another long polling request to continue monitoring that resource.

You may also optionally add an `If-Modified-Since` header to specify a start time to wait. This is exactly the same as the `alias.last` semantics in scripting. You will want to use this if it's important that you receive all updates to a given resource; otherwise, it is possible to miss points written between long polling requests.

**Note:** Only one resource may be read at a time when using long polling.

### request
```
GET /onep:v1/stack/alias?<alias 1> HTTP/1.1
Host: example.m2.exosite.io
{X-Exosite-CIK: <token>}
Accept: application/x-www-form-urlencoded; charset=utf-8
Request-Timeout: <timeout>
If-Modified-Since: <timestamp>
<blank line>
```

* `<alias>` is the alias you monitor for new datapoints.
* `Request-Timeout` specifies how long to wait on changes. `<timeout>` is a millisecond value and cannot be more than 300 seconds (300,000 ms).
* `If-Modified-Since` specifies waiting on aliases since the `<timestamp>`. `<timestamp>` can be timestamp seconds since 1970-01-01 00:00:00 UTC or standard <a href=http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html>HTTP-Date</a> format. If this is not specified, it defaults to "now."

### response
When the device set state is updated:
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Close
Content-Length: <length>
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Last-Modified: <value-set-date>
<blank line>
<alias>=<value>
```
If the device state is not updated before timeout:
```
HTTP/1.1 304 Not Modified
Date: <date>
Server: Murano
Connection: Close
Content-Length: <length>
<blank line>
```

When the device set state had been updated and a value is returned, a `Last-Modified` header is included. When it is vital for your application to receive all updates to a resource, you can pass the `Last-Modified` header value back as the `If-Not-Modified-Since` header in your next request to make sure you do not miss any points that may have been written since the last request returned.

### example
```
$ curl https://example.m2.exosite.io/onep:v1/stack/alias?thermostat \
    -H 'X-Exosite-CIK: 22596363b3de40b06f981fb85d82312e8c0ed511' \
    -H 'Accept: application/x-www-form-urlencoded; charset=utf-8'
    -H 'Request-Timeout: 30000
    -H 'If-Modified-Since: 1408088308
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 13
Content-Type: application/x-www-form-urlencoded; charset=utf-8
Last-Modified: 1408088412

thermostat=65
```

# Misc

## Timestamp
Get the current time according to the server.

### request
```
GET /timestamp HTTP/1.1
Host: example.m2.exosite.io
<blank line>
```

### response
```
HTTP/1.1 200 OK
Date: <date>
Server: Murano
Connection: Keep-Alive
Content-Length: <length>
Content-Type: text/plain; charset=utf-8

<timestamp>
```
* See [HTTP Responses](#http-responses) for a full list of responses

### example
```
$ curl -i https://example.m2.exosite.io/timestamp
```
```
HTTP/1.1 200 OK
Date: Fri, 05 May 2017 00:11:22 GMT
Server: Murano
Connection: Keep-Alive
Content-Length: 10
Content-Type: text/plain; charset=utf-8

1408088308
```
