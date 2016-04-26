#
# Cookbook Name:: firewalld
# Provider:: rich_rule
#
# Copyright:: 2015, Jeff Hutchison

# List of all actions supported by provider
actions :add, :remove

# Make add the default action
default_action :add

# Required attributes
attribute :name, :kind_of => String, :name_attribute => true

# Optional attributes
attribute :service_name, :kind_of => [String, NilClass]
attribute :family, :kind_of => String, :default => "ipv4"
attribute :zone, :kind_of => String
attribute :source_address, :kind_of => [String, NilClass]
attribute :destination_address, :kind_of => [String, NilClass]
attribute :port_number, :kind_of => [String, NilClass]
attribute :port_protocol, :kind_of => [String, NilClass], :default => "tcp"
attribute :log_prefix, :kind_of => [String, NilClass]
attribute :log_level, :kind_of => [String, NilClass]
attribute :limit_value, :kind_of => [String, NilClass]
attribute :firewall_action, :kind_of => [String, NilClass]
