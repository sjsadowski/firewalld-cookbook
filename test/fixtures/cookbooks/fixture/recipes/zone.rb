
service 'firewalld' do
  action [:enable, :start]
end

firewalld_zone 'zone1'

%w(zone2 zone3).each do |z|
  execute "create zone #{z} in permanent config" do
    command "firewall-cmd --permanent --new-zone=#{z}"
  end
end

execute 'reload firewalld for new zones to appear in runtime config' do
  command 'firewall-cmd --reload'
end

firewalld_zone 'zone2' do
  action :delete
end
