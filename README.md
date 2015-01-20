firewalld LWRP
==============
[![Build Status](https://travis-ci.org/jhh/firewalld-cookbook.svg?branch=master)](https://travis-ci.org/jhh/firewalld-cookbook)
[![Code Climate](https://codeclimate.com/github/jhh/firewalld-cookbook/badges/gpa.svg)](https://codeclimate.com/github/jhh/firewalld-cookbook)

`firewalld` provides a LWRP for adding and removing ports and rules to your firewall.

Attributes
----------
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

Resource Overview
-----------------
### port

Default action adds a port to the firewall:

```ruby
firewalld_port '993/tcp'
```

This will allow access to TCP port 993 in the default zone.

#### `add`
Add the port to _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_port '993/tcp' do
  action :add
  zone   'public'
end
```

#### `remove`
Removes the port from _zone_. If zone is omitted, default zone will be used.

```ruby
firewalld_port '993/tcp' do
	action :remove
	zone   'public'
end
```

### rich_rule

The `rich_rule` allows you to create complex rules directly onto the firewall.
It will load the rule into the running config and pass it to firewalld with the
`--permanent` flag, to persist it after a reload.

#### Examples

```ruby
# This opens the ssh service to ip `192.168.100.5` and logs at a rate of 1 entry
# per minute with a prefix of ssh on each log entry.
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

#### Parameters
The parameters for `rich_resource` map  directly to their commandline flag.
More can be read here: [Complex Firewall Rules with Rich Language](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/7/html/Security_Guide/sec-Using_Firewalls.html#Configuring_Complex_Firewall_Rules_with_the_Rich-Language_Syntax)

- `name` - The name of the resource. This is not passed to the `firewall-cmd`.

- `service-name` - Name of the service defined by `firewalld-cmd --get-services`.

- `family` - IPv family. Choice of 'ipv4' or 'ipv6'. Default: 'ipv4'

- `zone` - Predefined zone into which a network interface is placed.

- `source_address` - Limits the origin of a connection attempt to a specific 
  range of IPs.

- `destination_address` - Limits the target of a connection attempt to a
  specific range of IPs.

- `port_number` - Can be a single integer or a port range, for example `5060-5062`.
  The protocol can be specified. Depends on `port_protocol` parameter.

- `port_protocol` - The protocol for the specified port, can be 'tcp' or 'udp'. 
  Depends on `port_number` parameter and defaults to 'tcp'.

- `log_prefix` - Logs new connection attempts with kernel logging. This will 
  prepend the log lines with this prefix.

- `log_level` - Can be one of 'emerg', 'alert', 'error', 'warning', 'notice', 
  'info', or 'debug'.

- `limit_value` - Limits the rate at which logs are written. Defaults to "1/m" 
  one write per minute.

- `firewall_action` - Can be one of 'accept', 'reject', or 'drop'. This is the 
  behavior by which all traffic that matches the rule will be handled.

Usage
-----
If you're using [Berkshelf](http://berkshelf.com/), just add `firewalld` to your `Berksfile`:

```ruby
cookbook 'firewalld', git: 'https://github.com/jhh/firewalld-cookbook.git'
```
```ruby
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
