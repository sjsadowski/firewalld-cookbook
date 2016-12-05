#
# Cookbook Name:: firewalld
# Provider:: interface
#
# Copyright:: 2015, Johnathan Kuperer

use_inline_resources

action :add do
  e = execute "add interface #{new_resource.interface} to zone" do
    not_if "firewall-cmd --permanent #{zone} --query-interface=#{new_resource.interface}"
    command(<<-EOC)
      firewall-cmd #{zone} --add-interface=#{new_resource.interface}
      firewall-cmd --permanent #{zone} --add-interface=#{new_resource.interface}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :change do
  e = execute "change interface #{new_resource.interface} to zone" do
    not_if "firewall-cmd --permanent #{zone} --query-interface=#{new_resource.interface}"
    command(<<-EOC)
      firewall-cmd #{zone} --change-interface=#{new_resource.interface}
      firewall-cmd --permanent #{zone} --change-interface=#{new_resource.interface}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
  e = execute "remove interface #{new_resource.interface} from zone" do
    only_if "firewall-cmd --permanent #{zone} --query-interface=#{new_resource.interface}"
    command(<<-EOC)
      firewall-cmd #{zone} --remove-interface=#{new_resource.interface}
      firewall-cmd --permanent #{zone} --remove-interface=#{new_resource.interface}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def zone
  new_resource.zone ? "--zone=#{new_resource.zone}" : ''
end
