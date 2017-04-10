---
title: Exosite Command Line Interface
template: default
---
# Deprecation Warning

The Exosite CLI has been replaced by the [Murano CLI](/development/tools/murano-cli/).

# Exosite Command Line Interface (CLI)
The Exosite Command Line Interface is a tool that enables web application developers to use their local development environments to develop IoT application software and then to publish it online.

Note: If you're working with products, use the [Exoline CLI](../exoline-cli).

Open a terminal window to run the commands below.

<ul>
  <li>Install the Exosite CLI: ```$ sudo pip install exosite``` In OS X, you may need to use the built-in system dependencies by running ```$ sudo pip install --upgrade exosite --ignore-installed six --ignore-installed prompt-toolkit --ignore-installed requests```</li>
  <li>List commands: ```$ exosite -h```</li>
  <li>Initialize your solution: ```$ exosite --init```</li>
  <li>Deploy your solution: ```$ exosite --deploy```</li>
</ul>
