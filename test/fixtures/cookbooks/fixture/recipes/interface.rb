service 'firewalld' do
  action [:enable, :start]
end

firewalld_interface "eth0"

%w{eth1 eth2}.each do |eth|
  execute "change interface #{eth} to runtime config" do
    command "firewall-cmd --change-interface=#{eth}"
  end
  execute "change interface #{eth} to permanent config" do
    command "firewall-cmd --permanent --change-interface=#{eth}"
  end
end

firewalld_interface "eth1" do
  action :remove
end
