firewalld LWRP
==============

`firewalld` provides a LWRP for adding and removing ports to your firewall.

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

Actions
-------

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

Usage
-----
If you're using [Berkshelf](http://berkshelf.com/), just add `firewalld` to your `Berksfile`:

```ruby
cookbook 'firewalld', path: 'path/to/cookbook'
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
