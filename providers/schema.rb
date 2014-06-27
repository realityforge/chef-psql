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

notifying_action :grant_usage do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = new_resource.database
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password

  command1 = "GRANT ALL ON ALL TABLES IN SCHEMA \"#{new_resource.schema}\" TO \"#{new_resource.username}\""
  command2 = "GRANT ALL ON ALL SEQUENCES IN SCHEMA \"#{new_resource.schema}\" TO \"#{new_resource.username}\""
  command3 = "GRANT USAGE ON SCHEMA \"#{new_resource.schema}\" TO \"#{new_resource.username}\""

  bash "psql #{new_resource.name} - tables" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command1, options.merge(:match => 'GRANT'))
  end

  bash "psql #{new_resource.name} - sequences" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command2, options.merge(:match => 'GRANT'))
  end

  bash "psql #{new_resource.name} - schema" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    code Chef::PgCLI.pg_command(command3, options.merge(:match => 'GRANT'))
  end
end
