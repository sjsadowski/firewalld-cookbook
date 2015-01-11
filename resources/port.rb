#
# Cookbook Name:: firewalld
# Provider:: port
#
# Copyright:: 2015, Jeff Hutchison

# List of all actions supported by provider
actions :add, :remove

# Make add the default action
default_action :add

# Required attributes
attribute :port, :kind_of => String, :name_attribute => true

# Optional attributes
attribute :zone, :kind_of => String
