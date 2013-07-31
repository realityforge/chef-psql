Description
===========

[![Build Status](https://secure.travis-ci.org/realityforge/chef-psql.png?branch=master)](http://travis-ci.org/realityforge/chef-psql)

A set of LWRPs for interacting with postgres using the CLI.

Usage
=====

The cookbook is simply a set of LWRPs that you can use in your own cookbook. A simple example follows.

    psql_user "myuser" do
      host node['fqdn']
      port node['postgresql']['config']['port']
      admin_username 'postgres'
      admin_password node['postgresql']['password']['postgres']
      password 'secret'
      grant_create_db false
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
