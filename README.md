SevOne-Deferred-Data-Scripts
============================
A collection of open-source deferred data scripts for SevOne



deferred-data-import
====================
This is the core script in the collection.  It is agnostic to the data being
supplied to it; in true Unix style, it simply reads data points from STDIN and
imports them to a SevOne appliance using the Deferred Data SOAP API mechanism.

Required information is supplied to deferred-data-import via command-line, as
follows:

	deferred-data-import 'SevOne name or IP' 'username' 'password' 'Device Name'

Data input should follow this format:

	"timestamp" "object name" "object type" ["indicator name 1" "indicator format 1" "indicator units 1" "indicator value 1" ["indicator name 2" "indicator format 2" "indicator units 2" "indicator value 2" [... etc]]]

"Indicator format" refers to "GAUGE", "COUNTER32", or "COUNTER64".  Most of
what you import via Deferred Data will be GAUGE.  Refer to the SevOne manual
for more information.  It does attempt to use quotes to allow spaces in text
fields, command-line style, but note that this mechanism is not perfect.
Non-numeric values will be treated as dropped polls.

All the processors are executable; provided you have the proper language
interpreters installed, simply running them with the following syntax should
get your data imported fine:

	./processors/[processor and args] | ./defererd-data-import [args]



deferred-data-backfill
======================
This works exactly the same way as deferred-data-import, but is optimized for
backfilling a large volume of historical data by making use of the multi-row
insert functionality in SevOne's plugin_deferred_insertDataRows() API function.



bamboo-rest
===========
* Language:  Python
* Type:      API
* Reference: http://www.atlassian.com/software/bamboo
* Usage:


	bamboo-rest -u username -p password [options]

Provided you have Python and the dependencies installed, this one is easy. I'll
list the depdencies below.

Python dependencies:
* getopt
* urllib2
* calendar
* json
* datetime



process-mileage
===============
* Language:  PHP
* Type:      Local file
* Refernece: None
* Usage:


	process-mileage /path/to/csv     # Accepts a filename as a parameter
	process-mileage < /path/to/csv   # Also accepts data over STDIN

This one processes gas mileage data, imported to a file manually from fuel
receipts.  It expects CSV files in the following format:
	Time, name of station, octane rating ((RON + MON) / 2), price per gallon, volume in gallons, total price, distance travelled in mile

Special considerations:
* Time will be converted to a timestamp using strftime().  It's magic.
      Don't worry about how it works.
* * This was tested in the following format: "Y-m-d H:i:s Z"
* Each gas station you use will be a separate object, in addition to an
      object that contains data points for all the others.  This is mainly
      intended for comparing fuel quality from one brand to the next.  In
      the distant future (the year 2000), there will be a command-line
      switch to disable the separate stations in order to save elements on
      the SevOne appliance it's being imported to
* Any numeric fields that are found to contain a non-numeric value will
      have a NULL inserted for that indicator at that data point

Known issues:
* Can consume a lot of elements; need to have an option to not save individual
      fuel branding objects



mint
====
* Language:  CasperJS
* Type:      Screen scraper
* Reference: http://www.mint.com/
* Usage:


	mint 'Mint registered E-mail address' 'Mint password'

Known issues:
* Does not pull down details on individual investments, only whole accounts
* Auto-refreshes accounts at the end of the script, rather than the beginning



wordpress
=========
* Language:  Python
* Type:      Database processor
* Reference: http://www.wordpress.org/
* Usage:


    wordpress [options] mysql-host 'MySQL user' 'MySQL password' 'MySQL db'

This processor connects to a MySQL database backing a Wordpress instance, does
some processing, and exports some statistics about posts, metadata, comments,
categories, and tags.

Python dependencies:
* calendar
* datetime
* MySQLdb
* optparse
* time



alexa
=====
* Language:  Python
* Type:      Screen scraper
* Reference: http://www.alexa.com/
* Usage:


    alexa domain-name

This processor scrapes the page on alexa.com for the given domain name for
rank, reach, and other data.

Python dependencies:
* calendar
* datetime
* lxml
* mechanize
* optparse
* time



raspberry-pi
============
* Language: bash
* Type:     System poller
* Usage:


    raspberry-pi ip.or.hostname [/path/containing/vcgencmd]

This processor connects to a Raspberry Pi running one of the many flavors of
Linux that support the little computer.  

The statistics this exports include current temperature, clocks, voltages, and
system load.

Note that passwordless SSH from the system running this poller to the Raspberry
Pi must be enabled; also, the vcgencmd binary must be present somewhere on the
Raspberry Pi's filesystem.  By default, this looks for vcgencmd in the path
that OpenELEC places it in (/usr/bin); if your vcgencmd binary is elsewhere,
you must pass that path in (e.g. "/opt/vc/bin" for Debian Wheezy) as the second
parameter.

