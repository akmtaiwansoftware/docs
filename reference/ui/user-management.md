---
title: User Management
template: default
---

# Guide: Manage Users

Murano user management supports user authentication, role-based access control, and storage per user.

# Prerequisites

#### User Authentication
* Basic (email & password)
* Token based
* Social auth

#### User Permission
User permission is based on [RBAC](https://en.wikipedia.org/wiki/Role-based_access_control).
In this system, there are three concrete elements: &rsquo;role&rsquo;, &rsquo;user&rsquo;, and &rsquo;endpoint&rsquo;. According to RBAC, you can control a user&rsquo;s access to endpoint with the concept below:

1. Assign endpoint to role
2. Assign role to user
3. User can access the endpoint of their role

![User Diagram 1](../assets/user_1.png)

However, URL can be different in variable practically. For example, &rsquo;*device/1/info*&rsquo; and &rsquo;*device/2/info*&rsquo; are different literally but can be considered the same endpoint. You do not want to create two endpoints for such a difference. That is why the fourth element called &rsquo;parameter&rsquo; is added.

&rsquo;Parameter&rsquo; represents a specific resource by name and value. It is marked as {&lt;parameter_name&gt;} in endpoint. Here, the creation of only one endpoint &rsquo;device/{rid}/info&rsquo; for &rsquo;*device/1/info*&rsquo; and &rsquo;*device/2/info*&rsquo; is needed.
When user permission is granted, it is necessary to specify parameters for each role assignment.

![User Diagram 2](../assets/user_2.png)

If you want to grant &rsquo;UserA&rsquo; access to &rsquo;*device/1/info*&rsquo;, you can:

1. Create a role called &rsquo;Viewer&rsquo;.
2. Add parameter definition &rsquo;rid&rsquo; to role &rsquo;Viewer&rsquo;, which means parameter &rsquo;rid&rsquo; is available in role &rsquo;Viewer&rsquo;.
3. Assign endpoint &rsquo;*device/{rid}/info*&rsquo; to role &rsquo;Viewer&rsquo;.
4. Assign role &rsquo;Viewer&rsquo; with parameter &rsquo;rid&rsquo;(name) = 1(value) to &rsquo;UserA&rsquo;.
5. Now UserA is allowed access to &rsquo;*device/1/info*&rsquo; when you check their permission.

#### Storage Per User
The provided storage per user stores data by key-value format. Since a user&rsquo;s properties are only email and name, you can put more individual information in storage (for example, address, birthday, etc.).

# <span id="head_tutorial_example">Tutorial Example in Scripting System</span>

Assume you are running a parking application.
There are two major roles in your system. One: the driver wants to park their vehicle. Two: the parking lot/garage charges drivers for parking.

To separate their permission, you should create at least two roles.
###### <span id="eg_createRole"></span>
```lua
-- Create role 'vehicle_driver' for driver
local role_vehicle_driver = {
    ["role_id"] = "vehicle_driver"
}
User.createRole(role_vehicle_driver)

-- Create role 'parking_area_manager'
local role_parking_area_manager = {
    ["role_id"] = "parking_area_manager"
}
User.createRole(role_parking_area_manager)
```

Suppose you have two users:

**User\_Parking\_Area** is in role &rsquo;parking_area_manager&rsquo; and has unique ID = **1**.

###### <span id="eg_createUser"></span>
```lua
-- Create User_Parking_Area
local new_user = {
	["name"] = "User_Parking_Area",
	["email"] = "demo_parking_area@exosite.com",
	["password"] = "demo777"
}
local activation_code = User.createUser(new_user)
```

###### <span id="eg_activateUser"></span>

```lua
-- Need to activate user after creating
local parameters = {
	["code"] = activation_code
}
User.activateUser(parameters)

```

**User_Vehicle** is in role &rsquo;vehicle_driver&rsquo; and has unique ID = **2**.

```lua
-- Create User_Vehicle
local new_user = {
	["name"] = "User_Vehicle",
	["email"] = "demo_vehicle@exosite.com",
	["password"] = "demo777"
}
local activation_code = User.createUser(new_user)

-- Activate User_Vehicle
local parameters = {
	["code"] = activation_code
}
User.activateUser(parameters)

```

In this tutorial, you will assume each driver has exactly one vehicle. This is a simplification that allows you to respect the User Management focus of this tutorial. You will represent the driver's vehicle data in a keystore record derived from the user's ID.

###### <span></span>
```lua
--- Store User_Vehicle's license plate number
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Vehicle_License_Plate_Number",
    ["value"] = "QA-7712"
}
Keystore.set(parameters)

-- Initialize User_Vehicle's parking start time
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "0000-00-00 00:00:00" -- current parking start time
}
Keystore.set(parameters)

```
### Scenario: List Control
First, support an endpoint for parking areas to manage their parking spaces. This endpoint is expected to list unique IDs of parking spaces.

```lua
-- Create endpoint for listing parking spaces of parking area
local list_parking_space_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "list/{parkingAreaID}/parkingSpace" -- This endpoint contains a parameter name 'parkingAreaID'
}
User.createPermission(list_parking_space_endpoint)

-- Assign endpoint to role 'parking_area_manager', so parking area managers can access it.
local endpoints = {
    ["method"] = "GET",
    ["end_point"] = "list/{parkingAreaID}/parkingSpace"
}
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints})
```

To let **User\_Parking\_Area** access *'GET list/1/parkingSpace'*, grant **User\_Parking\_Area** permisson on 'parkingAreaID' = 1 in role 'parking_area_manager'.

```lua
-- We should add parameter definition before assigning roles with new parameter name.
local param_definitions = {
    {
        ["name"] = "parkingAreaID"
    }
}
User.addRoleParam({["role_id"] = "parking_area_manager",  ["body"] = param_definitions})

-- Grant User_Parking_Area parameter 'parkingAreaID' = 1 in role 'parking_area_manager'
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "parkingAreaID",
                ["value"] = 1
            }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```
Now **User\_Parking\_Area** can access *'GET list/1/parkingSpace'*.

Next, make the list returned in response.

Assume there are two parking spaces in **User\_Parking\_Area**. Each parking space has a device RID. Devices can detect the status of a parking space. You can make **User\_Parking\_Area** have device RIDs by assigning roles. 

```lua
-- We should add parameter definition before assigning roles with new parameter name.
local param_definitions = {
    ["role_id"] = "parking_area_manager",
    ["body"] = {
        {
            ["name"] = "spaceRID" -- device RID
        }
    }
}
User.addRoleParam(param_definitions)

-- Grant User_Parking_Area access to his parking space RIDs
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "spaceRID",
                ["value"] = "d2343hbcc1232sweee12" -- first parking space RID
             },
             {
                ["name"] = "spaceRID",
                ["value"] = "a34feh709a234e232xd21" -- second parking space RID
             }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```

After roles assignment, you can return a paginated list of &rsquo;spaceRID&rsquo; when **User\_Parking\_Area** accesses *'GET list/1/parkingSpace'*.

###### <span id="eg_listUserRoleParamValues"></span>
```lua
local parameters = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["role_id"] = "parking_area_manager",
    ["parameter_name"] = "spaceRID",
    ["offset"] = 0, -- offset for pagination
    ["limit"] = 10 -- limit for pagination
}
local result = User.listUserRoleParamValues(parameters)
response.message = result.items -- return the list of RID
```

### Scenario: Endpoint Access Control
Second, support an endpoint for drivers to look for a vacant parking space. Drivers can query a number of vacancy in every parking area while each parking area manager is restricted to their own.

###### <span id="eg_createPermission"></span>
```lua
-- Create endpoint for querying vacant parking space
local available_space_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "query/{parkingAreaID}/availableSpace" -- The endpoint contains a parameter name 'parkingAreaID'.
}
User.createPermission(available_space_endpoint)
```
###### <span id="eg_addRolePerm"></span>
```lua
-- Assign the endpoint to roles 'vehicle_driver' and 'parking_area_manager', so drivers and parking area managers can access the endpoint.
local endpoints = {
    {
        ["method"] = "GET",
        ["end_point"] = "query/{parkingAreaID}/availableSpace"
    }
}
-- Let drivers access this endpoint
User.addRolePerm({["role_id"] = "vehicle_driver", ["body"] = endpoints})
-- Let parking area managers access this endpoint
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints})
```

To let **User\_Parking\_Area** access *'GET query/1/availableSpace'*, **User\_Parking\_Area** should have parameter 'parkingAreaID' = 1 in role 'parking_area_manager'. Since they have been assigned it before, there is no need to assign again.

To let **User\_Vehicle** access *'GET query/\*/availableSpace'*, you should grant **User\_Vehicle** permission on 'parkingAreaID' = * in role 'vehicle_driver'.

###### <span id="eg_addRoleParam"></span>
```lua
-- To role 'vehicle_driver', parameter name 'parkingAreaID' is new. Before assigning roles with new parameter name, you need to add parameter definition.
local param_definitions = {
    {
        ["name"] = "parkingAreaID"
    }
}
User.addRoleParam({["role_id"] = "vehicle_driver",  ["body"] = param_definitions})
```

###### <span id="eg_assignUser"></span>
```lua
-- Grant User_Vehicle all value of parkingAreaID in role 'vehicle_driver'
local roles_assigned = {
    {
        ["role_id"] = "vehicle_driver",
        ["parameters"] = {
            {
                ["name"] = "parkingAreaID",
                ["value"] = {
                    ["type"] = "wildcard" -- this format represents all values
                }
            }
        }
    }
}
User.assignUser({["id"] = 2, ["roles"] = roles_assigned})
```

Now you can prepare the number returned in response.

You already know there are two parking spaces in **User\_Parking\_Area**. Assume that each parking area is managed by one manager. Thus, info can be stored in keystore storage with the key derived from the manager's ID.

```lua
-- Set number of vacancy info for User_Parking_Area
local manager_id = 1 -- User ID of User_Parking_Area
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = 2 -- Assuming currently there is no vehicle parked in User_Parking_Area.
}
Keystore.set(parameters) -- We store value by Keystore service.
```

When permitted user accesses *'GET  query/1/availableSpace'*, you can return the number.
```lua
-- Get number of vanacy of User_Parking_Area
local manager_id = 1 -- User ID of User_Parking_Area
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local number = Keystore.get(parameters)
response.message = number
```


The background process of permission check when the user accesses endpoint can be replicated as follows:
###### <span id="eg_hasUserPerm"></span>
```lua
-- Check if User_Vehicle can access GET query/1/availableSpace.
local check_permission = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["perm_id"] = "GET/query/{parkingAreaID}/availableSpace", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1" -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
    }
}
local result = User.hasUserPerm(check_permission)
```

Because **User\_Vehicle** has been assigned with all values of &rsquo;parkingAreaID&rsquo; in role &rsquo;vehicle_driver&rsquo;, variable &rsquo;result&rsquo; is expected to be &rsquo;OK&rsquo;.

```lua
-- Check if User_Parking_Area can access 'GET query/1/availableSpace'.
local check_param = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["perm_id"] = "GET/query/{parkingAreaID}/availableSpace", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1" -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
    }
}
local result = User.hasUserPerm(check_param)
```

Because **User\_Parking\_Area** has been assigned with &rsquo;parkingAreaID = 1&rsquo; in role &rsquo;parking_area_manager&rsquo;, variable &rsquo;result&rsquo; is expected to be &rsquo;OK&rsquo;.




### Scenario: Application of User-storage and Endpoint-access-control

An endpoint for parking area managers to query info of a vehicle, such as parking time or license plate number, is also supported. Each parking area manager can only see info of vehicles parked in their spaces.

```lua
-- Create endpoint 'GET query/{parkingAreaID}/parkingVehicle/{vehicleID}/info'
local vehicle_info_endpoint = {
    ["method"] = "GET",
    ["end_point"] = "query/{parkingAreaID}/parkingVehicle/{vehicleID}/info"
}
User.createPermission(vehicle_info_endpoint)

-- Assign endpoint to role 'parking_area_manager', so parking area managers can access this endpoint.
local endpoints_assigned = {
    {
        ["method"] = "GET",
        ["end_point"] = "query/{parkingAreaID}/parkingVehicle/{vehicleID}/info" -- This endpoint contains a parameter name 'vehicleID'
    }
}
User.addRolePerm({["role_id"] = "parking_area_manager", ["body"] = endpoints_assigned})

-- Add parameter definition 'vehicleID' to role 'parking_area_manager' for assigning role 'parking_area_manager' with parameter 'vehicleID'
local param_definitions = {
    {
        ["name"] = "vehicleID"
    }
}
User.addRoleParam({["role_id"] = "parking_area_manager",  ["body"] = param_definitions})
```

When **User\_Vehicle** parks in **User\_Parking\_Area** (detected by device), **User\_Parking\_Area** should have the right to see info of **User\_Vehicle**.

```lua
-- Since User_Parking_Area already has 'parkingAreaID' = 1 in role 'parking_area_manager', we only need to assign role 'parking_area_manager' with extra parameter 'vehicleID' = 2 to User_Parking_Area.
local roles_assigned = {
    {
        ["role_id"] = "parking_area_manager",
        ["parameters"] = {
            {
                ["name"] = "vehicleID",
                ["value"] = 2 -- User ID of User_Vehicle
            }
        }
    }
}
User.assignUser({["id"] = 1, ["roles"] = roles_assigned})
```

###### <span id="eg_updateUserData"></span>
```lua
-- Add parking info for User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "2016-08-30 08:10:10"
}
Keystore.set(parameters)
```

For info of the space **User\_Vehicle** is parking at, you can create another parameter 'parkingSpaceRID' to store relationship by role assignment.

```lua
-- Create parameter definition for new parameter.
local param_definitions = {
    ["role_id"] = "vehicle_driver",
    ["body"] = {
        {
            ["name"] = "parkingSpaceRID" -- device RID of parking space
        }
    }
}
User.addRoleParam(param_definitions)
-- User_Vehicle is parking at space 'd2343hbcc1232sweee1'.
local roles_assigned = {
    {
        ["role_id"] = "vehicle_driver",
        ["parameters"] = {
            {
                ["name"] = "parkingSpaceRID",
                ["value"] = "d2343hbcc1232sweee1" -- device RID of parking space
            }
        }
    }
}
User.assignUser({["id"] = 2, ["roles"] = roles_assigned})
```

Because parking space &rsquo;d2343hbcc1232sweee1&rsquo; is occupied, you should also update the number of vacancy of **User\_Parking\_Area**.
```lua
-- Get current number of vacancy of User_Parking_Area
local manager_id = 1
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local latest_number = Keystore.get(parameters)

-- Update number of vacancy to latest
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = latest_number - 1 -- User_Vehicle just occupied one parking space.
}
Keystore.set(parameters)
```

Now **User\_Parking\_Area** can access *'GET query/1/parkingVehicle/2/info'* to get parking info of **User\_Vehicle**.

###### <span></span>
```lua
-- Get parking info of User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time"
}
local parking_start_time = Keystore.get(parameters)

parameters = {
    ["key"] = "Driver_"..driver_id.."_Vehicle_License_Plate_Number"
}
local license_plate_number = Keystore.get(parameters)

-- Find parking space User_Vehicle is parking at

parameters = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["role_id"] = "vehicle_driver",
    ["parameter_name"] = "parkingSpaceRID"
}
local values = User.listUserRoleParamValues(parameters)
local parking_space_rid = values[1]

-- response with parking info
response.message = {
    ["parking_start_time"] = parking_start_time,
    ["license_plate_number"] = license_plate_number,
    ["parking_space_rid"] = parking_space_rid
}
```

When **User\_Vehicle** is going to leave, **User\_Parking\_Area** can charge them according to the parking time.

After **User\_Vehicle** leaves, remove **User\_Vehicle** from the parking list of **User\_Parking\_Area** and update relevant info.

```lua
local roles_removed = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["role_id"] = "parking_area_manager",
    ["parameter_name"] = "vehicleID",
    ["parameter_value"] = 2 -- User ID of User_Vehicle
}
User.deassignUserParam(roles_removed)

-- Also remove relationship between User_Vehicle and parking space
local roles_removed = {
    ["id"] = 2, -- User ID of User_Vehicle
    ["role_id"] = "vehicle_driver",
    ["parameter_name"] = "parkingSpaceRID",
    ["parameter_value"] = "d2343hbcc1232sweee1"
}
User.deassignUserParam(roles_removed)

-- Update parking info of User_Vehicle
local driver_id = 2 -- User ID of User_Vehicle
parameters = {
    ["key"] = "Driver_"..driver_id.."_Parking_Start_Time",
    ["value"] = "0000-00-00 00:00:00"
}
Keystore.set(parameters)

-- Update number of vacancy of User_Parking_Area
local manager_id = 1
parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy"
}
local latest_number = Keystore.get(parameters)

parameters = {
    ["key"] = "Parking_Area_"..manager_id.."_Number_of_Vacancy",
    ["value"] = latest_number + 1 -- User_Vehicle just left.
}
Keystore.set(parameters)
```

**User\_Parking\_Area** cannot access *'GET query/1/parkingVehicle/2/info'* any longer since **User\_Vehicle** is not in their parking list.

```lua
-- Background process of checking if User_Parking_Area can access 'GET query/1/parkingVehicle/2/info'.

local check_permission = {
    ["id"] = 1, -- User ID of User_Parking_Area
    ["perm_id"] = "GET/query/{parkingAreaID}/parkingVehicle/{vehicleID}/info", -- {method}/{end_point}
    ["parameters"] = {
        "parkingAreaID::1", -- Specifies value 1 for parameter 'parkingAreaID' in endpoint
        "vehicleID::2" -- Specifies value 2 for parameter 'vehicleID' in endpoint
    }
}
local result = User.hasUserPerm(check_permission)
```

Because currently **User\_Parking\_Area** does not have parameter &rsquo;vehicleID&rsquo; = 2 in role &rsquo;parking_area_manager&rsquo;, it is expected to get result.status == 403.

# <span id="head_reference">Reference for Example</span>
* RBAC
   * User
      * [User.createUser()](#eg_createUser)
      * [User.activateUser()](#eg_activateUser)
   * Role
      * [User.createRole()](#eg_createRole)
      * [User.addRoleParam()](#eg_caddRoleParam)
   * Endpoint
      * [User.createPermission()](#eg_createPermission)
   * Role-Endpoint Relation
      * [User.addRolePerm()](#eg_addRolePerm)
   * Role-User Relation
      * [User.assignUser()](#eg_assignUser)
      * [User.deassignUserParam()](#eg_deassignUserParam)
      * [User.hasUserPerm()](#eg_hasUserPerm)
      * [User.listUserRoleParamValues()](#eg_listUserRoleParamValues)

* User Storage
   * [User.createUserData()](#eg_createUserData)
   * [User.updateUserData()](#eg_updateUserData)
   * [User.getUserData()](#eg_getUserData)


