---
title: Portals
---

# Portals API (BETA)

__The Portals API is in beta testing and may be subject to occasional tweaks. Any changes will be documented here.__

Portals provides a user authentication and management system on top of the One Platform. The Portals API provides access to Portals functionality using a REST-style HTTP API, using the JSON format in request and response bodies, and basic authentication where a Portals account is required.

## Overview

Here are some documents that will help you understand the basics of the Portals API.

* [API Endpoints](#api-endpoints)
* [API Index](#api-index)
* [REST](#rest)
* [Request and Response Format](#request-and-response-format)
* [Authentication](#authentication)
* [Definition of Domain](#definition-of-domain)
* [Objects](#objects)
* [Resources](#resources)

## API Endpoints

#### Accounts

* [Get user account by email](#get-user-account-by-email)
* [Get user account by user ID](#get-user-account-by-user-id)
* [Get all user accounts](#get-all-user-accounts) (Deprecated)

#### Client Models

* [Get client model](#get-client-model)
* [List client models](#list-client-models)
* [Update client model](#update-client-model)
* [Delete client model](#delete-client-model)
* [Get serial number](#get-serial-number)

#### Dashboards

* [Get dashboard](#get-dashboard)
* [List Portal dashboards](#list-portal-dashboards)
* [Create Portal dashboard](#create-portal-dashboard)
* [Update dashboard](#update-dashboard)
* [Delete dashboard](#delete-dashboard)

#### Data Sources

* [Get data source](#get-data-source)
* [Get multiple data sources](#get-multiple-data-sources)
* [List device data sources](#list-device-data-sources)
* [List Portal data sources](#list-portal-data-sources)
* [Create device data source](#create-device-data-source)
* [Create Portal data source](#create-portal-data-source)
* [Update data source](#update-data-source)
* [Delete data source](#delete-data-source)

#### Data Sources Data

* [Get data source data](#get-data-source-data)
* [Get data from multiple data sources](#get-data-from-multiple-data-sources)
* [Record data source data](#record-data-source-data)
* [Append data source data](#append-data-source-data)
* [Append data source data in JSON format](#append-data-source-data-in-json-format)
* [Delete data source data](#delete-data-source-data)

#### Device

* [Create new device under a Portal of authenticated user](#create-new-device-under-a-portal-of-authenticated-user)

#### Devices

* [Get device](#get-device)
* [Get multiple devices](#get-multiple-devices)
* [Create device](#create-device)
* [Update device](#update-device)
* [Update multiple devices](#update-multiple-devices)
* [Delete device](#delete-device)

#### Domain

* [List domains of authenticated user](#list-domains-of-authenticated-user)

#### Domain Widgets

* [Get domain widget](#get-domain-widget)
* [List domain widget](#list-domain-widget)
* [Create domain widget](#create-domain-widget)
* [Update domain widget](#update-domain-widget)
* [Delete domain widget](#delete-domain-widget)

#### File Systems

* [Get file](#get-file)
* [Get file content](#get-file-content)
* [List files](#list-files)
* [Append to directory](#append-to-directory)
* [Update file content](#update-file-content)

#### Groups

* [Get group](#get-group)
* [Get multiple groups](#get-multiple-groups)
* [Get group permissions](#get-group-permissions)
* [Add group permissions](#add-group-permissions)
* [Create group under user](#create-group-under-user)
* [Update group](#update-group)
* [Delete group](#delete-group)
* [Delete group permissions](#delete-group-permissions)

#### Portal

* [List portals of authenticated user](#list-portals-of-authenticated-user)

#### Portals
* [Get portal](#get-portal)
* [List portals by domain](#list-portals-by-domain)
* [List portal data sources](#list-portal-data-sources)
* [List portal devices](#list-portal-devices)
* [List portal dashboards](#list-portal-dashboards)
* [Create portal data source](#create-portal-data-source)
* [Create device](#create-device)
* [Create portal](#create-portal)
* [Create portal dashboard](#create-portal-dashboard)
* [Update portal](#update-portal)
* [Delete portal by ID](#delete-portal-by-id)
* [Delete portal by RID](#delete-portal-by-rid)

#### Scripts

* [Get script](#get-script)
* [List device scripts](#list-device-scripts)
* [List Portal scripts](#list-portal-scripts)
* [Create device script](#create-device-script)
* [Create Portal script](#create-portal-script)
* [Update script](#update-script)
* [Delete script](#delete-script)

#### Script Data

* [Get script data](#get-script-data)

#### Themes

* [Get theme](#get-theme)
* [List themes](#list-themes)
* [Create theme](#create-theme)
* [Update theme](#update-theme)
* [Delete theme](#delete-theme)

#### User

* [Register new user account](#register-new-user-account) (Deprecated)
* [Reset user account password](#reset-user-account-password) (Deprecated)

#### Users

* [Get user](#get-user)
* [Get multiple users](#get-multiple-users)
* [Get all users](#get-all-users)
* [Get all user portals](#get-all-user-portals)
* [Get all users portals shares](#get-all-users-portals-shares)
* [Get user data storage](#get-user-data-storage)
* [Get user data storage list](#get-user-data-storage-list)
* [Get user permissions](#get-user-permissions)
* [Get user profile picture](#get-user-profile-picture)
* [Get user Portal](#get-user-portal)
* [Get user Portal shares](#get-user-portal-shares)
* [Get user readtoken](#get-user-readtoken)
* [Get user through readtoken](#get-user-through-readtoken)
* [Get user token](#get-user-token)
* [Get user token for OpenID user](#get-user-token-for-openid-user) (For App)
* [Create user](#create-user)
* [Create user data storage](#create-user-data-storage)
* [Activate user account](#activate-user-account)
* [Add user permissions](#add-user-permissions)
* [Set user profile picture](#set-user-profile-picture)
* [Share User Portal](#share-user-portal)
* [Update user](#update-user)
* [Reset password](#reset-password)
* [Reset user profile picture](#reset-user-profile-picture)
* [Delete user](#delete-user)
* [Delete user data storage](#delete-user-data-storage)
* [Delete user permissions](#delete-user-permissions)
* [Delete user Portal share](#delete-user-portal-share)

#### Bulk Requests

* [Get multiple data sources](#get-multiple-data-sources)
* [Get data from multiple data sources](#get-data-from-multiple-data-sources)
* [Get multiple devices](#get-multiple-devices)
* [Get multiple users](#get-multiple-users)
* [Get multiple groups](#get-multiple-groups)
* [Update multiple devices](#update-multiple-devices)

## API Index

#### /accounts

* [GET] [/api/portals/v1/accounts/{user-email}](#get-user-account-by-email)
* [GET] [/api/portals/v1/accounts/{user-id}](#get-user-account-by-user-id)
* [GET] [/api/portals/v1/accounts](#get-all-user-accounts) (Deprecated)

#### /client-models

* [GET] [/api/portals/v1/client-models/{vendor}/{name}](#get-client-model)
* [GET] [/api/portals/v1/client-models/](#list-client-models)
* [GET] [/api/portals/v1/client-models/{vendor}/{name}/sn/{serial-number}](#get-serial-number)
* [PUT] [/api/portals/v1/client-models/{vendor}/{name}](#update-client-model)
* [DELETE] [/api/portals/v1/client-models/{vendor}/{name}](#delete-client-model)

#### /dashboards
* [GET] [/api/portals/v1/dashboards/{dashboard-id}](#get-dashboard)
* [PUT] [/api/portals/v1/dashboards/{dashboard-id}](#update-dashboard)
* [DELETE] [/api/portals/v1/dashboards/{dashboard-id}](#delete-dashboard)

#### /data-sources

* [GET] [/api/portals/v1/data-sources/{data-source-rid}](#get-data-source)
* [GET] [/api/portals/v1/data-sources/{data-source-rid}/data](#get-data-source-data)
* [GET] [/api/portals/v1/data-sources/[{data-source-rid},{data-source-rid},...]/data](#get-data-from-multiple-data-sources)
* [POST] [/api/portals/v1/data-sources/{data-source-rid}/data](#append-data-source-data)
* [POST] [/api/portals/v1/data-sources/{data-source-rid}/json](#append-data-source-data-in-json-format)
* [PUT] [/api/portals/v1/data-sources/{data-source-rid}](#update-data-source)
* [DELETE] [/api/portals/v1/data-sources/{data-source-rid}](#delete-data-source)
* [DELETE] [/api/portals/v1/data-sources/{data-source-rid}/data](#delete-data-source-data)

#### /device

* [POST] [/api/portals/v1/device](#create-new-device-under-a-portal-of-authenticated-user)

#### /devices

* [GET] [/api/portals/v1/devices/{device-rid}](#get-device)
* [GET] [/api/portals/v1/devices/{device-rid}/data-sources](#list-device-data-sources)
* [GET] [/api/portals/v1/devices/{device-rid}/scripts](#list-device-script)
* [POST] [/api/portals/v1/devices/{device-rid}/data-sources](#create-device-data-source)
* [POST] [/api/portals/v1/devices/{device-rid}/scripts](#create-device-script)
* [PUT] [/api/portals/v1/devices/{device-rid}](#update-device)
* [PUT] [/api/portals/v1/devices/[{device-rid},{device-rid},...]](#Update-multiple-devices)
* [DELETE] [/api/portals/v1/devices/{device-rid}](#delete-device)

#### /domain

* [GET] [/api/portals/v1/domain/](#list-domains-of-authenticated-user)

#### /fs

* [GET] [/api/portals/v1/fs](#list-files)
* [GET] [/api/portals/v1/fs/{directory-path}/{subdirectory}](#get-a-file)
* [GET] [/api/portals/v1/fs/{directory-path}/{subdirectory}/{field-name}](#get-file-content)
* [POST] [/api/portals/v1/fs](#append-to-directory)
* [PUT] [/api/portals/v1/fs/{directory-path}](#update-file-content)

#### /groups

* [GET] [/api/portals/v1/groups/{group-id}](#get-group)
* [GET] [/api/portals/v1/groups/{group-id}/permissions](#get-group-permissions)
* [POST] [/api/portals/v1/groups/{group-id}/permissions](#add-group-permissions)
* [PUT] [/api/portals/v1/groups/{group-id}](#update-group)
* [DELETE] [/api/portals/v1/groups/{group-id}](#delete-group)
* [DELETE] [/api/portals/v1/groups/{group-id}/permissions](#delete-group-permissions)

#### /portal

* [GET] [/api/portals/v1/portal/ ](#list-portals-of-authenticated-user)

#### /portals

* [GET] [/api/portals/v1/portals/{portal-id}/dashboards](#list-portal-dashboards)
* [GET] [/api/portals/v1/portals/{portal-id}/data-sources](#list-portal-data-sources)
* [GET] [/api/portals/v1/portals/{portal-id}/devices](#list-portal-device)
* [GET] [/api/portals/v1/portals/{portal-id}](#get-portal)
* [GET] [/api/portals/v1/portals](#list-portals-by-domain)
* [GET] [/api/portals/v1/devices/{device-rid}/scripts](#list-device-script)
* [GET] [/api/portals/v1/portals/{portal-id}/scripts](#list-portal-script)
* [POST] [/api/portals/v1/portals/{portal-id}/dashboards](#create-portal-dashboard)
* [POST] [/api/portals/v1/portals/{portal-id}/data-sources](#create-portal-data-source)
* [POST] [/api/portals/v1/portals/{portal-id}/devices](#create-device)
* [POST] [/api/portals/v1/portals/{portal-id}/scripts](#create-portal-script)
* [PUT] [/api/portals/v1/portals/{portal-id}](#update-portal)
* [DELETE] [/api/portals/v1/portals/{portal-id}](#delete-portal-by-id)
* [DELETE] [/api/portals/v1/portals/{portal-rid}/ByRid](#delete-portal-by-rid)

#### /scripts

* [GET] [/api/portals/v1/scripts/{script-rid}](#get-script)
* [GET] [/api/portals/v1/scripts/{script-rid}/data](#get-script-data)
* [PUT] [/api/portals/v1/scripts/{script-rid}](#update-script)
* [DELETE] [/api/portals/v1/scripts/{script-rid}](#delete-script)

#### /themes

* [GET] [/api/portals/v1/themes/](#list-themes)
* [GET] [/api/portals/v1/themes/{themeid}](#get-theme)
* [POST] [/api/portals/v1/themes/](#create-theme)
* [PUT] [/api/portals/v1/themes/{themeid}](#update-theme)
* [DELETE][/api/portals/v1/themes/{themeid}](#delete-theme)

#### /user

* [POST] [/api/portals/v1/user](#register-new-user-account) (Deprecated)
* [POST] [/api/portals/v1/user/password](#reset-user-account-password) (Deprecated)

#### /users

* [GET] [/api/portals/v1/users](#get-all-users)
* [GET] [/api/portals/v1/users/{user-id}](#get-user)
* [GET] [/api/portals/v1/users/{user-id}?readtoken={user-readtoken}](#get-user-through-readtoken)
* [PUT] [/api/portals/v1/users/{user-id}](#update-user)
* [GET] [/api/portals/v1/users/{user-id}/ds/{subdirectory}](#get-user-data-storage)
* [GET] [/api/portals/v1/users/{user-id}/ds/{subdirectory}/*}](#get-user-data-storage-list)
* [GET] [/api/portals/v1/users/{user-id}/permissions](#get-user-permissions)
* [GET] [/api/portals/v1/users/{user-id}/portals](#get-all-user-portals)
* [GET] [/api/portals/v1/users/{user-id}/portals/shares](#get-all-users-portals-shares)
* [GET] [/api/portals/v1/users/{user-id}/portals/{portal-id}](#get-user-portal)
* [GET] [/api/portals/v1/users/{user-id}/portals/{portal-id}/shares](#get-user-portal-shares)
* [GET] [/api/portals/v1/users/{user-id}/profile/picture](#get-user-profile-picture)
* [GET] [/api/portals/v1/users/{user-id}/token](#get-user-token)
* [GET] [/api/portals/v1/users/{user-id}/readtoken](#get-user-readtoken)
* [GET] [/api/portals/v1/users/_this/token](#get-user-token-for-openid-user) (For App)
* [GET] [/api/portals/v1/users/_this/data-sources/[{data-source-rid},{data-source-rid},...]](#get-multiple-data-sources)
* [GET] [/api/portals/v1/users/_this/devices/[{device-rid},{device-rid},...]](#get-multiple-devices)
* [GET] [/api/portals/v1/users/_this/groups/[{group-id},{group-id},...]](#get-multiple-groups)
* [GET] [/api/portals/v1/users/_this/users/[{user-id},{user-id},...]](#get-multiple-users)
* [POST] [/api/portals/v1/users](#create-user)
* [POST] [/api/portals/v1/users/{user-id}/ds/{subdirectory}](#create-user-data-storage)
* [POST] [/api/portals/v1/users/{user-id}/groups](#create-group-under-user)
* [POST] [/api/portals/v1/users/{user-id}/permissions](#add-user-permissions)
* [POST] [/api/portals/v1/users/{user-id}/portals](#create-portal)
* [POST] [/api/portals/v1/users/{user-id}/portals/{portal-id}/shares](#share-user-portal)
* [POST] [/api/portals/v1/users/{user-id}/profile/picture](#set-user-profile-picture)
* [POST] [/api/portals/v1/users/reset-password](#reset-password)
* [PUT] [/api/portals/v1/users/reset-password](#update-password-by-reset-password-key)
* [DELETE] [/api/portals/v1/users/{user-id}/ds/{subdirectory}](#delete-user-data-storage)
* [DELETE] [/api/portals/v1/users/{user-id}](#delete-user)
* [DELETE] [/api/portals/v1/users/{user-id}/permissions](#delete-user-permissions)
* [DELETE] [/api/portals/v1/users/{user-id}/portals/{portal-id}/shares](#delete-user-portal-share)
* [DELETE] [/api/portals/v1/users/{user-id}/profile/picture](#reset-user-profile-picture)

#### /widget-scripts

* [GET] [/api/portals/v1/widget-scripts/{widget-script-id}](#get-domain-widget)
* [GET] [/api/portals/v1/widget-scripts](#list-domain-widget)
* [POST] [/api/portals/v1/widget-scripts](#create-domain-widget)
* [PUT] [/api/portals/v1/widget-scripts/{widget-script-id}](#update-domain-widget)
* [DELETE] [/api/portals/v1/widget-scripts/{widget-script-id}](#delete-domain-widget)

## REST

The Portals API is a REST-style API, which means that:

* HTTP verbs in the request determine the type of action the client wants to take, e.g. GET, POST or DELETE.
* HTTP statuses in the response indicate the result of the API call, e.g. 200 for success, 400 for bad request or 401 for authentication error.

## Request and Response Format

Request and response bodies, when present, are formatted using [JSON](http://json.org).

Please note that some of the JSON examples below have been formatted with extra whitespaces for clarity.

The request header MUST include:

    Content-type: application/json; charset=utf-8

## Authentication

Some API endpoints require a Portals email (or username) and password combination for authentication. These are passed using [basic access authentication](http://en.wikipedia.org/wiki/Basic_access_authentication).

## Definition of Domain

For some API endpoints, the domain of the request URL determines which domain will be affected. For example, a GET request to...

    https://mydomain.exosite.com/api/portals/v1/portal/

...will return a different array of portals than a GET request to...

    https://portals.exosite.com/api/portals/v1/portal/

The domain is also used for user authentication. Endpoints affected by the queried domain are listed below.

## Objects

The following objects are common to several API endpoints.

### Account Object

An account object contains information on a Portals user.

```
{
    "email": <short-string>,
    "fullName": <short-string>,
    "id": <id>,
    "rid":<rid>,
    "meta": <meta>,
    "phoneNumber": <short-string>,
    "userName": <short-string>
}
```

* `"email"` is the user's email address. It is a string of fewer than 256 characters.
* `"fullName"` is the user's full name. It is a string of fewer than 256 characters.
* `"id"` is a numeric identifier for the user.
* `"meta"` may be any type. It contains application-specific information describing the user. It MUST be less than 2 megabytes after JSON string serializing.
* `"phoneNumber"` is the user's phone number. It is a string of fewer than 256 characters.
* `"userName"` is a string identifier for the user. It is a string of fewer than 256 characters.

### Client Model Object

A client model object contains detailed information on a client model, such as the client model's id and vendor.

```
{
    "id": "samplevendor\/samplemodel",
    "domainID": "0000000000",
    "vendor": "samplevendor",
    "friendly": "dfhg",
    "name": "samplemodel",
    "cloneRID": "29770f4f96122ffd33af1f6edb1b875810c7844a",
    "viewID": "0000000000",
    "exampleSN": "",
    "sharedSN": "",
    "convertSN": "no",
    "alternateSN": "",
    "noteSetup": "",
    "noteName": "",
    "noteLocation": "(optional - can be a string or GPS decimal degrees)",
    "pictureDevice": "https:\/\/portals.yourdomain.com\/cache\/model\/samplevendor\/samplemodel_PictureDevice.png",
    "description": "",
    "pictureSN": "",
    "confirmPage": "Your [client model name] [device] was successfully enabled with the CIK\u003Cbr\/\u003E[device cik]\u003Cbr\/\u003E\u003Cbr\/\u003EYour [device] will need to connect to the Exosite platform within 24 hours or your provision request will expire and you will need to re-enable your [device] from the Re-Enable block in your [device] pop-up. If you have any problems connecting, please contact your [device] provider at:\u003Cbr\/\u003E\u003Cbr\/\u003E\u003Cb\u003ECompany name:\u003C\/b\u003E [company name]\u003Cbr\/\u003E\u003Cb\u003ECompany email contact information:\u003C\/b\u003E [company email]\u003Cbr\/\u003E",
    "companyName": "",
    "contactEmail": "",
    ":published": true
}
```

### Dashboard Object

A dashboard object contains a dashboard's configuration, layout and information.

```
{
    "config": object = {
        "layout" : object = {
            "cols": 2 | 4 | 6 = 4,
            "gravity": "LeftTop" | "Top" = "LeftTop"
        },
        "widgets": object = {}
    },
    "description": string = "",
    "id": string,
    "location": string = "",
    "name": string,
    "portalId": string,
    "public": boolean = false
}
```

* `"config"` is the dashboard configuration, limited to 16MB of characters.
    * `"layout"` is the dashboard layout.
        * `"cols"` means 1 column by 2 grids, 2 columns equal 4 grids and so on.
        * `"gravity"` provides the dashboard layout alignment.
    * `"widgets"` provides each widget's configuration on the dashboard.
* `"description"` is a dashboard's description, limited to 255 characters.
* `"id"` is a 10 digit dashboard identifier.
* `"location"` is dashboard location, limited to 255 characters.
* `"name"` is a descriptive name, limited to 50 characters and must be unique under the Portal.
* `"portalId"` is a 10 digit identifier of a Portal.
* `"public"` provides public read-only access. If set to true, it will make the dashboard readable by any user. If set to false, the dashboard will be readable only by users with permission to view the dashboard or to manage the Portal.

### Data Source Object

A data source object contains information on a Portal's time series data source.

```
{
    "data": [
        [
            <unix-timestamp-1>,
            <value-1>
        ],
        [
            <unix-timestamp-2>,
            <value-2>
        ],
        ...
    ],
    "info": {
        "basic": <basic>,
        "description": <description>,
        "shares": <shares>,
        "storage": <storage>,
        "subscribers": <subscribers>,
        "tags": <tags>
    },
    "rid": <rid>,
    "unit": <unit>
}
```

* `"data"` is an array of data points. A data point has a unit timestamp and a value.

    * `<unix-timestamp-N>` is a [Unix timestamp](http://en.wikipedia.org/wiki/Unix_time), defined as the number of seconds that have elapsed since 00:00:00, January 1st 1970 (UTC).

    * `<value-N>` may be a string, int, or float depending on the type of the data source.

* `"info"` is a dataport object documented in the [remote procedure call documentation](https://github.com/exosite/docs/tree/master/rpc#info). But only basic, description, shares, storage, subscribers and tags are exposed.
* `"rid"` is the RID of a data source.
* `"unit"` is the unit of a data source.

### Device Object

A device object contains detailed information on a device, such as it's data sources, resource id, serial number and type.

```
{
    "dataSources": [
        <data-source-rid-1>,
        <data-source-rid-2>,
        ...
    ],
    "info": {
        "aliases": <aliases>,
        "basic": <basic>,
        "description": <description>,
        "key": <key>,
        "shares": <shares>,
        "subscribers": <subscribers>,
        "tagged": <tagged>,
        "tags": <tags>,
    },
    "members": [
        <permission-1>,
        <permission-2>,
        ...
    ],
    "model": <model-id>,
    "rid": <rid>,
    "sn": <sn>,
    "type": <device-type>,
    "vendor": <vendor-id>
}
```

* `"dataSources"` is an array of data source IDs under a device.
    * `<data-source-rid-N>` is a 40 character hex string representing the data source's RID in the One Platform.

* `"info"` is an client object documented in the [remote procedure call documentation](https://github.com/exosite/docs/tree/master/rpc#info). But only aliases, basic, description, key, shares, subscribers, tagged and tags are exposed.
    * `<key>` is a 40 character hex string representing the client's CIK in the One Platform, or null if the authorized user does not have \_\_\_admin permission to this device.

* `"members"` is an array of [permission objects](#permission-object) listing the members of the device.
* `"model"` is a string identifying the model.
* `"rid"` is the RID of a device.
* `"sn"` is a string representing the serial number of the device.
* `"type"` is a constant string representing the type of the device. Possible values are:
    * `"vendor"`

* `"vendor-id"` is a string identifying the vendor.

### Domain widget object

A domain widget object contains information on a domain widget.

```
{
    "code": "function(){}",
    "description": "no operation",
    "id": "0000000000",
    "name": "noop"
}
```

* `"code"` is the JavaScript code of the domain widget. It MUST be less than 1 megabyte after JSON string serializing.
* `"description"` is the description of the domain widget. It MUST be less than 256 characters.
* `"id"` is the identifier of the domain widget.
* `"name"` is the name of the domain widget. It MUST be less than or equal to 50 characters.

### Group object

A group object contains information on a Portals permissions group, such as the group's id, members and permissions.

```
{
    "id": <group-id>,
    "members": [
        <permission-1>,
        ...
    ],
    "meta": <meta>,
    "name": <short-text>,
    "permissions": [
        <permission-1>,
        ...
    ],
    "userId": <user-id>
}
```

* `"id"` is a number identifying the group.
* `"members"` is an array of [permission objects](#permission-object) listing the members of the group.
* `"meta"` may be any type. It contains application-specific information describing the group. It MUST be less than 2 megabytes after JSON string serializing.
* `"name"` is the group name. It is a string of fewer than 50 characters. It MUST be unique among the same user in a domain.
* `"permissions"` is an array of [permission objects](#permission-object) describing the Portals resources members of the group may access.
* `"userId"` is a number identifying the owner of the group.

### Permission object

A permission object describes a level of access to a specific Portals resource identified by `"oid"`, and will only show resources under the current domain. In other words, a permissions list will never contain resources which do not belong to the current domain.

```
{
    "access": <access>,
    "oid": {
        "id": <id>,
        "type": <type>
    }
}
```

* `"access"` is a string which defines what permission the owner has for the resource. Possible values are:

 `"___admin"` (Default) means the owner has the highest permission to the resource.

    * Common Access

        * Dashboard
            * `"v___view"` means the owner can GET information from the dashboard.

        * Data Source
            * `"d__write"` means the owner can GET information from the data source and read from or write to the data source.
            * `"d___read"` means the owner can GET the data source's information, and read data from the data source.

        * Device
            * `"d_update"` means the owner can GET, update the device's information and delete the device.
            * `"d___view"` means the owner can GET the device's information.

        * Domain
            * `"d_s_cont"` means the owner can update the domain's information.
            * `"d_s_crea"` means the owner can create a group under the domain.
            * `"d_p_list"` means the owner can create a Portal under the domain.
            * `"d_p_crea"` means the owner can just create a Portal for himself under the domain.
            * `"d_u_list"` means the owner can GET a user, GET all users, and delete a user from the domain.
            * `"d_u_view"` means the owner can GET user, GET users list form the domain.
            * `"d_____fs"` means the owner can create, update and delete the file systems in the domain.

        * Group
            * `"g_update"` means the owner can modifying member list of the group and read, update the group information.
            * `"g_member"` means the owner can modifying member list of the group and read the group information.
            * `"g_modera"` means the owner can modifying member list of the group.

        * Portal
            * `"p_manage"` means the owner can GET, update Portal information and create device, data source to the Portal.
            * `"p_m_crea"` means the owner can create device to the Portal.
            * `"p___view"` means the owner can GET Portal information, GET devices and GET data sources under the Portal.
            * `"p_contac"` means the owner can receive alerts from the Portal.

* `"oid"` is an object identifying the resource with the permission.

    * `<id>` is a number identifying the resource.

    * `<type>` is a string identifying the type of resource the permission provides access to. It may have one of the following values:

        * `"DataSource"`

        * `"Device"`

        * `"Domain"`

        * `"Group"`

        * `"Portal"`

        * `"User"`

#### Example

* Update a user's permissions

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736' \
     -X PUT \
     -d '{"permissions":[{"access":"d_update","oid":{"type":"Device","id":"dc226acdf0f9b92e40f0f62878970417b8689f9e"}}]}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:33:44 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
    "email": "updatedemail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions":[{"access":"d_update","oid":{"type":"Device","id":"dc226acdf0f9b92e40f0f62878970417b8689f9e"}}]
}
```

* Update group permission

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/3167859736' \
     -X PUT \
     -d '{"permissions":[{"access":"d_update","oid":{"type":"Device","id":"dc226acdf0f9b92e40f0f62878970417b8689f9e"}}]}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:33:44 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
    "email": "updatedemail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions":[{"access":"d_update","oid":{"type":"Device","id":"dc226acdf0f9b92e40f0f62878970417b8689f9e"}}]
}
```

### Portal object

A Portal object contains information on a Portal, such as the Portal's devices, id, description and shares.

```
{
    "devices": [
        <device-rid-1>,
        <device-rid-2>,
        ...
    ],
    "id": <id>,
    "info": {
        "aliases": <aliases>,
        "basic": <basic>,
        "description": <description>,
        "key": <key>,
        "shares": <shares>,
        "subscribers": <subscribers>,
        "tagged": <tagged>,
        "tags": <tags>,
    },
    "planId": <plan-id>,
}
```

* `"devices"` is an array of identifiers for devices of the Portal owns.

    * `<device-rid-N>` is a 40 character hex string representing the device's RID in the One Platform

* `"id"` is a numeric identifier for the Portal.

* `"info"` is a client object documented in the [remote procedure call documentation](https://github.com/exosite/docs/tree/master/rpc#info). But only aliases, basic, description, key, shares, subscribers, tagged and tags are exposed.

    * `<key>` is a 40 character hex string representing the client's CIK in the One Platform or null if the authorized user doesn't have \_\_\_admin permission to this Portal.

* `"planId"` is a numeric identifier for the plan of the Portal.

### Script object

A script object contains the rid, data and info of a script.

```
{
    "rid": "28571049e6bf6de245012957171da9e83926d897",
    "data": [
        [1431316854, "line 4: 8\nline 4: 9\nline 4: 10"]
    ],
    "info": {
        "basic": {
            "modified": 1431316848,
            "subscribers": 0,
            "type": "datarule",
            "status": "completed",
            "activity": [
                [1431316855, ["completed"]],
                [1431316853, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": "local n = 0\nwhile n < 10 do\n\tn = n + 1\n\tdebug(tostring(n))\nend"
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}
```

* `<rid>` is a 40 digit resource identifier.
* `<data>` is a list of timestamps and value pairs.
* `<info>` contains information on an existing [resource](http://docs.exosite.com/rpc/#resources).

### Theme object

A theme object contains the id, name, description and detailed configurations of a theme.

```
{
    "id": "3077881923",
    "name": "sample_theme",
    "description": "this is a description",
    ":default": true,
    "config": {
        "dashboard_background": {
            "background_color": "F9F9F9",
            "background_image": "",
            "background_attachment": "scroll",
            "background_repeat": "repeat-y",
            "background_position": "left top"
        },
        "header_logo": "https:\/\/portals.yourdomain.com\/cache\/theme\/0_1923506535_header_logo.png",
        "header_bkimage": "https:\/\/portals.yourdomain.com\/static\/png\/skin_portals_bannerbg.png?62d38477d5d7a46968a168c460bf76fc",
        "header_title_color": "D5E04D",
        "header_subtitle_color": "FFFFFF",
        "header_titles_position_top": "1.375em",
        "header_linktext_color": "E5E5E5",
        "header_linktextover_color": "D5E04D",
        "header_dropdown_text_color": "FFFFFF",
        "header_linktext_position_top": "1.5em",
        "header_portalmenu_current_color": "0000FF",
        "footer_text": "ANY DEVICE. ANY DATA. ANY WHERE.",
        "footer_text_color": "D5E04D",
        "footer_bar_color": "D5E04D",
        "footer_linktext_color": "5C5D60",
        "footer_linktextover_color": "000000",
        "block_title_text_color": "000000",
        "block_title_linkover_color": "010101",
        "block_title_back_color": "D5E04D",
        "block_invert_icons": "",
        "managepage_highlight_text_color": "0000FF",
        "dashboard_thumbnail": "",
        "thankyoupage_title_text_color": "D5E04D",
        "browser_tab_text": "Exosite Portals",
        "browser_tab_icon": "https:\/\/portals.yourdomain.com\/static\/png\/icon_exosite.png?834282e60aa5c2cf2d3a6894307437dd",
        "admin_menu_style": {
            "admin_menu_title": "Domain Admin",
            "manage_menu_title": "Manage",
            "secondary_menu_title": "Portal Menu",
            "account_menu_title": "Account",
            "menu_title_color": "E5E5E5",
            "background_color": "5C5D60",
            "background_hover_color": "A6A6A6",
            "text_color": "FFFFFF",
            "sub_background_color": "FFFFFF",
            "sub_background_hover_color": "A6A6A6",
            "sub_text_color": "5C5D60",
            "text_active_color": "D5E04D"
        },
        "jsCode": ""
    },
    "code": ""
}
```

### User object

A user object contains information on a Portal's user, such as the user's email, full name, id and permissions.

```
{
    "activated": <boolean>,
    "email": <short-string>,
    "fullName": <short-string>,
    "groups": [
        <group-id-1>,
        <group-id-2>,
        ...
    ],
    "id": <id>,
    "meta": <meta>,
    "permissions": [
        <permission-1>,
        ...
    ],
    "phoneNumber": <short-string>,
    "userName": <short-string>
}
```

* `"activated"` indicates whether a user is activated in the domain or not.
* `"email"` is the user's email address. It is a string of fewer than 256 characters.
* `"fullName"` is the user's full name. It is a string of fewer than 256 characters.
* `"groups"` is an array of identifiers for groups of which the user is a member.

    * `<group-id-N>` is a number identifying the group.

* `"id"` is a numeric identifier for the user.
* `"meta"` may be any type. It contains application-specific information describing the user. It MUST be less than 2 megabytes after JSON string serializing.
* `"permissions"` is an array of [permission objects](#permission-object) describing Portals resources the user may access.
* `"phoneNumber"` is the user's phone number. It is a string of fewer than 256 characters.
* `"userName"` is a string identifier for the user. It is a string of fewer than 256 characters.

### User ID ###

Anywhere an API endpoint takes a user ID, you can instead use \_this as an alias for the user ID of the authenticated user.

#### Example ####

Given a request is authenticated as a user with ID being 1234567890,

`GET /api/portals/v1/users/1234567890`

yields the same result as

`GET /api/portals/v1/users/_this`

## Caveats

API responses are subject to updates and improvements (e.g. additional fields may be added). Developers using Exosite APIs should not hard-code elements that are not forward compatible, such as field counts, IP addresses, or header length.

## Resources

### Accounts

#### Get all user accounts

`GET /api/portals/v1/accounts`

> **Deprecated.** This API is deprecated and should not be used.

Get all user's account information.

##### Permissions

* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [account objects](#account-object) if the caller has permission to list accounts.
* `403 Forbidden`: Returned if the caller does not have `d_u_view` permission to the domain.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/accounts' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:42:30 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "useremail@gmail.com",
        "fullName": "",
        "id": "3167859736",
        "rid":"7fe862bd9f274b8ab80cf22284a2316599024fb9",
        "meta": null,
        "phoneNumber": "",
        "userName":"useremail"
    },
    {
        "email": "existinguseremail@gmail.com",
        "fullName": "existinguseremail",
        "id": "3407735538",
        "rid":"7fe862bd9f274b8ab80cf22284a2316599024fb0",
        "meta": null,
        "phoneNumber": "",
        "userName":"existinguseremail"
    },
    ...
]
```

#### Get user account by email

`GET /api/portals/v1/accounts/{user-email}`

Get a user's account information by the user's email.

##### Permissions

* User can GET his own account information.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an [account object](#account-object) if the caller has permission to GET the account and the account exists in the domain.
* `403 Forbidden`: Returned if the caller does not have permission to GET the user's account.
* `404 Not Found`: Returned if the account does not exist in the domain.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/accounts/existinguseremail@gmail.com' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:40:58 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 99
Content-Type: application/json; charset=UTF-8

{
    "email": "existinguseremail@gmail.com",
    "fullName": "existinguseremail",
    "id": "3407735538",
    "rid":"7fe862bd9f274b8ab80cf22284a2316599024fb0",
    "meta": null,
    "phoneNumber": "",
    "userName":"existinguseremail"
}
```

#### Get user account by user ID

`GET /api/portals/v1/accounts/{user-id}`

Get a user's account information by the user's ID.

##### Permissions

* User can GET his own account information.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an [account object](#account-object) if the caller has permission to GET the account and the user's account exists in the domain.
* `403 Forbidden`: Returned if the caller does not have permission to GET the user's account.
* `404 Not Found`: Returned if the user's account does not exist in the domain.


##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/accounts/3407735538' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:40:58 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 99
Content-Type: application/json; charset=UTF-8

{
    "email": "existinguseremail@gmail.com",
    "fullName": "existinguseremail",
    "id": "3407735538",
    "rid":"7fe862bd9f274b8ab80cf22284a2316599024fb0",
    "meta": null,
    "phoneNumber": "",
    "userName":"existinguseremail"
}
```

### Client Models

Client models represent a class of devices. All devices of the same client model have the same behaviour attributes and pricing. Only domain administrators can use the client model APIs.
**Note: Image data cannot be modified using this API currently**

#### Get client model

`GET /api/portals/v1/client-models/{vendor}/{name}`

Get a client model's information.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [client model object](#client-model-object) if the caller has permission to GET the client model and the client model exists in the domain.
* `403 Forbidden`: Returned if the caller does not have permission to GET the client model.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/client-models/myvendor/myname' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:21:14 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 1071
Content-Type: application/json; charset=UTF-8

{
    "id": "myvendor/myname",
    "domainID": "3481377489",
    "vendor": "myvendor",
    "friendly": "myname",
    "name": "myname",
    "cloneRID": "96436ca6874ce01d0dd1f41001d71e75c3aebd6f",
    "viewID": "0000000000",
    "exampleSN": "",
    "sharedSN": "",
    "convertSN": "no",
    "alternateSN": "",
    "noteSetup": "",
    "noteName": "",
    "noteLocation": "(optional - can be a string or GPS decimal degrees)",
    "pictureDevice": "",
    "description": "",
    "pictureSN": "",
    "confirmPage": "Your [client model name] [device] was successfully enabled with the CIK<br/>[device cik]<br/><br/>Your [device] will need to connect to the Exosite platform within 24 hours or your provision request will expire and you will need to re-enable your [device] from the Re-Enable block in your [device] pop-up. If you have any problems connecting, please contact your [device] provider at:<br/><br/><b>Company name:</b> [company name]<br/><b>Company email contact information:</b> [company email]<br/>",
    "companyName": "",
    "contactEmail": "",
    ":published": false
}
```

#### Update client model

`PUT /api/portals/v1/client-models/{vendor}/{name}`

Update a client model's information.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is a JSON encoded [client model object](#client-model-object).
* Requires authentication.

##### Response

* `200 OK`: Returned if the client model was updated successfully.
* `403 Forbidden`: Returned if the caller does not have permission to update the client model.
* `404 Not Found`: Returned if the client model does not exist in the domain.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/client-models/myvendor/mymodel' \
     -X PUT \
     -d '{"description": "sample model"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 08:14:01 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### List client models

`GET /api/portals/v1/client-models/`

Returns an array of client models under the domain.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [client models objects](#client-model-object) if the caller has permission to list client models.
* `403 Forbidden`: Returned if the caller does not have permission to list client models.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/client-models' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:10:30 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[
       {
        "id": "myvendor/myname",
        "domainID": "3481377489",
        "vendor": "myvendor",
        "friendly": "myname",
        "name": "myname",
        "cloneRID": "96436ca6874ce01d0dd1f41001d71e75c3aebd6f",
        "viewID": "0000000000",
        "exampleSN": "",
        "sharedSN": "",
        "convertSN": "no",
        "alternateSN": "",
        "noteSetup": "",
        "noteName": "",
        "noteLocation": "(optional - can be a string or GPS decimal degrees)",
        "pictureDevice": "",
        "description": "",
        "pictureSN": "",
        "confirmPage": "Your [client model name] [device] was successfully enabled with the CIK<br/>[device cik]<br/><br/>Your [device] will need to connect to the Exosite platform within 24 hours or your provision request will expire and you will need to re-enable your [device] from the Re-Enable block in your [device] pop-up. If you have any problems connecting, please contact your [device] provider at:<br/><br/><b>Company name:</b> [company name]<br/><b>Company email contact information:</b> [company email]<br/>",
        "companyName": "",
        "contactEmail": "",
        ":published": false
    },
    {
        "id": "myvendor/testing%2B1412320409837",
        "domainID": "3481377489",
        "vendor": "myvendor",
        "friendly": "testing+1412320546880",
        "name": "testing+1412320409837",
        "cloneRID": "fc03f70ea93a2b8e65ac96e9ad71fbb79bbbd7ad",
        "viewID": "0000000000",
        "exampleSN": "",
        "sharedSN": "",
        "convertSN": "no",
        "alternateSN": "",
        "noteSetup": "",
        "noteName": "",
        "noteLocation": "(optional - can be a string or GPS decimal degrees)",
        "pictureDevice": "",
        "description": "testing+1412320409837",
        "pictureSN": "",
        "confirmPage": "Your [client model name] [device] was successfully enabled with the CIK<br/>[device cik]<br/><br/>Your [device] will need to connect to the Exosite platform within 24 hours or your provision request will expire and you will need to re-enable your [device] from the Re-Enable block in your [device] pop-up. If you have any problems connecting, please contact your [device] provider at:<br/><br/><b>Company name:</b> [company name]<br/><b>Company email contact information:</b> [company email]<br/>",
        "companyName": "testing+1412320546880",
        "contactEmail": "testing+1412320546880@email.com",
        ":published": true
    },
    ...
]
```

#### Delete client model

`DELETE /api/portals/v1/client-models/{vendor}/{name}`

If the current default client model was deleted, the Exosite system client model will be applied to the domain.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the client model was deleted successfully.
* `403 Forbidden`: Returned if the caller does not have permission to delete the client model.
* `404 Not Found`: Returned if the client model does not exist in the domain.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/client-models/myvendor/mymodel' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:26:52 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get serial number

`GET /api/portals/v1/client-models/{vendor}/{name}/sn/{serial-number}`

Get information on a serial number.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.
* User must have `___admin` [permission](#permission-object) to the device with the serial number (Check "Allow end users to obtain the serial number extra field information using the API." under the admin/configuration page.)

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a JSON entity if the caller has permission to GET the serial number.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the serial number.
* `404 Not Found`: Returned if the serial number does not exist in the domain.


##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/client-models/myvendor/mymodel/sn/123' \
     -X GET \
     -u 'domainuseremail@gmail.com:adminuserPassword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:10:30 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

{
    "status": "expired",
    "rid": "847699a4667a64a42eaca6ecd0f564374e64b9f7",
    "extra": "test for extra info",
}
```

### Bulk Requests

#### Get multiple data sources

`GET /api/portals/v1/users/_this/data-sources/[{data-source-rid},{data-source-rid},...]`

Get information on multiple data sources.
Can be used for pagination.

##### Permissions

* User must have at least `d___read` [permission](#permission-object) to the data sources.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `limit` | Limits the number of data sources to retrieve. The internal limit is 200, but some may be smaller. Optional. | `/users/_this/users/[{data-source-rid},{data-source-rid},...]?limit=10`      |
| `offset` | Sets the number of data sources in the query array to skip. Optional. | `/users/_this/users/[{data-source-rid},{data-source-rid},...]?offset=10`     |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [data source objects](#data-source-object) if the caller has permission to GET the data sources.
* `206 Partial Content`: Returned along with a body containing an array of [data source objects](#data-source-object) if the number of requested IDs exceeds the response limit, the link will appear in the header  `Link=<{url}>; rel="previous", <{url}>; rel="next"`.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the data sources.
* `404 Not Found`: Returned if one of the data sources is invalid.

##### Example

###### If all items were fetched

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/data-sources/\[a3fc4e5a6fbc20fcb14091ba0735580e56060e9a,a90f263111b05088a3c78aef511f14275bba6cc5\]' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 02:49:17 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 648
Content-Type: application/json; charset=UTF-8

[
    {
        "data": [
            [
                1416190810,
                100
            ]
        ],
        "info": {
            "basic": {
                "modified": 1416190782,
                "subscribers": 0,
                "type": "dataport"
            },
            "description": {
                "format": "integer",
                "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
                "name": "test",
                "preprocess": [],
                "public": false,
                "retention": {
                    "count": "infinity",
                    "duration": "infinity"
                },
                "subscribe": null
            },
            "shares": [],
            "storage": {
                "count": 1,
                "first": 1416190810,
                "last": 1416190810,
                "size": 12
            },
            "subscribers": [],
            "tags": []
        },
        "rid": "a3fc4e5a6fbc20fcb14091ba0735580e56060e9a",
        "unit": ""
    },
    {
        "data": [
            [
                1416190822,
                300
            ]
        ],
        "info": {
            "basic": {
                "modified": 1416190793,
                "subscribers": 0,
                "type": "dataport"
            },
            "description": {
                "format": "integer",
                "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
                "name": "test1",
                "preprocess": [],
                "public": false,
                "retention": {
                    "count": "infinity",
                    "duration": "infinity"
                },
                "subscribe": null
            },
            "shares": [],
            "storage": {
                "count": 1,
                "first": 1416190822,
                "last": 1416190822,
                "size": 12
            },
            "subscribers": [],
            "tags": []
        },
        "rid": "a90f263111b05088a3c78aef511f14275bba6cc5",
        "unit": ""
    }
]
```

###### If the number of requested IDs exceeds the response limit

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/data-sources/\[a3fc4e5a6fbc20fcb14091ba0735580e56060e9a,a90f263111b05088a3c78aef511f14275bba6cc5\]?limit=1' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
Date: Mon, 17 Nov 2014 03:18:57 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/data-sources/[a3fc4e5a6fbc20fcb14091ba0735580e56060e9a,a90f263111b05088a3c78aef511f14275bba6cc5]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 486
Content-Type: application/json; charset=UTF-8

[
    {
        "data": [
            [
                1416190810,
                100
            ]
        ],
        "info": {
            "basic": {
                "modified": 1416190782,
                "subscribers": 0,
                "type": "dataport"
            },
            "description": {
                "format": "integer",
                "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
                "name": "test",
                "preprocess": [],
                "public": false,
                "retention": {
                    "count": "infinity",
                    "duration": "infinity"
                },
                "subscribe": null
            },
            "shares": [],
            "storage": {
                "count": 1,
                "first": 1416190810,
                "last": 1416190810,
                "size": 12
            },
            "subscribers": [],
            "tags": []
        },
        "rid": "a3fc4e5a6fbc20fcb14091ba0735580e56060e9a",
        "unit": ""
    }
]
```

#### Get multiple devices

`GET /api/portals/v1/users/_this/devices/[{device-rid},{device-rid},...]`

Get information for devices.
Can be used for pagination.

##### Permissions

* User must have at least `d___view` [permission](#permission-object) to the devices.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `limit` | Limits the number of devices to retrieve. The internal limit is 200, but some may be smaller. Optional. | `/users/_this/users/[{device-rid},{device-rid},...]?limit=10`      |
| `offset` | Sets the number of devices in the query array to skip. Optional. | `/users/_this/users/[{device-rid},{device-rid},...]?offset=10`     |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [device objects](#device-object) if the caller has permission to GET the devices.
* `206 Partial Content`: Returned along with a body containing an array of [device objects](#device-object) if the number of requested IDs exceeds the response limit, the link will appear in he header `Link=<{url}>; rel="previous", <{url}>; rel="next"`.
* `400 Bad Request`: Returned if one of the devices is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the devices.

##### Example

###### If all items were fetched

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/devices/\[47ab21c6e169ca4f749128fb00a4bf077f4a463f,96436ca6874ce01d0dd1f41001d71e75c3aebd6f\]' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 03:29:42 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 2742
Content-Type: application/json; charset=UTF-8

[
    {
        "dataSources": [
            "561d1c757bdafd2c7fb3196e5a35558317045876",
            "8840cd68dfcef3c20c8bc4821f0c670ba2d2eb44"
        ],
        "info": {
            "aliases": {
                "0798132e5e5def5decc7129430112086f1448b39": [
                    "temp"
                ],
                "8840cd68dfcef3c20c8bc4821f0c670ba2d2eb44": [
                    "shared data"
                ],
                "561d1c757bdafd2c7fb3196e5a35558317045876": [
                    "public"
                ]
            },
            "basic": {
                "modified": 1407985593,
                "subscribers": 0,
                "type": "client",
                "status": "activated"
            },
            "description": {
                "limits": {
                    "client": 0,
                    "dataport": "inherit",
                    "datarule": "inherit",
                    "disk": "inherit",
                    "dispatch": "inherit",
                    "email": "inherit",
                    "email_bucket": "inherit",
                    "http": "inherit",
                    "http_bucket": "inherit",
                    "share": "inherit",
                    "sms": "inherit",
                    "sms_bucket": "inherit",
                    "xmpp": "inherit",
                    "xmpp_bucket": "inherit"
                },
                "locked": false,
                "meta": "{\"timezone\":\"Asia\\/Taipei\",\"location\":\"Taichung\",\"device\":{\"type\":\"generic\"},\"activetime\":\"30\"}",
                "name": "device Apple",
                "public": false
            },
            "shares": [
                {
                    "code": "8a7bfcfb3db340d23cdafc599107e16088075b38",
                    "meta": "[\"testing\",\"1\"]",
                    "activator": null
                },
                {
                    "code": "3fcfb90db1210878510c4cd67e06324eb862efb4",
                    "meta": "[\"testing\",\"Fruit+20140807\"]",
                    "activator": null
                },
                {
                    "code": "4b467a56d7b2f5c546d1bcfeab91690bf1e98f24",
                    "meta": "[\"testing\",\"test\"]",
                    "activator": null
                },
                {
                    "code": "98010735f04f1f50ee57251f7342370cbe40d841",
                    "meta": "[\"testing\",\"testing+20140814-1\"]",
                    "activator": null
                },
                {
                    "code": "85c060851a07de239da1159d6294751885afdc9e",
                    "meta": "[\"testing\",\"restfulapi\"]",
                    "activator": null
                },
                {
                    "code": "cd64dfd210e9eb18a403bd04b92901e96c72cc37",
                    "meta": "[\"testing\",\"2\"]",
                    "activator": null
                },
                {
                    "code": "e146db1b2ea1397ce67c02ddf7e876941e137fc5",
                    "meta": "[\"testing\",\"testing+20140822-1\"]",
                    "activator": null
                }
            ],
            "subscribers": [],
            "tagged": [
                "public"
            ],
            "tags": []
        },
        "members": [],
        "model": null,
        "rid": "47ab21c6e169ca4f749128fb00a4bf077f4a463f",
        "sn": null,
        "type": "generic",
        "vendor": null
    },
    {
        "dataSources": [],
        "info": {
            "aliases": [],
            "basic": {
                "modified": 1415769574,
                "subscribers": 0,
                "type": "client",
                "status": "expired"
            },
            "description": {
                "limits": {
                    "client": 0,
                    "dataport": "inherit",
                    "datarule": "inherit",
                    "disk": "inherit",
                    "dispatch": "inherit",
                    "email": "inherit",
                    "email_bucket": "inherit",
                    "http": "inherit",
                    "http_bucket": "inherit",
                    "share": "inherit",
                    "sms": "inherit",
                    "sms_bucket": "inherit",
                    "xmpp": "inherit",
                    "xmpp_bucket": "inherit"
                },
                "locked": false,
                "meta": "{\"DeviceType\":\"generic\",\"DeviceTypeID\":\"0000000002\",\"Timezone\":\"Asia\\/Taipei\",\"Location\":\"Taiwan\",\"activetime\":\"\",\"DeviceTypeName\":\"generic\",\"timezone\":\"Asia\\/Taipei\",\"location\":\"Taiwan\",\"device\":{\"type\":\"vendor\",\"model\":\"testAPI\",\"vendor\":\"testing\",\"sn\":\"888\"}}",
                "name": "888",
                "public": false
            },
            "shares": [],
            "subscribers": [],
            "tagged": [],
            "tags": []
        },
        "members": [],
        "model": "testAPI",
        "rid": "96436ca6874ce01d0dd1f41001d71e75c3aebd6f",
        "sn": "888",
        "type": "vendor",
        "vendor": "testing"
    }
]
```

###### If the number of requested IDs exceeds the response limit

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/devices/\[47ab21c6e169ca4f749128fb00a4bf077f4a463f,96436ca6874ce01d0dd1f41001d71e75c3aebd6f\]?limit=1' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 206 Partial Content
Date: Mon, 17 Nov 2014 03:24:46 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/devices/[47ab21c6e169ca4f749128fb00a4bf077f4a463f,96436ca6874ce01d0dd1f41001d71e75c3aebd6f]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 1772
Content-Type: application/json; charset=UTF-8

[
    {
        "dataSources": [
            "561d1c757bdafd2c7fb3196e5a35558317045876",
            "8840cd68dfcef3c20c8bc4821f0c670ba2d2eb44"
        ],
        "info": {
            "aliases": {
                "0798132e5e5def5decc7129430112086f1448b39": [
                    "temp"
                ],
                "8840cd68dfcef3c20c8bc4821f0c670ba2d2eb44": [
                    "shared data"
                ],
                "561d1c757bdafd2c7fb3196e5a35558317045876": [
                    "public"
                ]
            },
            "basic": {
                "modified": 1407985593,
                "subscribers": 0,
                "type": "client",
                "status": "activated"
            },
            "description": {
                "limits": {
                    "client": 0,
                    "dataport": "inherit",
                    "datarule": "inherit",
                    "disk": "inherit",
                    "dispatch": "inherit",
                    "email": "inherit",
                    "email_bucket": "inherit",
                    "http": "inherit",
                    "http_bucket": "inherit",
                    "share": "inherit",
                    "sms": "inherit",
                    "sms_bucket": "inherit",
                    "xmpp": "inherit",
                    "xmpp_bucket": "inherit"
                },
                "locked": false,
                "meta": "{\"timezone\":\"Asia\\/Taipei\",\"location\":\"Taichung\",\"device\":{\"type\":\"generic\"},\"activetime\":\"30\"}",
                "name": "device Apple",
                "public": false
            },
            "shares": [
                {
                    "code": "8a7bfcfb3db340d23cdafc599107e16088075b38",
                    "meta": "[\"testing\",\"1\"]",
                    "activator": null
                },
                {
                    "code": "3fcfb90db1210878510c4cd67e06324eb862efb4",
                    "meta": "[\"testing\",\"Fruit+20140807\"]",
                    "activator": null
                },
                {
                    "code": "4b467a56d7b2f5c546d1bcfeab91690bf1e98f24",
                    "meta": "[\"testing\",\"test\"]",
                    "activator": null
                },
                {
                    "code": "98010735f04f1f50ee57251f7342370cbe40d841",
                    "meta": "[\"testing\",\"testing+20140814-1\"]",
                    "activator": null
                },
                {
                    "code": "85c060851a07de239da1159d6294751885afdc9e",
                    "meta": "[\"testing\",\"restfulapi\"]",
                    "activator": null
                },
                {
                    "code": "cd64dfd210e9eb18a403bd04b92901e96c72cc37",
                    "meta": "[\"testing\",\"2\"]",
                    "activator": null
                },
                {
                    "code": "e146db1b2ea1397ce67c02ddf7e876941e137fc5",
                    "meta": "[\"testing\",\"testing+20140822-1\"]",
                    "activator": null
                }
            ],
            "subscribers": [],
            "tagged": [
                "public"
            ],
            "tags": []
        },
        "members": [],
        "model": null,
        "rid": "47ab21c6e169ca4f749128fb00a4bf077f4a463f",
        "sn": null,
        "type": "generic",
        "vendor": null
    }
]
```

#### Get multiple groups

`GET /users/_this/groups/[{group-id},{group-id},...]`

Get information on multiple groups.
Can be used for pagination.

##### Permissions

* User must have at least `g_member` [permission](#permission-object) to the groups.

##### Query String

| String | Description | Example |
|:-------|:------------|:--------|
| `limit` | Limits the number of groups to retrieve. The internal limit is 200, but some may be smaller. Optional. | `/users/_this/users/[{group-id},{group-id},...]?limit=10`      |
| `offset` | Sets the number of groups in the query array to skip. Optional. | `/users/_this/users/[{group-id},{group-id},...]?offset=10`     |
| `NoPermissions` | Excludes permission items from the response object. Optional. | `/users/_this/users/[{group-id},{group-id},...]?NoPermissions` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [group objects](#group-object) if the caller has permission to GET the groups.
* `206 Partial Content`: Returned along with a body containing an array of [group objects](#group-object) if the number of requested IDs exceeds the response limit, the link will appear in the header `Link=<{url}>; rel="previous", <{url}>; rel="next"`.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the groups.

##### Example

###### If all items were fetched

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/groups/\[2581071857,2937453355\]' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 03:35:46 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 343
Content-Type: application/json; charset=UTF-8

[
    {
        "id": "2581071857",
        "userId": "1026285982",
        "members": [
            {
                "access": "___admin",
                "oid": {
                    "type": "User",
                    "id": "1026285982"
                }
            }
        ],
        "meta": null,
        "name": "test group 10883",
        "permissions": []
    },
    {
        "id": "2937453355",
        "userId": "1026285982",
        "members": [
            {
                "access": "___admin",
                "oid": {
                    "type": "User",
                    "id": "1026285982"
                }
            }
        ],
        "meta": null,
        "name": "test group 13553",
        "permissions": []
    }
]
```

###### If all items were fetched and NoPermissions is set

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/groups/\[2581071857,2937453355\]?NoPermissions' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 03:35:46 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 343
Content-Type: application/json; charset=UTF-8

[
    {
        "id": "2581071857",
        "userId": "1026285982",
        "members": [
            {
                "access": "___admin",
                "oid": {
                    "type": "User",
                    "id": "1026285982"
                }
            }
        ],
        "meta": null,
        "name": "test group 10883"
    },
    {
        "id": "2937453355",
        "userId": "1026285982",
        "members": [
            {
                "access": "___admin",
                "oid": {
                    "type": "User",
                    "id": "1026285982"
                }
            }
        ],
        "meta": null,
        "name": "test group 13553"
    }
]
```

###### If the number of requested IDs exceeds the response limit

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/groups/\[2581071857,2937453355\]?limit=1' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 206 Partial Content
Date: Mon, 17 Nov 2014 03:39:28 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/groups/[2937453355,2581071857]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 172
Content-Type: application/json; charset=UTF-8

[
    {
        "id": "2937453355",
        "userId": "1026285982",
        "members": [
            {
                "access": "___admin",
                "oid": {
                    "type": "User",
                    "id": "1026285982"
                }
            }
        ],
        "meta": null,
        "name": "test group 13553",
        "permissions": []
    }
]
```

#### Get multiple users

`GET /api/portals/v1/users/_this/users/[{user-id},{user-id},...]`

Get information on multiple users.
Can be used for pagination.
w
##### Permissions

* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Query String

| String | Description | Example |
|:-------|:------------|:--------|
| `limit` | Limits the number of users to retrieve. The internal limit is 200, but some may be smaller. Optional. | `/users/_this/users/[{user-id},{user-id},...]?limit=10`      |
| `offset` | Sets the number of users in the query array to skip. Optional. | `/users/_this/users/[{user-id},{user-id},...]?offset=10`     |
| `NoPermissions` | Excludes permission items from the response object. Optional. | `/users/_this/users/[{user-id},{user-id},...]?NoPermissions` |
| `LastLoginTimestamp` | Includes last-login timestamp of the [user object](#user-object). Optional. | `/users/_this/users/[{user-id},{user-id},...]?LastLoginTimestamp` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [user objects](#user-object) if the caller has permission to GET the users.
* `206 Partial Content`: Returned along with a body containing an array of [user objects](#user-object) if the number of requested IDs exceeds the response limit, the link will appear in the header `Link=<{url}>; rel="previous", <{url}>; rel="next"`.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the users.

##### Example

###### If all items were fetched

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/users/\[2014970789,2308265000\]' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 03:43:14 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 648
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "testing+2014+0805+0309+0953+7449@exosite.com",
        "fullName": "",
        "id": "2014970789",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "permissions": [
            {
                "access": "d_update",
                "oid": {
                    "type": "Device",
                    "id": "27a9414bc2999a8d975a9c65a1195acde7ec3f4b"
                }
            }
        ]
    },
    {
        "email": "testing+2014+0805+0310+0635+2749@exosite.com",
        "fullName": "",
        "id": "2308265000",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [
            "2053728508",
            "2705108658",
            "3415641988"
        ],
        "permissions": [
            {
                "access": "g_modera",
                "oid": {
                    "type": "Group",
                    "id": "2053728508"
                }
            },
            {
                "access": "g_update",
                "oid": {
                    "type": "Group",
                    "id": "2705108658"
                }
            },
            {
                "access": "g_modera",
                "oid": {
                    "type": "Group",
                    "id": "3415641988"
                }
            }
        ]
    }
]
```

###### If the number of requested IDs exceeds the response limit

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/users/\[2014970789,2308265000\]?limit=1' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 206 Partial Content
Date: Mon, 17 Nov 2014 03:44:42 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/users/[2014970789,2308265000]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 258
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "testing+2014+0805+0309+0953+7449@exosite.com",
        "fullName": "",
        "id": "2014970789",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "permissions": [
            {
                "access": "d_update",
                "oid": {
                    "type": "Device",
                    "id": "27a9414bc2999a8d975a9c65a1195acde7ec3f4b"
                }
            }
        ]
    }
]
```

###### If the number of requested IDs exceeds the response limit and NoPermissions is set

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/users/\[2014970789,2308265000\]?limit=1&NoPermissions' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 206 Partial Content
Date: Mon, 17 Nov 2014 03:44:42 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/users/[2014970789,2308265000]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 258
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "testing+2014+0805+0309+0953+7449@exosite.com",
        "fullName": "",
        "id": "2014970789",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": []
    }
]
```

###### If the number of requested IDs exceeds the response limit and LastLoginTimestamp is set

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/users/\[2014970789,2308265000\]?limit=1&LastLoginTimestamp' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 206 Partial Content
Date: Mon, 17 Nov 2014 03:44:42 GMT
Status: 206 Partial Content
Link: <https://mydomain.exosite.com/api/portals/v1/users/_this/users/[2014970789,2308265000]?offset=1&limit=1>; rel="next"
Vary: Accept-Encoding
Content-Length: 280
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "testing+2014+0805+0309+0953+7449@exosite.com",
        "fullName": "",
        "id": "2014970789",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "permissions": [
            {
                "access": "d_update",
                "oid": {
                    "type": "Device",
                    "id": "27a9414bc2999a8d975a9c65a1195acde7ec3f4b"
                }
            }
        ],
        "lastLoginTimestamp": 1416190210
    }
]
```

### Dashboards

#### Create Portal dashboard

`POST /api/portals/v1/portals/{portal-id}/dashboards`

Create a Portal dashboard.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

```
{
    "config": object = <config>,
    "description": string = "",
    "location": string = "",
    "name": string,
    "public": boolean = false
}
```

* `"config"` -  See [dashboard object](#dashboard-object).
* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [dashboard object](#dashboard-object) if the dashboard was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create a dashboard under the Portal.
* `404 Not Found`: Returned if the `portalId` is invalid.
* `409 Conflict`: Returned if the dashboard name already exists.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/dashboards' \
     -X POST \
     -d '{"name":"Demo"}' \
     -u 'domainuseremail@gmail.com:adminuserP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Thu, 14 May 2015 10:14:23 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 167
Content-Type: application/json; charset=UTF-8

{
    "config": {
        "layout": {
            "cols": 4,
            "gravity": "LeftTop"
        },
        "widgets": []
    },
    "description": "",
    "id": "3087021266",
    "location": "",
    "name": "Demo",
    "portalId": "1284862590",
    "public": false
}
```

#### Delete dashboard

`DELETE /api/portals/v1/dashboards/{dashboard-id}`

Delete a dashboard.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the dashboard.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the dashboard was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the dashboard.
* `404 Not Found`: Returned if the dashboard id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/dashboards/3087021266' \
     -X DELETE
     -u 'domainuseremail@gmail.com:adminuserP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Mon, 18 May 2015 03:37:06 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get dashboard

`GET /api/portals/v1/dashboards/{dashboard-id}`

Get information on a dashboard.

##### Permissions

* User must have at least `v___view` [permission](#permission-object) to the dashboard.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [dashboard object](#dashboard-object) if the caller has permission to GET the dashboard information.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the dashboard information.
* `404 Not Found`: Returned if the dashboard id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/dashboards/3087021266' \
     -u 'domainuseremail@gmail.com:adminuserP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 18 May 2015 03:33:11 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 184
Content-Type: application/json; charset=UTF-8

{
    "config": {
        "layout": {
            "cols": 4,
            "gravity": "LeftTop"
        },
        "widgets": []
    },
    "description": "4294896906",
    "id": "4294896906",
    "location": "",
    "name": "Hello World",
    "portalId": "1284862590",
    "public": false
}
```

#### List Portal dashboards

`GET /api/portals/v1/portals/{portal-id}/dashboards`

List Portal dashboards.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Query String

| String | Description | Example |
|:-------|:------------|:--------|
| `limit` | Limits the number of portal dashboards to retrieve. Optional. | `/portals/{portal-id}/dashboards?limit=10` |
| `offset` | Sets the number of data sources in the query array to skip, only available when `"limit"` is valid. Optional. | `/portals/{portal-id}/dashboards?offset=10` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [dashboard objects](#dashboard-object) if the caller has permission to GET the dashboard information.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the dashboard information.
* `404 Not Found`: Returned if the `portalId` is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/dashboards' \
     -u 'domainuseremail@gmail.com:adminuserP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Thu, 14 May 2015 09:14:29 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 1123
Content-Type: application/json; charset=UTF-8

[{
    "config": {
        "layout": {
            "cols": 4,
            "gravity": "LeftTop"
        },
        "widgets": {
            "1": {
                "title": "Welcome",
                "type": "0000000013",
                "order": "0"
            }
        }
    },
    "description": "clone",
    "id": "4093336427",
    "location": "",
    "name": "clone",
    "portalId": "1284862590",
    "public": false
}]
```

#### Update dashboard

`PUT /api/portals/v1/dashboards/{dashboard-id}`

Update dashboard.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the dashboard.

##### Request

See [Create Portal dashboard](#create-portal-dashboard).

##### Response

* `200 OK`: Returned along with a body containing a [dashboard object](#dashboard-object)If the dashboard was updated successfully.
* `400 Bad Request`: Returned if request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the dashboard information.
* `404 Not Found`: Returned if the dashboard id is invalid.
* `409 Conflict`: Returned if the dashboard name already exists.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/dashboards/3087021266' \
     -X PUT \
     -d '{"name":"Demo"}' \
     -u 'domainuseremail@gmail.com:adminuserP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 18 May 2015 02:47:24 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 184
Content-Type: application/json; charset=UTF-8

{
    "config": {
        "layout": {
            "cols": 4,
            "gravity": "LeftTop"
        },
        "widgets": []
    },
    "description": "4294896906",
    "id": "4294896906",
    "location": "",
    "name": "Hello World",
    "portalId": "1284862590",
    "public": false
}
```

### Data Sources

#### Create Portal data source

`POST /api/portals/v1/portals/{portal-id}/data-sources`

Create a data source under a Portal.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

* Request body is a [data source object](#data-source-object). Currently only the following keys are supported:
    * `"format"` - Data source format under info description, optional.
    * `"name"` - Data source name under info description, optional.
    * `"unit"` - Data source unit under info description, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [data source object](#data-source-object) if the data source was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create data sources under the Portal.
* `404 Not Found`: Returned if the `portalId` is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/2853566858/data-sources' \
     -X POST \
     -d '{"info":{"description":{"name": "new data"}}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 18 Nov 2014 02:25:20 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 452
Content-Type: application/json; charset=UTF-8

{
    "data": [],
    "info": {
        "basic": {
            "modified": 1416277438,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "string",
            "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
            "name": "new data",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 0,
            "first": 0,
            "last": 0,
            "size": 0
        },
        "subscribers": [],
        "tags": []
    },
    "rid": "4f39859d41a66468cf1e5e28d08ad2cab45b498f",
    "unit": ""
}
```

#### Update data source

`PUT /api/portals/v1/data-sources/{data-sources-rid}`

Update a data source.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the data source.

##### Request

* Request body is a [data source object](#data-source-object). Currently only the following keys may be updated:
    * `"info": {"description": ...}` - description under info, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [data source object](#data-source-object) if the data source was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update data sources.
* `404 Not Found`: Returned if data sources rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f' \
     -X PUT \
     -d '{"info": {"description": {"name": "data source update name"}}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 06 Jan 2015 03:25:15 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 565
Content-Type: application/json; charset=UTF-8

{
    "data": [
        [1413958187, "1413519694"]
    ],
    "info": {
        "basic": {
            "modified": 1420514686,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "string",
            "meta": "{\"datasource\":{\"description\":\"test\",\"unit\":\"1413519694\"},\"alias\":\"1413519694\"}",
            "name": "data source update name",
            "preprocess": [],
            "public": true,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 1,
            "first": 1413958187,
            "last": 1413958187,
            "size": 14
        },
        "subscribers": [],
        "tags": ["test"]
    },
    "rid": "4f39859d41a66468cf1e5e28d08ad2cab45b498f",
    "unit": "1413519694"
}

```

#### Create device data source

`POST /api/portals/v1/devices/{device-rid}/data-sources`

Create a data source under a device.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the device.

##### Request

* Request body is a object. Currently only the following keys are supported:

    * `"info"` - Data source info, optional.
        * `"description"` - Data source description, optional.
            * `"format"` - Data source format, optional.
            * `"name"` - Data source name, optional.
    * `"unit"` - Data source unit, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [data source object](#data-source-object) if the data source was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create data sources for the device.
* `404 Not Found`: Returned if device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/bbc295c0dc98f8518b784867bae4a1b168c77f1b/data-sources' \
     -X POST \
     -d '{"info":{"description":{"format":"float","name":"Length"}},"unit":"m"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 13 Apr 2015 07:30:18 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 451
Content-Type: application/json; charset=UTF-8

{
    "data": [],
    "info": {
        "basic": {
            "modified": 1428910043,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "float",
            "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"m\"}}",
            "name": "Length",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 0,
            "first": 0,
            "last": 0,
            "size": 0
        },
        "subscribers": [],
        "tags": []
    },
    "rid": "913e39363a2ce91edae09c246f8d8be079e5b7cc",
    "unit": "m"
}
```

#### List Portal data sources

`GET /api/portals/v1/portals/{portal-id}/data-sources`

List Portal data sources.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to list the Portal's data source.
* `404 Not Found`: Returned if Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1162382494/data-sources' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 13 Apr 2015 08:31:10 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 939
Content-Type: application/json; charset=UTF-8

[{
    "data": [],
    "info": {
        "basic": {
            "modified": 1428493470,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "string",
            "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
            "name": "2015-04-08T11:44:30.355Z",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 0,
            "first": 0,
            "last": 0,
            "size": 0
        },
        "subscribers": [],
        "tags": []
    },
    "rid": "8db88286d89876576fab83dd9d7cbaa25973b309",
    "unit": ""
}]
```

#### List device data sources

`GET /api/portals/v1/devices/{device-rid}/data-sources`

List device data sources.

##### Permissions

* User must have at least `d___view` [permission](#permission-object) to the device.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [data source object](#data-source-object) if the caller has permission to list the device's data source.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to list the device's data source.
* `404 Not Found`: Returned if device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/bbc295c0dc98f8518b784867bae4a1b168c77f1b/data-sources' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 13 Apr 2015 08:15:00 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 3277
Content-Type: application/json; charset=UTF-8

[{
    "data": [],
    "info": {
        "basic": {
            "modified": 1428910043,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "float",
            "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"m\"}}",
            "name": "Length",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 0,
            "first": 0,
            "last": 0,
            "size": 0
        },
        "subscribers": [],
        "tags": []
    },
    "rid": "913e39363a2ce91edae09c246f8d8be079e5b7cc",
    "unit": "m"
}]
```

#### Delete data source

`DELETE /api/portals/v1/data-sources/{data-source-rid}`

Delete a data source.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the data sources.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the data source was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the data source.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/24fd0b1ed31fb6d403484ca939e37d19c9b71308' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Mon, 13 Apr 2015 06:55:07 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get data source

`GET /api/portals/v1/data-sources/{data-source-rid}`

Get information on a Portals data source.
To get information on multiple data sources, see [Get multiple data sources](#get-multiple-data-sources).

##### Permissions

* User must have at least `d___read` [permission](#permission-object) to the data sources.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [data source object](#data-source-object) if the caller has permission to GET the data source information.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the data source information.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:32:43 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 452
Content-Type: application/json; charset=UTF-8

{
    "data": [],
    "info": {
        "basic": {
            "modified": 1416277438,
            "subscribers": 0,
            "type": "dataport"
        },
        "description": {
            "format": "string",
            "meta": "{\"datasource\":{\"description\":\"\",\"unit\":\"\"}}",
            "name": "new data",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": "infinity",
                "duration": "infinity"
            },
            "subscribe": null
        },
        "shares": [],
        "storage": {
            "count": 0,
            "first": 0,
            "last": 0,
            "size": 0
        },
        "subscribers": [],
        "tags": []
    },
    "rid": "4f39859d41a66468cf1e5e28d08ad2cab45b498f",
    "unit": ""
}
```

### Data Source Data

#### Get data source data

`GET /api/portals/v1/data-sources/{data-source-rid}/data`

Get data from a data source.

##### Permissions

* User must have at least `d___read` [permission](#permission-object) to the data sources.

##### Query String

This API can retrieve multiple data points. The options below can be included to modify the results of an API call:

| String | Description | Example |
|:-------|:------------|:--------|
| `starttime` | Unix timestamps that specify the start time of the window to read. Must be used with `endtime`. Optional. | `/data-sources/{data-source-rid}/data?starttime=1416278080` |
| `endtime`  | Unix timestamps that specify the end time of the window to read. Must be used with `starttime`. Optional.  | `/data-sources/{data-source-rid}/data?endtime=1416278417` |
| `sort` | Defines the order of the data points before applying `"limit"`. This affects which data points will be retrieved when there are more data points than `"limit"` in the specified time window. `"desc"` sorts data points from the newest to the oldest. `"asc"` sorts the data points from the oldest to the newest. Optional. | `/data-sources/{data-source-rid}/data?sort=desc`|
| `limit` | Limits the number of data points to retrieve. Optional. | `/data-sources/{data-source-rid}/data?limit=2` |

For more details about these options, see the [read API](https://github.com/exosite/docs/tree/master/rpc#read).

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned if the caller has permission to GET data from the data source, along with an array of `"data"` contents such as the following:
    * `"data"` is an array of data points. A data point has a unit timestamp and a value.
        * `{unix-timestamp}` is a [Unix timestamp](http://en.wikipedia.org/wiki/Unix_time), measured in number of seconds since the epoch.
        * `{value}` may be a string, int, or float depending on the data source type.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET data from the data sources.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

* Get data with no options

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/data' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:39:23 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 21
Content-Type: application/json; charset=UTF-8

[[1416278080,"1000"]]
```

* Get data with options

api/portals/v1/data-sources/`ResourceID`/data?starttime=`Unix Timestamp for starttime`&endtime=`Unix Timestamp for endtime`&limit=`Number of data points`&sort=`Sorting order of choice`

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/data?starttime=1416278080&endtime=1416278417&limit=2&sort=desc' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:43:35 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 41
Content-Type: application/json; charset=UTF-8

[[1416278417,"5.00"],[1416278080,"1000"]]
```

#### Get data from multiple data sources

`GET /api/portals/v1/data-sources/[{data-source-rid},{data-source-rid},...]/data`

##### Permissions

* User must have at least `d___read` [permission](#permission-object) to the data sources.

##### Query String

The options below can be included to modify the results of an API call:

| String | Description | Example |
|:-------|:------------|:--------|
| `starttime` | Unix timestamps that specify the start time of the window to read. Must be used with `endtime`. Optional. | `/data-sources/{data-source-rid}/data?starttime=1416278080` |
| `endtime` | Unix timestamps that specify the end time of the window to read. Must be used with `starttime`. Optional. | `/data-sources/{data-source-rid}/data?endtime=1416278417` |
| `sort` | Defines the order of the data points before applying `"limit"`. This affects which data points will be retrieved when there are more data points than `"limit"` in the specified time window. `"desc"` sorts data points from the newest to the oldest. `"asc"` sorts the data points from the oldest to the newest. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?sort=desc` |
| `limit` | Limits the number of data points to retrieve. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?limit=2` |
For more details about these options, see the [read API](https://github.com/exosite/docs/tree/master/rpc#read).

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned if the caller has permission to GET data from the data source, and along with a JSON object contain the following keys:
    * `{data-source-rid}` is an array of data points from the data source. A data point has a unit timestamp and a value.
        * `{unix-timestamp}` is a [Unix timestamp](http://en.wikipedia.org/wiki/Unix_time), measured in number of seconds since the epoch.
        * `{value}` may be a string, int, or float depending on the data source type.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET data from the data source.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

* Get data with no options

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/\[3218552df19a93a3f1b85c29fd0f46ddff2f7071,437240fba025d3416a60ef1a160e5424d4138fdc\]/data' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Fri, 22 May 2015 10:22:30 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

{"3218552df19a93a3f1b85c29fd0f46ddff2f7071":[],"437240fba025d3416a60ef1a160e5424d4138fdc":[]}
```

#### Append data source data

`POST /api/portals/v1/data-sources/{data-source-rid}/data`

##### Permissions

* User must have at least `d__write` [permission](#permission-object) to the data sources.

##### Request

* Request body is a [value](#data-source-object).
* Requires authentication.

##### Response

* `201 Created`: Returned if the data is appended to data source successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission append data to the data source.
* `400 Bad Request`: Returned if request body is invalid.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/data' \
     -X POST \
     -d '1000' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 18 Nov 2014 02:36:02 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Record data source data

`POST /api/portals/v1/data-sources/{data-source-rid}/data`

##### Permissions

* User must have at least `d__write` [permission](#permission-object) to the data sources.

##### Request

* Request body is [data](https://github.com/exosite/docs/tree/master/rpc#recordbatch).
* Requires authentication.

##### Response

* `201 Created`: Returned if the data is recorded to data source successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission record data to the data source.
* `400 Bad Request`: Returned if request body is invalid.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/ad75f5b356907f0d2ec7a67d31254410526ef032/data' \
     -X POST \
     -d '[[1420041600,"1000"]]' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Thu, 08 Jan 2015 11:57:06 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Append data source data in JSON format

`POST /api/portals/v1/data-sources/{data-source-rid}/json`

Write json data

##### Permissions

* User must have at least `d__write` [permission](#permission-object) to the data sources.

##### Query String

| String | Description | Example |
|:-------|-------------|:--------|
| `safe` | Safe write, the server will wait for 1 second and scan the data again for safety. Optional. | `data-sources/{data-source-rid}/json?safe` |

##### Request

* Request body is a valid JSON.
* Requires authentication.

##### Response

* `201 Created`: Returned if the JSON data is appended to data source successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission append JSON data to the data source.
* `404 Not Found`: Returned if the data sources rid is invalid.
* `409 Conflict`: Returned if `safe` is passed in the query string and failed to append JSON data.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/json' \
     -X POST \
     -d '{"how":"are","you":"?"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 18 Nov 2014 02:46:49 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Delete data source data

`DELETE /api/portals/v1/data-sources/{data-source-rid}/data`

Delete data points from a data source.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the data sources.

##### Query String

The following parameters specify which data points to delete:

| String | Description | Example |
|:-------|:------------|:--------|
| `starttime` | Unix timestamps that specify the start time of the window to read. Must be used with `endtime`. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?starttime=1416278080` |
| `endtime` | Unix timestamps that specify the end time of the window to read. Must be used with `starttime`. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?endtime=1416278417` |
| `sort` | Defines the order of the data points before applying `"limit"`. This affects which data points will be deleted when there are more data points than `"limit"` in the specified time window. `"desc"` sorts data points from the newest to the oldest. `"asc"` sorts the data points from the oldest to the newest. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?sort=desc` |
| `limit` | Limits the number of data points to delete. When set to `"infinity"`, all data points in the given window will be deleted. Optional. | `/data-sources/[{data-source-rid},{data-source-rid},...]/data?limit=2` |

For more details about these options, see [Get data source data](#get-data-source-data).

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the data source was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the data source.
* `404 Not Found`: Returned if the data sources rid is invalid.

##### Example

* Delete data without options

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/data' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 13 Jan 2015 04:40:50 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

* Delete data with options

```
curl 'https://mydomain.exosite.com/api/portals/v1/data-sources/4f39859d41a66468cf1e5e28d08ad2cab45b498f/data?starttime=1416278080&endtime=1416278417&limit=2&sort=desc' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 13 Jan 2015 04:40:50 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

### Device

#### Create new device under a Portal of authenticated user

`POST /api/portals/v1/device`

Creates a new device based on a client model. Returns the CIK and RID of the created device.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

* Requires authentication.
* The following keys are passed:

    * `"portal_rid"` - resource ID of Portal where the device is to be created. User creating the device must have at least manager level access to this Portal. This may be found in the output of the /portal/ API call, or in Portals here: https://<subdomain>.exosite.com/admin/portallist

    ![Find Portal RID](images/find_portal_rid.png)

    * `"vendor"` - vendor identifier. Administrators may find this identifier here: https://<subdomain>.exosite.com/admin/home

    ![Find Vendor ID](images/find_vendor.png)

    * `"model"` - client model of device to create. Administrators may find this here, at the bottom of the page: https://<subdomain>.exosite.com/admin/managemodels

    ![Find Model](images/find_model.png)

    * `"serialnumber"` - serial number of new device. The serial numbers available are configurable per device model. Administrators may configure individual serial numbers, or configure a range, here:  https://<subdomain>.exosite.com/admin/serialnumbers For example, this model has serial numbers consisting of six base 10 digits, e.g. 123456.

    ![Find device serial number](images/find_serialnumber.png)

    * `"name"` - device name. This is a human-readable name for the device.
    * `"timezone"` - device timezone, optional.
    * `"location"` - device location, optional.

    The domain name in the HTTP request determines the domain to authenticate the user, it must be the same domain in which the portal_rid is registered.

##### Response

* `200 OK`: Returned if the device was created successful, and along with a JSON object contains following keys:
    * `"rid"` - resource identifier for created device
    * `"cik"` - key for created device

    After creating a device, it is necessary to activate it using the provisioning API. This is normally done by device firmware, but may also be done at the command line for testing.
    [https://github.com/exosite/api/blob/master/provision/device.md#provisionactivate]
    The RID and CIK may then be used with Exosite’s other APIs to interact with the device.
* `400 Bad Request`: Returned along body contains a JSON formatted response object. The response object may contain the following keys:
    * `"errors"` - array of error identifier strings
        * `"limit"` - Portal’s device limit has been reached
        * `"invalid_sn"` - serial number is invalid
        * `"unavailable_sn"` - serial number is not available
        * `"forbidden_model"` - model is not available in this domain (this also results if `"vendor"` is invalid or otherwise does not correspond to `"model"`)
        * `"require_purchase"` - creating this type of device requires a purchase
        * `"insufficient_resources"` - device could not be added due to insufficient resources in the Portal
        * `"portal_not_found"` - portal_rid could not be found
        * `"missing_*"` - some required input was missing. E.g. `missing_portal_rid` indicates a missing or empty (blank) portal_rid
    * `"notices"` - array of user-readable error strings
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create the device.

##### Example

* Create the device:

```
$ curl 'https://mydomain.exosite.com/api/portals/v1/device' \
       -X POST \
       -d '{"model": "myDeviceModel", "vendor":"joevendor", "serialnumber":"ABC-123", "location":"Samoa", "timezone":"(GMT-11:00) Midway Island, Samoa", "portal_rid": "5ef46b987385aaaaaaaaaa75183fb43edeb3557b", "name":"Device Name"}' \
       -u 'useremail@gmail.com:userP4ssword' \
       -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 01:45:37 GMT
Vary: Accept-Encoding
Content-Length: 99
Content-Type: application/json; charset=UTF-8

{
    "rid": "1767af3da6283354eb4818a709db4a0c15756eel",
    "cik": "a148dd4b498cf18c8f1b066af0dab8d671a79a5l"
}
```

* Then activate the device. Normally this would be done from the device firmware, but we do it here from the command line as an example.

```
$ curl 'https://m2.exosite.com/provision/activate' \
       -d 'vendor=joevendor&model=myDeviceModel&sn=ABC-123'
```

```
a148dd4b498cf18c8f1b066af0dab8d671a79a5l
```

### Devices

#### Create device

`POST /api/portals/v1/portals/{portal-id}/devices`

Create a device under a Portal.

##### Permissions

* User must have at least `p_m_crea` [permission](#permission-object) to the Portal.

##### Request

* Request body is a [device object](#device-object). Currently only the following keys are supported:
    * `"type"` - Device type, could be either `generic` or `vendor`, REQUIRED.

    If `"type"` is `vendor`, the following keys are required:
        * `"model"` - Model name, optional.
        * `"sn"` - Serial number, optional.
        * `"vendor"` - Vendor name, optional.

        If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [device object](#device-object) if the device was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create the device.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

Generic type

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/devices' \
     -X POST \
     -d '{"type":"generic"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 28 Apr 2015 11:11:56 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 877
Content-Type: application/json; charset=UTF-8

{
    "rid": "446a943cdf4d7b2e113c8673d1d27323764427f4",
    "members": [{
        "access": "___admin",
        "oid": {
            "type": "User",
            "id": "1075526687"
        }
    }],
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1430219273,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 0,
                "dataport": "inherit",
                "datarule": "inherit",
                "disk": "inherit",
                "dispatch": "inherit",
                "email": "inherit",
                "email_bucket": "inherit",
                "http": "inherit",
                "http_bucket": "inherit",
                "share": "inherit",
                "sms": "inherit",
                "sms_bucket": "inherit",
                "xmpp": "inherit",
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "{\"timezone\":\"Asia\\\/Taipei\",\"location\":\"\",\"device\":{\"type\":\"generic\"}}",
            "name": "New Device@2015-04-28T11:11:56+00:00 1430219516.9894",
            "public": false
        },
        "key": "519cc84b04b0144b479c7644d0defd45127983dd",
        "shares": [],
        "subscribers": [],
        "tags": []
    },
    "dataSources": [],
    "model": null,
    "sn": null,
    "type": "generic",
    "vendor": null
}
```

Vendor type

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/2853566858/devices' \
     -X POST \
     -d '{"sn":"123", "vendor":"mydomain", "model":"apimodel", "type":"vendor"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 18 Nov 2014 02:14:27 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 1113
Content-Type: application/json; charset=UTF-8

{
    "dataSources": [],
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1416276786,
            "subscribers": 0,
            "type": "client",
            "status": "notactivated"
        },
        "description": {
            "limits": {
                "client": 0,
                "dataport": "inherit",
                "datarule": "inherit",
                "disk": "inherit",
                "dispatch": "inherit",
                "email": "inherit",
                "email_bucket": "inherit",
                "http": "inherit",
                "http_bucket": "inherit",
                "share": "inherit",
                "sms": "inherit",
                "sms_bucket": "inherit",
                "xmpp": "inherit",
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "{\"DeviceType\":\"generic\",\"DeviceTypeID\":\"0000000002\",\"Timezone\":\"Asia\\/Taipei\",\"Location\":\"Taiwan\",\"activetime\":\"\",\"DeviceTypeName\":\"generic\",\"timezone\":\"\",\"location\":\"\",\"device\":{\"type\":\"vendor\",\"model\":\"apimodel\",\"vendor\":\"mydomain\",\"sn\":\"123\"}}",
            "name": "New Device@2014-11-18T02:14:27+00:00 1416276867.8066",
            "public": false
        },
        "key": "32e5952d4891f2a5e03433080a36fae46e79bd2b",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    },
    "members": [
        {
            "access": "___admin",
            "oid": {
                "type": "User",
                "id": "1026285982"
            }
        }
    ],
    "model": "apimodel",
    "rid": "bd89188973b18826c99a287f4c43880b0643a757",
    "sn": "123",
    "type": "vendor",
    "vendor": "mydomain"
}
```

#### Update device

`PUT /api/portals/v1/devices/{device-rid}`

Update a device.

##### Permissions

* User must have at least `d_update` [permission](#permission-object) to the device.

##### Request

* Request body is a [device object](#device-object). Currently only the following keys may be updated:

    * `"info": {"description": ...}` - description under info, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [device object](#device-object) if the device was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the device.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/5d4bacb783b10600e12b759bb1ae80b43666085b' \
     -X PUT \
     -d '{"info": {"description": {"name": "device update name"}}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:22:12 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 780
Content-Type: application/json; charset=UTF-8

{
    "dataSources": [],
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1416277250,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 0,
                "dataport": "inherit",
                "datarule": "inherit",
                "disk": "inherit",
                "dispatch": "inherit",
                "email": "inherit",
                "email_bucket": "inherit",
                "http": "inherit",
                "http_bucket": "inherit",
                "share": "inherit",
                "sms": "inherit",
                "sms_bucket": "inherit",
                "xmpp": "inherit",
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "{\"timezone\":\"\",\"location\":\"\",\"device\":{\"type\":\"generic\"}}",
            "name": "device update name",
            "public": false
        },
        "key": "36e4df531973d866f5ded2b99704672321cc5d7a",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    },
    "members": [],
    "model": null,
    "rid": "5d4bacb783b10600e12b759bb1ae80b43666085b",
    "sn": null,
    "type": "generic",
    "vendor": null
}
```

#### Update multiple devices

`PUT /api/portals/v1/devices/[{device-rid},{device-rid}..]`

##### Permissions

* User must have at least `d_update` [permission](#permission-object) to the devices.

##### Request

* Request body is an object of [device objects](#device-object). Currently only the following keys may be updated:

    * `"info": {"description": ...}` - description under info, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an object of [device objects](#device-object) if the devices were updated successfully. However, if any device(s) failed to update, 200 OK will still be returned, with an additional error object at the top of the response body. This error object will provide error details for each device (see error example).
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update one or more of the devices.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/\[d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6,b2618de3b54cab517a3a347e1cba5a014ae26d62\]' -H 'Host: portals.review.portalsapp' \
     -u 'useremail@gmail.com:userP4ssword' \
     -X PUT \
     -d '{"d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6":{"info": {"description": {"name": "device update12311123 name"}}},"b2618de3b54cab517a3a347e1cba5a014ae26d62":{"info": {"description": {"name": "device updataaaaaaaaa name"}}} }'
     -H 'Content-Type: application/json'
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 07 Jul 2015 06:27:57 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

{
  "d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6": {
    "rid": "d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6",
    "members": [

    ],
    "info": {
      "aliases": {
        "9a89a449b55c514164e7e721aa2733f452502d54": [
          "1122"
        ]
      },
      "basic": {
        "modified": 1434614230,
        "subscribers": 0,
        "type": "client",
        "status": "expired"
      },
      "description": {
        "limits": {
          "client": 0,
          "dataport": "inherit",
          "datarule": "inherit",
          "disk": "inherit",
          "dispatch": "inherit",
          "email": "inherit",
          "email_bucket": "inherit",
          "http": "inherit",
          "http_bucket": "inherit",
          "share": "inherit",
          "sms": "inherit",
          "sms_bucket": "inherit",
          "xmpp": "inherit",
          "xmpp_bucket": "inherit"
        },
        "locked": false,
        "meta": "{\"DeviceType\":\"generic\",\"DeviceTypeID\":\"0000000002\",\"Timezone\":\"Pacific\\\/Gambier\",\"Location\":\"\",\"activetime\":\"5\",\"DeviceTypeName\":\"generic\",\"timezone\":\"Asia\\\/Taipei\",\"location\":\"Taiwan\",\"device\":{\"type\":\"vendor\",\"model\":\"Test0615\",\"vendor\":\"review\",\"sn\":\"111\"}}",
        "name": "device update12311123 name",
        "public": false
      },
      "key": "361b4c37730d614fe53f6be722a48ceced88a08a",
      "shares": [

      ],
      "subscribers": [

      ],
      "tags": [

      ]
    },
    "dataSources": [
      "9a89a449b55c514164e7e721aa2733f452502d54"
    ],
    "model": "Test0615",
    "sn": "111",
    "type": "vendor",
    "vendor": "review"
  },
  "b2618de3b54cab517a3a347e1cba5a014ae26d62": {
    "rid": "b2618de3b54cab517a3a347e1cba5a014ae26d62",
    "members": [

    ],
    "info": {
      "aliases": {
        "e83839c0a22cb33673f4c6bb9e51433995d4ee46": [
          "1122"
        ]
      },
      "basic": {
        "modified": 1436250476,
        "subscribers": 0,
        "type": "client",
        "status": "activated"
      },
      "description": {
        "limits": {
          "client": 0,
          "dataport": "inherit",
          "datarule": "inherit",
          "disk": "inherit",
          "dispatch": "inherit",
          "email": "inherit",
          "email_bucket": "inherit",
          "http": "inherit",
          "http_bucket": "inherit",
          "share": "inherit",
          "sms": "inherit",
          "sms_bucket": "inherit",
          "xmpp": "inherit",
          "xmpp_bucket": "inherit"
        },
        "locked": false,
        "meta": "{\"timezone\":\"Pacific\\\/Gambier\",\"location\":\"\",\"device\":{\"type\":\"generic\"},\"activetime\":\"5\"}",
        "name": "device updataaaaaaaaa name",
        "public": false
      },
      "key": "6bad08a4b8b24dc6e62a7b9248872aadc94b4e91",
      "shares": [
        {
          "code": "8e727c19df0cf4f4c7aea40e97ec06f643f71039",
          "meta": "[\"review\",\"Test0615\"]",
          "activator": null
        },
        {
          "code": "86ca167b9a9ca8ae365eb427433cf26e9ec1dec0",
          "meta": "[\"review\",\"test0511\"]",
          "activator": null
        }
      ],
      "subscribers": [

      ],
      "tags": [

      ]
    },
    "dataSources": [
      "e83839c0a22cb33673f4c6bb9e51433995d4ee46"
    ],
    "model": null,
    "sn": null,
    "type": "generic",
    "vendor": null
  }
}
```

##### Error Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/\[d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6,b2618de3b54cab517a3a347e1cba5a014ae26d62\]' -H 'Host: portals.review.portalsapp' \
     -u 'useremail@gmail.com:userP4ssword' \
     -X PUT \
     -d '{"d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6":{"info": {"description": {"name": "device update12311123 name"}}}}'
     -H 'Content-Type: application/json'
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 07 Jul 2015 06:35:25 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

{
  "error": {
    "b2618de3b54cab517a3a347e1cba5a014ae26d62": [
      {
        "code": 404,
        "message": "Not found update data"
      }
    ]
  },
  "d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6": {
    "rid": "d13da92f1f73f9c5dcf14ef4ce7f43636c277fa6",
    "members": [

    ],
    "info": {
      "aliases": {
        "9a89a449b55c514164e7e721aa2733f452502d54": [
          "1122"
        ]
      },
      "basic": {
        "modified": 1434614230,
        "subscribers": 0,
        "type": "client",
        "status": "expired"
      },
      "description": {
        "limits": {
          "client": 0,
          "dataport": "inherit",
          "datarule": "inherit",
          "disk": "inherit",
          "dispatch": "inherit",
          "email": "inherit",
          "email_bucket": "inherit",
          "http": "inherit",
          "http_bucket": "inherit",
          "share": "inherit",
          "sms": "inherit",
          "sms_bucket": "inherit",
          "xmpp": "inherit",
          "xmpp_bucket": "inherit"
        },
        "locked": false,
        "meta": "{\"DeviceType\":\"generic\",\"DeviceTypeID\":\"0000000002\",\"Timezone\":\"Pacific\\\/Gambier\",\"Location\":\"\",\"activetime\":\"5\",\"DeviceTypeName\":\"generic\",\"timezone\":\"Asia\\\/Taipei\",\"location\":\"Taiwan\",\"device\":{\"type\":\"vendor\",\"model\":\"Test0615\",\"vendor\":\"review\",\"sn\":\"111\"}}",
        "name": "device update12311123 name",
        "public": false
      },
      "key": "361b4c37730d614fe53f6be722a48ceced88a08a",
      "shares": [

      ],
      "subscribers": [

      ],
      "tags": [

      ]
    },
    "dataSources": [
      "9a89a449b55c514164e7e721aa2733f452502d54"
    ],
    "model": "Test0615",
    "sn": "111",
    "type": "vendor",
    "vendor": "review"
  }
}
```

#### Get device

`GET /api/portals/v1/devices/{device-rid}`

Get information on a device.
To get information on multiple devices, see [Get multiple devices](#get-multiple-devices).

##### Permissions

* User must have at least `d___view` [permission](#permission-object) to the device.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [device object](#device-object) if the caller has permission to GET the device.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the device.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/5d4bacb783b10600e12b759bb1ae80b43666085b'\
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:19:42 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 776
Content-Type: application/json; charset=UTF-8

{
    "dataSources": [],
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1416213844,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 0,
                "dataport": "inherit",
                "datarule": "inherit",
                "disk": "inherit",
                "dispatch": "inherit",
                "email": "inherit",
                "email_bucket": "inherit",
                "http": "inherit",
                "http_bucket": "inherit",
                "share": "inherit",
                "sms": "inherit",
                "sms_bucket": "inherit",
                "xmpp": "inherit",
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "{\"timezone\":\"\",\"location\":\"\",\"device\":{\"type\":\"generic\"}}",
            "name": "Exosite Device",
            "public": false
        },
        "key": "36e4df531973d866f5ded2b99704672321cc5d7a",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    },
    "members": [],
    "model": null,
    "rid": "5d4bacb783b10600e12b759bb1ae80b43666085b",
    "sn": null,
    "type": "generic",
    "vendor": null
}
```

#### Delete device

`DELETE /api/portals/v1/devices/{device-rid}`

Delete a device that is not a clone template of a model or a pay per use device. This will reset the status of the associated serial number.

##### Permissions

* User must have at least `d_update` [permission](#permission-object) to the device.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the device was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the device.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/5d4bacb783b10600e12b759bb1ae80b43666085b' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 07:45:09 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

### Domain

#### List domains of authenticated user

`GET /api/portals/v1/domain/`

Returns an array of domains to which the user’s account is added.

##### Permissions

 * User can get information from the domain the user is under.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned if domain information was GET successfully, and along with an array of domain objects. Domain objects contain the following keys:
    * `"rid"` - domain rid.
    * `"domain"` - the domain address. This may be used in a subsequent call to /api/portals/v1/portal/.
    * `"role"` - the user’s role on this domain. Has one of the following values:
        * `"user"` - non-admin.
        * `"admin"` - domain admin.
    If user `"role"` is `"user"`, that domain objects will not contain the following keys:
    * `"name"` - vendor name (for provisioning API).
    * `"token"` - vendor token (for provisioning API).
* `403 Forbidden`: Returned if the caller is not authenticated.

##### Example

```
$ curl 'https://mydomain.exosite.com/api/portals/v1/domain' \
       -X GET \
       -u 'useremail@gmail.com:userP4ssword' \
       -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:54:40 GMT
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[
    {
        "role":"user",
        "rid":"3fd70884cd1e406cd45a7eac898de5d2e6d20d12",
        "domain":"portals.exosite.com"
    },
    {
        "rid":"3fd70884cd1e406cd45a7eac898de5d2e6d20d11"
        "role":"admin",
        "domain":"joesdomain.exosite.com",
        "name":"joesdomain",
        "token":"01233fb43edeb3557b5ef46b987385abcdef0123"
    }
]
```

### Domain Widgets

#### Create domain widget

`POST /api/portals/v1/widget-scripts`

Create a domain widget.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is a [domain widget object](#domain-widget-object).
    * `"code"` - Domain widget code, optional.
    * `"description"` - Domain widget description, optional.
    * `"name"` - Domain widget name, REQUIRED.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [domain widget object](#domain-widget-object) if the domain widget was created successfully.
* `400 Bad Request`: Returned if request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create the domain widget.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/widget-scripts' \
     -X POST \
     -d '{"code":"function(){}","description":"no operation","name":"noop"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Thu, 02 Apr 2015 18:14:40 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 84
Content-Type: application/json; charset=UTF-8

{
    "code": "function(){}",
    "description": "no operation",
    "id": "3396985491",
    "name": "noop"
}
```

#### Delete domain widget

`DELETE /api/portals/v1/widget-scripts/{widget-script-id}`

Delete a domain widget.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the domain widget was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the domain widget.
* `404 Not Found`: Returned if the widget script id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/widget-scripts/3396985491' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Thu, 02 Apr 2015 18:59:11 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get domain widget

`GET /api/portals/v1/widget-scripts/{widget-script-id}`

Get a domain widget.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [domain widget object](#domain-widget-object) if the caller has permission to GET the domain widget.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the domain widget.
* `404 Not Found`: Returned if the widget script id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/widget-scripts/3396985491' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Thu, 02 Apr 2015 18:18:28 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 84
Content-Type: application/json; charset=UTF-8

{
    "code": "function(){}",
    "description": "no operation",
    "id": "3396985491",
    "name": "noop"
}
```

#### List domain widget

`GET /api/portals/v1/widget-scripts`

List domain widget.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [domain widget objects](#domain-widget-object) if the caller has permission to GET the domain widget.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the domain widget.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/widget-scripts' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Thu, 02 Apr 2015 18:24:58 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 86
Content-Type: application/json; charset=UTF-8

[
    {
        "code": "function(){}",
        "description": "no operation",
        "id": "3396985491",
        "name": "noop"
    }
]
```

#### Update domain widget

`PUT /api/portals/v1/widget-scripts/{widget-script-id}`

Update a domain widget.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is a [domain widget object](#domain-widget-object).
    * `"code"` - Domain widget code, optional.
    * `"description"` - Domain widget description, optional.
    * `"name"` - Domain widget name, optional.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [domain widget object](#domain-widget-object) if the domain widget was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the domain widget.
* `404 Not Found`: Returned if the widget script id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/widget-scripts/3396985491' \
     -X PUT \
     -d '{"code":""},"description":"empty","name":"empty"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Thu, 02 Apr 2015 18:58:01 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 66
Content-Type: application/json; charset=UTF-8

{
    "code": "",
    "description": "empty",
    "id": "3396985491",
    "name": "empty"
}
```

### File Systems

```
<form action="/api/portals/v1/fs/{directory-path}" enctype="multipart/form-data" method="POST">
    <div>
        <input name="{field-name-1}" type="file">
        <input name="{field-name-2}" type="text">
        <button type="submit">Submit</button>
    </div>
</form>
```

* `<directory-path>` can be `[\/\-_0-9A-Za-z]*`.
* `<field-name-*>` is `^[\-0-9_A-Za-z]*$`.

Submitting this form redirects the page to "/api/portals/v1/fs/{directory-path}/{subdirectory}".

The response entity body is:

```
{
    {field-name-1}: {field-content-type-1},
    {field-name-2}: {field-value-2}
}
```

* `{field-name-*}` is the literal send in the request.
* `{field-content-type-1}` is the content type of the file as the value of field 1.
* `{field-value-2}` is the value of `{field-name-2}`.

The file system sets the Content-Type of a GET response according to its file extension. Supported file extensions are:

ai, bmp, cab, css, doc, eps, exe, flv, gif, htm, html, ico, jpe, jpeg, jpg, js, json, mov, mp3, msi, ods, odt, pdf, php, png, ppt, ps, psd, qt, rar, rtf, svg, svgz, swf, tif, tiff, txt, xls, xml, zip.

#### Append to directory

`POST /api/portals/v1/fs`

##### Permissions

* User must have at least `d_____fs` [permission](#permission-object) to the domain.

##### Request

* Request body must not be empty.
* Requires authentication.

##### Response

* `303 See Other`: Returned along with the file content if the file is appended successfully, the field directory will appear in `Location`.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to append the file.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs' \
     -X POST \
     -H 'Content-Type: application/json' \
     -d '{"info":[{"description":{"name":"hello"}}]}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 303 See Other
Date: Tue, 16 Jun 2015 01:43:31 GMT
Status: 303 See Other
Location: https://mydomain.exosite.com/api/portals/v1/fs/141517041216756400
Vary: Accept-Encoding
Content-Length: 43
Content-Type: application/json

{"info":[{"description":{"name":"hello"}}]}
```

#### List files

`GET /api/portals/v1/fs`

Get all files which under the same directory.

##### Permissions

* Anyone can use this endpoint to get file content.

##### Request

* Request body is empty.

##### Response

* `200 OK`: Returned along with a body containing a JSON entity.

##### Example without file extension

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Wed, 19 Nov 2014 09:09:03 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 21
Content-Type: application/json

{
    "143442117468881900": {
        "info": [
            {
                "description": {
                    "name": "hello1"
                }
            }
        ]
    },
    "143442118299661000": {
        "info": [
            {
                "description": {
                    "name": "hello2"
                }
            }
        ]
    }
}
```

##### Example with file extension

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs.js' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Wed, 19 Nov 2014 09:09:03 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 21
Content-Type: application/javascript

console.log("Hello JavaScript");
```

#### Get file

`GET /api/portals/v1/fs/{directory-path}/{subdirectory}`

##### Permissions

* Anyone can use this endpoint to get a file.

##### Request

* Request body is empty.

##### Response

* `200 OK`: Returned with a body containing the file previously uploaded by the user.
* `404 Not Found`: Returned if the directory of field is invalid.

##### Example

* IF the myfile is a image file:

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs/path/141517041216756400' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:41:13 GMT
Status: 200 OK
Content-Length: 82
Content-Type: image/png

{"myfile":"image\/png; @md5=a6cfdf1c6d7fb1574a66fd06a94f4435"}
```

#### Get file content

`GET /api/portals/v1/fs/{directory-path}/{subdirectory}/{field-name}`

##### Permissions

* Anyone can use this endpoint to get file content.

##### Request

* Request body is empty.

##### Response

* `200 OK`: Returned with a body containing the file previously uploaded by the user.
* `404 Not Found`: Returned if the directory of field is invalid.

##### Example

* IF the myfile is a image file:

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs/path/141517041216756400/myfile' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:41:13 GMT
Status: 200 OK
Content-Length: 82
Content-Type: image/png

▒PNG

IHDR%▒V▒PLTEA▒▒▒▒V▒
IDATx▒cb67|▒IEND▒B`▒
```

* IF the myfile is a text file:

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs/path/141517041216756401/myfile' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:58:14 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 43
Content-Type: application/json

{"info":[{"description":{"name":"hello"}}]}
```

#### Update file content

`PUT /api/portals/v1/fs/{directory-path}`

##### Permissions

* User must have at least `d_____fs` [permission](#permission-object) to the domain.

##### Request

* Request body must not be empty
* Request header must contain `Content-Type`.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing file content if the file was updated successfully.
* `201 Created`: Returned along with file content and file directory appear in `Location` if the file directory does not exist.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the file.

##### Example

* IF the file directory exist:

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs/aa' \
     -X PUT \
     -H 'Content-Type: application/json' \
     -d '{"info":[{"description":{"name":"hell2"}}]}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 23 Jun 2015 08:06:23 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 43
Content-Type: application/json

{"info":[{"description":{"name":"hell2"}}]}
```

* IF the file directory does not exist:

```
curl 'https://mydomain.exosite.com/api/portals/v1/fs/aa' \
     -X PUT \
     -H 'Content-Type: application/json' \
     -d '{"info":[{"description":{"name":"hell1"}}]}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 23 Jun 2015 07:25:00 GMT
Status: 201 Created
Location: https://mydomain.exosite.com/api/portals/v1/fs/aa
Vary: Accept-Encoding
Content-Length: 43
Content-Type: application/json

{"info":[{"description":{"name":"hell1"}}]}
```

### Groups

#### Create group under user

`POST /api/portals/v1/users/{user-id}/groups`

Create a group under a user, which may be updated only by the owner.

##### Permissions

* User can create a group under himself.
* User must have at least `d_s_crea` [permission](#permission-object) to the domain.

##### Request

* The request body is a [group object](#group-object). Currently, only the following keys are supported:
    * `"name"` - group name, optional.
    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [group object](#group-object) if the group was created successfully.
* `403 Forbidden`: Returned if the caller is not authenticated.
* `404 Not Found`: Returned if the directory of field is invalid.
* `409 Conflict`: Returned if the group name exists already.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/groups' \
     -X POST \
     -d '{"name":"new group"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Tue, 18 Nov 2014 02:48:23 GMT
Status: 201 Created
Location: https://mydomain.exosite.com/api/portals/v1/groups/1206252898
Vary: Accept-Encoding
Content-Length: 163
Content-Type: application/json; charset=UTF-8

{
    "id": "1206252898",
    "userId": "3167859736",
    "members": [
        {
            "access": "___admin",
            "oid": {
                "type": "User",
                "id": "3167859736"
            }
        }
    ],
    "meta": null,
    "name": "new group",
    "permissions": []
}s
```

#### Update group

`PUT /api/portals/v1/groups/{group-id}`

Update information on a group.

##### Permissions

* User must have at least `g_update` [permission](#permission-object) to the group.

##### Query String

| String | Description |        Example |
|:-------|:------------|:---------------|
| `force` | Updates permissions which are valid and ignores invalid permissions, instead of failing the entire API call. Optional. | `/{group-id}?force=true` |

##### Request

* Body contains a [group object](#group-object). Currently only the following keys may be updated:
    * `"members"` - group members, optional.
    * `"meta"` - group meta, optional.
    * `"name"` - group name, optional.
    * `"permissions"` - group permissions, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [group object](#group-object) if the group was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the group.
* `404 Not Found`: Returned if the group id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/1206252898' \
     -X PUT \
     -d '{"name":"update group name"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:52:44 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 171
Content-Type: application/json; charset=UTF-8

{
    "id": "1206252898",
    "userId": "3167859736",
    "members": [
        {
            "access": "___admin",
            "oid": {
                "type": "User",
                "id": "3167859736"
            }
        }
    ],
    "meta": null,
    "name": "update group name",
    "permissions": []
}
```

#### Get group

`GET /api/portals/v1/groups/{group-id}`

Get information on a group.

If you want to get information on multiple groups, see [Get multiple groups](#get-multiple-groups).

##### Permissions

* User must have at least `g_member` [permission](#permission-object) to the group.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [group object](#group-object) if the caller has permission to GET the group.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the group.
* `404 Not Found`: Returned if the group id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/1206252898' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:51:19 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 163
Content-Type: application/json; charset=UTF-8

{
    "id": "1206252898",
    "userId": "3167859736",
    "members": [
        {
            "access": "___admin",
            "oid": {
                "type": "User",
                "id": "3167859736"
            }
        }
    ],
    "meta": null,
    "name": "new group",
    "permissions": []
}
```

#### Get group permissions

`GET /api/portals/v1/groups/{group-id}/permissions`

Get permissions on a group.

##### Permissions

* User must have at least `g_member` [permission](#permission-object) to the group.

##### Query String

| String | Description |        Example |
|:-------|:------------|:---------------|
| `type` | An array of permission types to retrieve. The supported types are `Domain`, `Portal`, `Device`, `DataSource` and `Group`. Optional. | `/groups/{group-id}/permissions?type%5B%5D=Group` <br> (Square brackets "[" and "]" have been replaced with "%5B" and "%5D" respectively) |
| `offset` | Sets the number of permissions to skip, only available when `"limit"` is valid. Optional. | `/groups/{group-id}/permissions?offset=0` |
| `limit` | Limits the number of permissions to retrieve. Optional. | `/groups/{group-id}/permissions?limit=10` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [permission](#permission-object) if the caller has permission to GET the group.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the group.
* `404 Not Found`: Returned if the group id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/1206252898/permissions' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:51:19 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 163
Content-Type: application/json; charset=UTF-8

[
    {
        "access": "___admin",
        "oid": {
            "type": "Device",
            "id": <device-rid>
        }
    }
]

```

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/1206252898/permissions?type%5B%5D=Device' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:51:19 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 163
Content-Type: application/json; charset=UTF-8

[
    {
        "access": "___admin",
        "oid": {
            "type": "Device",
            "id": <device-rid>
        }
    }
]

```

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/1206252898/permissions?offset=0&limit=1' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 02:51:19 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 163
Content-Type: application/json; charset=UTF-8

[
    {
        "access": "___admin",
        "oid": {
            "type": "Device",
            "id": <device-rid>
        }
    }
]

```

#### Delete group

`DELETE /api/portals/v1/groups/{group-id}`

Delete a group

##### Permissions

* User must have `___admin` [permission](#permission-object) to the group.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the group was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the group.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/3065555968' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 07:42:00 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Add group permissions

`POST /api/portals/v1/groups/{group-id}/permissions`

Add multiple permissions to a group.

##### Permissions

* the caller must have at least `g_update` [permission](#permission-object) to the group.
* the caller must have access to the [permission objects](#permission-object).

##### Request

* The request body is an array of [permission objects](#permission-object).
* Requires authentication.

##### Response

* `202 Accepted`: Returned if the group permission(s) was added successfully.
* `400 Bad Request`: Returned if the request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have access to the [permission objects](#permission-object).
    * Returned if the caller does not have permission to add the permission(s) to the group.
* `404 Not Found`: Returned if the group id is invalid.
* `409 Conflict`: Returned if the permissions already exist in the group.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/3167859736/permissions' \
     -X POST \
     -d '[{"access":"d_u_list","oid":{"id":"1576946496","type":"Domain"}}]' \
     -u 'groupemail@gmail.com:groupP4ssword' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Tue, 18 Nov 2014 02:48:23 GMT
Status: 202 Accepted
Location: https://mydomain.exosite.com/api/portals/v1/groups/3167859736/permissions
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

```

#### Delete group permissions

`DELETE /api/portals/v1/groups/{group-id}/permissions`

Delete multiple permissions on a group.

##### Permissions

* User must have at least `g_update` [permission](#permission-object) to the group.
* User must have access to the [permission objects](#permission-object).

##### Request

* The request body is an array of [permission objects](#permission-object).
* Requires authentication.

##### Response

* `204 No Content`: Returned if the group permissions were deleted successfully.
* `400 Bad Request`: Returned if the request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the group permission(s).
    * Returned if the permissions were deleted by another group and the group no longer has permissions on the permissions.
* `404 Not Found`: Returned if the group id is invalid.
* `409 Conflict`: Returned if the permissions were deleted by the callee group and the group no longer has permissions on the permissions.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/groups/3167859736/permissions' \
     -X DELETE \
     -d '[{"access":"d_u_list","oid":{"id":"1576946496","type":"Domain"}}]' \
     -u 'groupemail@gmail.com:groupP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 02:48:23 GMT
Status: 204 No Content
Location: https://mydomain.exosite.com/api/portals/v1/groups/3167859736/permissions
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

```

### Portal

#### List portals of authenticated user

`GET /api/portals/v1/portal/`

Get an array of portals for the specified user on the domain specified in the URL of the request.

##### Permissions

* User must be authenticated in the domain.

##### Request

* Request body is empty. The domain name in the HTTP request is used to determine which domain’s portals should be listed.
* Requires authentication.

##### Response

* `200 OK`: Returned if the caller has permission to list Portal, and along with a JSON array of [Portal objects](#portal-object). Portal objects contain the following keys:
    * `"name"` - Portal name.
    * `"domain"` - Portal domain.
    * `"key"` - Portal CIK (returned only if user has "owner" or "manager" level access to the Portal).
    * `"rid"` - Portal resource ID.
    * `"role"` - User’s role for this Portal. Possible values are:
        * `"owner"` - user is the Portal’s direct owner.
        * `"manager"` - user has manager access to the Portal. This role grants the same rights as the owner. A role of `"manager"` indicates the Portal is not a child client of this user in the One Platform hierarchy. Though once you have a key to the Portal, the distinction is not important to the API.
* `403 Forbidden`: Returned if the caller is not authenticated.

##### Example

```
$ curl 'https://mydomain.exosite.com/api/portals/v1/portal' \
       -X GET \
       -u 'useremail@gmail.com:userP4ssword' \
       -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:45:50 GMT
Vary: Accept-Encoding
Content-Length: 1442
Content-Type: application/json; charset=UTF-8

[
    {
        "name": "Test Sighoff 2014-06-19 16:47:21",
        "rid": "845e50e84fae7fe3d680f56ab79c7db31e7ab9b3",
        "key": "18279f186f23aea867eaadc1e2af4010017e1dba",
        "role": "owner",
        "domain": "mydomain.exosite.com"
    },
    {
        "name": "Test Sighoff 2014-06-19 16:47:21",
        "rid": "9dd0f4bf2e3a55553cfae85e3b61dcae178e0544",
        "key": "5fbf1cd65803a8b2eeb823eeaf4a92b0bf5f2bd2",
        "role": "owner",
        "domain": "mydomain.exosite.com"
    },
    ...
]
```

### Portals

#### Create Portal

`POST /api/portals/v1/users/{user-id}/portals`

Create a Portal under a user. If Default Portal Template under /admin/portaltemplate is not "no template", the created Portal will have the same device, data sources, events, alerts and scripts as the Default Portal Template.

##### Permissions

* User must have at least `d_p_crea` [permission](#permission-object) to the domain.

##### Request

* Request body is a [portal object](#portal-object).  Currently only the following keys may be included:
    * `"planId"` - portals plan ID as found in the URL of your signup page, e.g. https://yourdomain.exosite.com/signup?plan=1234567890. Plan must allow free signups.

* Requires authentication.

##### Response

* `201 Created`: Returned along with a body containing a [Portal object](#portal-object) if the Portal was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create the Portal.
* `201 Created`: Returned along with a body containing a [portal object](#portal-object) if the portal is created successfully.
* `400 Bad Request`: Returned when the planId is missing or invalid, or the body of the request is malformed.
* `403 Forbidden`:
    * Returned if the caller user is not authenticated.
    * Returned if the caller user does not have permission to create the portal.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals' \
     -X POST \
     -d '{"planId":"3676938388"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 17 Nov 2014 09:52:58 GMT
Status: 201 Created
Location: https://mydomain.exosite.com/api/portals/v1/portals/3882920427
Vary: Accept-Encoding
Content-Length: 578
Content-Type: application/json; charset=UTF-8

{
    "devices": [
        "3fb37448bc68d4c84d58c755fd29f187edc74694"
    ],
    "id": "3882920427",
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1416217920,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 5,
                "dataport": 50,
                "datarule": 50,
                "disk": "inherit",
                "dispatch": 50,
                "email": 10,
                "email_bucket": "inherit",
                "http": 100,
                "http_bucket": "inherit",
                "share": 100,
                "sms": 10,
                "sms_bucket": "inherit",
                "xmpp": 100,
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "",
            "name": "",
            "public": false
        },
        "key": "9ebc9f396e86995fe52cc77a9533675c0ac8876d",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    }
}
```

#### Update Portal

`PUT /api/portals/v1/portals/{portal-id}`

Update information on a Portal.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

* Request body is a [Portal object](#portal-object).  Currently only the following keys may be updated:

    * `"info"` - Info is an object. Possible values are:
        * `"aliases"` - Aliases under info is an array, optional. NOTE: this will replace the existing aliases-- not append to them. To prevent loss of data, be sure to include all aliases in the request body. Possible values are:
            * `{rid}` - The under this Portal's data-sources/ device rid. Possible values are:
                * `"{aliases}"` - The under this Portal's data-sources/ device aliases is an array.
        * `"description"` - Description under info, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [Portal object](#portal-object) if the Portal was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the Portal.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/3882920427' \
     -X PUT \
     -d '{"info":{"aliases":{"3fb37448bc68d4c84d58c755fd29f187edc74694":["update aliases"]}}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 10:03:21 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 639
Content-Type: application/json; charset=UTF-8

{
    "devices": [
        "3fb37448bc68d4c84d58c755fd29f187edc74694"
    ],
    "id": "3882920427",
    "info": {
        "aliases": {
            "3fb37448bc68d4c84d58c755fd29f187edc74694": [
                "update aliases"
            ]
        },
        "basic": {
            "modified": 1416217920,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 5,
                "dataport": 50,
                "datarule": 50,
                "disk": "inherit",
                "dispatch": 50,
                "email": 10,
                "email_bucket": "inherit",
                "http": 100,
                "http_bucket": "inherit",
                "share": 100,
                "sms": 10,
                "sms_bucket": "inherit",
                "xmpp": 100,
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "",
            "name": "",
            "public": false
        },
        "key": "9ebc9f396e86995fe52cc77a9533675c0ac8876d",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    }
}
```

#### Get Portal

`GET /api/portals/v1/portals/{portal-id}`

Get information on a Portal.

##### Permissions

* User must have at least `p___view` [permission](#permission-object) to the Portal.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [Portal object](#portal-object) if the caller has permission to GET the Portal.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the Portal.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/2853566858' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:49:38 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 578
Content-Type: application/json; charset=UTF-8

{
    "devices": [
        "5d4bacb783b10600e12b759bb1ae80b43666085b"
    ],
    "id": "2853566858",
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1416213843,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 5,
                "dataport": 50,
                "datarule": 50,
                "disk": "inherit",
                "dispatch": 50,
                "email": 10,
                "email_bucket": "inherit",
                "http": 100,
                "http_bucket": "inherit",
                "share": 100,
                "sms": 10,
                "sms_bucket": "inherit",
                "xmpp": 100,
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "",
            "name": "",
            "public": false
        },
        "key": "607be8f93031588b7be6985a16808a7c669413d7",
        "shares": [],
        "subscribers": [],
        "tagged": [],
        "tags": []
    }
}
```

#### List portals by domain

`GET /api/portals/v1/portals`

List portals by domain.

##### Permissions

* User must have at least `d_p_list` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of Portal IDs if the caller has permission to list portals.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to list Portal.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 20 Apr 2015 08:29:21 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[{
    "id": "2590421429"
}]
```

#### List Portal devices

`GET /api/portals/v1/portals/{portal-id}/devices`

List devices under a portal.

##### Permissions

* User must have at least `p___view` [permission](#permission-object) to the Portal.

##### Query String

| String | Description |        Example |
|:-------|:------------|:---------------|
| `limit` | Limits the number of devices to retrieve. Optional. | `/portals/{portal-id}/devices?limit=10` |
| `offset` | Sets the number of devices to skip, only available when `"limit"` is valid. Optional. | `/portals/{portal-id}/devices?offset=10` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [device objects](#device-object) if the caller has permission to list Portal devices.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to list Portal devices.
* `404 Not Found`: Returned if the portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/devices' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 28 Apr 2015 11:16:14 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[{
    "rid": "446a943cdf4d7b2e113c8673d1d27323764427f4",
    "members": [{
        "access": "___admin",
        "oid": {
            "type": "User",
            "id": "1075526687"
        }
    }],
    "info": {
        "aliases": [],
        "basic": {
            "modified": 1430219273,
            "subscribers": 0,
            "type": "client",
            "status": "activated"
        },
        "description": {
            "limits": {
                "client": 0,
                "dataport": "inherit",
                "datarule": "inherit",
                "disk": "inherit",
                "dispatch": "inherit",
                "email": "inherit",
                "email_bucket": "inherit",
                "http": "inherit",
                "http_bucket": "inherit",
                "share": "inherit",
                "sms": "inherit",
                "sms_bucket": "inherit",
                "xmpp": "inherit",
                "xmpp_bucket": "inherit"
            },
            "locked": false,
            "meta": "{\"timezone\":\"Asia\\\/Taipei\",\"location\":\"\",\"device\":{\"type\":\"generic\"}}",
            "name": "New Device@2015-04-28T11:11:56+00:00 1430219516.9894",
            "public": false
        },
        "key": "519cc84b04b0144b479c7644d0defd45127983dd",
        "shares": [],
        "subscribers": [],
        "tags": []
    },
    "dataSources": [],
    "model": null,
    "sn": null,
    "type": "generic",
    "vendor": null
}]
```

#### Delete Portal by ID

`DELETE /api/portals/v1/portals/{portal-id}`

Delete a Portal through Portal ID.

##### Permissions

* User must be authenticated in the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`:
    * Returned if the portal was deleted successfully.
* `403 Forbidden`: Returned if the caller is not authenticated.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1156616498' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Wed, 19 Nov 2014 01:59:13 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 52
Content-Type: application/json; charset=UTF-8

["myportal has been successfully deleted."]
```

#### Delete Portal by RID

`DELETE /api/portals/v1/portals/{portal-rid}/ByRid`

Delete a Portal through Portal ID.

##### Permissions

* User must be authenticated in the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`:
    * Returned if the Portal was deleted successfully.
    * Returned if failed to delete the Portal due to devices under that Portal being used as a Clone for other devices.
* `403 Forbidden`: Returned if the caller is not authenticated.
* `404 Not Found`: Returned if the Portal rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/de3d88a4c15a341d386e7c1cfa0fa2a3a4cf2dcb/ByRid' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Wed, 19 Nov 2014 01:59:13 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 52
Content-Type: application/json; charset=UTF-8

["myportal has been successfully deleted."]
```

### Scripts

#### Create device script

`POST /api/portals/v1/devices/{device-rid}/scripts`

Create a device script.

##### Permissions

* User must have at least `d_update` [permission](#permission-object) to the device.

##### Request

```
{
    "info": {
        "description": {
            "name": string = "",
            "rule": {
                "script": string = ""
            }
        }
    }
}
```

* See the [create datarule API](https://github.com/exosite/docs/blob/master/rpc/README.md#create-datarule).
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [script object](#script-object) if the device script was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create device scripts.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/bbc295c0dc98f8518b784867bae4a1b168c77f1b/scripts' \
     -X POST \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 11 May 2015 08:31:37 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 403
Content-Type: application/json; charset=UTF-8

{
    "rid": "8e628a6c2018fdff9a9a6feae198adad6f7fe126",
    "data": [],
    "info": {
        "basic": {
            "modified": 1431332795,
            "subscribers": 0,
            "type": "datarule",
            "status": "running",
            "activity": [
                [1431332794, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": ""
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}
```

#### Create Portal script

`POST /api/portals/v1/portals/{portal-id}/scripts`

Create a Portal script.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Request

```
{
    "info": {
        "description": {
            "name": string = "",
            "rule": {
                "script": string = ""
            }
        }
    }
}
```

* See the [create datarule API](https://github.com/exosite/docs/blob/master/rpc/README.md#create-datarule).
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [script object](#script-object) if the Portal script was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create a Portal script.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/scripts' \
     -X POST \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 11 May 2015 08:41:56 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 403
Content-Type: application/json; charset=UTF-8

{
    "rid": "c2a2bdfa83b0a8c6eeca438ce895fa4913b48f87",
    "data": [],
    "info": {
        "basic": {
            "modified": 1431333414,
            "subscribers": 0,
            "type": "datarule",
            "status": "running",
            "activity": [
                [1431333413, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": ""
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}
```

#### Delete script

`DELETE /api/portals/v1/scripts/{script-rid}`

Delete a script.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the script.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned along with an empty body if the script was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the script.
* `404 Not Found`: Returned if the script rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/scripts/c2a2bdfa83b0a8c6eeca438ce895fa4913b48f87' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Mon, 11 May 2015 08:57:09 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get script data

`GET /api/portals/v1/scripts/{script-rid}/data`

See [Get data source data](#get-data-source-data).

##### Permissions

* User must have `___admin` [permission](#permission-object) to the script.

##### Request

See [Get data source data](#get-data-source-data).

##### Response

See [Get data source data](#get-data-source-data).

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/scripts/28571049e6bf6de245012957171da9e83926d897/data' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 11 May 2015 09:15:20 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 49
Content-Type: application/json; charset=UTF-8

[
    [1431316854, "line 4: 8\nline 4: 9\nline 4: 10"]
]
```

#### Get script

`GET /api/portals/v1/scripts/{script-rid}`

Get information on a script.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the script.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [script object](#script-object) if the caller has permission to GET the script.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the script.
* `404 Not Found`: Returned if the script rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/scripts/28571049e6bf6de245012957171da9e83926d897' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 11 May 2015 09:17:31 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 547
Content-Type: application/json; charset=UTF-8

{
    "rid": "28571049e6bf6de245012957171da9e83926d897",
    "data": [
        [1431316854, "line 4: 8\nline 4: 9\nline 4: 10"]
    ],
    "info": {
        "basic": {
            "modified": 1431316848,
            "subscribers": 0,
            "type": "datarule",
            "status": "completed",
            "activity": [
                [1431316855, ["completed"]],
                [1431316853, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": "local n = 0\nwhile n < 10 do\n\tn = n + 1\n\tdebug(tostring(n))\nend"
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}
```

#### List device script

`GET /api/portals/v1/devices/{device-rid}/scripts`

List scripts under a device.

##### Permissions

* User must have at least `d___view` [permission](#permission-object) to the device.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `limit` | Limits the number of scripts to retrieve. Optional. | `/devices/{device-rid}/scripts?limit=10` |
| `offset` | Sets the number of scripts to skip, only available when `"limit"` is valid. Optional. | `/devices/{device-rid}/scripts?offset=10` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [script objects](#script-object) if the caller has permission to GET the device scripts.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the device scripts.
* `404 Not Found`: Returned if the device rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/devices/bbc295c0dc98f8518b784867bae4a1b168c77f1b/scripts' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 11 May 2015 10:23:35 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 434
Content-Type: application/json; charset=UTF-8

[{
    "rid": "8e628a6c2018fdff9a9a6feae198adad6f7fe126",
    "data": [],
    "info": {
        "basic": {
            "modified": 1431332795,
            "subscribers": 0,
            "type": "datarule",
            "status": "completed",
            "activity": [
                [1431332798, ["completed"]],
                [1431332794, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": ""
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}]
```

#### List Portal scripts

`GET /api/portals/v1/portals/{portal-id}/scripts`

List scripts under a portal.

##### Permissions

* User must have at least `p_manage` [permission](#permission-object) to the Portal.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `limit` | Limits the number of scripts to retrieve. Optional. | `/portals/{portal-id}/scripts?limit=10` |
| `offset` | Sets the number of scripts to skip, only available when `"limit"` is valid. Optional. | `/portals/{portal-id}/scripts?offset=10` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [script objects](#script-object) if the caller has permission to GET  the Portal scripts.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET Portal scripts.
* `404 Not Found`: Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/portals/1284862590/scripts' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 11 May 2015 10:28:37 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 1912
Content-Type: application/json; charset=UTF-8

[{
    "rid": "28571049e6bf6de245012957171da9e83926d897",
    "data": [
        [1431316854, "line 4: 8\nline 4: 9\nline 4: 10"]
    ],
    "info": {
        "basic": {
            "modified": 1431316848,
            "subscribers": 0,
            "type": "datarule",
            "status": "completed",
            "activity": [
                [1431316855, ["completed"]],
                [1431316853, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": "local n = 0\nwhile n < 10 do\n\tn = n + 1\n\tdebug(tostring(n))\nend"
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}]
```

#### Update script

`PUT /api/portals/v1/scripts/{script-rid}`

Update a script.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the script.

##### Request

```
{
    "info": {
        "description": <description>
    }
}
```

* `<description>` - See the [update API](https://github.com/exosite/docs/blob/master/rpc/README.md#update)

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [script object](#script-object) if the script was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the script.
* `404 Not Found`: Returned if the script rid is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/scripts/28571049e6bf6de245012957171da9e83926d897' \
     -X PUT \
     -d '{"info":{"description":{"rule":{"script":"debug(\"Hello World!\")"}}}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 11 May 2015 11:25:04 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 473
Content-Type: application/json; charset=UTF-8

{
    "rid": "28571049e6bf6de245012957171da9e83926d897",
    "data": [
        [1431316854, "line 4: 8\nline 4: 9\nline 4: 10"]
    ],
    "info": {
        "basic": {
            "modified": 1431343202,
            "subscribers": 0,
            "type": "datarule",
            "status": "running",
            "activity": [
                [1431343201, ["running"]]
            ]
        },
        "description": {
            "format": "string",
            "meta": "",
            "name": "",
            "preprocess": [],
            "public": false,
            "retention": {
                "count": 1000,
                "duration": "infinity"
            },
            "rule": {
                "script": "debug(\"Hello World!\")"
            },
            "subscribe": null
        },
        "shares": [],
        "subscribers": [],
        "tags": []
    }
}
```

### Themes

Themes are designs applied to your domain. Only domain administrators can use the Themes APIs. All Themes APIs share the same prefix: `/api/portals/v1/themes/`.
**Note: Image data cannot be modified using this API currently**

#### Create theme

`POST /api/portals/v1/themes`

Create a theme with default configuration.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Body contains a [theme object](#theme-object). Currently only the following keys may be updated:
    * `"name"` - theme name, REQUIRED.
    * `"description"` - theme permissions, REQUIRED.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [theme object](#theme-object) if the theme was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to create a theme.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/themes' \
     -X POST \
     -d '{"name":"test1113","description":"desc-test1113"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 27 Apr 2015 08:15:57 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

{
    "id": "3156844504",
    "name": "test1113",
    "description": "desc-test1113",
    ":default": false,
    "config": {
        "dashboard_background": {
            "background_color": "f9f9f9",
            "background_image": "",
            "background_attachment": "scroll",
            "background_repeat": "repeat-y",
            "background_position": "left top"
        },
        "header_logo": "https://mydomain.exosite.com/static/png/skin_portals_bannerbrand.png?9ebccc0ccd74b887b6e0b8aabc97f3b2",
        "header_bkimage": "https://portals.review.portalsapp/static/png/skin_portals_bannerbg.png?62d38477d5d7a46968a168c460bf76fc",
        "header_title_color": "D5E04D",
        "header_subtitle_color": "FFFFFF",
        "header_titles_position_top": "1.375em",
        "header_linktext_color": "E5E5E5",
        "header_linktextover_color": "D5E04D",
        "header_dropdown_text_color": "FFFFFF",
        "header_linktext_position_top": "1.5em",
        "header_portalmenu_current_color": "0000FF",
        "footer_text": "ANY DEVICE. ANY DATA. ANY WHERE.",
        "footer_text_color": "D5E04D",
        "footer_bar_color": "D5E04D",
        "footer_linktext_color": "5C5D60",
        "footer_linktextover_color": "000000",
        "block_title_text_color": "000000",
        "block_title_linkover_color": "010101",
        "block_title_back_color": "D5E04D",
        "block_invert_icons": "0",
        "managepage_highlight_text_color": "0000FF",
        "dashboard_thumbnail": "",
        "thankyoupage_title_text_color": "D5E04D",
        "browser_tab_text": "Exosite Portals",
        "browser_tab_icon": "https://mydomain.exosite.com/static/png/icon_exosite.png?834282e60aa5c2cf2d3a6894307437dd",
        "admin_menu_style": {
            "admin_menu_title": "Domain Admin",
            "manage_menu_title": "Manage",
            "secondary_menu_title": "Portal Menu",
            "account_menu_title": "Account",
            "menu_title_color": "e5e5e5",
            "background_color": "5c5d60",
            "background_hover_color": "a6a6a6",
            "text_color": "fff",
            "sub_background_color": "fff",
            "sub_background_hover_color": "a6a6a6",
            "sub_text_color": "5c5d60",
            "text_active_color": "d5e04d"
        },
        "jsCode": ""
    },
    "code": ""
}
```

#### Delete theme

`DELETE /api/portals/v1/themes/{theme-id}`

Delete a theme.
If the default theme was deleted, the Portals system theme will be applied to the domain.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the theme was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete theme.
* `404 Not Found`: Returned if the theme id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/themes/1083890176' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 16 Jun 2015 11:07:02 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Get theme

`GET /api/portals/v1/themes/{theme-id}`

Get information on a theme.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [theme object](#theme-object) if the caller has permission to GET the theme.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the theme.
* `404 Not Found`: Returned if the theme id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/themes/1083890176' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 05:59:28 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 1880
Content-Type: application/json; charset=UTF-8

{
    "id": "1083890176",
    "name": "-1408691077",
    "description": "123",
    ":default": true,
    "config": {
        "dashboard_background": {
            "background_color": "D9E4F9",
            "background_image": "",
            "background_attachment": "fixed",
            "background_repeat": "repeat",
            "background_position": "left top"
        },
        "header_logo": "https://mydomain.exosite.com/static/png/skin_portals_bannerbrand.png?9ebccc0ccd74b887b6e0b8aabc97f3b2",
        "header_bkimage": "https://mydomain.exosite.com/static/png/skin_portals_bannerbg.png?62d38477d5d7a46968a168c460bf76fc",
        "header_title_color": "D5E04D",
        "header_subtitle_color": "FFFFFF",
        "header_titles_position_top": "1.375em",
        "header_linktext_color": "E5E5E5",
        "header_linktextover_color": "D5E04D",
        "header_dropdown_text_color": "FFFFFF",
        "header_linktext_position_top": "1.5em",
        "header_portalmenu_current_color": "0000FF",
        "footer_text": "ANY DEVICE. ANY DATA. ANY WHERE.",
        "footer_text_color": "D5E04D",
        "footer_bar_color": "D5E04D",
        "footer_linktext_color": "5C5D60",
        "footer_linktextover_color": "000000",
        "block_title_text_color": "000000",
        "block_title_linkover_color": "010101",
        "block_title_back_color": "D5E04D",
        "block_invert_icons": "0",
        "managepage_highlight_text_color": "0000FF",
        "dashboard_thumbnail": "https://mydomain.exosite.com/cache/theme/0_2110723926_dashboard_thumbnail.png",
        "thankyoupage_title_text_color": "D5E04D",
        "browser_tab_text": "Exosite Portals",
        "browser_tab_icon": "https://mydomain.exosite.com/static/png/icon_exosite.png?834282e60aa5c2cf2d3a6894307437dd",
        "admin_menu_style": {
            "admin_menu_title": "Domain Admin",
            "manage_menu_title": "Manage",
            "secondary_menu_title": "Portal Menu",
            "account_menu_title": "Account",
            "menu_title_color": "E5E5E5",
            "background_color": "5C5D60",
            "background_hover_color": "A6A6A6",
            "text_color": "FFFFFF",
            "sub_background_color": "FFFFFF",
            "sub_background_hover_color": "A6A6A6",
            "sub_text_color": "5C5D60",
            "text_active_color": "D5E04D"
        },
        "jsCode": ""
    },
    "code": ""
}
```

#### List themes

`GET /api/portals/v1/themes/`

Returns an array of themes under this domain.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [theme objects](#theme-object) if the caller has permission to list the themes.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to list the themes.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/themes' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 05:56:40 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 3676
Content-Type: application/json; charset=UTF-8

[
    {
        "id": "1083890176",
        "name": "-1408691077",
        "description": "123",
        ":default": true,
        "config": {
            "dashboard_background": {
                "background_color": "D9E4F9",
                "background_image": "",
                "background_attachment": "fixed",
                "background_repeat": "repeat",
                "background_position": "left top"
            },
            "header_logo": "https://testing.signoff.https://mydomain.exosite.com/static/png/skin_portals_bannerbrand.png?9ebccc0ccd74b887b6e0b8aabc97f3b2",
            "header_bkimage": "https://mydomain.exosite.com/static/png/skin_portals_bannerbg.png?62d38477d5d7a46968a168c460bf76fc",
            "header_title_color": "D5E04D",
            "header_subtitle_color": "FFFFFF",
            "header_titles_position_top": "1.375em",
            "header_linktext_color": "E5E5E5",
            "header_linktextover_color": "D5E04D",
            "header_dropdown_text_color": "FFFFFF",
            "header_linktext_position_top": "1.5em",
            "header_portalmenu_current_color": "0000FF",
            "footer_text": "ANY DEVICE. ANY DATA. ANY WHERE.",
            "footer_text_color": "D5E04D",
            "footer_bar_color": "D5E04D",
            "footer_linktext_color": "5C5D60",
            "footer_linktextover_color": "000000",
            "block_title_text_color": "000000",
            "block_title_linkover_color": "010101",
            "block_title_back_color": "D5E04D",
            "block_invert_icons": "0",
            "managepage_highlight_text_color": "0000FF",
            "dashboard_thumbnail": "https://mydomain.exosite.com/cache/theme/0_2110723926_dashboard_thumbnail.png",
            "thankyoupage_title_text_color": "D5E04D",
            "browser_tab_text": "Exosite Portals",
            "browser_tab_icon": "https://mydomain.exosite.com/static/png/icon_exosite.png?834282e60aa5c2cf2d3a6894307437dd",
            "admin_menu_style": {
                "admin_menu_title": "Domain Admin",
                "manage_menu_title": "Manage",
                "secondary_menu_title": "Portal Menu",
                "account_menu_title": "Account",
                "menu_title_color": "E5E5E5",
                "background_color": "5C5D60",
                "background_hover_color": "A6A6A6",
                "text_color": "FFFFFF",
                "sub_background_color": "FFFFFF",
                "sub_background_hover_color": "A6A6A6",
                "sub_text_color": "5C5D60",
                "text_active_color": "D5E04D"
            },
            "jsCode": ""
        },
        "code": ""
    },
    {
        "id": "1272623304",
        "name": "default",
        "description": "default",
        ":default": false,
        "config": {
            "dashboard_background": {
                "background_color": "F9F8DE",
                "background_image": "",
                "background_attachment": "fixed",
                "background_repeat": "repeat",
                "background_position": "left top"
            },
            "header_logo": "https://mydomain.exosite.com/static/png/skin_portals_bannerbrand.png?9ebccc0ccd74b887b6e0b8aabc97f3b2",
            "header_bkimage": "https://mydomain.exosite.com/static/png/skin_portals_bannerbg.png?62d38477d5d7a46968a168c460bf76fc",
            "header_title_color": "D5E04D",
            "header_subtitle_color": "FFFFFF",
            "header_titles_position_top": "1.375em",
            "header_linktext_color": "E5E5E5",
            "header_linktextover_color": "D5E04D",
            "header_dropdown_text_color": "FFFFFF",
            "header_linktext_position_top": "1.5em",
            "header_portalmenu_current_color": "0000FF",
            "footer_text": "ANY DEVICE. ANY DATA. ANY WHERE.",
            "footer_text_color": "D5E04D",
            "footer_bar_color": "D5E04D",
            "footer_linktext_color": "5C5D60",
            "footer_linktextover_color": "000000",
            "block_title_text_color": "000000",
            "block_title_linkover_color": "010101",
            "block_title_back_color": "D5E04D",
            "block_invert_icons": "0",
            "managepage_highlight_text_color": "0000FF",
            "dashboard_thumbnail": "",
            "thankyoupage_title_text_color": "D5E04D",
            "browser_tab_text": "Exosite Portals",
            "browser_tab_icon": "https://mydomain.exosite.com/static/png/icon_exosite.png?834282e60aa5c2cf2d3a6894307437dd",
            "admin_menu_style": {
                "admin_menu_title": "Domain Admin",
                "manage_menu_title": "Manage",
                "secondary_menu_title": "Portal Menu",
                "account_menu_title": "Account",
                "menu_title_color": "E5E5E5",
                "background_color": "5C5D60",
                "background_hover_color": "A6A6A6",
                "text_color": "FFFFFF",
                "sub_background_color": "FFFFFF",
                "sub_background_hover_color": "A6A6A6",
                "sub_text_color": "5C5D60",
                "text_active_color": "D5E04D"
            },
            "jsCode": ""
        },
        "code": ""
    },
    ...
]
```

#### Update theme

`PUT /api/portals/v1/themes/{themeid}`

Update information on a theme.

##### Permissions

* User must have `___admin` [permission](#permission-object) to the domain.

##### Request

* The body is a JSON encoded [theme object](#theme-object).
* Requires authentication.

##### Response

* `200 OK`: Returned if the theme was updated successfully.
* `400 Bad Request`: Returned if the body is not a JSON encoded [theme object](#theme-object).
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the theme.
* `404 Not Found`: Returned if the theme id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/themes/1083890176' \
     -X PUT \
     -d '{"name": "update_theme"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 18 Nov 2014 06:01:39 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

### User

#### Register new user account

`POST /api/portals/v1/user`

> **Deprecated.** This API is deprecated and should not be used.

Signs up a new user account, sending an activation email to the specified address.

##### Permissions

* Anyone can use this endpoint to create a new user.

##### Request

* Request body is a JSON object with the following keys:
    * `"email"` - new user’s email address, REQUIRED
    * `"password"` - new user’s password, REQUIRED.
    * `"plan"` - portals plan ID from signup page, e.g. https://portals.exosite.com/signup?plan=3676938388, REQUIRED. Plan must allow free signups.
    * `"first_name"` - user’s first name, optional.
    * `"last_name"` - user’s last name, optional.
    If `"first_name"` or `"last_name"` are omitted or empty, they will be respectively set to `"New"` and `"User"`.

* The domain name in the HTTP request is used to determine which domain the user should be signed up in.

##### Response

* `200 OK`: Returned if the user was created successfully.
* `400 Bad Request`: Returned along with  JSON formatted response object. Response object may contain the following keys:
    * `"errors"` - array of error identifier strings.
        * `"missing_*"` - some required input was missing. E.g. missing_email indicates a missing or empty (blank) email.
        * `"wrong_password"` - email is already registered with Portals and the password is incorrect.
        * `"user_exists_wrong_domain”` - user exists on another domain.
        * `"user_exists"` - user already exists on this domain.
    * `"notices"` - array of user-readable error strings.

##### Example

```
$ curl 'https://mydomain.exosite.com/api/portals/v1/user' \
       -X POST \
       -d '{"email": "jane+testuser123@gmail.com", "password":"testuserP4ssword", "plan":"3676938388"}' \
       -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 06:24:51 GMT
Vary: Accept-Encoding
Content-Length: 0
Content-Type: text/html
```

#### Reset user account password

`POST /api/portals/v1/user/password`

> **Deprecated.** This API is deprecated and should not be used.

Sends a password reset email for this user.

##### Permissions

* Anyone can use this endpoint to reset password.

##### Request

* Request contains a JSON object with the following keys:
    * `"email"` - email address of a Portals user.
    * `"action"` - what to do. Supported values:
        * `"reset"` - send user a password reset request

##### Response

* `200 OK`: Returned if reset password request is allowed, will receive a reset password email.
* `400 Bad Request`: Returned along with  JSON formatted response object. Response object may contain the following keys:
    * `"errors"` - array of error identifier strings.
        * `"missing_*"` - some required input was missing. E.g. missing_email indicates a missing or empty (blank) email.
        * `"failed"` - some other error occurred.
    * `"notices"` - array of user-readable error strings.

##### Example

```
$ curl 'https://mydomain.exosite.com/api/portals/v1/user/password' \
       -X POST \
       -d '{"action":"reset", "email": "joe@gmail.com"}' \
       -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:16:12 GMT
Vary: Accept-Encoding
Content-Length: 0
Content-Type: text/html
```

### Users

#### Create user

`POST /api/portals/v1/users`

Create a user.

* Non-admin and admin users can create a new account
* To create a new user, "Moderate New User Signup" under /admin/moderate must be set to "**OFF**".
* Depending on the request, an activation email may be sent to the user
    * To send an activation email, include `X-User-Agent` in the request header.
    * If you would like to have a Portal created for the new users, check **Assign a default plan for the following: -- Please Select Plan --** and select a default plan under Signup Configuration at /admin/plans.
![Find Default Plan](images/find_default_plan.png)

##### Permissions

* Anyone can use this endpoint to create a new user.

##### Request

* Request body is a [user object](#user-object).  Currently only the following keys may be included:
    * `"email"` - User email, REQUIRED.
    * `"userName"` - User name, optional. If omitted, this will be the same as `email`.
    * `"password"` - User password, optional. If omitted, a random password will be created.
    * `"Firstname"` - User's first name, optional.
    * `"Lastname"` - User's last name, optional.

    If any keys beside these are sent, they will be ignored.

If both Firstname and Lastname are sent, the fullName in the response body will be Firstname + Lastname.

##### Response

* `201 Created`: Returned along with a body containing an array of [user objects](#user-object) if the new user was created successfully. The new user will receive an email with a randomly generated password.
* `202 Accepted`: Returned if the user was created successfully with `X-User-Agent` in the request header. The new user will receive an activation email.
* `400 Bad Request`: Returned if request body is invalid.
* `409 Conflict`:
    * Returned if the email has already been registered and is awaiting activation.
    * Returned if the email already has an account in this domain.

##### Example

* Create a user with `X-User-Agent` in the request header.

```
curl 'https://mydomain.exosite.com/api/portals/v1/users' \
     -X POST \
     -H 'X-User-Agent: Android' \
     -d '{"email":"newuseremail@gmail.com"}' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Thu, 05 Feb 2015 04:02:27 GMT
Status: 202 Accepted
Vary: Accept-Encoding
Content-Length: 184
Content-Type: application/json; charset=UTF-8

{
    "code": 202,
    "message": "Thank you. You will receive an email confirming your new account shortly. That email will contain a link to validate and complete the account creation process."
}
```

* Create a user without `X-User-Agent` in the request header.

```
curl 'https://mydomain.exosite.com/api/portals/v1/users' \
     -X POST \
     -d '{"email":"newuseremail@gmail.com"}' \
     -i
```

```
HTTP/1.1 201 Created
Date: Mon, 17 Nov 2014 08:12:25 GMT
Status: 201 Created
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
    "email": "newuseremail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions": []
}
```

#### Activate a user account using activation key

`POST /api/portals/v1/users`

Activate an activation email.

* The activation email is generated by calling POST /users to create a user with `X-User-Agent` in the request header.

##### Permissions

* Anyone can use this endpoint to activate an activation email.

##### Request

* Request body is a JSON object.  Currently only the following key may be included:
    * `"activationRegkey"` - activation key, REQUIRED. This can be found in the activation email sent when the user was created.

    If any keys beside these are sent, they will be ignored.

##### Response

* `200 OK`: Returned if the new user was activated successfully.
* `400 Bad Request`:
    * Returned if the activation key does not exist in the domain.
    * Returned if request body is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users' \
     -X POST \
     -d '{"activationRegkey":"21c2bdc303c23f5841b35fd0935efca42803fdeb"}' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 10 Mar 2015 06:31:25 GMT
Vary: Accept-Encoding
Cache-Control: max-age=0, no-cache
Content-Length: 0
Content-Type: text/html

```

#### Update user

`PUT /api/portals/v1/users/{user-id}`

Update information on a user.

##### Permissions

* User can update his own information.
* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `silence` | Excludes the [user object](#user-object) from the response body. Optional. | `/users/{user-id}?silence` |

##### Request

* Request body is a [user object](#user-object). Currently only the following keys may be updated:
    * `"activated"` - Whether a user is activated, optional.
    * `"email"` - User email, optional.
    * `"userName"` - User name, optional.
    * `"fullName"` - User full name, optional.
    * `"password"` - User password, optional.
    * `"meta"` -User meta, optional.
    * `"permissions"` - User permissions, optional.
    * `"phoneNumber"` - user phone number, optional.

    If any keys beside these are sent, they will be ignored.

* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [user objects](#user-object) if the user was updated successfully.
* `202 Accepted`: Returned if `silence` is passed in the query string and the user was updated successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to update the user.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736' \
     -X PUT \
     -d '{"email":"updatedemail@gmail.com"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:33:44 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
    "email": "updatedemail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions": []
}
```

##### Example with options

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736?silence' \
     -X PUT \
     -d '{"email":"updatedemail@gmail.com"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Mon, 17 Nov 2014 08:33:44 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```

#### Reset password

`POST /api/portals/v1/users/reset-password`

Step 1 of 2: Send a reset password email to the user's email address.
See [Step 2 of 2: Update password by reset password key](#update-password-by-reset-password-key)

##### Permissions

* Anyone can use this endpoint to reset passwords.

##### Request

* Request body is a JSON object.  Currently only the following key may be included:
    * `"email"` - User email, REQUIRED.

    If any keys beside these are sent, they will be ignored.

##### Response

* `202 Accepted`: Returned along with a body containing a message if the reset password request is valid. The user will receive a reset password email.
* `400 Bad Request`:
    * Returned if the email address has not been registered.
    * Returned if request body is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/reset-password' \
     -X POST \
     -d '{"email":"resetEmail@gmail.com"}' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Tue, 17 Mar 2015 04:06:36 GMT
Status: 202 Accepted
Vary: Accept-Encoding
Content-Length: 187
Content-Type: application/json; charset=UTF-8

{
    "code":202,
    "message":"Thank you. We have sent an email to your account's registered email address. The email contains a link that will allow you to complete the password reset process."
}
```

#### Reset user profile picture

`DELETE /api/portals/v1/users/{user-id}/profile/picture`

Reset a user's profile picture to default.

##### Permissions

* User can reset his own profile picture.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `202 Accepted`: Returned if the user's profile picture was reset successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to reset the user's profile picture.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/profile/picture' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Fri, 22 May 2015 06:20:40 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2
```

#### Set user profile picture

`POST /api/portals/v1/users/{user-id}/profile/picture`

Set a user's profile picture by uploading a file.

##### Permissions

* User can set his own profile picture.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is the file the caller intends to upload. Only png images are supported.
* Requires authentication.

##### Response

* `201 Created`: Returned if the user's profile picture was uploaded and set successfully.
* `400 Bad Request`: Returned if request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to set the user's profile picture.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/profile/picture' \
     -X POST \
     -F myfile=@"~/Downloads/user1-64x64.png" \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 100 Continue

HTTP/1.1 201 Created
Date: Fri, 22 May 2015 06:30:51 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2
```


#### Update password by reset password key

`PUT /api/portals/v1/users/reset-password`

Step 2 of 2: Activate a reset password email.
See [Step 1 of 2: Reset password](#reset-password).

##### Permissions

* Anyone can use this endpoint to reset password.

##### Request

* Request body is a JSON object.  Currently only the following keys may be included:
    * `"resetPasswordRegkey"` - Reset key, REQUIRED. This can be found in the reset email sent upon the POST /users/reset-password request to the user's email address.
    * `"newPassword"` - User's new password, optional. If omitted, a random password will be generated.

    If any keys beside these are sent, they will be ignored.

##### Response

* `200 OK`: Returned if the user password was reset successfully.
* `400 Bad Request`: Returned if the request body is invalid.

##### Example


```
curl 'https://mydomain.exosite.com/api/portals/v1/users/reset-password' \
     -X PUT \
     -d '{"resetPasswordRegkey":"21c2bdc303c23f5841b35fd0935efca42803fdeb", "newPassword":"newPassword"}' \
     -i
```

```
HTTP/1.1 200 OK
Date: Tue, 17 Mar 2015 04:09:36 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 113
Content-Type: application/json; charset=UTF-8
```

#### Get all users

`GET /api/portals/v1/users`

Get information on all users.

##### Permissions

* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `offset` | Sets the number of users to skip. Optional but paired with limit. | `/users?offset=0&limit=10` |
| `limit` | Limits the number of users to retrieve. Optional but paired with offset. | `/users?limit=10&offset=0` |
| `NoPermissions` | Excludes permissions from the [user object](#user-object). Optional. | `/users?NoPermissions` |
| `LastLoginTimestamp` | Includes last-login timestamp of the [user object](#user-object). Optional. | `/users?LastLoginTimestamp` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [user objects](#user-object) if the caller has permission to GET all users.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET all users.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:21:47 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "newuseremail@gmail.com",
        "fullName": "",
        "id": "3167859736",
        "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "permissions": []
    },
    {
        "email": "existinguseremail@gmail.com",
        "fullName": "olduser",
        "id": "3407735538",
        "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "permissions": [
            {
                "access": "___admin",
                "oid": {
                    "type": "Domain",
                    "id": "0000000000"
                }
            }
        ]
    },
    ...
]
```

##### Example with options

```
curl 'https://mydomain.exosite.com/api/portals/v1/users?offset=0&limit=10&NoPermissions&LastLoginTimestamp' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:21:47 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8

[
    {
        "email": "newuseremail@gmail.com",
        "fullName": "",
        "id": "3167859736",
        "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "lastLoginTimestamp": null
    },
    {
        "email": "existinguseremail@gmail.com",
        "fullName": "olduser",
        "id": "3407735538",
        "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
        "meta": null,
        "phoneNumber": "",
        "activated": true,
        "groups": [],
        "lastLoginTimestamp": 1416190210
    },
    ...
]
```

#### Get all user portals

`GET /api/portals/v1/users/{user-id}/portals`

Get a user's permissions to portals he owns or was shared to by other users.

##### Permissions

* User can get permissions on portals he owns or was shared to by other users.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `options` | Includes a `Devices` item in the [portal object](#portal-object), which includes an array of device RIDs. The supported option is `devices`. Optional. | `/users/{user-id}/portals?options=devices` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned if the user's portals were GET successfully, along with an array of [Portal objects](#portal-object). Portal objects contain the following keys:
    * `"PortalName"` - Portal name.
    * `"PortalID"` - Portal ID.
    * `"PortalRID"` - Portal RID.
    * `"UserEmail"` - The user's email.
    * `"Description"` - Portal description.
    * `"Permissions"` - User’s permission for the Portal. Possible values are:
        * `"___admin"` - user is the Portal’s direct owner.
        * `"p_manage"` - user has manager access to the Portal. This permission grants the same rights as owner.
        * `"p_m_crea"` - user has create device access to the Portal.
        * `"p_contac"` - user has receive alerts access from the Portal.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's portals.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:36:45 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 339
Content-Type: application/json; charset=UTF-8

[
    {
        "PortalName": "",
        "PortalID": "2853566858",
        "PortalRID": "6800e1ee0948d39744625990d28d360f78ac2e4d",
        "UserEmail": "useremail@gmail.com",
        "Description": "Default Portal",
        "Permissions":[{"access":"___admin"}]
    },
    {
        "PortalName": "",
        "PortalID": "2978406756",
        "PortalRID": "dd6e30fe1a00a9718b919ccd93601ff10310238b",
        "UserEmail": "useremail@gmail.com",
        "Description": "Default Portal"
        "Permissions":[{"access":"p_manage"}
    }
    ...
]
```

#### Example with options

```
curl https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals?options=devices \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
[
  {
    "PortalName": "",
    "PortalID": "2853566858",
    "PortalRID": "6800e1ee0948d39744625990d28d360f78ac2e4d",
    "UserEmail": "useremail@gmail.com",
    "Description": "Default Portal",
    "Permissions":[{"access":"___admin"}]
    "Devices":["acf4838d1aa26e00ae834c1ab67884e21137c1b7","c36ec9302b2fa9b43772ba7a72da3e74efb3dc92"]
  },
  {
    "PortalName": "",
    "PortalID": "2978406756",
    "PortalRID": "dd6e30fe1a00a9718b919ccd93601ff10310238b",
    "UserEmail": "useremail@gmail.com",
    "Description": "Default Portal"
    "Permissions":[{"access":"p_manage"}
    "Devices":[]
  }
  ...
]
```

#### Get user

`GET /api/portals/v1/users/{user-id}`

Get information on a user.

If you want to get more than one user information can refer to [Get multiple users](#get-multiple-users).

##### Permissions

* User can get his own portals information.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Query String

| String | Description | Example |
|:-------|:------------|:---------------|
| `LastLoginTimestamp` | Includes last-login timestamp of the [user object](#user-object). Optional. | `/users?LastLoginTimestamp` |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing a [user object](#user-object) if the caller has permission to GET the user.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:18:40 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
    "email": "newuseremail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions": []
}
```

##### Example with options

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736?LastLoginTimestamp' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:18:40 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 172
Content-Type: application/json; charset=UTF-8

{
    "email": "newuseremail@gmail.com",
    "fullName": "",
    "id": "3167859736",
    "rid": "72ab11cdb1b5025e0f8ae8fe78b1c0c949751090",
    "meta": null,
    "phoneNumber": "",
    "activated": true,
    "groups": [],
    "permissions": [],
    "lastLoginTimestamp": 1416190210
}
```

### Get user through readtoken

`GET /api/portals/v1/users/{user-id}?readtoken={user-readtoken}`

Get information on a user by a readtoken.

* The token expires in 5 mins once it's generated.

##### Permissions

* User must have a readtoken.

#### Request

* Request body is empty.
* Requires authentication.

#### Response

* `200 OK`: Returned along with a body containing a [user object](#user-object) if the caller has permission to GET the user.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user.

#### Example

```
curl  https://mydomain.exosite.com/api/portals/v1/users/3167859736?readtoken=kDRv-JHtAjeECWSineeCRTVM-ZZyVUjpwrWLKc3DFuAjOokBcXrxtHQJ-immZyyRZbco9rG_TuOGqPpx1MRw5cvPgfEO \
      -H 'Content-Type: application/json' \
      -u 'domainuseremail@gmail.com:domainuserP4ssword' \
      -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:18:40 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 144
Content-Type: application/json; charset=UTF-8

{
  "email":"doaminUser1@gmail.com",
  "fullName":"doamin User1",
  "id":"3167859736",
  "rid":"fc7830446d5053abd0c212294764bb23bdedf0dd",
  "meta":null,
  "phoneNumber":"09123456789",
  "userName":"doaminUser1@gmail.com",
  "activated":true,"groups":[],
  "permissions":[{"access":"___admin","oid":{"type":"Portal","id":"3349395467"}}]
}
```

#### Get user token

`GET /api/portals/v1/users/{user-id}/token`

Get a Portals user token. This token can be used to log into a domain or call APIs.

* The token expires in 30 days once it's generated.

##### Permissions

* User can get his own token.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request string.
    * `"reDirect"` - the URL to reDirect to if login fails.

* Request body is empty.

##### Response

* `200 OK`: Returned if the token was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's token.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

* Create a token

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/token\?reDirect\=http%3A%2F%2Fwww.google.com.tw%2F' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:39:27 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 16
Content-Type: application/json; charset=UTF-8

"MzE2Nzg1OTczNq=="
```

* To use a token, put the token in the Authorization field as shown below, response content has been skipped for clarity:

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this' \
     -H 'Authorization: Token MzE2Nzg1OTczNq==' \
     -i
```

```
HTTP/1.1 200 OK
Date: Fri, 21 Nov 2014 08:00:10 GMT
Status: 200 OK
Vary: Accept-Encoding
Transfer-Encoding: chunked
Content-Type: application/json; charset=UTF-8
```

### Get user readtoken

`GET /api/portals/v1/users/{user-id}/readtoken`

Get a user's readtoken, which allows others to get information on the user without domain admin permission.

* The token expires in 5 mins once it's generated.

##### Permissions

* User can get his own readtoken.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

#### Request

* Request body is empty.
* Requires authentication.

#### Response

* `200 OK`: Returned if the readtoken was created successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's readtoken.
* `404 Not Found`: Returned if the user id is invalid.

#### Example

```
curl  https://mydomain.exosite.com/api/portals/v1/users/3167859736/readtoken \
      -u 'useremail@gmail.com:userP4ssword' \
      -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:39:27 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

"kDRv-JHtAjeECWSineeCRTVM-ZZyVUjpwrWLKc3DFuAjOokBcXrxtHQJ-immZyyRZbco9rG_TuOGqPpx1MRw5cvPgfEO"
```

#### Get user token for OpenID user

`GET /api/portals/v1/users/_this/token`

Get a Portals user token. This token can be used to log into a domain or call APIs.

* If the OpenID user is a new user to the domain, an account and portal will be created, then a token from Exosite will be granted.

* If the OpenID user is an existing user to the domain, a token from Exosite will be granted.

* A new account will only be created if settings are as follows:
    * Moderate New User Signup under /admin/moderate is set to **OFF**.
    * A default plan is set via **Assign a default plan for the following: -- Please Select Plan --**  under Signup Configuration at /admin/plans.
![Find Default Plan](images/find_default_plan.png)

* The token expires in 30 days once it's generated.

##### Permissions

* Only support the OpenID Connect user of Google for App.

##### Request

* Request header must include some information for authorization.
    * What is the Oauth/OpenID server? (E.g. Google)
    * What is the user's short-lived authorization code from the authorization server?
* Request body is empty.

##### Response

* `200 OK`: Returned along with a body containing an array of [user objects](#user-object) if the new user was created successfully. The new user will receive an email with a randomly generated password.
* `202 Accepted`: Returned if the new user was created successfully with `X-User-Agent` in the request header. The new user will receive an activation email.
* `400 Bad Request`:
    * Returned if Moderate New User Signup under /admin/moderate is set to **ON**.
    * Returned if no default plan was set for **Automatically create a Portal for any user who signs up from another domain** under /admin/configuration.
    * Returned if authorization is invalid.
* `409 Conflict`:
    * Returned if the email has already been registered and is awaiting activation.
    * Returned if there is already an account in the domain with the same email.

##### Example

* Create a token

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/token' \
     -H 'Authorization: Google 4/S39q1GijhAxDVtx5Dwhh-9kpYBvcVj1IFMFc.4vbo5d2l_AdgKnQAx0j5UqlQI' \
     -X GET \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:39:27 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 16
Content-Type: application/json; charset=UTF-8

"MzE2Nzg1OTczNq=="
```

#### Get user data storage

`GET /api/portals/v1/users/{user-id}/ds/{subdirectory}`

Get information on a user's data storage.

##### Permissions

* User can get information on his own data storage.
* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing the content if the user's data storage was GET successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's data storage.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the subdirectory is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Fri, 22 May 2015 09:01:46 GMT
Content-Type: application/json
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

{"myTest":"123123"}
```

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds/apple/456' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Fri, 22 May 2015 09:03:54 GMT
Content-Type: image/png
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

�PNG

:���s���=;�q���t�'�)��x����n�M����63��4�d��]��;wd�oݖ�as������gj����j=��D����Ԅ�KO��_
```

#### Get user data storage list

`GET /api/portals/v1/users/{user-id}/ds/{subdirectory}/*`

Get the user's data storage list.

##### Permissions

* User can get his own data storage list.
* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of data storages if the caller has permission to GET the user's data storage list.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's data storage list.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds/*' \
     -X GET \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Fri, 22 May 2015 09:15:10 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

["apple","dog"]
```

#### Create user data storage

`POST /api/portals/v1/users/{user-id}/ds/{subdirectory}`

Create a data storage under the portal.

##### Permissions

* User can set his own data storage.
* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Request

* Request body is the value you want to set
* Request header must contain one of following as content type:
    * `application/json`
    * `text/plain`
    * `image/gif`
    * `image/jpg`
    * `image/png`
    * `image/bmp`
    * `image/jpeg`
    * `application/octet-stream`

* Requires authentication.

##### Response

* `201 Created`: Returned if the data storage was created successfully.
* `400 Bad Request`: Returned if Content-Type is not set.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to set the user's data storage.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds/dog' \
     -X POST \
     -H 'Content-Type: application/json' \
     -d '{"myTest":"1231443534523"}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 201 Created
Date: Fri, 22 May 2015 09:16:10 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2
```

##### Example of file upload

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds/dog' \
     -X POST \
     -H 'Content-Type: image/png' \
     -F myfile=@"/Volumes/exosite/review/public/static/png/bullet_go.png" \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 100 Continue

HTTP/1.1 201 Created
Date: Fri, 22 May 2015 09:03:31 GMT
Content-Type: application/json; charset=UTF-8
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2
```

#### Delete user data storage

`DELETE /api/portals/v1/users/{user-id}/ds/{subdirectory}`

Delete a user's data storage.

##### Permissions

* User can delete his own data storage.
* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the directory was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the user's directory.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the subdirectory is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/_this/ds/dog' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Fri, 22 May 2015 09:33:28 GMT
Content-Type: application/json; charset=UTF-8
Connection: keep-alive
Keep-Alive: timeout=2
```

#### Get user Portal

`GET /api/portals/v1/users/{user-id}/portals/{portal-id}`

Get information on a Portal owned by a user.

##### Permissions

* User can get his own Portal.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with an array of [Portal objects](#portal-object) if the caller has permission to GET the user's Portal. Portal objects contain the following keys:
    * `"PortalName"` - Portal name.
    * `"PortalID"` - Portal ID.
    * `"PortalRID"` - Portal RID.
    * `"UserEmail"` - The user's email.
    * `"Description"` - Portal description.
    * `"Permissions"` - User’s permission for this Portal. Possible values are:
        * `"___admin"` - user is the Portal’s direct owner
        * `"p_manage"` - user has manager access to this Portal. This permission grants the same rights as owner.
        * `"p_m_crea"` - user has create device access to this Portal.
        * `"p_contac"` - user has receive alerts access from this Portal.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's Portal.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals/2123755496' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:45:53 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 168
Content-Type: application/json; charset=UTF-8

[
  {
    "PortalName": "demo1",
    "PortalID": "2123755496",
    "PortalRID": "2c233ace8411c2af9b51b23985f86da23c732c00",
    "UserEmail": "demo@gmail.com",
    "Description": "Default Portal",
    "Permissions": [
      {
        "access": "___admin"
      }
    ]
  }
]
```

#### Get user permissions

`GET /api/portals/v1/users/{user-id}/permissions`

Get a user's permissions.

##### Permissions

* User can get his own permissions.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Query string

| String | Description |        Example |
|:-------|:------------|:---------------|
| `type` | An array of permission types to retrieve. The supported types are `Domain`, `Portal`, `Device`, `DataSource`, and `Group`. Optional. | `users/{user-id}/permissions?type%5B%5D=Group` (Square brackets ([ and ]) are replaced with %5B and %5D respectively) |

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with a body containing an array of [permission objects](#permission-object) if the user's permissions were GET successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's permissions.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/permissions?type%5B%5D=Portal&type%5B%5D=Domain' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 08:45:53 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

[
  {
    "access": "___admin",
    "oid": {
      "type": "Domain",
      "id": "1231234567"
    }
  },
  {
    "access": "___admin",
    "oid": {
      "type": "Portal",
      "id": "2490770768"
    }
  }
]
```

#### Add user permissions

`POST /api/portals/v1/users/{user-id}/permissions`

Add one or multiple permissions to a user.

##### Permissions

* User must have at least `d_u_view` [permission](#permission-object) to the domain.
* User must have access to the [permission objects](#permission-object).

##### Request

* The request body is an array [permission objects](#permission-object).
* Requires authentication.

##### Response

* `202 Accepted`: Returned if the user's permissions were added successfully.
* `400 Bad Request`: Returned if request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have access to the [permission objects](#permission-object).
    * Returned if the caller does not have permission to add permissions to the user.
* `404 Not Found`: Returned if the user id is invalid.
* `409 Conflict`: Returned if the permissions already exist on the user.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/permissions' \
     -X POST \
     -d '[{"access":"d_u_list","oid":{"id":"1576946496","type":"Domain"}}]' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Tue, 18 Nov 2014 02:48:23 GMT
Status: 202 Accepted
Location: https://mydomain.exosite.com/api/portals/v1/users/3167859736/permissions
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

```

#### Delete user permissions

`DELETE /api/portals/v1/users/{user-id}/permissions`

Delete one or multiple permissions on a user.

##### Permissions

* User must have at least `d_u_view` [permission](#permission-object) to the domain.
* User must have access to the [permission objects](#permission-object).

##### Request

* The request body is an array [permission objects](#permission-object).
* Requires authentication.

##### Response

* `204 No Content`: Returned if the user permissions were deleted successfully.
* `400 Bad Request`: Returned if request body is invalid.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete user permissions.
    * Returned if the [permission objects](#permission-object) was deleted by other user and the callee user no longer has permissions on the object(s)
* `404 Not Found`: Returned if the user id is invalid.
* `409 Conflict`: Returned if the [permission objects](#permission-object) was deleted by the callee user and the user no longer has permissions on the object(s).

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/permissions' \
     -X DELETE \
     -d '[{"access":"d_u_list","oid":{"id":"1576946496","type":"Domain"}}]' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 02:48:23 GMT
Status: 204 No Content
Location: https://mydomain.exosite.com/api/portals/v1/users/3167859736/permissions
Vary: Accept-Encoding
Content-Type: application/json; charset=UTF-8

```

#### Get user profile picture

`GET /api/portals/v1/users/{user-id}/profile/picture`

Get a user's profile picture.

##### Permissions

* User can get his own profile picture.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty or picture.
* Requires authentication.

##### Response

* `200 OK`: Returned if the user's profile picture was GET successfully. The picture had previously been uploaded by user and was returned within the body of the request.
* `303 See Other`: Returned if the user's profile picture was GET successfully and the profile picture is the default system profile picture. The profile picture can be retrieved from the returned URL.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's profile picture.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/profile/picture' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 303 See Other
Date: Fri, 22 May 2015 06:21:16 GMT
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2
Location: https://mydomain.exosite.com/static/png/user-64x64.png
```

or

```
HTTP/1.1 200 OK
Date: Fri, 22 May 2015 06:31:31 GMT
Content-Type: image/png
Transfer-Encoding: chunked
Connection: keep-alive
Keep-Alive: timeout=2

▒PNG

IHDR%▒V▒PLTEA▒▒▒▒V▒
IDATx▒cb67|▒IEND▒B`▒
```

#### Get all users portals shares

`GET /api/portals/v1/users/{user-id}/portals/shares`

Get a user's owned portals and shared portals.

##### Permissions

* User can get his own portals and shared portals.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with an array of [Portal objects](#portal-object) if the caller has permission to GET the user's Portal shares.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's Portal shares.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals/shares' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:45:53 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 168
Content-Type: application/json; charset=UTF-8

[
  {
    "PortalName": "test group",
    "PortalID": "1173271281",
    "PortalRID": "2517727616d873727f5b838e9e9c6e656eaa4e27",
    "UserEmail": "demo2@gmail.com",
    "Description": "test group",
    "Shares": [
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1498682908",
          "email": "demo1@gmail.com"
        }
      },
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1838401279",
          "email": "demo4@gmail.com"
        }
      }
    ]
  },
  {
    "PortalName": "test0731",
    "PortalID": "3456260404",
    "PortalRID": "b463fb13f2ab8f61f415eddd7638fdd3e4ab9f76",
    "UserEmail": "demo2@gmail.com",
    "Description": "test0731",
    "Shares": [

    ]
  }
]
```

#### Get user Portal shares

`GET /api/portals/v1/users/{user-id}/portals/{portal-id}/shares`

Get a user's owned portals and Portal shares.

##### Permissions

* User can get his own portals and Portal shares.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `200 OK`: Returned along with an array of [Portal objects](#portal-object) if the caller has permission to GET the user's Portal shares.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to GET the user's Portal shares.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the Portal id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals/1173271281/shares' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 200 OK
Date: Mon, 17 Nov 2014 09:45:53 GMT
Status: 200 OK
Vary: Accept-Encoding
Content-Length: 168
Content-Type: application/json; charset=UTF-8

[
  {
    "PortalName": "test group",
    "PortalID": "1173271281",
    "PortalRID": "2517727616d873727f5b838e9e9c6e656eaa4e27",
    "UserEmail": "demo2@gmail.com",
    "Description": "test group",
    "Shares": [
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1498682908",
          "email": "demo1@gmail.com"
        }
      },
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1838401279",
          "email": "demo4@gmail.com"
        }
      }
    ]
  }
]
```

#### Share user Portal

`POST /api/portals/v1/users/{user-id}/portals/{portal-id}/shares`

Share a Portal to another user.

##### Permissions

* User can share his own portals to another user.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is a [permission object](#permission-object), it contains the following keys:
    * `"access"` - User’s permission for this Portal. Possible values are:
        * `"p_manage"` - user has manager access to this Portal. This permission grants the same rights as the owner.
        * `"p_m_crea"` - user has create device access to this Portal.
        * `"p_contac"` - user has receive alerts access from this Portal.
    * `"oid"` - The information of the user. The object contain the following keys:
        * `"id"` - Id of the user who are being shared with this Portal.
        * `"type"` - The general value is **User**.

* Requires authentication.

##### Response

* `202 Accepted`: Returned along with information on the Portal share if the Portal was shared successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to share the Portal.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the Portal id is invalid.
* `409 Conflict`: Returned if the Portal has already been shared to the user.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals/1173271281/shares' \
	 -X POST \
     -d '{"access": "p_manage","oid":{"type":"User","id":"1498682908"}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 202 Accepted
Date: Mon, 17 Nov 2014 09:45:53 GMT
Status: 202 Accepted
Vary: Accept-Encoding
Content-Length: 168
Content-Type: application/json; charset=UTF-8

[
  {
    "PortalName": "test group",
    "PortalID": "1173271281",
    "PortalRID": "2517727616d873727f5b838e9e9c6e656eaa4e27",
    "UserEmail": "demo2@gmail.com",
    "Description": "test group",
    "Shares": [
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1498682908",
          "email": "demo1@gmail.com"
        }
      },
      {
        "access": "p_manage",
        "oid": {
          "type": "User",
          "id": "1838401279",
          "email": "demo4@gmail.com"
        }
      }
    ]
  }
]


```

#### Delete user Portal share

`DELETE /api/portals/v1/users/{user-id}/portals/{portal-id}/shares`

Unshare a Portal from another user.

##### Permissions

* User can unshare his own Portal from another user.
* User must have at least `d_u_view` [permission](#permission-object) to the domain.

##### Request

* Request body is a [permission object](#permission-object). The object contain the following keys:
    * `"access"` - User’s permission for this Portal. Possible values are:
        * `"p_manage"` - user has manager access to this Portal. This permission grants the same rights as owner.
        * `"p_m_crea"` - user has create device access to this Portal.
        * `"p_contac"` - user has receive alerts access from this Portal.
    * `"oid"` - The information of the user. The object contain the following keys:
        * `"id"` - Id of the user who are being shared with this Portal.
        * `"type"` - The general value is **User**.

* Requires authentication.

##### Response

* `204 No Content`: Returned if the Portal was unshared successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to unshare the Portal.
* `404 Not Found`:
    * Returned if the user id is invalid.
    * Returned if the Portal id is invalid.
* `409 Conflict`: Returned if the Portal has already been unshared from the user.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736/portals/1173271281/shares' \
	 -X DELETE \
     -d '{"access": "p_manage","oid":{"type":"User","id":"1498682908"}}' \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 07:34:30 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8

```

#### Delete user

`DELETE /api/portals/v1/users/{user-id}`

Delete a user who has no Braintree ID, no Portal or no discount.

##### Permissions

* User must have at least `d_u_list` [permission](#permission-object) to the domain.

##### Request

* Request body is empty.
* Requires authentication.

##### Response

* `204 No Content`: Returned if the user was deleted successfully.
* `403 Forbidden`:
    * Returned if the caller is not authenticated.
    * Returned if the caller does not have permission to delete the user.
* `400 Bad Request`:
    * Returned if the user owns any resourcse.
    * Returned if the user does not exist on the current domain.
* `404 Not Found`: Returned if the user id is invalid.

##### Example

```
curl 'https://mydomain.exosite.com/api/portals/v1/users/3167859736' \
     -X DELETE \
     -u 'useremail@gmail.com:userP4ssword' \
     -i
```

```
HTTP/1.1 204 No Content
Date: Tue, 18 Nov 2014 07:34:30 GMT
Status: 204 No Content
Vary: Accept-Encoding
Content-Length: 0
Content-Type: application/json; charset=UTF-8
```
