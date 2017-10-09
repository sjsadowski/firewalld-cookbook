#
# Cookbook Name:: firewalld
# Provider:: forward
#
# Copyright:: 2017, Alfred Moreno

use_inline_resources

action :add do
    e = execute "add forward port #{new_resource.port}:#{new_resource.protocol} => #{new_resource.to_port} #{new_resource.address}" do
        not_if "firewall-cmd --query-forward-port=port=#{new_resource.port}:proto=#{new_resource.protocol}:toport=#{new_resource.to_port}#{address}"
        command(firewall_command(:add))
    end

    new_resource.updated_by_last_action(e.updated_by_last_action?)
end

action :remove do
    e = execute "remove forward port #{new_resource.port}:#{new_resource.protocol} => #{new_resource.to_port} #{new_resource.address}" do
        only_if "firewall-cmd --query-forward-port=port=#{new_resource.port}:proto=#{new_resource.protocol}:toport=#{new_resource.to_port}#{address}"
        command(firewall_command(:remove))
    end

    new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def firewall_command(operation)
    <<-EOC
        firewall-cmd #{zone} --#{operation.to_s}-forward-port=port=#{new_resource.port}:proto=#{new_resource.protocol}:toport=#{new_resource.to_port}#{address}"
        firewall-cmd --permanent #{zone} --#{operation.to_s}-forward-port=port=#{new_resource.port}:proto=#{new_resource.protocol}:toport=#{new_resource.to_port}#{address}"
    EOC
end

def address
    new_resource.address ? ":toaddr=#{new_resource.address}" : ''
end

def zone
    new_resource.zone ? "--zone=#{new_resource.zone}" : ''
end
