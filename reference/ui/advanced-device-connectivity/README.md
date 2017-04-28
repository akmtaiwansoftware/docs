# Advanced Device Connectivity Manual

This reference manual breaks out each page of Murano's Advanced Device Connectivity (ADC) feature and diagrams each component. All ADC functionality is located within Murano under the *Product* realm of your Project.

![ADC Entry](assets/adc_entry_marked.png) 

# ADC Pages
* [Devices](#devices)
* [Logs](#logs)
* [Resources](#resources)
* [Content](#content)
* [Settings](#settings)

# Devices

The *Devices* page is where you will add, list, and manage all your devices (real or simulated).
Once you have populated your list of devices, you will have the capability to search, sort, and filter you device list to suit your needs. 

![Devices](assets/devices.png) 

When you click “+ NEW DEVICE(S)”, you will have the option to add one device or many devices at once (note: free Murano accounts limit the number of devices you are able to add). 

![Device Creation](assets/device_creation.png)

**NOTE:** the *Endpoint* URL at the top of the screen is the host name that has been created to receive your devices' outgoing API calls.  

![Endpoint](assets/endpoint.png)

# Logs

The *Logs* page is where you can access a connection log of each device’s meta data.

![Logs](assets/logs.png) 

# Resources

The *Resources* page is where you can add attributes to your devices. Resources are defined by alias and format and delimit the data model of your devices. 

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


