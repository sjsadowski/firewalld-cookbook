firewalld_port "993/tcp"

%w{1001/tcp 1002/tcp}.each do |p|
  execute "add port #{p}" do
    command "firewall-cmd --permanent --add-port=#{p}"
  end
end

firewalld_port "1001/tcp" do
  action :remove
end