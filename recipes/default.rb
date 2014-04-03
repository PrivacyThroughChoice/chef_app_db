#
# Cookbook Name:: chef_app_db
# Recipe:: default
#
# Copyright (C) 2014 Privacy Through Choice
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

include_recipe 'mysql::server'
include_recipe 'database::mysql'

db_conn =  {
    :host      => '127.0.0.1',
    :username  => 'root',
    :password  => node['mysql']['server_root_password']
}

mysql_database 'ptc-db' do
  connection db_conn
  action :create
end

mysql_database_user "ptc-db" do
  password 'changeme'
  host '%'
  database_name 'ptc-db'
  connection db_conn
  action :grant
end

cookbook_file "#{Chef::Config[:file_cache_path]}/mysql-init.sql" do
  owner 'root'
  group 'root'
  mode 0644
end

mysql_database 'init db' do
  connection db_conn
  database_name 'ptc-db'
  sql { ::File.open("#{Chef::Config[:file_cache_path]}/mysql-init.sql").read }
  action :query
end
