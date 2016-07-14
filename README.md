Smart Rain Gauge Project
========================

The Smart Rain Gauge project is a distributed system of Wireless sensing nodes that monitor precipitation in the Syracuse, NY region. This repository has all the necessary code and documentation needed for setting up this system.


Web Application
---------------

This is an application written in primarily Python that is responsible for storing and displaying data from the Particle Electron devices in a web interface. The code necessary for this is currently in a private repository and will be moved here shortly. Please excuse any inconvience. 

### Technology Used

**Application**

- **Flask** - The Python web framework being used. There are also a number of other third party dependencies, also written in Python and installed with `pip`.
- **npm** - Node Package Manager. `pip` for Node.js
- **gulp** - Build system, written in Javascript. Automates repetitive development & build tasks.
- **bower** - Front end dependency management (i.e. bootstrap, etc.)

**Server**

- **MySQL/MariaDB** - Database housing all of the information for the application (and sensors)
- **nginx** - HTTP server (like Apache)
- **gunicorn** - Python WSGI server (runs our Python application)

### Architecture Overview

The Electron cloud has an active webhook listening for a specific `publish()` event from any Electron device. When the publish event runs every 15 minutes, the webhook sends an HTTP POST containing formatted JSON to a regular HTTP endpoint in our application, which processes and inserts the data into the MySQL database.

The web application provides user and access management, searchable raw data, maps, more information, and much more.

### Local Setup

This application runs locally for development & testing, and is also deployed to the production machines locally via ssh.

#### Prereqresites

You need the following installed on your machine before we get started. There should be installers on the official websites:

- Python 2.7 _(2.7.10 or above preferred)_

- Node.js (for dev/builds + front end dependencies)

- MySQL or MariaDB

#### Set up (first time only)

**Database**

Make sure that MySQL is running locally first, and create an empty database named **savetherain** (`create database savetherain;` from `mysql` shell). 

After the database is created, run `python manage.py db migrate` followed by `python manage.py db upgrade`. This should populate your formerly empty database with the proper database schema.

**Virtualenv**

We use a tool called _virtualenv_ to keep a self-contained Python environment so that we don't have to install dependencies on our system level. To install it, just run:

`pip install virtualenv`

When it is finished installing, `cd` to the project folder, and run:

`virtualenv venv`

This command will create an empty virtualenv called "venv". Now you can try activating it by typing `source venv/bin/activate` and you should see (venv) on the left side of the CLI:

```shell
➜ StR_Website git:(master) ✗ source venv/bin/activate
(venv) ➜ StR_Website git:(master) ✗
```

Now we're ready to install dependencies and get everything up and running.

#### Installing Dependencies

Before we run the application, we're going to need to install the dependencies:

1. `pip install -r requirements.txt` _Note: be sure to be in venv_
2. `npm -g install bower`
3. `npm install`
4. `bower install`

If you get errors trying to install anything, save the error and let someone know.

#### Running the application (development)

Finally, we're ready to run the application:

1. Activate your virtualenv with `source venv/bin/activate`
2. Start the python application `python run.py`
3. Start the gulp server (compile CSS/JS) with just `gulp`
4. Navigate to [localhost:5000](localhost:5000) and you should have the site up and running




### Production Setup

Coming soon...

Building a Rain Gauge
---------------------

Coming soon...

Setting up a Particle Device
-----------------------------

