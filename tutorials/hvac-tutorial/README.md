---
title: HVAC Reference Application Tutorial
template: default
---
# HVAC Reference Application Tutorial

This HVAC Reference Application is an interactive tutorial that allows users to learn the core features of Murano from both a hardware and software perspective. You will have the option to prototype or simulate the implementation of an HVAC monitoring system with simple controls using the Murano platform.

# Requirements
This tutorial is designed to be flexible based the hardware, software, and tools you have available. If you have one of the supported hardware items, you will be able to create a full IoT solution with working hardware. If you do not have any of the supported hardware available, we have created a Python based simulator that will help you get started.

## Supported Hardware

### SeeedStudio BeagleBone Green Wireless

SeeedStudio BeagleBone Green (BBG) is a low-cost, open-source, community-supported development platform for developers and hobbyists. It is a joint effort by BeagleBoard.org and Seeed Studio. It is based on the classical open-source hardware design of BeagleBone Black and has been developed into this differentiated version. The BBG includes two Grove connectors, making it easier to connect to the large family of Grove sensors. The onboard HDMI is removed to make room for these Grove connectors.

[https://beagleboard.org/green-wireless](https://beagleboard.org/green-wireless)

[http://wiki.seeed.cc/BeagleBone_Green/](http://wiki.seeed.cc/BeagleBone_Green/) 

### TI CC3200 SimpleLink™ Wi-Fi® and Internet-of-Things solution

The CC3200 device is a complete platform solution including software, sample applications, tools, user and programming guides, reference designs, and the TI E2E™ support community. The device is available in a QFN package that is easy to layout.

[http://www.ti.com/product/CC3200](http://www.ti.com/product/CC3200)

## Software

### Murano CLI

Murano CLI is a command-line utility for working with Murano. Think of it as a way to simplify and automate repetitious tasks for those who are comfortable with the command-line interface. 

[https://github.com/exosite/MuranoCLI](https://github.com/exosite/MuranoCLI)

### Python

All code written for the simulator in this tutorial has been designed to work with Python 2 and 3, which can be downloaded from the [Python website](https://www.python.org/).

### Web Browser

You will need a web browser for the initial steps in this tutorial.

# Getting Started

In this section you will walk through the process of setting up your account with Murano and preparing to run the simulator or actual hardware. 

## Create an Account

To get started with this tutorial, you will need to create an Exosite account using your web browser of choice. 

1. If you do not have an Exosite account, you can sign up here ([https://exosite.com/signup/](https://exosite.com/signup/)).

   ![signup](assets/exosite_signup.png)
   
2. Once you have signed up, an email confirmation of your new Murano account will be sent to you. Follow the instructions provided in the email, and you will be all set.
   
   ![welcome](assets/business_welcome.png)

## Manage Your Business

1. Once you have an active account and have logged in, you can navigate to the following URL to see your newly created business [https://www.exosite.io/business/memberships](https://www.exosite.io/business/memberships).

   ![new business](assets/new_business.png)

1. Click on your business to access your business page. 

1. Or, click the "+ NEW BUSINESS" button to create a new business.
   
## Install Murano CLI

Exosite offers a command-line tool that allows you to efficiently work with the project in this tutorial. Even though everything in this tutorial can be accomplished using a Web UI, feel free to install the Murano CLI.

```
Murano CLI is the command-line tool that interacts with Murano and makes tasks easier. Murano CLI makes it simple to deploy code to a solution, import many product definitions at once, set up endpoints and APIs, and more. 
```

Murano CLI is a Ruby-based command-line interface. Murano CLI will be used for most actions throughout the rest of this tutorial.

Check to see if Ruby is installed first by opening up a terminal window and typing the following command:  

**Note:** Always copy and paste what comes after the $.

```sh
$ which gem
```

If you see something like `/usr/bin/gem`, then Ruby is already installed. 

```
If you do not have Ruby installed, the official Ruby docs will help you get it installed:
[https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/) 
```

Once Ruby is installed, install Murano CLI by running this command:

```sh
$ sudo gem install ExositeMurano
```

If prompted, please enter your local computer password.

## Download the HVAC code

This tutorial uses a common codebase that includes a web application and specifications for the hardware. The code has been written to be flexible and works with multiple hardware platforms or the Python simulator.

[https://github.com/exosite/hvac-reference-application/archive/v0.1.zip](https://github.com/exosite/hvac-reference-application/archive/v0.1.zip)

## Create a Solution

You will need a place to deploy the HVAC solution code. 

### Web UI

To create a solution using the Web UI:

1. From the *Solutions* tab (https://www.exosite.io/business/solutions), click "+ NEW SOLUTION." 

   ![new solution](assets/new_solution.png)

2. Select *Start from scratch* and click the "ADD" button.

   ![new solution](assets/new_solution_popup.png)

Once you have created a solution, you will need to find the Solution ID.

1. In Murano select *Solutions*.

2. Select the solution you just created.

3. Copy the Solution ID on this page.

   ![solutions tab](assets/solutions_tab.png)

### Murano CLI

To create a solution using the Murano CLI:

```sh
$ murano solution create <name>
```

This command will return the ID of your solution for the next step.

### Configure Your Solution

To configure Murano CLI to work with your newly created solution, use the config command of the Murano CLI tool.

```sh
$ murano config solution.id <solutionid>
```

## Create a Product

Next, you will need to create a product. The product you create is the virtual representation of the BBG’s physical hardware and sensors that will send data to the Murano platform. 

### Web UI

To create a new product using the Web UI:

1. Navigate to the following URL: 
   [https://www.exosite.io/business/products](https://www.exosite.io/business/products)

   ![new product](assets/new_product.png)

1. Click on "+ NEW PRODUCT." 

1. Name your product. Note: your product name cannot contain any capital letters. 

1. Open the *Choose starting point* dropdown, select *Start from scratch*, and click the "ADD" button. In the next step you can use code to configure your product.

   ![new product](assets/new_product_popup.png)

Before continuing, you will need to find the ID of the product you created.

1. In Murano select *Products*.

2. Select the product you just created.

3. Copy the Product ID on this page.

   ![product id](assets/product_id.png)


### Murano CLI

To create a new product using the Murano CLI:

```sh
$ murano product create <name>
```

This command will return the ID of your product for the next step.

## Configure Your Product

To configure your product, you may use the config command of the Murano CLI tool. This command tells Murano CLI which product to use. 

```sh
$ murano config product.id <productid>
```

Executing the command below will set the product definition for this example as defined in the `specs/resources.yaml` file. 

```
$ murano syncup --specs
```
This command sets up all of the data aliases used in this example. You can now see them by going to [https://www.exosite.io/business/products](https://www.exosite.io/business/products) and clicking the *DEFINITION* tab. Many of the aliases are used by Gateway Engine. Notice, the aliases like "ambient_temperature", "desired_temperature", and "heat_on". These are all the different resources used for this HVAC tutorial. 

## Connect Product to Solution

You will need to link your product with your solution. Linking allows your solution and product to communicate with one another.

### Web UI

1. In your Murano solution, click on the *SERVICES* tab. 

2. Select *Product*.

3. Select the settings icon. 

4. Select the product(s) you want to include in the solution. 

5. Click "APPLY".

   ![solutions services](assets/solutions_services.png)

### Murano CLI

To connect a product with a solution using the Murano CLI:

```sh
$ murano assign set <product>
```

## Sync Your Solution

Before moving on to hardware, all of the configuration needs to be synced up to Murano.

```sh
$ murano syncup --all
```

```
What is happening when you sync code?

Murano CLI looks at the directory structure of your local repository and syncs the appropriate files and configurations directly to your solution in Murano. Endpoints, event handles, static files, and modules are synced. If you make changes locally, a syncup command will ensure Murano matches your local changes. If you make changes using the Murano interface, a syncdown will ensure your local repository matches Murano.
```

At this point your product and solution are configured and ready to start receiving data from your hardware of choice or the simulator. You can see the solution interface at this point by clicking the *DOMAIN* link on the Solutions page.

## Next Steps

If you have hardware available, you can walk through installing required software on your hardware, connecting the hardware and its sensors to the Murano platform, and connecting the sensor data to a Murano solution.

[BeagleBone Green Wireless](./beaglebone/)

[TI CC3200](./cc3200/)

If you do not have hardware available, you can walk through running the simulator. This should provide you with an easy starting point for connecting devices and creating solutions to visualize and interpret your device's data.

[Python Simulator](./simulator/)
