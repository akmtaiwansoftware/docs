---
title: Working with APIs
template: default
---

# Working with APIs

* [Overview & References](#overview)
* [Service Call](#service-call)
* [Script Execution & Event Handlers](#script-execution)
* [API Endpoint Scripts](#api-endpoint-scripts)
* [Websocket Scripts](#websocket-endpoints)
* [Writing Modules](#modules)
* [Troubleshooting](#troubleshooting)
* [Script Environment](#script-environment)

# Overview

Exosite's [Murano]() platform is an event-driven system that uses scripts to route data and perform application logic and rules. These scripts have a rich set of capabilities and are used to perform such actions as storing device data into a time series data store, offloading processing from your devices, and handling Solution Application API requests. These scripts have access to all of the Murano services. A reference for each of these services and their functionality can be found here: [Service Reference](services)

Scripts are written in Lua, on the LuaJIT VM, which is Lua 5.1 with [some 5.2 features](http://luajit.org/extensions.html#lua52).
For general information about Lua 5.1, please refer to the [online Lua manual](http://www.lua.org/manual/5.1/).

Scripts may be added to a Solution by using either the [Murano admin UI](https://www.exosite.com/business/solutions) or by
using the [Exosite Command Line Interface](../development/tools/exosite-cli).


### Examples

Examples of Murano Lua scripts are made available in the following projects:

* [Example Platform Scripts Repository](https://github.com/exosite/murano-examples/tree/master/solutions/simple_graph)
* [Example of Home Automation Solution Using Murano](https://github.com/exosite/home-automation-example)

---

# Service Call

The besides native Lua scripting, Murano script offers direct access to high level service, providing extended functionalities. For example Murano has a service for sending emails.

To send an email, a service operation call can be made from the Lua script by using the service alias with a capitalized first letter followed by the operation to call.

#### Example

```lua
locale result = Email.send({to="my@friend.com", subject="Hello", text="World"})
```

The list of services, operations, arguments and response are defined for each services on [Murano Services page](services).

### Error handling

If for any reason the service call failed the following Lua Table is returned to the script:
```lua
{
  "error": "Error details, typically the Service response as a string",
  "status": 400, -- The http status code
  "type": "QueryError" -- Either QueryError or ServerError
}
```

---

# Script Execution

The Murano Lua scripts are executed in reaction to a system event, which are defined by [Murano services](services) events.

For example, a [message is received from an IoT device](../../reference/services/device/#datapoint) or an
HTTP request is made on your [Custom API endpoint](../../reference/services/webservice/#request).

Those events will trigger the execution of one or more **event_handler script(s)** defined
in your solution. One **event_handler script** always targets a single [Murano services](services) event.

On the [Murano Portal](https://www.exosite.com/business/solutions) you can define event script under the Solutions *Services* tab.
If you are using the [Exosite client tool](../development/tools/exosite-cli), you can define the event script in the
[event_handler folder](https://github.com/exosite/home-automation-example/tree/master/event_handler) of your project
by using the service _Alias_ as the file name.

## Event Handler Context

During execution, **event handler scripts** are wrapped in a handler function corresponding to
the [Murano Services](services) event. The event handler function will expose arguments defined by the Murano service event.

**Important:** Murano **event handler scripts** share the same context within a solution.
Therefore, the use of the _local_ keyword is highly recommended for every function and variable definitions to avoid a potential overlapping issue.

### Example

**Incoming data from an IoT device** are triggered by the [Device service datapoint event](../../reference/services/device/#datapoint) which
defines a _data_ parameter for the event handler context. The wrapper function will therefore be:

```lua
function handle_device_datapoint (data)
  -- Here goes your device data handler script
end
```

So when your **event handler script** defines:

```lua
print(data.pid)
```

The final execution script will look like the following:

```lua
function handle_device_datapoint (data)
  print(data.pid)
end
```

## API Endpoint Scripts

For convenience, Murano offers the option to build your custom HTTP API by defining endpoint scripts.

**Endpoint scripts** are automatically wrapped in a simple routing mechanism based on the [Webservice Murano service](../../reference/services/webservice)
set within the event handler for the ["request" event](../../reference/services/webservice/#request).
As for a regular Service event handler, the script will receive the [request event arguments](../../reference/services/webservice/#request)
containing the HTTP request data.

An extra *response* argument is provided to the **endpoint script** context allowing a compact response syntax.

The _response_ object content:

<table class="table table-bordered table-condensed">
<tr>
<th>attribute</th>
<th>type</th>
<th>default value</th>
<th>description</th>
</tr>
<tr>
<td>**code**</td>
<td>_integer_</td>
<td>200</td>
<td>The response HTTP status code.<br />If any exception occurs, a 500 is returned.</td>
</tr>
<tr>
<td>**message**</td>
<td>_string_ or _table_</td>
<td>"Ok"</td>
<td>The HTTP response body. If a Lua table is given, the routing wrapper will automatically encode it as JSON object.</td>
</tr>
<tr>
<td>**headers**</td>
<td>Table of _string_</td>
<td>"content-type" = *text/plan* or *application/json*</td>
<td>The HTTP response headers depend on message type.</td>
</tr>
</table>

### Example

```lua
response.headers = {} -- optional
response.code = 200 -- optional
response.message = "My response to endpoint " .. request.uri
```

or

```lua
return "My response to endpoint " .. request.uri
```

### Endpoints Functions Context

Under the hood, endpoints scripts are stored in an *_endpoints* table used by the [Webservice "request"](../../reference/services/webservice/#request) event handler.
So the final API script will be:

```lua
local _endpoints = {
    ["get_/myendpoint"] = function (request, response)
      -- endpoint script
      return "My response to endpoint " .. request.uri
    end
}
function handle_webservice_request(request)
  ... -- default routing mechanism
end
```

## Websocket Endpoints

Websocket endpoints are handled in a similar manner as webservice endpoints based on [Websocket Murano service](/reference/services/websocket).
The function context includes the [websocketInfo](/reference/services/websocket/#websocket_info) as well as a _response_ arguments.
The _response.message_ content will be automatically sent back to the websocket channel.

```lua
response.message = "Hello world"
```

Or you can directly pass the message as function result:

```lua
return "Hello world"
```

In addition, you can also interact with the websocket channel with the following functions:

```lua
websocketInfo.send("Hello") -- Send a message to the channel.
websocketInfo.send("world") -- Useful to send back multiple messages.
websocketInfo.close() -- Close the websocket connection
```

### Websocket Endpoints Functions Context

Similar to the webservice endpoints, websockets are stored in the *_ws_endpoints* table. And final script at execution will be:

```lua
local _ws_endpoints = {
    ["/mywebsocketendpoint"] = function (websocketInfo, response)
      -- websocket endpoint script
      return "My response to endpoint " .. request.uri
    end
}
function handle_websocket_websocket_info(websocketInfo)
  ... -- default routing mechanism
end
```

---

# Modules

Murano recommends the use of a reusable block of Lua code. For this purpose, you can define Lua modules from
the [module folder](https://github.com/exosite/home-automation-example/tree/master/modules) of your project.

Murano modules diverge from standard Lua modules as they are automatically added to the solution script and do not need to be manually included in other scripts.

## To Keep in Mind About Modules

* **Naming:** To avoid confusion with Murano services, use a lowercase first letter.
* **Context isolation:** Murano modules do not have a specific context isolation from other Modules of the solution, and the _local_ keyword is highly recommended for every function and variable definitions to avoid potential overlapping issue. As a best practice, wrap your module in an object named after your module name.
* **Loading order:** currently loading order between modules is not ensured and cross-Modules reference is to be avoided.

### Example

**Module**
```lua
myModule = {} -- Module object accessible withing all event handler scripts of the solution

function myModule.hello()
    local localModuleVariable = "World"
    return localModuleVariable
end
```
**Usage**
```lua
   -- In Endpoint script
   return myModule.hello()
```

---

# Troubleshooting

The Lua script execution is recorded in the solution logs and is accessible through the solution management console under the *LOG* panel.

Two different types of logs are available:


## *[script log]*

Contains the Lua script execution result.

#### Request Content

* *solution_id:* Active solution ID
* *event_type:* The event that triggered the script execution. In the format of ```{ServiceAlias}_{EventName}```
* *script_parameters:* JSON object containing the input parameters of the script

#### Response Content

* *status_code:* HTTP status code representing the Lua script execution status
* *result.result:* "ok" or "error"
* *result.error:* Execution error if any
* *result.execution_time:* Script execution time in ms
* *result.script_output:* Content logged with the *print(..)* function

#### Example

A log from the script execution triggered by a [Webservice request event](../../reference/services/webservice/#request).
```
[script log] 2016-07-12T09:21:40.350+00:00
--------- request: solution_id=mySolutionId, event_type=webservice_request, script_parameters={"body": {}, "route": "/user/{email}/lightbulbs", .. }
--------- response: status_code=200, result={"error": "", "result": "ok", "execution_time": "110.103996ms", "script_output": "200"}
```


### *[service call log]*

Log of Murano services calls. Example: a key value is stored or a websocket message is sent.

#### Request Content

* *solution_id:* Active solution ID
* *service_alias:* Target service alias
* *function_call:* Target service function
* *arguments:* JSON object containing the parameters

#### Response Content

* *error:* Execution error if any
* *status:* Service call HTTP status code
* *result:* Service call response data

#### Example

Log from the call to the [Webservice request operation](../../reference/services/webservice/#apiReply).
```
[service call log] 2016-07-12T09:21:40.464+00:00
--------- request: {"arguments": {"code": 200, "headers": {}, "message": "[]", ..}, "function_call": "apiReply", "service_alias": "Webservice", "solution_id": "mySolutionId"}
--------- response: {"error": "", "result: "", "status": 204}
```

---

# Script Environment

Scripts are executed in their own sandboxed instance of the Lua VM to keep them isolated
from each other. Each script has access to all [Murano Services](services), but access
to those services is authenticated based on your solution.

Each script execution is resource constrained. Currently that translates into 1MB of
RAM and 64k Lua instructions.

While memory usage is easy to reason about, a Lua instruction limit is not so clear-cut.
If you are not sure what a Lua instruction is, intuitively you could view it as correlated to
CPU usage, although it is not a direct correlation—in short, it represents how much work your
script performs. Lua is a stack-based virtual machine, and its instruction set is similar to assembly
in some respects. Thus Lua instructions are primitive operations on the stack and the registers in
each stack frame, as well as primitives for boolean logic and arithmetic. Examples of
such instructions are: LOADNIL, LOADK, MOVE, ADD, SUB, MUL, POW, LEN, JMP, EQ, and many more.

The limit is only enforced for instructions executed.

In cases where either limit is exceeded, your script will immediately fail with an error message
explaining why. If you are curious how Lua 5.1 memory management works, please see the following
references:

- [Garbage Collection](http://www.lua.org/manual/5.1/manual.html#2.5)
- [Visibility Rules](http://www.lua.org/manual/5.1/manual.html#3.5)


## Lua Tables and Functions

The following global Lua tables and functions are available to Lua
scripts. They operate exactly as described in the Lua 5.1 reference manual.

* [`Basic Functions`](http://www.lua.org/manual/5.1/manual.html#5.1) (Note:
    the `dofile` function are not available to scripts.)

* [`string`](http://www.lua.org/manual/5.1/manual.html#5.4) (Note:
    the `string.dump` function are not available to scripts.)

* [`table`](http://www.lua.org/manual/5.1/manual.html#5.5)

* [`math`](http://www.lua.org/manual/5.1/manual.html#5.6)

* [`os`](http://www.lua.org/manual/5.1/manual.html#5.8) (Note:
    Only `os.difftime`, `os.date`, `os.time`, `os.clock` function are available to scripts.)


## Additional Global Tables, Functions, and Properties

In addition to the Lua system resources, the following global features are available to Lua scripts:

### to_json

Converts a Lua table to a JSON string.
This function is multi-return, the first value being the result,
and the second value being an error value. If the error value is nil,
then the conversion was successful, and the result can be used safely.

If non-nil, the error value will be a string.

```lua
local jsonString, err = to_json({})
if err ~= nil then
  print(err)
end

-- Or directly

local jsonString = to_json({})
```

### from_json

Converts a JSON string to a Lua table.
This function is multi-return, the first value being the result,
and the second value being an error value. If the error value is nil,
then the conversion was successful, and the result can be used safely.

If non-nil, the error value will be a string.

```lua
local luaTable, err = from_json("{}")
if err ~= nil then
  print(err)
end

-- Or directly

local luaTable = from_json("{}")
```

### bench.measure()

Returns the elapsed time to nanosecond precision as a human readable string. It may be used to do optimization of solution code. For example here's how to measure how long some code in a solution endpoint took to run.

```
elapsed = bench.measure(function ()
  -- do a couple things
    end)
return elapsed   -- returns, e.g., "122.145329ms"
```

`bench.measure()` will also return any parameters the function returns before the elapsed time. For example:

```
a, b, elapsed = bench.measure(function ()
  return "foo", 2 -- you can return how ever many values you want, adjust the assignment accordingly
  end)
print({a=a, b=b, elapsed=elapsed}) -- results in printing `map[a:foo,b:2,elapsed:44.406µs]`
```
