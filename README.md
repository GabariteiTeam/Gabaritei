#Gabaritei Project


## Introduction

Gabaritei is an easy-to-use educational platform, that aims non-university environment, like highshchol, languages classes and much more. It's built out of the box with usefull tools like social sharing, drag n'drop, internationalization, embedded resources (YouTube, Google Drive), advanced question editing and a complete platform to create online tests.

As it's open source, if you're a developer, you may step in and take a look under the hood. You may also translate the system into your own language, set-up colors and much more.

Simplicity is the keyword to build Gabaritei. Everything is easy and simple, with few clicks you get things done. What about installing? You may check our binary installer, so that you don't need to handle complex configurations if you just want to test it.

Made with **love** by Gabaritei Team.

## Technologies

Using the most recent technologies, we built a system that is simple to use, modern and responsive. So, what it's under Gabaritei?

    * Ruby on Rails
    * Bootstrap and Bootswatch
    * AngularJS
    * NodeJS
    * Many other gems and angular modules
    
## How do I get started?

### The hard way

#### Clone our repository

You may want to start the hardway, so clone our repository:

```
git clone https://github.com/GabariteiTeam/Gabaritei.git
```

#### Install support applications

Note that to proceed, you may need to setup some applications to run on your computer:

**Install NodeJS** 
Just goto https://nodejs.org/en/ and download the installer, if Windows.
If Linux, it depends on your distribution, but assuming Debian/Ubuntu, just go for:
```
sudo apt-get install nodejs           # install nodejs
sudo apt-get install nodejs-legacy    # ensures that it's compatible with ruby bower interface
sudo apt-get install npm              # node package manager
npm install bower -g                  # bower for our front-end dependencies
```

**Install Ruby on Rails**

On Windows, go for: http://rubyinstaller.org/ and download ruby installer AND don't forget to install devkit as well.

A simple way to install Ruby on Rails on Linux is using RVM, on Ubuntu/Debian:

```
# install libraries needed by ruby
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
# downloads RVM and install ruby
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.2.3
rvm use 2.2.3 --default
ruby -v
echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler

# install Rails 
gem install rails -v 4.2.4
```

**Install ImageMagick**

One last dependency is ImageMagick, on Linux Ubuntu/Debian is quite easy:

```
sudo apt-get install imagemagick libmagickwand-dev
```

On Windows is quite trickier, so go for (https://www.redmine.org/projects/redmine/wiki/HowTo_install_rmagick_gem_on_Windows):

* Download and install imagemagick binary release for Windows. On "Select Aditional Tasks", make shure to check the options "Add application directory to your system path" and "Install development headers and libraries for C and C++"
* Set your system path (Right click on "My Computer", then "Properties", then "Advanced System Settings", finally click "Environment Variables") and add:
```
set CPATH=C:\Program Files (x86)\ImageMagick-6.7.9-Q16\include
set LIBRARY_PATH=C:\Program Files (x86)\ImageMagick-6.7.9-Q16\l
```

#### Project settings

Go for it:

```
cd Gabaritei/
sudo apt-get install libmysql-ruby libmysqlclient-dev   # makes sure that mysql libs won't fail the build
bundle install                                          # install ruby gems
rake bower:install                                      # install bower front-end dependencies
rake db:lazy                                            # set's up database
rails s                                                 # start rails server (testing only)
```
