
remote_file '/opt/jenkins-cli.jar' do
  source "http://#{node[:jenkins][:ip]}/jnlpJars/jenkins-cli.jar"
  not_if { ::File.exists?( '/opt/jenkins-cli.jar' ) }
end

template '/var/lib/jenkins/.m2/settings.xml' do
  source   'var/lib/jenkins/.m2/settings.xml.erb'
  mode     '0755'
  variables({})
end



template '/opt/config.xml' do
  source   'var/lib/jenkins/jobs/petclinic/config.xml.erb'
  mode     '0755'
  variables({
    :nexus_repo = node[:jenkins][:nexus_repo]
  })
end
execute "java -jar jenkins-cli.jar -s http://#{node[:jenkins][:ip]} create-job petclinic-auto-1 < config.xml" do
  cwd "/opt"
end




