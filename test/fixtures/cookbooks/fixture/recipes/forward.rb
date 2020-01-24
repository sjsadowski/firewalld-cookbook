package 'firewalld'

service 'firewalld' do
  action [:enable, :start]
end

firewalld_forward "forward 443 to 8443" do
  port 443
  to_port 8443
  protocol :tcp
end

execute "Verify port 443 rule is up" do
  command "firewall-cmd --query-forward-port=port=443:proto=tcp:toport=8443"
end

execute "Verify port 443 rule is up" do
  command "firewall-cmd --permanent --query-forward-port=port=443:proto=tcp:toport=8443"
end

firewalld_forward "remove forward port 443" do
  port 443
  to_port 8443
  protocol :tcp
  action :remove
end
