#
# Cookbook Name:: firewalld
# Provider:: zone
#
# Copyright:: 2015, Johnathan Kuperer

use_inline_resources

action :create_if_missing do

  # Check if zone exists by attempting to call --get-target
  zone_exists = system(
    'firewall-cmd','--permanent',"--zone=#{new_resource.zone}","--get-target",
    :out=>["/dev/null","w"], :err=>["/dev/null","w"]
  )

  if zone_exists
    Chef::Log.debug("firewalld zone #{new_resource.zone} exists, taking no action.")
    new_resource.updated_by_last_action( false )
  else
    action_create
    new_resource.updated_by_last_action( true )
  end
end

action :create do
  updated = false

  e_create = execute "new zone #{new_resource.zone}" do
    not_if "firewall-cmd --permanent --zone=#{new_resource.zone} --get-target"
    command(<<-EOC)
      firewall-cmd --permanent --new-zone=#{new_resource.zone}
      firewall-cmd --reload
    EOC
  end
  updated ||= e_create.updated_by_last_action?

  e_target = execute "set target for #{new_resource.zone} to #{target}" do
    #not_if "[ `firewall-cmd --permanent --zone=#{new_resource.zone} --get-target` = #{target} ]"
    not_if { target == Mixlib::ShellOut.new('firewall-cmd --permanent --zone=#{new_resource.zone} --get-target') }
    command(<<-EOC)
      firewall-cmd --permanent --zone=#{new_resource.zone} --set-target=#{target}
      firewall-cmd --reload
    EOC
  end
  updated ||= e_target.updated_by_last_action?

  if new_resource.default
    e_default = execute "set #{new_resource.zone} to be default zone" do
      not_if { new_resource.zone == Mixlib::ShellOut.new('firewall-cmd --get-default-zone') }
      command(<<-EOC)
        firewall-cmd --set-default-zone=#{new_resource.zone}
      EOC
    end
    updated ||= e_default.updated_by_last_action?
  end

  new_resource.updated_by_last_action( updated )
end

action :delete do
  e = execute "delete zone #{new_resource.zone}" do
    only_if "firewall-cmd --permanent --zone=#{new_resource.zone} --get-target"
    command(<<-EOC)
      firewall-cmd --permanent --delete-zone=#{new_resource.zone}
    EOC
  end
  new_resource.updated_by_last_action(e.updated_by_last_action?)
end

def target
  new_resource.target ? new_resource.target : 'default'
end
