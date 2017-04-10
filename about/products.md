---
title: Products in Murano
template: default
---

# Products in Murano

As is discussed in the <a href="/about/data-flow">Data Flow article</a>, Murano internally represents real-world IoT components as the concepts of Connected Products, Applications, and  Integrations.

<img src="/about/assets/murano-components.png" width="800" alt="Murano Components">


This article has information about Products in Murano. 

<img src="/about/assets/map-connected-products.png" width="300" alt="Connected Products">

The following topics are related, and can be reviewed for more information:

1. <a href="/ui/device-management">Connected Product lifecycle management</a>
1. <a href="/reference/services/device">The Device Service</a>
1. <a href="/ui/keystore-service">View and record Product metrics</a>
1. <a href="/ui/create-product/">Using my Product in my Application</a>
1. <a href="/about/applications">Murano Applications</a>
1. <a href="/about/integrations">Murano Integrations</a>

At a basic level, what most of our customers want to do is simply connect a Device to the cloud and start interacting with that Device remotely to create something valuable for End-Users or for business process.  However, there are many different types of Devices – each type has a different level of processing/communication/storage capabilities, and represents/controls different real-world parameters.

<img src="/about/assets/map-product-types.png" width="400" alt="Product Types">

To make “connecting/interacting to a remote Device” a scalable effort for businesses, Murano uses the idea of a Device type (or Device model) – known as a Product – to define how Devices belonging to the Product interact.  Products, therefore, have multiple Devices associated with them (one Product, many Devices).  Once the behavior of the general Product is defined, it is easy to start “stamping out” thousands of Devices that will interact as required by the Product to which they belong.  The representation & capabilities in Murano of a given Device is often referred to by the industry as a “Digital Twin” or a “Device Shadow” or a “Virtual Device”.

<img src="/about/assets/map-product-devices.png" width="400" alt="One Product, Many Devices">

Because there are so many different possible Products variants (i.e. ranging from a simple sensor to a very capable gateway - each having varieties of processing, communications, storage, data representation, and control capabilities), each Murano Product allows the configuration of its capabilities. Every Device interacts with Murano as defined its Product’s configuration of these areas: 

* Communications authentication method
* Communications protocol
* Device identities / whitelist pool
* Expected communications behavior
* Expected data schema
* Firmware / content
* Time series storage
* Key value storage
* Cloud-assisted processing
* User / Value-Added-Reseller access/control permissions
* Automated external Integrations

It is also often the case that a Product will be used to power a variety of End User applications (<a href="/about/applications">Applications</a>).  For example, a Connected Pump Product may have some specific Pumps that are used in an container truck filling/dispensing application, while other Pumps (belonging to the same Product) are used in a maintenance facility fluid transfer application.  In Murano, a Product is able to be used in a variety of Applications without changes to the underlying Devices – even when the Applications are created and maintained by business partners or customers.

<img src="/about/assets/map-product-many-apps.png" width="600" alt="One Product, Many Applications">

To get started with Murano Products try the <a href="/quickstarts/devicesensor">Device Sensor Quickstart</a>, or to dive in deeper with the <a href="/tutorials/hvac-tutorial">HVAC Tutorial</a>.






