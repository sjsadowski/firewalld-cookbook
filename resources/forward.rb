# Cookbook Name:: firewalld
# Provider:: forward
#
# Copyright:: 2017, Alfred Moreno

# List of all actions supported by provider
actions :add, :remove

# Make change the default action
default_action :add

attribute :protocol, :kind_of => Symbol
attribute :address, :kind_of => String
attribute :port, :kind_of => Integer
attribute :to_port, :kind_of => Integer

# Optional attributes
attribute :zone, :kind_of => String
