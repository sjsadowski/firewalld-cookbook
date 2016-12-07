# Changelog

## 1.1.5
* Adds resource for firewalld masquerade [Dru Goradia]

## 1.1.3

### New

* Added resources for firewalld zone [University of Illinois Chicago]
* Make iptables installation conditional on fallback attribute [Rob Nasby]

### Fix

* Correct Foodcritic message FC048 [Ricky Grassmuck]
* Correct Foodcritic message FC059 [Ricky Grassmuck]
* Bump ruby version to 2.2.2 in .travis.yaml [Ricky Grassmuck]

## 1.1.2

### New

* Add support for Debian 8 and Ubuntu 14.04 [Stephen Sadowski]

### Fix

* Normalize default.rb quotes [Jason Martin]
* Add use_inline_features to providers [Ricky Grassmuck]
* Add issues_url to metadata.rb [Ricky Grassmuck]
* Updated travis-ci link in README [Ricky Grassmuck]

## 1.1.0

### New

* Add enable/disable recipes with fallback to iptables [Stanislav Bogatyrev]

### Fix

* Corrected Foodcritic message FC002  [Stanislav Bogatyrev]

## 1.0.0

### New

* Add firewalld service LWRP. [Jeff Hutchison]

* Renamed default spec and recipe to port. [Jeff Hutchison]

### Fix

* Metadata lists support for Fedora 15 and above. [Jeff Hutchison]

* README usage refers to Chef Supermarket instead of Github. [Jeff Hutchison]


## 0.3.0

### New

* Add Rich Rule LWRP documentation to README. [Manny Toledo]

* ChefSpec test added for Rich Rule LWRP. [Manny Toledo]

* Integration tests added for Rich Rule LWRP. [Manny Toledo]

* Add rules directly with Rich Rule LWRP! [Manny Toledo]

### Fix

* Correct IPs in tests to more common ranges. [Manny Toledo]

* Update readme. [Manny Toledo]

* Add missing defaults in resource file and clean up comment. [Manny Toledo]

## 0.2.1

### New

* Better README and send email for Travis. [Jeff Hutchison]

* Update ruby version. [Jeff Hutchison]

* Add chefspec custom matchers, other cleanup. [Jeff Hutchison]

* Need berkshelf for chefspec tests in Travis. [Jeff Hutchison]

* Add chefspec tests. [Jeff Hutchison]

* Exclude dependencies not used by Travis. [Jeff Hutchison]

* Enable Travis CI. [Jeff Hutchison]

* Clean up syntax. [Jeff Hutchison]

* Use bundler. [Jeff Hutchison]

* Add more tests. [Jeff Hutchison]

* Removed attributes not recognized by Berkshelf. [Jeff Hutchison]

* Add issues url. [Jeff Hutchison]

* Bump version. [Jeff Hutchison]

* Update README. [Jeff Hutchison]

* Update license to Apache v2. [Jeff Hutchison]

* First version with tests. [Jeff Hutchison]
