#
# Cookbook Name:: firewalld
# Provider:: service
#
# Copyright:: 2015, Jeff Hutchison

use_inline_resources

action :add do
  e = execute "add service #{new_resource.service} to zone" do
    not_if "firewall-cmd --permanent #{zone} --query-service=#{new_resource.service}"
    command(<<-EOC)
      firewall-cmd #{zone} --add-service=#{new_resource.service}
      firewall-cmd --permanent #{zone} --add-service=#{new_resource.service}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
  e = execute "remove service #{new_resource.service} from zone" do
    only_if "firewall-cmd --permanent #{zone} --query-service=#{new_resource.service}"
    command(<<-EOC)
      firewall-cmd #{zone} --remove-service=#{new_resource.service}
      firewall-cmd --permanent #{zone} --remove-service=#{new_resource.service}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def zone
  new_resource.zone ? "--zone=#{new_resource.zone}" : ''
end
