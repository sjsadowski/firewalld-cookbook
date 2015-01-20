service 'firewalld' do
  action [:enable, :start]
end

firewalld_rich_rule "ssh add" do
  zone 'public'
  family 'ipv4'
  source_address '192.168.100.0/22'
  service_name 'ssh'
  log_prefix 'ssh'
  log_level 'info'
  limit_value '1/m'
  firewall_action 'accept'
  action :add
end

rules = [
  'rule family="ipv4" source address="192.168.200.0/22" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept',
  'rule family="ipv4" source address="192.168.254.0/22" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept',
]

rules.each do |r|
  execute "add #{r}" do
    command(<<-EOC)
    firewall-cmd --zone=public --add-rich-rule='#{r}'
    firewall-cmd --zone=public --add-rich-rule='#{r}' --permanent
    EOC
  end
end

firewalld_rich_rule "ssh remove" do
  zone 'public'
  family 'ipv4'
  service_name 'ssh'
  source_address '192.168.254.0/22'
  log_prefix 'ssh'
  log_level 'info'
  limit_value '1/m'
  firewall_action 'accept'
  action :remove
end


# Services
# amanda-client bacula bacula-client dhcp dhcpv6 dhcpv6-client dns ftp high-availability http https imaps ipp ipp-client ipsec kerberos kpasswd ldap ldaps libvirt libvirt-tls mdns mountd ms-wbt mysql nfs ntp openvpn pmcd pmproxy pmwebapi pmwebapis pop3s postgresql proxy-dhcp radius rpc-bind samba samba-client smtp ssh telnet tftp tftp-client transmission-client vnc-server wbem-https
