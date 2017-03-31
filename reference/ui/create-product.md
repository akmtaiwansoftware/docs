---
title: Create a Product
template: default
---

# Guide: Create a Product

The product you create is the virtual representation of the physical hardware and sensors that will send data to the Murano platform. 

# Web UI

To create a new product using the Web UI:

1. Navigate to the following URL: 
   [https://www.exosite.io/business/products](https://www.exosite.io/business/products)

   ![new product](../assets/new_product.png)

1. Click on "+ NEW PRODUCT." 

1. Name your product. Note: your product name cannot contain any capital letters. 

1. Open the *Choose starting point* dropdown, select *Start from scratch*, and click the "ADD" button. In the next step you can use code to configure your product.

   ![new product](../assets/new_product_popup.png)

Before continuing, you will need to find the ID of the product you created.

1. In Murano select *Products*.

2. Select the product you just created.

3. Copy the Product ID on this page.

   ![product id](../assets/product_id.png)


# Murano CLI

To create a new product using the Murano CLI:

```sh
$ murano product create <name>
```

This command will return the ID of your product for the next step.

# Configure Your Product

To configure your product you can use the config command of the Murano CLI tool. This command tells Murano CLI which product to use. 

```sh
$ murano config product.id <productid>
```

Executing the command below will set the product definition for this example as defined in the `specs/resources.yaml` file. 

```
$ murano syncup --specs
```
This command sets up all the data aliases in the spec file. You can now see them by going to [https://www.exosite.io/business/products](https://www.exosite.io/business/products) and clicking the *DEFINITION* tab. These are all the different resources that will used by your hardware. 
