#
# Cookbook Name:: firewalld
# Recipe:: enable
#

package 'firewalld'

service 'firewalld' do
  action [:enable, :start]
end

service 'iptables' do
  action [:disable, :stop]
  only_if { node['firewalld']['iptables_fallback'] }
end

service 'ip6tables' do
  action [:disable, :stop]
  only_if { node['firewalld']['iptables_fallback'] }
end
