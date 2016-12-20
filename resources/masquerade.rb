#
# Cookbook Name:: firewalld
# Provider:: masquerade
#
# Author:: Dru Goradia

# List of all actions supported by provider
actions :add, :remove

# Make change the default action
default_action :add

# Required attributes
attribute :zone, kind_of: String, name_attribute: true
