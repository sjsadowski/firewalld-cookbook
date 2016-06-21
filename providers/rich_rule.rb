#
# Cookbook Name:: firewalld
# Provider:: rich_rule
#
# Copyright:: 2015, Jeff Hutchison

use_inline_resources

action :add do
  e = execute "add port #{new_resource.name} to zone" do
    not_if "firewall-cmd #{zone} --query-rich-rule=\"#{rich_rule}\""
    command(<<-EOC)
    firewall-cmd #{zone} --add-rich-rule="#{rich_rule}"
    firewall-cmd --permanent #{zone} --add-rich-rule="#{rich_rule}"
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
  e = execute "remove port #{new_resource.name} from zone" do
    only_if "firewall-cmd #{zone} --query-rich-rule=\"#{rich_rule}\""
    command(<<-EOC)
    firewall-cmd #{zone} --remove-rich-rule="#{rich_rule}"
    firewall-cmd --permanent #{zone} --remove-rich-rule="#{rich_rule}"
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def zone
  new_resource.zone ? "--zone=#{new_resource.zone}" : ''
end

def rich_rule
    cmd = "rule "
    cmd += "family='#{new_resource.family}' " if new_resource.family
    cmd += "source address='#{new_resource.source_address}' " if new_resource.source_address
    cmd += "destination address='#{new_resource.destination_address}' " if new_resource.destination_address
    cmd += "service name='#{new_resource.service_name}' " if new_resource.service_name
    cmd += "port port='#{new_resource.port_number}' protocol='#{new_resource.port_protocol}' " if new_resource.port_number
    cmd += "log " if new_resource.log_prefix || new_resource.log_level || new_resource.limit_value
    cmd += "prefix='#{new_resource.log_prefix}' " if new_resource.log_prefix
    cmd += "level='#{new_resource.log_level}' " if new_resource.log_level
    cmd += "limit value='#{new_resource.limit_value}' " if new_resource.limit_value
    cmd += new_resource.firewall_action if new_resource.firewall_action
    cmd
end
