#
# Cookbook Name:: firewalld
# Provider:: zone
#
# Copyright:: 2015, Johnathan Kupferer

# List of all actions supported by provider
actions :create, :create_if_missing, :delete

# Make new the default action
default_action :create

# Required attributes
attribute :zone, :kind_of => String, :name_attribute => true

# Optional attributes
attribute :target, :kind_of => String, :equal_to => ["default", "ACCEPT", "DROP", "%%REJECT%%"], :default => "default"
attribute :default, :kind_of => [TrueClass, NilClass], :default => nil
