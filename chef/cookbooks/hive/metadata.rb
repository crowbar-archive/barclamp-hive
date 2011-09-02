maintainer       "Dell, Inc."
maintainer_email "Paul_Webster@Dell.com"
license          "All rights reserved"
description      "Installs and configures the hive cluster component"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0"
recipe           "hive::default", "Installs hive base libraries and configuration."
