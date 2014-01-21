################################################
# sandbox-php Chef provisioning: composer
# @author Erika Heidi <erika@erikaheidi.com>
################################################

execute "get-composer" do
    cwd '/home/vagrant'
    command "curl -sS https://getcomposer.org/installer | php"
    creates '/home/vagrant/composer.phar'
end

execute "move-composer" do
    cwd '/home/vagrant'
    command "cp composer.phar /usr/bin/composer"
    creates '/usr/bin/composer'
end