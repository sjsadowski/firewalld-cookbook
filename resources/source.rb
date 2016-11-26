#
# Cookbook Name:: firewalld
# Provider:: source
#
# Copyright:: 2015, Johnathan Kupferer

# List of all actions supported by provider
actions :add, :change, :remove

# Make change the default action
default_action :change

# Required attributes
attribute :source, :kind_of => String, :name_attribute => true

# Optional attributes
attribute :zone, :kind_of => String
