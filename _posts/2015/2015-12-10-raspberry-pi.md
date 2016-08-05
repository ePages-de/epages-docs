---
layout: post
title: "Student internship: Set up a Raspberry Pi to send SMS notifications "
date: "2015-12-10 06:00:00"
image: blog-header/raspberry-pi.jpg
categories: tech-stories
authors: ["Katharina", "Norman"]
---

Setting up a Raspberry PI to send SMS notifications was my task within a two-weeks student internship at ePages.
Starting position: the external service provider AnySMS is integrated in the Icinga Monitoring.
The Icinga sends error messages to our standby phone via AnySMS.
To being able to carry out this service ourselves, we realised this via a Raspberry Pi.

First, AnySMS and the Raspberry Pi should run in parallel, so that if one fails the other could still send an SMS.
The Raspberry Pi should be able to send SMS via a web service and has to be integrated with the Icinga.

## Preparing the Raspberry Pi

* Write Raspbian image to SD card.
* Connect SD card, power supply, monitor, keyboard and LAN cable to Raspberry Pi and perform basic configuration.
* Expand SD card (Expand filesystem) to make use of all the available space.
* Change password.
* Adjust language options.
* Set up SSH connection.
* etc.

## Installing the Gammu SMS Daemon

To send SMS via Raspberry Pi, an SMS gateway has to be installed.
Connect a UMTS stick with SIM card to the Raspberry Pi (maybe use a USB hub if there are not enough connections available) and install the Gammu SMS Daemon on the Raspberry Pi.
As an alternative to Gammu you may also use SMS Server Tools 3, Kannel or the like.

* Check if Raspberry Pi recognises the UMTS stick:

{% highlight text %}
$ Isusb
{% endhighlight %}

* Download and install the Gammu SMS Daemon:

{% highlight text %}
$ sudo apt-get install gammu-smsd
{% endhighlight %}

* Configure the file */etc/gammu-smsrdc.* according to the example; only the password varies:

{% highlight text %}
$ vi /etc/gammu-smsdrc
{% endhighlight %}

{% highlight text %}
# Configuration file for Gammu SMS Daemon

# Gammu library configuration, see gammurc(5)
[gammu]
# Please configure this!
port = /dev/ttyUSB0
connection = at
# Debugging
logformat = textalldate

# SMSD configuration, see gammu-smsdrc(5)
[smsd]
pin = 1234
service = files
#logfile = syslog
logfile = /var/log/gammu-smsd
# Increase for debugging information
debuglevel = 4
ReceiveFrequency = 300

# Paths where messages are stored
inboxpath = /var/spool/gammu/inbox/
outboxpath = /var/spool/gammu/outbox/
sentsmspath = /var/spool/gammu/sent/
errorsmspath = /var/spool/gammu/error/
{% endhighlight %}

* Restart Gammu:

{% highlight text %}
$ sudo /etc/init.d/gammu-smsd restart
{% endhighlight %}

* Send a test SMS:

{% highlight text %}
$ echo "MESSAGE" | sudo gammu-smsd-inject TEXT "NUMBER")
{% endhighlight %}

## Installing PlaySMS

Sending an SMS should be controlled via a website.
We use PlaySMS for this.

* Install PlaySMS and the belonging software (Apache, PHP, MySQL, cURL):

{% highlight text %}
$ sudo -s
$ apt-get install apache2 libapache2-mod-php5 mysql-server php5 php5-cli php5-mysql php5-mcrypt php5-gd php5-imap php5-curl
{% endhighlight %}

* Attention: if you're asked for a new root password, choose a very strong one:

{% highlight text %}
$ php5enmod mcrypt
$ service apache2 restart
{% endhighlight %}

When calling the Raspberry Pi's IP address in the browser, "It Works" should appear:

{% highlight text %}
http://your-ip
{% endhighlight %}

* Install PlaySMS:

{% highlight text %}
$ cd /tmp/
$ wget http://downloads.sourceforge.net/project/playsms/playsms/Version%201.1/playsms-1.1.tar.gz
$ tar -zxf playsms-1.1.tar.gz -C /usr/local/src
$ ls -l /usr/local/src/
$ cd /usr/local/src/playsms-1.1/
{% endhighlight %}

* Copy the file *install.conf.dist* to *install.conf*, then edit the files:

{% highlight text %}
$ cp install.conf.dist install.conf
$ vi install.conf
{% endhighlight %}

* Amend the content in the *config* file.
We used DBPASS as password for the root.

{% highlight text %}
# INSTALL DATA
# ============


# Please change INSTALL DATA below to suit your system configurations

# Please do not change variable name, you may change only the value

# MySQL database username
DBUSER="root"

# MySQL database password
DBPASS="SICHERESPASSWORT"

# MySQL database name
DBNAME="playsms"

# MySQL database host
DBHOST="localhost"

# MySQL database port
DBPORT="3306"

# Web server's user, for example apache2 user by default is www-data
# note: please make sure your web server user
WEBSERVERUSER="www-data"

# Web server's group, for example apache2 group by default is www-data
# note: please make sure your web server group
WEBSERVERGROUP="www-data"

# Path to playSMS extracted source files
PATHSRC="$(pwd)"

# Path to playSMS web files
# note: please make sure your web root path, in this example its /var/www/html
PATHWEB="/var/www/html/playsms"

# Path to playSMS additional files
PATHLIB="/var/lib/playsms"

# Path to playSMS daemon and other binary files
PATHBIN="/usr/local/bin"

# Path to playSMS log files
PATHLOG="/var/log/playsms"


# END OF INSTALL DATA
# ===================
{% endhighlight %}

* Run the following command:

{% highlight text %}
$ ./install-playsms.sh
{% endhighlight %}

If everything looks fine, confirm with *Y*.
To start PlaySMS as soon as the Raspberry Pi is initialised, configure the following file:

{% highlight text %}
$ vi /etc/init.d/rc.local
{% endhighlight %}

* Write the following line to the end of the file and save:

{% highlight text %}
....
 /usr/local/bin/playsmsd start
{% endhighlight %}

* Now amend the following file:

{% highlight text %}
$ vi /etc/apache2/sites-available/default
{% endhighlight %}

{% highlight text %}
ServerAdmin webmaster@localhost

        DocumentRoot /var/www/html/playsms

                Options FollowSymLinks
                AllowOverride None


                Options Indexes FollowSymLinks MultiViews
                AllowOverride None
                Order allow,deny
                allow from all


        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <directory "="" usr="" lib="" cgi-bin"="">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all


        ErrorLog ${APACHE_LOG_DIR}/error.log

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog ${APACHE_LOG_DIR}/access.log combined
{% endhighlight %}

* Reload Apache:

{% highlight text %}
$ service apache2 reload
{% endhighlight %}

Now you can again call the website http://your-ip.
This time, a login screen should appear.
By default the login data are set to:

username: admin
password: admin

* To connect PlaySMS and Gammu, add the gateway Gammu to PlaySMS:

{% highlight text %}
Settings > Manage gateway and SMSC > Gateway Gammu (Add)
{% endhighlight %}

Now you're able to send SMS via PlaySMS or via the command line.

## Installing SSL certificate

Use an SSL certificate to encrypt internet data transfer.

## Integrating Raspberry Pi with Icinga

As you are now able send SMS via a URL, the only step remaining is integrating the Raspberry Pi with Icinga.
For AnySMS there's already an integration, so that you can store the Bash files with the same path.
To change something within Icinga, you can use Git Bash.
Git Bash manages the changes within Icinga.
