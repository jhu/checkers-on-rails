# Checkers game (Rails)
Final project for SWE 681: Secure Software Design

### Current Status
Still buggy and being tested but the game is live at my Heroku cloud platform. Email me for the url.

### Setup Checkers on localhost
0. Ensure you have at least Ruby 2.1.0 installed. See below for installation details. (besure to check enable "Add Ruby executables to your PATH")
install Development Kit also ()
1. `gem install bundler`
1. Download and unarchive the zip, navigate to the root of this unarchived folder
2. To install gem packages, run `bundle install`
3. To intialize the database, run `rake db:setup`
4. Optional: To generate fake data for the database, run `rake db:populate` use `--trace` tag if it failed.
5. To start rails server `rails s` (Default port number is 3000 but you can specify port number by using `-p X` flag where X being any value) 
6. Navigate to `localhost:3000` 

Install Ruby Installer 2.0.0 (32-bit)
    check off Add Ruby executables to your PATH
    check off Associate .rb and .rbw files with this Ruby installation?
Install Development Kit (32-bit) (https://forwardhq.com/support/installing-ruby-windows
https://github.com/oneclick/rubyinstaller/wiki/Development-Kit
Note: if you are on Windows 8, you may want to install Nodejs (probably 32 bit http://nodejs.org/download/)
Ruby Installer 2.0.0
install dev kit:
gem install bundler
bundle install
optional rake db:setup
rake db:migrate

**Important**: Be sure to change the `sysadmin` username password as it defaults to `Admin123` when deploying this app for first time!

### Ruby 2.1.x Installation
- [Ruby Installation Information](https://www.ruby-lang.org/en/downloads/) 
- [Recommended installer for Windows](http://rubyinstaller.org/)

### TODO
1. Add multiple jump capability
2. Review [Rails Security](http://guides.rubyonrails.org/security.html) and [OWASP Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)
