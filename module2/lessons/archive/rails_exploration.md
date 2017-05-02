---
layout: page
title: Advanced Routing in Rails
subheading: Web Applications with Ruby
---

0:50 Installing Rails
1:43 Rails principles (DRY, Conv over Config)
2:22 MVC
3:35 Development layout
4:05 rails new readit -d mysql
4:30 sqlite
4:54 bundler
5:33 Rails files and folders
7:05 Gemfile
7:17 bundle exec command for commands that don't execute
7:50 changing db to mysql in database.yml
8:46 rails s (webrick)
9:18 rails g controller welcome index
10:05 rails --version, ruby -v, rvm use ruby-2.2.0 and gem update rails --no-ri --no-rdoc
10:58 controllers > index
11:26 view > index
11:40 routes for index
11:58 erb file (HTML + Ruby)
12:22 % Ruby; %= Ruby with Output; %# Ruby with Comment
12:59 Output a string %= "count"
13:12 Loop % 11.times do |i| %= i
14:10 Make a new view 'Sample'
14:49 Routes > match ':controller(/:action(/:id))', :via => :get
15:40 Pass data from controller to views
15:50 Make Instance variable in Controller > @controller_message = "hi"
16:03 In View, add #{@controller_message}
16:39 Linking Pages: %= link_to("Go Index", {:action => 'index'})
18:00 Pass 'random' parameter from Sample View to Index View: :random => "X"
18:24 Controller/index > if(params.has_key?(:random)) @random = params[:random]
19:12 Show 'random' in the Index View: %= "random: #{params[:random]}"
20:08 mysql5 -u root -p
20:31 CREATE DATABASE readit_development;
20:50 show databases;
20:57 USE readit_development;
21:07 GRANT ALL PRIVILEGES ON readit_development.* TO 'admin'@localhost IENTIFIED BY 'pass';
21:34 Login as admin: mysql5 -u admin -p
21:41 use readit_development;
21:54 database.yml settings
22:17 Connect app to the db and create a schema.rb > rake db:schema:dump
23:23 Making a model > rails g model User
23:50 Define table via migration file (data types, options :default :string :limit :null :precision :scale)
27:00 Up create_table, Down drop_table
27:25 create tables by running the migration
27:35 Show the Database created: describe users;
28:19 revert to old db > rake db:migrate VERSION=timestamp,
28:42 show migration IDs > rake db:migrate:status﻿
