################################################
# sandbox-php Chef provisioning: apachephp
# @author Erika Heidi <erika@erikaheidi.com>
################################################

# apache and php5
["apache2", "php5"].each do |p|

 apt_package p do
     action :install
 end

end

# php packages
node['php']['packages'].each do |p|

 apt_package p do
     action :install
 end

end

service "apache2" do
    action [ :enable, :start ]
end

# set apache default site
template "/etc/apache2/sites-available/000-default.conf" do
    source "vhost.conf.erb"
    variables({
        :doc_root    => node['apache']['doc_root']
    })
    action :create
    notifies :restart, resources(:service => "apache2")
end