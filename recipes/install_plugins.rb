
#
# recipe to install various jenkins plugins
#
# GIT  Client Plugin is the first, GIT Plugin depends on it.
#
# From: http://stackoverflow.com/questions/7709993/how-can-i-update-jenkins-plugins-from-the-terminal
#

plugins_dir  = "/var/lib/jenkins/plugins"
plugins_site = "http://updates.jenkins-ci.org/download/plugins"
plugins_site = "https://updates.jenkins-ci.org/latest/" # +"git.hpi"
jenkins_ip   = "192.168.56.31:8080"
plugins_list = %w( git git-client build-pipeline-plugin )


plugins_list.each do |plugin_name|
  remote_file "#{plugins_dir}/#{plugin_name}.hpi" do
    source "#{plugins_site}/#{plugin_name}.hpi"
  end
end

execute "curl http://#{jenkins_ip}/safeRestart -X POST -i"

