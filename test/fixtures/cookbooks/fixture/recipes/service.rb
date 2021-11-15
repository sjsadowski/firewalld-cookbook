
firewalld_service 'http'

%w(telnet).each do |p|
  execute "add service #{p} to runtime config" do
    command "firewall-cmd --add-service=#{p}"
  end
  execute "add service #{p} to permanent config" do
    command "firewall-cmd --permanent --add-service=#{p}"
  end
end

firewalld_service 'telnet' do
  action :remove
end
