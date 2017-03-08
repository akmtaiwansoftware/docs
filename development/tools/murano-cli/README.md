# Murano Command Line Interface (CLI)

Do more from the command line with [Murano](https://exosite.com/platform/).

Murano CLI is the command-line tool that interacts with Murano and makes different tasks easier. Murano CLI makes it easy to deploy code to a solution, import many product definitions at once, set up endpoints and APIs, and more.

Murano CLI works around the idea of syncing, much like rsync. Files from your project directory are synced up (or down) from Murano.

# Usage

## Start from an Existing Murano Project

```
mkdir myproject
  cd myproject
  murano config solution.id XXXXXX
  murano syncdown -V
```

Do stuff, see what changed: `murano status` or `murano diff`. Then deploy with `murano syncup`.

## Start a New Project

There are a few steps and pieces to getting a solution with a product up and running in Murano. Here is the list:

* Pick a business: `murano business list`. If this is the first time you have run Murano, it will ask for your Murano username and password.

* Set it: `murano config business.id ZZZZZZZZZ`

* Create a product: `murano product create myawesomeproduct`

* Save the result: `murano config product.id YYYYYYYYY`

* Add resource aliases to specs/resources.yaml

* Sync the product definition up: `murano syncup -V --specs`

* Create a solution: `murano solution create myawesomesolution`

* Save the result: `murano config solution.id XXXXXX`

* Sync solution code up: `murano syncup -V`

* Assign the product to the solution: `murano assign set`

Do stuff, see what changed: `murano status` or `murano diff`. Then deploy with `murano syncup`.

# Install

When upgrading from a 1.* version to a 2.0, you should uninstall the old versions first.
```
gem uninstall MuranoCLI
```

And then install:
```
gem install MuranoCLI
```

Or:
```
gem update MuranoCLI
```

You will likely need to be root for the above commands. If you would rather not install as root, you can install gems in the user directory.
```
gem install MuranoCLI --user-install
```

Your `PATH` may need to be updated to find the installed Murano command. See the [Ruby Gem FAQ](http://guides.rubygems.org/faqs/#user-install). In short, you need to add the output of `ruby -rubygems -e 'puts Gem.user_dir'` to your `PATH`.

## Windows Install

The Murano CLI gem will install on Windows. There is also a single Windows binary Setup installer available in [releases](https://github.com/exosite/MrMurano/releases).

If you do not already use Ruby on Windows, then you should use the binary installer.

When upgrading, it is best to run the uninstaller for the old version before installing the new version.

# Features

## Logs

You can monitor the log messages from your solution with the `murano logs --follow`. Or quickly get the last few with `murano logs`.

Murano CLI does a few things to make your log output easier to follow.

* Adds color to easily see where each log message starts.

* Reformats the timestamps to be in local time.

* Finds JSON blobs and pretty prints them.

All of these can be toggled with command-line options.

## MURANO_CONFIGFILE Environment and Dotenv

The environment variable `MURANO_CONFIGFILE` is checked for an additional config to load. This, in conjunction with dotenv support, allows for easily switching between development, staging, and production setups.

To use this, write the three solution ids into `.murano.dev`, `.murano.stg`, and `.murano.prod`. Then write the `.env` file to point at the system you are currently working on.

The files for this are then:
```
cat >> .murano.dev <<EOF
  [solution]
  id=AAAAAAAA
  EOF
```
```
  cat >> .murano.stg <<EOF
  [solution]
  id=BBBBBBBB
  EOF
```
```
  cat >> .murano.prod <<EOF
  [solution]
  id=CCCCCCCC
  EOF
```
```
  cat > .env <<EOF
  MURANO_CONFIGFILE=.murano.dev
  EOF
```

This also allows for keeping private things in a separate config file and having the shared things checked into source control.

## Direct Service Access

To aid with debugging, Murano CLI has direct access to some of the services in a solution.

Currently these are:

* Keystore: `murano keystore`

* Timeseries: `murano timeseries`

* TSDB: `murano tsdb`

## Output Format

Many sub-commands respect the outformat setting. This lets you switch the output between YAML, JSON, Ruby, CSV, and pretty tables. Not all formats work with all commands.

```
> murano tsdb product list
  > murano tsdb product list -c outformat=csv
  > murano tsdb product list -c outformat=json
  > murano tsdb product list -c outformat=yaml
  > murano tsdb product list -c outformat=pp
```

## Product Content Area

Murano CLI can manage the content area for a product. This area is a place to store files for use by devices. Typically holding firmware images for Over-The-Air updating. Although any kind of fleet wide data that devices may need to download can be stored here.

Once the product.id is set, the content for that product can be accessed with the following commands:

```
> murano content list
  > murano content upload
  > murano content info
  > murano content delete
  > murano content download
```

Call them with `--help` for details.