This section will go into detail about setting up your local computer so that you can work with your Particle Electron offline. A large majority of the section is borrowed from [Particle's own documentation]:https://docs.Particle.io.

### Getting Started

This section assumes you have a Electron from Particle. If not, head over to their [store]:https://store.particle.io/ and pick up your very own today. 

#### What's All here?

The Cellular Module. The cellular module allows your Electron to communicate with the internet with a 3G network connection! The cellular module is also accompanied with a Particle SIM card. It connects your device to the internet in the same way that your smartphone might connect to its cellular network. 

The Microcontroller. The microcontroller is the brain of your device. It runs  software and tells the Rain Gauge (or your own prototype) what to do. Unlike your computer, it can only run one application (often called firmware or an embedded application). This application can be simple (just a few lines of code), or very complex, depending on what you want to do. The microcontroller interacts with the outside world using pins.

The Pins. Pins are the input and output parts of the microcontroller that are exposed on the sides of your device. GPIO (General Purpose) pins can be hooked to sensors or buttons to listen to the world, or they can be hooked to lights and buzzers to act upon the world. There are also pins to allow you to power your device, or power motors and outputs outside of your device. There are pins for Serial/UART communication, and a pin for resetting your device. The Sensors the Smart Rain Gauge uses are a form of Serial Communication, called I2C.

The Antenna & USB Cable. The cellular antenna is imperative for the Electron to reach connection to a cellular tower. It will operate for all 2G/3G frequencies that your Electron needs. The USB cable provides a means to charge your Electron as well as send serial and dfu commands to your device.

The Battery. The Electron comes with a standard 2000mAh 3.7V LiPo battery (rechargeable) which allows the Electron to be powered over long periods of time without needing a connection to wired power source. Instead of using the batteries that came with the device, we will be using a 6600 3.7V LiPo battery for a more reliable automated system.

For more technical details on what comes on your device, go [here]: http://bower.io/search/?q=flatdoc.

#### Useful Features

##### Onboard Power Management
- If the small red LED is on, the battery is charging
- When the LED turns off, the battery is fully charged

##### Display Signal Strength
- Press MODE once quickly when the Electron is breathing cyan
- The signal strength (RSSI) will be shown in a 0-5 green blinks, 5 being the strongest

### SIM Card Setup
- Setup the SIM card by visting the online web [setup page]:https://setup.particle.io/.
- You can also use the Particle Mobile App - [iPhone]:https://itunes.apple.com/us/app/particle-build-photon-electron/id991459054?ls=1&mt=8 | [Android]:https://play.google.com/store/apps/details?id=io.particle.android.app

### Connecting over USB
Check this [page]:https://docs.particle.io/guide/getting-started/connect/electron/ for the most up to date information.

It's worth noting here that you currently cannot set up an Electron from the command line (CLI) because we require that a credit card number be entered, but the CLI will be extremely useful for other things. Please use [setup page]:https://setup.particle.io/ or the mobile apps found in the previous section.

For all of the following methods, the device must be in Listening Mode, where the RGB LED is blinking blue.Particle devices boot into listening mode by default, so if your device is brand new, it should go straight into listening mode. If your device is not blinking blue, hold down the MODE button.

There are a two ways to go about connecting your device over USB, depending on your OS.

#### Using OSX

We're going to install the Particle CLI(Command Line Interface) on your computer. 

##### Installing Node.js

The Particle CLI runs with Node.js. Grab the latest version from the [Node.js website]:https://nodejs.org/en/download/.

Launch the installer and follow the instructions to install node.js.
Next, open your terminal, or preferred terminal program.

##### Install The Particle CLI

Type: npm install -g particle-cli
Note: You may need to update xcode at this time.

##### Connecting your Device

If you're using an Electron, please follow the instructions at https://setup.particle.io.

#### Using Windows
An official, updated tutorial on CLI, DFU, and driver tools installation is referenced [here]:http://community.particle.io/t/particle-official-windows-10-full-cli-and-dfu-setup/18309.

To connect and interact with a Particle Device over USB from a Windows machine, the easiest route is to use the Particle command line interface. The following describes how to install the Particle CLI on your computer. If you already have Node.js installed, you can skip to this step.

##### Installing Node.js

The Particle CLI runs with Node.js. Grab the latest version from the [Node.js website]:https://nodejs.org/en/download/.

Run the installer you downloaded. Follow the prompts. The default file locations should be fine for this.

Restart your computer.

Node should now be installed! In the next step we will test it and install the CLI.

##### Installing th Particle Driver

You'll also need to install the Windows driver. Download it [here]:https://s3.amazonaws.com/spark-website/Particle.zip.

Unzip the file. It is fine to unzip this as a default into your Downloads folder.

Go to the Device Manager and double-click on your Particle device under **Other Devices** (on Windows 10 your Particle device may be listed under Ports).
Click **Update Driver**, and select **Browse for driver software on your computer**.

Navigate to your Downloads folder, or wherever you unzipped the drivers.
If you have a problem installing, you may have to temporarily disable the digitally signed driver enforcement policy. (We're sorry.) There are good instructions on how to do that [here]:http://www.howtogeek.com/167723/how-to-disable-driver-signature-verification-on-64-bit-windows-8.1-so-that-you-can-install-unsigned-drivers/.

##### Opening Comand Prompt


Smart Rain Gauge
----------------

This section will cover what components are needed to build a Smart Rain Gauge device.


### Getting Started
