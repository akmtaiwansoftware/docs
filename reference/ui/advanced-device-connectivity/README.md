# ADC Page-by-Page Reference

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

**NOTE:** the *Endpoint* URL at the top of the screen is the host name your devices will use when connecting to Murano via the [HTTP Device API](/reference/products/device-api/http/).

![Endpoint](assets/endpoint.png)

# Logs

The *Logs* page is where you may access a connection log of each device’s meta data and a "live" view that displays events associated with a product's API endpoint that came in while the Murano product UI was running.

![Logs](assets/logs.png) 


![Logs2](/tutorials/provisioning/assets/provisioning_device_wrote.png)

# Resources

The *Resources* page is where you may add attributes (or "alias"es) to your devices (e.g., temperature, status, etc.). Resources represent a device's digital twin in the cloud. A resource is identified by its alias, and the resource's unit (e.g., °C) can be specified to further clarify the alias's measurement. It is possible to restrict values to ranges (0-100) or to discrete values ("open", "closed", "jammed"). The current resource value for a given device is visible when browsing the device in the project and is accessible to scripts, which can then act on reported values in any number of ways.

![Resources](assets/resources.png) 

When you click "+ NEW RESOURCE", you will be prompted to choose your data format. 
* *String* refers to a unicode sequence of characters. 
* *Number* refers to any positive or negative value. 
* *Boolean* refers to a binary variable (i.e., true or false).

You will also be given the option to "modify this value from the cloud." Leaving this box unchecked will allow only the device itself to write to the alias. Checking this box will allow other applications to modify the value of the resource, depending on the permissions you have put in place. 

![New Resource Creation](assets/new_resource_creation.png)

Typically, devices report values to resources that are "read-only" in the cloud. It is possible to enable writing from the cloud, which can be used to support command-and-control behavior. All resources have a "reported" value which represents the last value written by the device (using the write API). Resources that are cloud-writeable have an additional "set" value assigned when a write occurs from the cloud. The read API will return the "set" value (not the "reported" value) in this case; note, however, that a device write will replace both the "set" and the "reported" value. Devices will use either the read API or the long-polling API to receive control requests and then write appropriate resource updates to reflect its having acted on the request.

Devices are not restricted to write to only defined resources. Devices write to "alias"es which may or may not correspond to defined resources. All device writes are sent to the event handler and can be processed by scripts, but only writes to defined resources will have "reported" values stored, available to devices via "read" and visible when viewing the device online. Additionally, only resources that are cloud-modifiable will have "set" values.

# Content

The *Content* page serves as a file store that your devices can access and utilize through the API. Click “+ NEW CONTENT” and follow the prompts to upload your files. Each content item has an ID, a MIME type, a size (in bytes), and a timestamp. Devices may list available content, get content info, and download content using the [HTTP Device API](/reference/products/device-api/http/).

![Content](assets/content.png) 

There is no restriction as to the kind of content that can be made available to devices. Files can contain anything from audio/video content to config data, but the typical use case is to store firmware updates. For content that gets updated over time, such as with new firmware versions, it is recommended to include in the ID some kind of version tag. Whether this approach is taken or the content is updated in place and a timestamp is used to differentiate, devices will need a means to know which version they are at. Exosite recommends storing this information in a [Resource](#resources). Additionally, if the resource is cloud-modifiable, the device can be notified when new firmware is available.
 
**Note:** Content items must be less than 64 MB in size.

# Settings

The *Settings* page allows you to set your authentication method and determine which devices can connect. 

The *Token* authentication method assigns a unique 40-character string to each device. The token serves as both the identity and the authorization for the device; devices pass this token as part of the "X-Exosite-CIK" HTTP header when connecting to Murano.

The *TLS CLient Certificate* authentication method employs a standard TLS client certificate. Devices present the certificate during the TLS connection handshake with Murano and are challenged to prove they hold the corresponding private key. The device's certificate's CommonName (CN) field in its subject indicates the identity of the device; Murano uses this to confirm that the certificate is associated to the device.

The *TLS Client Certificate*, by nature, operates within a TLS session and therefore requires the use of HTTPS. Since the *Token* mechanism uses a simple HTTP header, it is possible to support this mechanism over plain HTTP and checking the "Allow development devices to connect" box enables such connections. Doing so means all communication will be unencrypted, and everything -- including the token! -- will be plainly visible to third parties. **It is highly discouraged to run in this mode**, but activities -- particularly those during the development of the device -- make doing so useful under very limited circumstances. **Note**: devices used during development which connected using plain HTTP should reprovision (to acquire a new token) prior to switching over to HTTPS, as the token used during development will not be secret.

See the [HTTP Device API](/reference/products/device-api/http/) documentation for more information.

![Settings](assets/settings.png) 

## Provisioning

Farther down on the *Settings* page, you may select your provisioning settings.

Provisioning is the process by which a device's token or a TLS client certificate is associated to a specific identity in Murano. Devices must be provisioned before they can read and write data and download content.

When using *token* authentication, the device and Murano must first agree to an identity before agreeing to a token. Enabling "Allow devices to register their own identity" allows a device to report its identity as part of requesting a token for that identity. In this case, the device need not have first been created in Murano (Murano will create the device, assign a token to the device, and send the token back to the device for it to subsequently use). Enabling "Allow server to generate the identity for devices connecting without one" allows devices without identities to request an identity.

When using *TLS certificates*, the device must have a certificate to present to Murano ("Allow server to generate the identity for devices connecting without one" is not applicable). Here, as with token, enabling "Allow devices to register their own identity" allows the device to be created in Murano when the certificate is first presented to it using the CN as the device's identity.

It is recommended to provision devices during manufacture when the IP address the device connects from is both known and controlled and to restrict provisioning from these known IP addresses. Murano will ensure the identity the device provides is legitimate given the format specified.

![Provisioning](assets/settings2.png) 
