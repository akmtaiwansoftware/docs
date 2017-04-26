---
title: Murano OAuth
template: default
---

# Manage OAuth User

This document describes how to use the Murano User service to connect with an OAuth provider. This allows the end users of a solution to sign in using an existing identity such as Google or Facebook rather than using a username and password.

# Function

## createSocial
Description: Create a social.

Example:
```
User.createSocial({"consumer":"Google","client_id":"xxxxxxxxxx","client_secret":"xxxxxx","scope":["profile","email"],"redirect":"https://xxxxx.exosite.io/social/handle/Google"})
```

## getSocial
Description: Get social info.

Example:
```
User.getSocial({consumer="Google”})
```

## deleteSocial
Description: Delete a social.

Example:
```
User.deleteSocial({consumer="Google”})
```

## updateSocial
Description: Update the social info.

Example:
```
User.updateSocial({consumer="Google”,client_id=”213casdsad”})
```

## getSocialLoginUrl
Description: Get social login URL.

Example:
```
User.getSociaLoginUrl({consumer="Google”})
```
## getSocialToken
Description: Get social login token.

Example:
```
User.getSocialToken({consumer="Google”,code=”xxxxx”})
```

## socialRequest
Description: Request social get information.

Example:
```
User.socialRequest({consumer="Google”,token=”xxxxx”})
```

# Example

## Endpoints

First,create the two endpoints on your solution.

```
--#ENDPOINT GET /social/handle/{consumer}/loginurl
-- This endpoint will redirect you to the social consumer login auth pages
response.headers["location"] = User.getSocialLoginUrl({consumer=request.parameters.consumer})
response.code = 303
```

```
--#ENDPOINT GET /social/handle/{consumer}
-- This endpoint is social consumer callback url
-- Get token then request information
results, err = to_json(request.parameters)
resultd, err = from_json(results)
local tokenstr = User.getSocialToken(resultd)
response.message = User.socialRequest({consumer=request.parameters.consumer, token=tokenstr})
```

## Google

