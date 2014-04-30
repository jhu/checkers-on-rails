# Checkers game (Rails)
Final project for SWE 681: Secure Software Design

### Current Status
Still buggy and being tested but the game is live at [Heroku](https://gentle-meadow-9245.herokuapp.com/) cloud platform. 

### Setup Checkers on localhost
0. Ensure you have at least Ruby 2.1.0 installed. See below for installation details.
1. To install gem packages, run `bundle install`
2. To intialize the database, run `rake db:setup`
3. To start rails server `foreman start`
4. Navigate to `localhost:5000`

### Ruby 2.1.x Installation
- [Ruby Installation Information](https://www.ruby-lang.org/en/downloads/) 
- [Recommended installer for Windows](http://rubyinstaller.org/)

### TODO
1. Add styling to game results
2. Fix the read me
3. Add multiple jump capability
4. Review [Rails Security](http://guides.rubyonrails.org/security.html) and [OWASP Rails Cheatsheet](https://www.owasp.org/index.php/Ruby_on_Rails_Cheatsheet)
