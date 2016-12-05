#
# Cookbook Name:: firewalld
# Provider:: source
#
# Copyright:: 2015, Johnathan Kuperer

use_inline_resources

action :add do
  e = execute "add source #{new_resource.source} to zone" do
    not_if "firewall-cmd --permanent #{zone} --query-source=#{new_resource.source}"
    command(<<-EOC)
      firewall-cmd #{zone} --add-source=#{new_resource.source}
      firewall-cmd --permanent #{zone} --add-source=#{new_resource.source}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :change do
  e = execute "change source #{new_resource.source} to zone" do
    not_if "firewall-cmd --permanent #{zone} --query-source=#{new_resource.source}"
    command(<<-EOC)
      firewall-cmd #{zone} --change-source=#{new_resource.source}
      firewall-cmd --permanent #{zone} --change-source=#{new_resource.source}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
  e = execute "remove source #{new_resource.source} from zone" do
    only_if "firewall-cmd --permanent #{zone} --query-source=#{new_resource.source}"
    command(<<-EOC)
      firewall-cmd #{zone} --remove-source=#{new_resource.source}
      firewall-cmd --permanent #{zone} --remove-source=#{new_resource.source}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def zone
  new_resource.zone ? "--zone=#{new_resource.zone}" : ''
end
