#
# Cookbook Name:: firewalld
# Recipe:: disable
#

package 'iptables-services' if node['firewalld']['iptables_fallback']

service 'firewalld' do
  action [:disable, :stop]
end

service 'iptables' do
  action [:enable, :start]
  only_if { node['firewalld']['iptables_fallback'] }
end

service 'ip6tables' do
  action [:enable, :start]
  only_if { node['firewalld']['iptables_fallback'] }
end