Create an app on Google: [https://console.developers.google.com/](https://console.developers.google.com/)

Go to Credentials and create a new credential. It should be an OAuth client ID with type "Web Application".

![image alt text](assets/oauth_0.png)	

Get the:
```
 ClientID => Client ID

 Client_secret => Client secret
```

Add callback URL.

![image alt text](assets/oauth_1.png)

Use websocket debug endpoint to add the google social connection.

```
Example: User.createSocial({"consumer":"Google","client_id":"xxxxxxxxxx","client_secret":"xxxxxx","scope":["profile","email"],"redirect":"https://sphx185.apps.exosite-dev.io/social/handle/Google"})
```

![image alt text](assets/oauth_2.png)

Test it:

Example: [https://sphx185.apps.exosite-dev.io/social/handle/Google/loginurl](https://sphx185.apps.exosite-dev.io/social/handle/Google/loginurl)

![image alt text](assets/oauth_3.png)￼￼￼

## Facebook

Create an app on Facebook: [https://developers.facebook.com/apps/](https://developers.facebook.com/apps/)

![image alt text](assets/oauth_4.png)

Get the:
```
 ClientID => App ID

 Client_secret => App Secret
```

![image alt text](assets/oauth_5.png)

Set the callback URL.

![image alt text](assets/oauth_6.png)

Use websocket debug endpoint to add the Facebook social.

    Example: User.createSocial({"consumer":"Facebook","client_id":"xxxxxxxxxx","client_secret":"xxxxxx","scope":["email","public_profile"],"redirect":"https://sphx185.apps.exosite-dev.io/social/handle/Facebook"})

![image alt text](assets/oauth_7.png)

Test it.

Example: [https://sphx185.apps.exosite-dev.io/social/handle/Facebook/loginurl](https://sphx185.apps.exosite-dev.io/social/handle/Facebook/loginurl)

![image alt text](assets/oauth_8.png)

Success!

![image alt text](assets/oauth_9.png)

## Amazon

Go to Amazon doc: [http://login.amazon.com/website](http://login.amazon.com/website)

Register your website as an Application on the App Console.

![image alt text](assets/oauth_10.png)

Get the: 
```
 ClientID =>  Client ID

 Client_secret => Client Secret
```

Use websocket debug endpoint to add the amazon social.

```
Example: User.createSocial({"consumer":"Amazon","client_id":"xxxxxxxxxx","client_secret":"xxxxxx","scope":["profile"],"redirect":"https://sphx185.apps.exosite-dev.io/social/handle/Amazon"})
```

![image alt text](assets/oauth_11.png)

Test it:

Example: [https://sphx185.apps.exosite-d](https://sphx185.apps.exosite-dev.io/social/handle/Amazon/loginurl)

[ev.io/social/handle/Amazon/loginurl](https://sphx185.apps.exosite-dev.io/social/handle/Amazon/loginurl)

![image alt text](assets/oauth_12.png)

Success!

![image alt text](assets/oauth_13.png)

## GitHub

Create a new application on Github: [https://github.com/settings/applications/new](https://github.com/settings/applications/new)![image alt text](oauth_14.png)

Get the:
```
 ClientID =>  Client ID

 Client_secret => Client Secret
```

![image alt text](assets/oauth_15.png)

Use websocket debug endpoint to add the GitHub social.

```
Example: User.createSocial({"consumer":"GitHub","client_id":"xxxxxxxxxxxx","client_secret":"xxxxxxxxxxxxxxx","scope":["user"],"redirect":"[https://sphx185.apps.exosite-dev.io/social/handle/GitHub](https://sphx185.apps.exosite-dev.io/social/handle/GitHub)"})
```

![image alt text](assets/oauth_16.png)

Test it:

Example:  [https://sphx185.apps.exosite-dev.io/social/handle/GitHub/loginurl](https://sphx185.apps.exosite-dev.io/social/handle/GitHub/loginurl)

![image alt text](assets/oauth_17.png)

![image alt text](assets/oauth_18.png)

## Twitter

**Note:** Twitter is using OAuth1, not OAuth2, so it is different.

First create the two endpoints on your solution.

```lua
--#ENDPOINT GET /Twitter/login
-- This endpoint will redirect you to the social consumer login auth pages
local qToken =  User.getSocialLoginUrl({consumer="Twitter"})
local url = User.getSocialLoginUrl({consumer="Twitter",reqToken=qToken})
response.headers = {
  ["location"] = url,
  ["Set-Cookie"] = "token=" .. qToken .. "; Path=/social/Twitter;"
}
response.code = 303
```

```lua
--#ENDPOINT GET /social/Twitter/handle
-- This endpoint is social consumer callback url
-- Get token then request information
local Headers = request.headers
local Token = string.gsub(Headers["cookie"], "token=(%w+)", "%1")
local params= request.parameters
params.reqToken = Token
params.consumer = "Twitter"
local aToken = User.getSocialToken(params)
response.message = User.socialRequest({consumer= "Twitter", token=aToken})
Create a new application on Twitter[ h](https://apps.twitter.com/)
```

![image alt text](assets/oauth_19.png)

![image alt text](assets/oauth_20.png)

![image alt text](assets/oauth_21.png)

Use websocket debug endpoint to add the GitHub social.

Example: User.createSocial({"consumer":"Twitter","client_id":"232131231","client_secret":"xxxxxxxxxxxxxxxxxx","redirect":"https://sphx185.apps.exosite-dev.io/social/Twitter/handle"})

![image alt text](assets/oauth_22.png)

Test it.

Example:  [https://sphx185.apps.exosite-dev.io/Twitter/login](https://sphx185.apps.exosite-dev.io/Twitter/login)

![image alt text](assets/oauth_23.png)

![image alt text](assets/oauth_24.png)

