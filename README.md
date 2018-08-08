An example for running Cucumber tests with Capybara
============================================================

The setup below is intended for running on Macbook OSX. 

You will need this before running: 

    * Homebrew for OSX 
    * Ruby 2.4+

To install Homebrew, in your terminal, run the command
 
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    
Type `brew` in your terminal to see if homebrew is installed. If it is not a known command, try restarting your terminal and run the command again.    

To check which version of Ruby you have run this command in terminal

    ruby -v

If you don't have a preference to what version Ruby you're using, this command will install the most stable version of ruby available

    brew install ruby
     
Firefox is installed as the default browser to run selenium tests. You will need Chromedriver installed to run the test on Chrome:     

    brew install chromedriver
    
To run the test in chrome, change the broswer instance in `env.rb` from `:browser => :firefox` to `:browser => :chrome`
     
Once you have completed the above steps, go to the project root folder and run this command to download ruby dependencies:  

    bundle install 
    
Use this command to run the UI test:

    bundle exec cucumber features/
