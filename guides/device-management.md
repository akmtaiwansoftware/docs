---
title: Device Management
template: default
---

# Guide: Manage Device Lifecycle

This guide will help you understand the process a device goes through during its time on the Murano platform. This will cover device provisioning, device distribution, customer experience, claiming a device, transfer of ownership, device replacement, and end of life.

# Device Provisioning Process

The Murano platform uses two methods of security that can be used to authenticate connections. One method uses an automatically generated preshared key and the other uses client certificates to establish a secure TLS connection. The following sections will walk through the process and features of each method.

## Preshared Key

The preshared key process has two methods to add identities and authenticate. Users can make a call that will add an identity, ID=12345, and a user generated key, CIK=40 character hex. This will add a device to the platform and add the authentication in one effort. The other method is to provide the server an identity, and it will generate a key for authentication. In either case, the preshared key will exist on the device in non-volatile memory. The key, either user generated or provided, will be used by the device to write to the cloud and read from it. 

# Data Format

In order for Murano to properly process data, it must first understand some information on the type of data it expects from the device. Murano supports three main data types: integer, float, and string. Each resource within a product has what is called an "alias." An alias is the name describing the resource. For instance, a resource with an alias of temp, and a format of integer will be expecting data to describe it in the following format "temp=70." The call would be rejected if temp were declared equal to a string.

![device data format](../assets/device-data-format.png)

# Distribution

Once a device has been provisioned and the data format defined, the device has been prepared to be sold to distributors or end users. Murano allows for the creation of a custom API that gives access to data and control over a device based on identity. Users can claim their device in a custom application and access the device's data from the custom API. The API uses a Lua scripting environment and gives access to dozens of integrations and core services. These can be leveraged to allow for maximum flexibility in the custom application design. After distribution, the device is in the standard operating mode. The device can remain this way until deactivation, ideally, but most devices require some sort of maintenance or debugging.

# Maintenance 

The Murano CLI tool allows for the uploading of content to the cloud where devices can have access to new firmware. Having the capacity to update device firmware allows for the changing of an embedded application after the initial deployment. This can be a valuable tool to fix mistakes, rollout new functionality, and optimize performance of a device. The updating of firmware varies from device to device. Murano provides a flexible platform for providing access to the needed files for your embedded application.

# Customer Experience 

Customers should be able to simply plug their device in and access the needed functionality from the custom application. Because the key has been preshared, and the device authenticated, the customer simply registers with your application and they will then have access to the data and control of the device from the cloud. Murano has been designed to be simple and easy for the end users of your device. 

 
