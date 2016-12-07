#
# Cookbook Name:: firewalld
# Provider:: masquerade
#
# Author:: Dru Goradia

use_inline_resources

action :add do
  e = execute "add masquerade to #{new_resource.zone} zone" do
    not_if "firewall-cmd --permanent --zone=#{new_resource.zone} --query-masquerade"
    command(<<-EOC)
      firewall-cmd --zone=#{new_resource.zone} --add-masquerade
      firewall-cmd --permanent --zone=#{new_resource.zone} --add-masquerade
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
  e = execute "remove masquerade from #{new_resource.zone} zone" do
    only_if "firewall-cmd --permanent --zone=#{new_resource.zone} --query-masquerade"
    command(<<-EOC)
      firewall-cmd --zone=#{new_resource.zone} --remove-masquerade
      firewall-cmd --permanent --zone=#{new_resource.zone} --remove-masquerade
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end
