package 'firewalld'

service 'firewalld' do
  action [:enable, :start]
end

firewalld_rich_rule "ssh add" do
  zone 'public'
  family 'ipv4'
  source_address '192.168.100.0/24'
  service_name 'ssh'
  log_prefix 'ssh'
  log_level 'info'
  limit_value '1/m'
  firewall_action 'accept'
  action :add
end

rules = [
  'rule family="ipv4" source address="192.168.200.0/24" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept',
  'rule family="ipv4" source address="192.168.254.0/24" service name="ssh" log prefix="ssh" level="info" limit value="1/m" accept',
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
  source_address '192.168.254.0/24'
  log_prefix 'ssh'
  log_level 'info'
  limit_value '1/m'
  firewall_action 'accept'
  action :remove
end
