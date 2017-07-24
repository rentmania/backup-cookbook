include_recipe 'backup::default'

backup_model node['database']['name'].to_sym do
  definition <<-DEF
    database MySQL do |db|
      db.name = '#{node['database']['name']}'
      db.username = '#{node['database']['user']['name']}'
      db.password = '#{node['database']['user']['password']}'
    end

    compress_with Gzip

    store_with S3 do |s3|
      s3.access_key_id = '#{node['aws']['access_key_id']}'
      s3.secret_access_key = '#{node['aws']['secret_access_key']}'
      s3.bucket = '#{node['aws']['bucket']}'
    end
  DEF

  schedule({
    minute: '*/5'
  })
end
