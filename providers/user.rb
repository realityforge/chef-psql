#
# Copyright Peter Donald
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

use_inline_resources

action :create do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = 'template1'
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password

  command = "CREATE USER \"#{new_resource.username}\" WITH PASSWORD '#{new_resource.password}' #{new_resource.grant_create_db ? ' CREATEDB' : ''}  #{new_resource.grant_superuser ? ' SUPERUSER' : ''}"
  unless_command = "SELECT * FROM pg_user WHERE usename='#{new_resource.username}'"

  bash "psql #{new_resource.name}" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command, options.merge(:match => 'CREATE ROLE'))
    not_if Chef::PgCLI.pg_command(unless_command, options.merge(:match => '(1 row)'))
  end
end

action :drop do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = 'template1'
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password

  command = "DROP USER \"#{new_resource.username}\""
  unless_command = "SELECT * FROM pg_user WHERE usename='#{new_resource.username}'"

  bash "psql #{new_resource.name}" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command, options.merge(:match => 'DROP ROLE'))
    only_if Chef::PgCLI.pg_command(unless_command, options.merge(:match => '(1 row)'))
  end
end
