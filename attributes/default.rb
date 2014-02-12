# encoding: UTF-8
#
# Cookbook Name:: openstack-orchestration
# Attributes:: default
#
# Copyright 2013, IBM Corp.
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

# Set to some text value if you want templated config files
# to contain a custom banner at the top of the written file
default['openstack']['orchestration']['custom_template_banner'] = '
# This file autogenerated by Chef
# Do not edit, changes will be overwritten
'

default['openstack']['orchestration']['verbose'] = 'False'
default['openstack']['orchestration']['debug'] = 'False'
# This is the name of the Chef role that will install the Keystone Service API
default['openstack']['orchestration']['identity_service_chef_role'] = 'os-identity'

# Gets set in the Heat Endpoint when registering with Keystone
default['openstack']['orchestration']['region'] = 'RegionOne'

# The name of the Chef role that knows about the message queue server
# that Heat uses
default['openstack']['orchestration']['rabbit_server_chef_role'] = 'os-ops-messaging'

default['openstack']['orchestration']['service_tenant_name'] = 'service'
default['openstack']['orchestration']['service_user'] = 'heat'
default['openstack']['orchestration']['service_role'] = 'admin'

default['openstack']['orchestration']['api']['auth']['version'] = 'v2.0'

# If set, heat API service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api']['bind_interface'] = nil

# If set, heat api-cfn service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api-cfn']['bind_interface'] = nil

# If set, heat api-cloudwatch service will bind to the address on this interface,
# otherwise it will bind to the API endpoint's host.
default['openstack']['orchestration']['api-cloudwatch']['bind_interface'] = nil

# Keystone PKI signing directory. Only written to the filter:authtoken section
# of the api-paste.ini when node['openstack']['auth']['strategy'] == 'pki'
default['openstack']['orchestration']['api']['auth']['cache_dir'] = '/var/cache/heat'

# logging attribute
default['openstack']['orchestration']['syslog']['use'] = false
default['openstack']['orchestration']['syslog']['facility'] = 'LOG_LOCAL2'
default['openstack']['orchestration']['syslog']['config_facility'] = 'local2'

# Common rpc definitions
default['openstack']['orchestration']['rpc_thread_pool_size'] = 64
default['openstack']['orchestration']['rpc_conn_pool_size'] = 30
default['openstack']['orchestration']['rpc_response_timeout'] = 60

# platform-specific settings
case platform
when 'fedora', 'redhat', 'centos' # :pragma-foodcritic: ~FC024 - won't fix this
  default['openstack']['orchestration']['user'] = 'heat'
  default['openstack']['orchestration']['group'] = 'heat'
  default['openstack']['orchestration']['platform'] = {
    'mysql_python_packages' => ['MySQL-python'],
    'postgresql_python_packages' => ['python-psycopg2'],
    'heat_common_packages' => ['openstack-heat'],
    'heat_client_packages' => ['python-heatclient'],
    'heat_api_packages' => ['python-heatclient'],
    'heat_api_service' => 'openstack-heat-api',
    'heat_api_cfn_packages' => ['python-heatclient'],
    'heat_api_cfn_service' => 'openstack-heat-api-cfn',
    'heat_api_cloudwatch_packages' => ['python-heatclient'],
    'heat_api_cloudwatch_service' => 'openstack-heat-api-cloudwatch',
    'heat_engine_packages' => [],
    'heat_engine_service' => 'openstack-heat-engine',
    'heat_api_process_name' => 'heat-api',
    'package_overrides' => ''
  }
when 'ubuntu'
  default['openstack']['orchestration']['user'] = 'heat'
  default['openstack']['orchestration']['group'] = 'heat'
  default['openstack']['orchestration']['platform'] = {
    'mysql_python_packages' => ['python-mysqldb'],
    'postgresql_python_packages' => ['python-psycopg2'],
    'heat_common_packages' => ['heat-common'],
    'heat_client_packages' => ['python-heatclient'],
    'heat_api_packages' => ['heat-api', 'python-heatclient'],
    'heat_api_service' => 'heat-api',
    'heat_api_cfn_packages' => ['heat-api-cfn', 'python-heatclient'],
    'heat_api_cfn_service' => 'heat-api-cfn',
    'heat_api_cloudwatch_packages' => ['heat-api-cloudwatch', 'python-heatclient'],
    'heat_api_cloudwatch_service' => 'heat-api-cloudwatch',
    'heat_engine_packages' => ['heat-engine'],
    'heat_engine_service' => 'heat-engine',
    'package_overrides' => "-o Dpkg::Options::='--force-confold' -o Dpkg::Options::='--force-confdef'"
  }
end
