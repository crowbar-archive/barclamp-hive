maintainer       "Dell, Inc."
maintainer_email "Paul_Webster@Dell.com"
license          "Apache 2.0 License, Copyright (c) 2011 Dell Inc. - http://www.apache.org/licenses/LICENSE-2.0"
description      "Data warehouse infrastructure that provides SQL based data summarization and ad hoc querying."
long_description IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version          "1.0"
recipe           "hive::default", "Installs hive base libraries and configuration."
