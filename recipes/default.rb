include_recipe 'backup::default'

package "ruby-full"
backup_install node.name
backup_generate_config node.name
gem_package "fog" do
  version "~> 1.4.0"
end
backup_generate_model "MySQL" do
  database_type "MySQL"
  store_with({
    "engine" => "S3",
    "settings" => {
      "s3.access_key_id" => "#{node['backup']['aws']['access_key_id']}",
      "s3.secret_access_key" => "#{node['backup']['aws']['secret_access_key']}",
      "s3.region" => "eu-west-1",
      "s3.bucket" => "#{node['backup']['aws']['bucket']}",
      "s3.path" => "/",
      "s3.keep" => 100
    }
  })
  options({
    "db.name" => "#{node['backup']['database']['name']}",
    "db.username" => "#{node['backup']['database']['username']}",
    "db.password" => "#{node['backup']['database']['password']}"
  })
  hour '*'
  minute '*/5'
  action :backup
end
