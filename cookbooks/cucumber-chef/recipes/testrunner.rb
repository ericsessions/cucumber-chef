%w{build-essential binutils-doc libxml2-dev libxslt1-dev}.each do |pkg|
  package pkg do
    action :install
  end
end

package "autoconf" do
  action :install
end

package "flex" do
  action :install
end

package "bison" do
  action :install
end

package "git-core" do
  action :install
end

node['cucumber-chef'][:gems].each do |gem|
    gem_package gem
end

##install cucumber-chef gem
bash 'install cucumber-chef gem' do
  cwd '/tmp'
  code <<-EOH
  git clone git@github.com:ericsessions/cucumber-chef.git . -q
  bundle install
  rake install
  EOH
end

directory "/root/.ssh" do
  owner "root"
  mode "0600"
end

cookbook_file "/root/.ssh/git-key.rsa" do
  source "git-private-key"
end

cookbook_file "/root/.ssh/config" do
  source "permissive-ssh-config"
end

cookbook_file "/root/.ssh/id_rsa" do
  source "cucumber-private-key"
  mode "0600"
  owner "root"
end

cookbook_file "/root/.bashrc" do
  source "add-git-identity"
end


