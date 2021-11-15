name             'firewalld'
maintainer       'Stephen Sadowski'
maintainer_email 'stephen.sadowski@sjsadowski.com'
source_url       'https://github.com/sjsadowski/firewalld-cookbook'
issues_url       'https://github.com/sjsadowski/firewalld-cookbook/issues'
chef_version     '>= 13.0'
license          'Apache v2.0'
description      'Installs/Configures firewalld'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.2'

supports         'fedora', ">= 15.0"
supports         'centos', ">= 7.0"
supports         'rhel',   ">= 7.0"
supports         'ubuntu', ">= 14.04"
supports         'debian', ">= 8.0"
