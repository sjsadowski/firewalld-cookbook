
service 'firewalld' do
  action [:enable, :start]
end

firewalld_source "192.168.0.0/24"

%w{192.168.1.0/24 192.168.2.0/24}.each do |ip|
  execute "add source #{ip} to runtime config" do
    command "firewall-cmd --add-interface=#{ip}"
  end
  execute "add source #{ip} to permanent config" do
    command "firewall-cmd --permanent --add-interface=#{ip}"
  end
end

firewalld_source "192.168.1.0/24" do
  action :remove
end
