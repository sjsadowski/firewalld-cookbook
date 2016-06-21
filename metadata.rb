name             'firewalld'
maintainer       'Jeff Hutchison'
maintainer_email 'jeff@jeffhutchison.com'
source_url       'https://github.com/jhh/firewalld-cookbook'
license          'Apache v2.0'
description      'Installs/Configures firewalld'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.1.1'

supports         'fedora', ">= 15.0"
supports         'centos', ">= 7.0"
supports         'rhel',   ">= 7.0"
supports         'ubuntu', ">= 14.04"
supports         'debian', ">= 8.0" # untested
