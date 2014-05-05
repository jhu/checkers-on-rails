# Checkers game (Rails)
Final project for SWE 681: Secure Software Design

### Current Status
The game is live at my Heroku cloud platform. Email me for the url.

### Setup Checkers game on localhost
0. Ensure you have all dependencies installed to be able to run Rails application in local Windows environment. See below for more instructions. 
1. Download my source code and unarchive the zip, navigate to the root of this unarchived folder
2. To install Rails dependencies with gem packages, run `bundle install`
3. To intialize the database, run `rake db:setup`. See important note below!
4. Run `rake db:migrate` to set up the database schema
5. Optional: To generate fake data for the database, run `rake db:populate` use `--trace` tag if it failed.
6. To start rails server `rails s` (Default port number is 3000 but you can specify port number by using `-p X` flag where X being any value) 
7. Navigate your browser (preferably Firefox) to `localhost:3000` 


**Important**: Be sure to change the `sysadmin` username password as it defaults to `Admin123` when deploying this app for first time!

### Setting up Windows environment for running Rails application
0. Install Ruby Installer 2.0.0 (32-bit) from [Ruby Installer for Windows](http://rubyinstaller.org/downloads/).
  * check off "Add Ruby executables to your PATH"
  * check off "Associate .rb and .rbw files with this Ruby installation"
1. Install Development Kit (32-bit) from the same Ruby Installer website. [Read this installation instructions](https://github.com/oneclick/rubyinstaller/wiki/Development-Kit#installation-instructions)
2. If you are running on Windows 8, you may need to install 32-bit [Node.js](http://nodejs.org/download/).
3. Run this in command: `gem install bundler`

### TODO
1. Add multiple jump capability
2. Review [Rails Security](http://guides.rubyonrails.org/security.html) and [OWASP Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)
