name             'firewalld'
maintainer       'Stephen Sadowski'
maintainer_email 'stephen.sadowski@sjsadowski.com'
source_url       'https://github.com/sjsadowski/firewalld-cookbook' if respond_to?(:source_url)
issues_url       'https://github.com/sjsadowski/firewalld-cookbook/issues' if respond_to?(:issues_url)
license          'Apache v2.0'
description      'Installs/Configures firewalld'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.2.1'

supports         'fedora', ">= 15.0"
supports         'centos', ">= 7.0"
supports         'rhel',   ">= 7.0"
supports         'ubuntu', ">= 14.04"
supports         'debian', ">= 8.0"
