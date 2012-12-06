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

notifying_action :grant do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = 'template1'
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password

  command = "GRANT #{new_resource.permissions.join(', ')} ON DATABASE \"#{new_resource.database}\" TO \"#{new_resource.username}\""

  bash "psql #{new_resource.name}" do
    user 'postgres'
    group 'postgres'
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command, options.merge(:match => 'GRANT'))
  end
end

notifying_action :revoke do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = 'template1'
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password

  command = "REVOKE #{new_resource.permissions.join(', ')} ON DATABASE \"#{new_resource.database}\" FROM \"#{new_resource.username}\""

  bash "psql #{new_resource.name}" do
    user 'postgres'
    group 'postgres'
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command, options.merge(:match => 'REVOKE'))
  end
end
