#
# Cookbook Name:: firewalld
# Provider:: source
#
# Copyright:: 2015, Johnathan Kupferer

# List of all actions supported by provider
actions :add, :change, :remove

# Make add the default action
default_action :add

# Required attributes
attribute :interface, :kind_of => String, :name_attribute => true

# Optional attributes
attribute :zone, :kind_of => String
