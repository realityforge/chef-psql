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

notifying_action :run do
  options = {}
  options[:host] = new_resource.host
  options[:port] = new_resource.port
  options[:dbname] = new_resource.dbname
  options[:admin_username] = new_resource.admin_username
  options[:admin_password] = new_resource.admin_password
  options[:match] = new_resource.match

  bash "psql #{new_resource.name}" do
    user new_resource.bash_user
    group new_resource.bash_group
    ignore_failure new_resource.ignore_failure
    returns new_resource.returns
    code Chef::PgCLI.pg_command(new_resource.command, options)
  end
end
