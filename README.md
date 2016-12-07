firewalld LWRP
==============
[![Build Status](https://travis-ci.org/rigrassm/firewalld-cookbook.svg?branch=master)][travis]
[![Cookbook Version](http://img.shields.io/cookbook/v/firewalld.svg)][cookbook]

[travis]: https://travis-ci.org/rigrassm/firewalld-cookbook
[cookbook]: https://supermarket.chef.io/cookbooks/firewalld

[Firewalld](https://fedoraproject.org/wiki/FirewallD) is the userland interface to dynamically managing a Linux firewall, introduced in Fedora 15 and Centos/RHEL 7.

# Resource Overview

This `firewalld` cookbook provides three resources for adding and removing  services, ports, and rules.

## interface

The `firewalld_interface` resource will add a network interface to a zone for the current and permanent configurations. The interface name is a string that should match a network interface on the system. If zone is omitted, default zone will be used.

### Actions

* `:add` - add the interface to the current and permanent configuration.
* `:change` - change the interface to the current and permanent configuration. (default)
* `:remove` - remove the interface from the current and permanent configuration.

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>interface</td>
<td>(name attribute) the interface to manage</td>
<td>em1</td>
<td></td>
</tr>
<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove interface from</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>
</table>

Default action, `:change`, associates an interface with a firewall zone:

```ruby
firewalld_interface 'em1'
```

This will associate the interface em1 with the default zone.

### `:add`
Add the interface to _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_interface 'em1' do
        action :add
        zone   'internal'
end
```

### `:change`
Add the interface to _zone_, and remove it from any other zones it may be associated
with. If zone is omitted, default zone will be used.

```ruby
firewalld_interface 'em1' do
        action :change
        zone   'internal'
end
```

### `:remove`
Remove the interface from _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_interface 'em1' do
        action :remove
        zone   'internal'
end
```

## rich_rule

The `firewalld_rich_rule` resource allows you to create complex rules directly onto the firewall. It will load the rule into the running config and pass it to `firewalld` with the `--permanent` flag, to persist it after a reload.

### Actions

* `:add` - add the rich rule to the current and permanent configuration
* `:remove` - remove the rich rule from the current and permanent configuration

### Attributes

The attributes for `rich_rule` map  directly to the `firewall-cmd (1)` command-line parameters. More can be read here: [Complex Firewall Rules with Rich Language](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Using_Firewalls.html#Configuring_Complex_Firewall_Rules_with_the_Rich-Language_Syntax) and *firewalld.richlanguage (5)*.

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>

<tr>
<td>name</td>
<td>(name attribute) The name of the resource. This is not passed to <code>firewall-cmd</code>.</td>
<td>ssh_add</td>
<td></td>
</tr>

<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove port from</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>

<tr>
<td>family</td>
<td>IP family. Choice of 'ipv4' or 'ipv6'.</td>
<td>ipv6</td>
<td>ipv4</td>
</tr>

<tr>
<td>source_address</td>
<td>Limits the origin of a connection attempt to a specific range of IPs.</td>
<td>192.168.100.5/32</td>
<td>(none, not limited)</td>
</tr>

<tr>
<td>destination_address</td>
<td>Limits the target of a connection attempt to a specific range of IPs.</td>
<td>192.168.100.5/32</td>
<td>(none, not limited)</td>
</tr>

<tr>
<td>service_name</td>
<td>The service name is one of the <code>firewalld</code> provided services. To get a list of the supported services, use <code>firewall-cmd --get-services</code>.</td>
<td>ssh</td>
<td></td>
</tr>

<tr>
<td>port_number</td>
<td>Can be a single integer or a port range, for example '5060-5062'. The protocol can be specified. Requires that <code>port_protocol</code> attribute be specified also.</td>
<td>5060</td>
<td></td>
</tr>

<tr>
<td>port_protocol</td>
<td>The protocol for the specified port, can be 'tcp' or 'udp'. Requires that <code>port_number</code> attribute be specified also.</td>
<td>tcp</td>
<td></td>
</tr>

<tr>
<td>log_prefix</td>
<td>Logs new connection attempts with kernel logging. This will prepend the log lines with this prefix.</td>
<td>ssh</td>
<td></td>
</tr>

<tr>
<td>log_level</td>
<td>Can be one of 'emerg', 'alert', 'error', 'warning', 'notice',
'info', or 'debug'.</td>
<td>info</td>
<td></td>
</tr>

<tr>
<td>limit_value</td>
<td>Limits the rate at which logs are written.</td>
<td>1/m</td>
<td>1/m - one write per minute</td>
</tr>

<tr>
<td>firewall_action</td>
<td>Can be one of 'accept', 'reject', or 'drop'. This is the behavior by which all traffic that matches the rule will be handled.</td>
<td>accept</td>
<td></td>
</tr>

</table>


### `:add`

```ruby
# This opens the ssh service to ip `192.168.100.5` and logs at a rate of
# 1 entry per minute with a prefix of ssh on each log entry.
#

firewalld_rich_rule "ssh_add" do
  zone 'public'
  family 'ipv4'
  source_address '192.168.100.5/32'
  service_name 'ssh'
  log_prefix 'ssh'
  log_level 'info'
  limit_value '1/m'
  firewall_action 'accept'
  action :add
end
```

## service

The `firewalld_service` resource will add the service for a zone to the current and permanent configurations. The service name is one of the `firewalld` provided services. To get a list of the supported services, use `firewall-cmd --get-services`. If zone is omitted, default zone will be used.

### Actions

* `:add` - add the service to the current and permanent configuration
* `:remove` - remove the service from the current and permanent configuration

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>service</td>
<td>(name attribute) the service to manage</td>
<td>http</td>
<td></td>
</tr>
<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove service from</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>
</table>

Default action adds a service to the firewall:

```ruby
firewalld_service 'http'
```

This will allow access to the http service in the default zone.

#### `:add`
Add the service to _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_service 'tftp' do
	action :add
	zone   'public'
end
```

#### `:remove`
Removes the service from _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_service 'telnet' do
action :remove
zone   'public'
end
```

## port

The `firewalld_port` resource will add the port for a zone to the current and permanent configurations. If zone is omitted, default zone will be used.

### Actions

* `:add` - add the port to the current and permanent configuration
* `:remove` - remove the port from the current and permanent configuration

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>port</td>
<td>(name attribute) the port to manage</td>
<td>993/tcp</td>
<td></td>
</tr>
<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove port from</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>
</table>

Default action adds a port to the firewall:

```ruby
firewalld_port '993/tcp'
```

This will allow access to TCP port 993 in the default zone.

#### `:add`
Add the port to _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_port '993/tcp' do
  action :add
  zone   'public'
end
```

#### `:remove`
Removes the port from _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_port '993/tcp' do
	action :remove
	zone   'public'
end
```

## zone

The `firewalld_zone` resource will add a firewalld zone for current and permanent configurations.

### Actions

* `:create` - Default. Use to create a zone. If a zone already exists (but does not match), use to update that zone to match.
* `:create_if_missing` - Use to create a zone only if the zone does not exist.
* `:delete` - Use to delete a zone.

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>zone</td>
<td>(name attribute) the zone name manage</td>
<td>external</td>
<td></td>
</tr>
<tr>
<td>default</td>
<td>Use to make zone the default zone.</td>
<td>true</td>
<td>nil</td>
</tr>
<tr>
<td>target</td>
<td>Default firewall target. May be one of "default", "ACCEPT", "DROP", or "%%REJECT%%".</td>
<td>ACCEPT</td>
<td>default</td>
</tr>
</table>

Default action, `:change`, associates an interface with a firewall zone:

```ruby
firewalld_source '192.168.100.0/24'
```

This will associate the source IP address range "192.168.100.0/24" with the default zone.

### `:add`
Add the source to _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_source '192.168.0.0/24' do
        action :add
        zone   'internal'
end
```

### `:change`
Add the source to _zone_, and remove it from any other zones it may be associated
with. If zone is omitted, default zone will be used.

```ruby
firewalld_source '192.168.0.0/24' do
        action :change
        zone   'internal'
end
```

### `:remove`
Remove the interface from _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_interface '192.168.0.0/24' do
        action :remove
        zone   'internal'
end
```
## source

The `firewalld_source` resource will add a source network address range to a zone for the current and permanent configurations. The source name is a network address in CIDR notation such as "192.168.100.0/24". If zone is omitted, default zone will be used.

### Actions

* `:add` - add the source to the current and permanent configuration.
* `:change` - change the source to the current and permanent configuration. (default)
* `:remove` - remove the source from the current and permanent configuration.

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>source</td>
<td>(name attribute) the network subnet specification manage</td>
<td>em1</td>
<td></td>
</tr>
<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove source from</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>
</table>

Default action, `:create`, creates or updates a zone:

```ruby
firewalld_zone 'database'
```

This will create a new firewalld zone called "database".

### `:create`
Create or update the zone.

```ruby
firewalld_zone 'secure' do
  action :create
  target 'DROP'
  default true
end
```

### `:create_if_missing`
Create the zone only if it does not exist.

```ruby
firewalld_zone 'database' do
  action :create_if_missing
  target 'DROP'
end
```

### `:delete`
Delete the zone.

```ruby
firewalld_zone 'secure' do
        action :delete
end
```

## masquerade

The `firewalld_masquerade` resource will add the masquerading option to a zone. If zone is omitted, default zone will be used. This is equivalent to `firewall-cmd --zone=public --add-masquerade` or `firewall-cmd --zone=public --remove-masquerade`.

### Actions

* `:add` - add the masquerade option to the current and permanent configuration. (default)
* `:remove` - remove the masquerade option from the current and permanent configuration.

### Attributes

<table>
<tr>
<th>Attribute</th>
<th>Description</th>
<th>Example</th>
<th>Default</th>
</tr>
<tr>
<td>zone</td>
<td><code>firewalld</code> zone to add or remove masquerade</td>
<td>public</td>
<td>(none, uses default zone)</td>
</tr>
</table>

Default action, `:add`, adds the masquerade option to a zone:

```ruby
firewalld_masquerade 'public'
```

This will add the masquerade option to the "public" firewalld zone.

### `:add`
Add masquerade to a zone.

```ruby
firewalld_masquerade 'add masquerading to public zone' do
  action :add
  zone 'public'
end
```

### `:remove`
Remove masquerade from a zone.

```ruby
firewalld_masquerade 'remove masquerading from public zone' do
  action :remove
  zone 'public'
end
```

# Recipes

* default - installs and enables `firewalld`.
* disable - disable `firewalld` and use `iptables` if `node[:firewalld][:iptables_fallback]` is set.
* enable - revert to `firewalld` if `node[:firewalld][:iptables_fallback]` is set.

# Usage

If you're using [Berkshelf](http://berkshelf.com/), just add `firewalld` to your
`Berksfile` and `metadata.rb`:

```ruby
# Berksfile
cookbook 'firewalld'

# metadata.rb
depends 'firewalld'
```

Contributing
------------
1. Fork the project
2. Create a feature branch corresponding to you change
3. Commit and test thoroughly
4. Create a Pull Request on github


License & Authors
-----------------
- Author:: Jeff Hutchison <jeff@jeffhutchison.com>
- Author:: Manuel Toledo   <mtoledo@adobe.com>
- Author:: Johnathan Kupferer   <jtk@uic.edu>

```text
Copyright 2015, Jeff Hutchison

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
