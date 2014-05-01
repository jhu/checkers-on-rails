# Checkers game (Rails)
Final project for SWE 681: Secure Software Design

### Current Status
Still buggy and being tested but the game is live at my Heroku cloud platform. Email me for the url.

### Setup Checkers on localhost
0. Ensure you have at least Ruby 2.1.0 installed. See below for installation details.
1. Download and unarchive the zip, navigate to the root of this unarchived folder
2. To install gem packages, run `bundle install`
3. To intialize the database, run `rake db:setup`
4. Optional: To generate fake data for the database, run `rake db:populate` use `--trace` tag if it failed.
5. To start rails server `rails s` (Default port number is 3000 but you can specify port number by using `-p XXXX' flag where XXXX being any value) 
6. Navigate to `localhost:3000` 

*Important*: Be sure to change the `admin` username password as it defaults to `Admin123` when deploying this app for first time!

### Ruby 2.1.x Installation
- [Ruby Installation Information](https://www.ruby-lang.org/en/downloads/) 
- [Recommended installer for Windows](http://rubyinstaller.org/)

### TODO
1. Add styling to game results
2. Fix the read me
3. Add multiple jump capability
4. Review [Rails Security](http://guides.rubyonrails.org/security.html) and [OWASP Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)
