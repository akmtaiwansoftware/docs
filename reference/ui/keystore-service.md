---
title: Record Product Metrics
template: default
---

# Record Product Metrics

A common need when managing a fleet of devices is to track metrics and error logs. This guide demonstrates how to use Murano's [Keystore service](../../services/keystore#) to [collect metrics](#collect-metrics) and [expose those metrics](#expose-metrics) from a custom API endpoint.

# Prerequisites

* A Murano account with a solution is required. To create a solution, you can follow the [Solution Quickstart](/quickstarts/solutions/exampleapp/).


# Collect Metrics

A first step for monitoring your device fleet is to collect information from devices. To keep things simple, you can collect two types of data about incoming messages from devices.

* The number of messages per day
* The contents of the last 10 messages

Murano solutions provide a [datapoint event](/reference/services/device/#datapoint) that gives you an opportunity to respond to incoming device data. When handling datapoints you may perform data conversion, store data, or send alerts. You may modify the way your solution responds to data by editing the handler for the datapoint event in Murano's web-based code editor or by uploading code using the command line tool. 

For the purpose of this guide, you can use the web-based editor. To modify the datapoint event handler, click on the *SERVICES* tab of your solution, select *Products*, and select the code tab. The code found here is executed when any devices with product types associated with the solution send data. You can now add code to store metrics to the Keystore service.

![web-based-editor](../assets/point-event.png)

## Increasing a Daily Metric Counter

To make a daily counter, you can use `incrby` command. This command adds one to the `"dailyCount"` key, setting it to 1 if the key does not already exist. It does so atomically, so you will not miss any incoming data points.

```lua
Keystore.command({ command = "incrby", key = "dailyCount", args = {1}})
```

To only keep the count for the current day, you can take advantage of the expire command which will automatically handle the value expiration at the given time.

```lua
-- Tomorrow midnight timestamp in seconds
local expiration = math.floor(1 + os.time()/86400) * 86400

-- Set the expiration time for next day midnight
Keystore.command({ command = "expireat", key = "dailyCount", args = {expiration} })
```

## Log the Last 10 Messages from the Device

To log message content from your devices, you can use the [data.value event argument](../../services/device/#datapoint) provided to the datapoint event handler. The first value found in data.value is the message timestamp, and the second is the message itself. (Note that in most cases, you would want to also filter on `data.alias` rather than log all messages.)

```lua
local message = data.value[2]
```

Next you will push the message to a list in the `Keystore` service using the `lpush` command. This will allow you to see the last few device messages, which can be useful for debugging.

```lua
Keystore.command({ command = "lpush", key = "logs", args = {message}})
```

Keep only the last log items with the trimming command by specifying a range of data to keep. Note that the list index starts at 0.
Therefore, in order to keep the last 10 logs, the target list range index is 0 to 9.

```lua
Keystore.command({ command = "ltrim", key = "logs", args = {0, 9}})
```

## All Together

Here is the point event code in its entirety.

```lua

local message = data.value[2]

-- Increment the counter
Keystore.command({ command = "incrby", key = "dailyCount", args = {1}})

-- Tomorrow midnight timestamp in seconds
local expiration = math.floor(1 + os.time()/86400) * 86400

-- Set the expiration time for next day midnight
Keystore.command({ command = "expireat", key = "dailyCount", args = {expiration} })

-- Push the new message to the logs list, not in lua the first element start at index 1
Keystore.command({ command = "lpush", key = "logs", args = {message}})

-- Only keep the last 10 logs, the trim command requires a range of index to keep (starting with 0).
Keystore.command({ command = "ltrim", key = "logs", args = {0, 9}})

```

# Expose Metrics

The easiest way to expose our collected data is to create an API route endpoint. Endpoints can be created with the "+" button on the *ROUTES* tab of your solution. When you create a new route, you will be prompted to specify the path and HTTP method for the route. Create a new route in your solution with the Method `GET` and the Path `/metrics`.

Once the route is created, you can write an endpoint script which runs when your API route endpoint is called. You can learn more about endpoint scripts on the [Webservice reference page](../../services/webservice).

Exposing the count only requires you get the counter value store in the `Keystore` service with the `get` operation.

```lua
  local dailyCount = Keystore.get({ key = "dailyCount" })
```

Logs can use the `lrange` command which return a range of elements from the list. Note that `{0, -1}` indicates you want everything from the most recent log entry (`0`) to the oldest log entry (`-1`).

```lua
  local logs = Keystore.command({ command = "lrange", key = "logs", args = {0, -1}})
```

To make the endpoint return the values of `dailyCount` and `logs`, you can simply return them in a Lua table. 

```lua
return { dailyCount = dailyCount.value, logs = logs.value }
```

This works because endpoint scripts return a 200 HTTP status code by default, and Lua tables are automatically transformed into JSON response bodies. However, you could also set these manually by setting `response.code` and `response.body` instead.

## All Together

Here is the API route endpoint code in its entirety:

```lua

-- Get the dailyCount value
local dailyCount = Keystore.get({ key = "dailyCount" })

-- Get the last n logs, -1 means all items
local logs = Keystore.command({ command = "lrange", key = "logs", args = {0, -1}})

-- Reponse a 200 HTTP response with a JSON body object
return { dailyCount = dailyCount.value, logs = logs.value }

```

# Generate Some Product Data

To test your scripts, you need to send data from your device to Murano. Here is how to do that:

1. Create a Product or use an existing one from the Murano portal and note its product ID.
2. If you create a new Product, be sure to add it to the Products configuration under the SERVICES tab of the solution.
3. Add a resource under the DEFINITION tab. For example, you could create a resource with the Alias "message" and Data format "string".
4. Create a device on the DEVICES panel and note its identity.
5. Activate the device to get the device key (CIK). A simple HTTP request on the provisioning API will do. Normally this step is done by a device, but here is how to do that using curl. (Be sure to substitute the items in brackets with your values.)

```
curl https://<product_id>.m2.exosite.com/provision/activate \
-H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
-d "vendor=<product_id>&model=<product_id>&sn=<identity>"
```

The CIK for the device is returned. See the [activate API](/reference/products/device-api/http/#activate) documentation for more about the activation step.

With the CIK in hand you are ready to write data. If you do not have a physical device, you can simulate one by sending data using the [write API](../../products/device_api/http#write). Here is how to do that using curl. Again, be sure to substitute the items in brackets with your values.

```
curl https://<product_id>.m2.exosite.com/onep:v1/stack/alias \
-H "X-Exosite-CIK: <CIK>" \
-H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" \
-d "<resource_alias>=<value>"
```

Here is an example, assuming a product ID of m0a6fwvjl7x8ncdi and device ID of 001.

```
$ curl https://m0a6fwvjl7x8ncdi.m2.exosite.com/provision/activate -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" -d "vendor=m0a6fwvjl7x8ncdi&model=m0a6fwvjl7x8ncdi&sn=001"
029c56108afffc2507e3ffb0aeed105dd6c39922

$ curl https://m0a6fwvjl7x8ncdi.m2.exosite.com/onep:v1/stack/alias -H "X-Exosite-CIK: 029c56108afffc2507e3ffb0aeed105dd6c39922" -H "Content-Type: application/x-www-form-urlencoded; charset=utf-8" -d "message=hello world"
```

# Test

You can now retrieve your metrics data by opening the `/metrics` endpoint you defined in your web browser. For example, if your solution name was `my-iot-solution`, then you would go to this address:

```
https://my-iot-solution.apps.exosite.io/metrics
```

Your metrics data looks like this:

```JSON
{
  "dailyCount": "1",
  "logs": [ "hello world" ]
}
```

You should now be able to use the Murano Keystore service to track product metrics for your connected devices.
