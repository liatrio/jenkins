
#
# recipe to install various jenkins plugins
#
# GIT  Client Plugin is the first, GIT Plugin depends on it.
#
# From: http://stackoverflow.com/questions/7709993/how-can-i-update-jenkins-plugins-from-the-terminal
#


user node[:jenkins][:user] do
  action :create
end

group node[:jenkins][:group] do
  action :create
end

execute "wget http://#{node[:jenkins][:ip]}/jnlpJars/jenkins-cli.jar" do
  cwd "/opt"
  not_if { ::File.exists?('/opt/jenkins-cli.jar') }
end

directory plugins_dir do
  action :create
  recursive true
  owner node[:jenkins][:user]
  group node[:jenkins][:group]
  mode '0755'
end

plugins_list.each do |plugin_name|
  remote_file "#{node[:jenkins][:plugins_dir]}/#{plugin_name}.hpi" do
    source "#{node[:jenkins][:plugins_site]}/#{plugin_name}.hpi"
    not_if { ::File.exists?( "#{node[:jenkins][:plugins_dir]}/#{plugin_name}.hpi" ) }
  end
end

execute "curl http://#{node[:jenkins][:ip]}/safeRestart -X POST -i" # " && sleep #{node[:jenkins][:sleep_interval]}"











