---
title: ADC
template: default
---

# ADC Overview

The Advanced Device Connectivity (ADC) feature in Murano allows anything capable
of sending IP packets (devices, mobiles, desktops, etc.) to securely connect
and authenticate with Exosite's IoT platform. ADC tracks and maintains information
about device connections and facilitates bidirectional communication between
the devices and Exosite's systems.

# Resources
* Device Provisioning Tutorial (Coming Soon)
* [Page-by-Page Reference](/reference/ui/advanced-device-connectivity/)

# About ADC

ADC enables devices to connect to Exosite using an 
HTTP protocol. All connections are secured by TLS.
Devices are assigned a unique identity and are required to authenticate using
device-specific credentials as supported by the chosen protocol. Devices report
data to resources in Exosite and may connect to receive control requests from Exosite,
including requests to update firmware.

ADC's **event mechanism** provides notifications when devices connect,
disconnect, and send data. Additionally, ADC persists and makes available a
device state representing the last reported resource values from the device and
any outstanding control requests to the device.

ADC's **identity management** supports provisioning as a means to assign an
identity—and associate authentication credentials—to a device.
Provisioned devices have an identity in Exosite and can authenticate using
assigned credentials. Explicitly provisioned devices are assigned an identity
(and given a means to authenticate) prior to first connecting with Exosite;
whereas implicitly provisioned devices are given authentication credentials and
(possibly) an identity when they first connect to Exosite.

Devices report data to *Resources*. A resource is identified by an alias, has a
data format (string, number, or boolean), and, possibly, has a value.
Additionally, it is possible to restrict the possible values for a resource
(either by specifying a range or by providing a discrete value list) and to
identify the value's unit. 
**For Example:** a connected thermometer might report
to a resource with alias "temperature", value "number", unit °C, and range -50 - 100.

--------------------------------------------------------------------------------

# ADC Protocols

## HTTP

ADC is backward-compatible with the HTTP-based One Platform [Data API](http://docs.exosite.com/reference/products/device-api/http/). This protocol 
supports CIK authentication as described by the API, and also supports TLS client
certificates not supported by One Platform. HTTPS connections are preferred; devices 
connecting via HTTP will be flagged as "developement devices" and be subject to 
restrictions such as rate limiting.

--------------------------------------------------------------------------------

# ADC FAQs

Q: How is ADC different than One Platform?

A: ADC supports a number of new features beyond what One Platform supports.

- Security features like TLS client certificates do not require secrets to be sent to our servers. Only the device holds the private key, and a security key may be used to prevent some physical access scenarios from allowing someone to impersonate a device.
- Logging and debugging features like the ability to see the last device IP address, and a UI that has been written with the device developer in mind.
- Sub-second time resolution. A frequently requested feature for One Platform was the ability to write multiple values within a second. ADC supports this.
- A user interface for content/firmware management for connected devices.

