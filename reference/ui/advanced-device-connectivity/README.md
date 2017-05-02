# ADC Page-by-Page Manual

This reference manual breaks down each page of Murano's Advanced Device Connectivity (ADC) feature and provides descriptions of each component's functionality. All ADC offerings are located within [Murano](https://www.exosite.io/business/) under the *Product* realm of your Project.

![ADC Entry](assets/adc_entry_marked.png) 

# ADC Pages
* [Devices](#devices)
* [Logs](#logs)
* [Resources](#resources)
* [Content](#content)
* [Settings](#settings)

# Devices

The *Devices* page is where you will add, list, and manage all your devices (real or simulated).
Once you have populated your list of devices, you will have the capability to search, sort, and filter your device list to suit your needs. 

![Devices](assets/devices.png) 

When you click the “+ NEW DEVICE(S)” button, you will have the option to add one device or many devices at once. Depending on your account tier, there may be a limit on the number of devices you are able to add. 

![Device Creation](assets/device_creation.png)

**NOTE:** the *Endpoint* URL at the top of the screen is the host name that has been created to receive your devices' outgoing API calls.  

![Endpoint](assets/endpoint.png)

# Logs

The *Logs* page is where you may access a connection log of each device’s meta data.

![Logs](assets/logs.png) 

# Resources

The *Resources* page is where you may add attributes to your devices (e.g., temperature). Resources are defined by alias and format and delimit the data model of your devices. 

![Resources](assets/resources.png) 

When you click "+ NEW RESOURCE", you will be prompted to choose your data format. 
* *String* refers to a unicode sequence of characters. 
* *Number* refers to any positive or negative value. 
* *Boolean* refers to a binary variable (i.e., true or false).

You will also be given the option to "modify this value from the cloud." Leaving this box unchecked will allow only the device itself to write to the alias. Checking this box will allow other applications to modify the value of the resource, depending on the permissions you have put in place. 

![New Resource Creation](assets/new_resource_creation.png)

# Content

The *Content* page serves as a file store that your devices can access and utilize through the API. Click “+ NEW CONTENT” and follow the prompts to upload your files. 

![Content](assets/content.png) 

# Settings

The *Settings* page allows you to set your authentication method and determine which devices can connect. 

Selecting the *Token* option enables a character string for the authorization of your devices’ communication with Murano. 
**NOTE:** checking the box “Allow development devices to connect” will allow unencrypted communication of your device. 

The *TLS Client Certificate* option enables authentication and identification of devices via parameters of the client certificate.

![Settings](assets/settings.png) 
