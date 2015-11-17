
remote_file '/opt/jenkins-cli.jar' do
  source "http://#{node[:jenkins][:ip]}/jnlpJars/jenkins-cli.jar"
  not_if { ::File.exists?( '/opt/jenkins-cli.jar' ) }
end

directory "/var/lib/jenkins/.m2" do
  action :create
  recursive true
  owner node[:jenkins][:user]
  group node[:jenkins][:group]
  mode '0755'
end

template '/etc/maven/settings.xml' do
  source   'etc/maven/settings.xml.erb'
  mode     '0755'
  variables({})
end



template '/opt/config.xml' do
  source   'var/lib/jenkins/jobs/petclinic/config.xml.erb'
  mode     '0755'
  variables({
    :nexus_repo => node[:jenkins][:nexus_repo]
  })
end
execute "java -jar jenkins-cli.jar -s http://#{node[:jenkins][:ip]} delete-job #{node[:jenkins][:job_name]}" do
  cwd "/opt"
  only_if "java -jar jenkins-cli.jar -s http://#{node[:jenkins][:ip]} list-jobs | grep #{node[:jenkins][:job_name]}"
end
execute "java -jar jenkins-cli.jar -s http://#{node[:jenkins][:ip]} create-job #{node[:jenkins][:job_name]} < config.xml" do
  cwd "/opt"
end




