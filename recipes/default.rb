# include_recipe 'backup::default'
#
# backup_model node['database']['name'].to_sym do
#   definition <<-DEF
#     database MySQL do |db|
#       db.name = '#{node['database']['name']}'
#       db.username = '#{node['database']['user']['name']}'
#       db.password = '#{node['database']['user']['password']}'
#     end
#
#     compress_with Gzip
#
#     store_with S3 do |s3|
#       s3.access_key_id = '#{node['aws']['access_key_id']}'
#       s3.secret_access_key = '#{node['aws']['secret_access_key']}'
#       s3.bucket = '#{node['aws']['bucket']}'
#     end
#   DEF
#
#   schedule({
#     minute: '*/5'
#   })
# end

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
