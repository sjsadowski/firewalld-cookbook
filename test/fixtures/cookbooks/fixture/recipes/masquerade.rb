service 'firewalld' do
  action [:enable, :start]
end

firewalld_masquerade 'public'

execute 'add masquerade to public zone' do
  command 'firewall-cmd --zone=public --add-masquerade'
end

execute 'add masquerade to public zone permanently' do
  command 'firewall-cmd --permanent --zone=public --add-masquerade'
end

firewalld_masquerade 'public' do
  action :remove
end
