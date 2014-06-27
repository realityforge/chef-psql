# Description

[![Build Status](https://secure.travis-ci.org/realityforge/chef-psql.png?branch=master)](http://travis-ci.org/realityforge/chef-psql)

A set of LWRPs for interacting with postgres using the CLI.

Dependencies
============

The cookbook requires the 'psql' client utility for postgres to be installed on the node. However there is no depedence on a
cookbook that installs this utlility. One can be found here: https://github.com/opscode-cookbooks/postgresql.git

# Requirements

## Platform:

*No platforms defined*

## Cookbooks:

* cutlery (~> 0.1)

# Attributes

*No attributes defined*

# Recipes

*No recipes defined*

# Resources

* [psql_database](#psql_database)
* [psql_exec](#psql_exec)
* [psql_permission](#psql_permission)
* [psql_schema](#psql_schema)
* [psql_user](#psql_user)

## psql_database

### Actions

- create:  Default action.
- drop: 
- owner: 

### Attribute Parameters

- host: 
- port:  Defaults to <code>5432</code>.
- admin_username:  Defaults to <code>nil</code>.
- admin_password:  Defaults to <code>nil</code>.
- database: 
- owner: 
- encoding:  Defaults to <code>"DEFAULT"</code>.
- template:  Defaults to <code>nil</code>.
- tablespace:  Defaults to <code>nil</code>.
- collation:  Defaults to <code>nil</code>.
- connection_limit:  Defaults to <code>nil</code>.
- bash_user:  Defaults to <code>"postgres"</code>.
- bash_group:  Defaults to <code>"postgres"</code>.

## psql_exec

### Actions

- run:  Default action.

### Attribute Parameters

- command: 
- host: 
- port:  Defaults to <code>5432</code>.
- admin_username:  Defaults to <code>nil</code>.
- admin_password:  Defaults to <code>nil</code>.
- dbname: 
- match:  Defaults to <code>nil</code>.
- returns:  Defaults to <code>0</code>.
- bash_user:  Defaults to <code>"postgres"</code>.
- bash_group:  Defaults to <code>"postgres"</code>.

## psql_permission

### Actions

- grant:  Default action.
- revoke: 

### Attribute Parameters

- host: 
- port:  Defaults to <code>5432</code>.
- admin_username:  Defaults to <code>nil</code>.
- admin_password:  Defaults to <code>nil</code>.
- username: 
- database: 
- permissions: 
- bash_user:  Defaults to <code>"postgres"</code>.
- bash_group:  Defaults to <code>"postgres"</code>.

## psql_schema

### Actions

- grant_usage: 

### Attribute Parameters

- host: 
- port:  Defaults to <code>5432</code>.
- admin_username:  Defaults to <code>nil</code>.
- admin_password:  Defaults to <code>nil</code>.
- database: 
- schema: 
- username: 
- bash_user:  Defaults to <code>"postgres"</code>.
- bash_group:  Defaults to <code>"postgres"</code>.

## psql_user

### Actions

- create:  Default action.
- drop: 

### Attribute Parameters

- host: 
- port:  Defaults to <code>5432</code>.
- admin_username:  Defaults to <code>nil</code>.
- admin_password:  Defaults to <code>nil</code>.
- username: 
- password: 
- grant_create_db:  Defaults to <code>false</code>.
- bash_user:  Defaults to <code>"postgres"</code>.
- bash_group:  Defaults to <code>"postgres"</code>.

### Usage

The cookbook is simply a set of LWRPs that you can use in your own cookbook. A simple example follows.

    psql_user "myuser" do
      host node['fqdn']
      port node['postgresql']['config']['port']
      admin_username 'postgres'
      admin_password node['postgresql']['password']['postgres']
      password 'secret'
    end

    psql_database "mydatabase" do
      host node['fqdn']
      port node['postgresql']['config']['port']
      admin_username 'postgres'
      admin_password node['postgresql']['password']['postgres']
      owner 'myuser'
      template 'template_postgis'
      encoding 'DEFAULT'
      tablespace 'MyTablespace'
      collation 'fr_FR'
      connection_limit -1
    end

    psql_permission "myuser@mydatabase => all" do
      host node['fqdn']
      port node['postgresql']['config']['port']
      admin_username 'postgres'
      admin_password node['postgresql']['password']['postgres']
      username 'myuser'
      database 'mydatabase'
      permissions ['ALL']
    end


# License and Maintainer

Maintainer:: Peter Donald (<peter@realityforge.org>)

License:: Apache 2.0
