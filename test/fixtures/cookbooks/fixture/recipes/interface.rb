service 'firewalld' do
  action [:enable, :start]
end

firewalld_interface "eth0"

%w{eth1 eth2}.each do |eth|
  execute "add interface #{eth} to runtime config" do
    command "firewall-cmd --add-interface=#{eth}"
  end
  execute "add interface #{eth} to permanent config" do
    command "firewall-cmd --permanent --add-interface=#{eth}"
  end
end

firewalld_interface "eth1" do
  action :remove
end
