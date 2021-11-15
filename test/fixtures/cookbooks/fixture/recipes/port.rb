package 'firewalld'

service 'firewalld' do
  action [:enable, :start]
end

firewalld_port '993/tcp'

%w(1001/tcp 1002/tcp).each do |p|
  execute "add port #{p} to runtime config" do
    command "firewall-cmd --add-port=#{p}"
  end
  execute "add port #{p} to permanent config" do
    command "firewall-cmd --permanent --add-port=#{p}"
  end
end

firewalld_port '1001/tcp' do
  action :remove
end
