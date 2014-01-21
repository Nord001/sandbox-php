################################################
# sandbox-php Chef provisioning: mysql
# @author Erika Heidi <erika@erikaheidi.com>
################################################

# mysql server and client
["mysql-server", "mysql-client"].each do |p|

 apt_package p do
     action :install
 end

end

service "mysql" do
    action [ :enable, :start ]
end

execute "set-mysql-root" do
    command "mysqladmin -uroot password #{node['mysql']['default_pass']}"
    not_if "mysqladmin -uroot -p#{node['mysql']['default_pass']} status"
end

execute "create-database" do
    command "mysql -uroot -p#{node['mysql']['default_pass']} -e \"create user '#{node['mysql']['default_user']}'@'localhost' identified by '#{node['mysql']['default_pass']}'; create database #{node['mysql']['default_db']}; grant all on #{node['mysql']['default_db']}.* to #{node['mysql']['default_user']}@localhost;\""
    not_if "mysql -u#{node['mysql']['default_user']} -p#{node['mysql']['default_pass']} #{node['mysql']['default_db']}"
end
