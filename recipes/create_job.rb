
remote_file '/opt/jenkins-cli.jar' do
  source "http://#{node[:jenkins][:ip]}/jnlpJars/jenkins-cli.jar"
  not_if { ::File.exists?( '/opt/jenkins-cli.jar' ) }
end

template '/opt/config.xml' do
  source   'var/lib/jenkins/jobs/petclinic/config.xml.erb'
  mode     '0755'
  variables({
    :nexus_repo = node[:jenkins][:nexus_repo]
  })
end



