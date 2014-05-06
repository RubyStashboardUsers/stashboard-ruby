# Updated Stashboard gem [![Gem Version](https://badge.fury.io/rb/stashboard-ruby.svg)](https://rubygems.org/gems/stashboard-ruby) [![Build Status](https://travis-ci.org/RubyStashboardUsers/stashboard-ruby.svg?branch=master)](https://travis-ci.org/RubyStashboardUsers/stashboard-ruby)

Simple little ruby library for interacting with a Stashboard instance
([http://www.stashboard.org](http://www.stashboard.org).

Stashboard is a Python application designed to be run on the Google App Engine,
which provides a system status type page for your application similar to the
status pages offered by [Amazon AWS](http://status.aws.amazon.com/), or 
[Google Apps](http://www.google.com/appsstatus).

This library doesn't address setting up your Stashboard instance, but
simplifies interacting with it from Ruby.

This is an updated version of the stashboard gem from [Sam Mulbe](https://github.com/smulube/stashboard-ruby), with fixes from [Brian Stolz](https://github.com/tecnobrat/stashboard-ruby). This new gem has been created to implement some much-needed updates, as the previous gem is no longer being actively maintained.

I've tried to add some extra set-up instructions to the below usage to help beginners aswell.

# Setup
    
### 1. Download the SDK
Download the latest [Python SDK for Google App Engine](http://code.google.com/appengine/downloads.html#Google_App_Engine_SDK_for_Python).

### 2. Get the project
Download and extract the [Stashboard project](http://github.com/twilio/stashboard/tarball/master) to your computer.

### 3. Run Locally
Open the SDK, choose
```
File > Add Existing Application...
```

Navigate to:
```
Project folder > stashboard
```
Select open, press Run and navigate to *http://localhost:{port}* to see your Stashboard installation.

### 4. Deploy to AppSpot
4.1. [Sign up for an AppSpot account](https://developers.google.com/appengine/docs/python/gettingstartedpython27/uploading?csw=1).

4.2. Create an application within AppSpot - specifying Python as the language.

4.3. Update your *app.yaml* file (within the local project folder) and change the *application-id* to the name of your newly created application.

4.4. Hit the 'Deploy' button, wait a couple of seconds, and then navigate to *http://{app-name}.appspot.com* to enjoy your new status dashboard

# Usage
Into your Gemfile add the line
```ruby
gem "stashboard-ruby"
```

Inside of your project, first create a new Stashboard
```ruby
stashboard = Stashboard::Stashboard.new("https://your-app.appspot.com", "<stashboard_oauth_token>", "<stashboard_oauth_secret>")
```

To receive an array of services:
```ruby
stashboard.services
=begin
 =>  [
        {
          "description"=>"Mail Service", 
          "url"=>"https://YOURAPP.appspot.com/api/v1/services/mail-service", 
          "list"=>{
            "url"=>"https://YOURAPP.appspot.com/api/v1/service-lists/application-services", 
            "description"=>"The main services that run the application", 
            "name"=>"Application Services", 
            "id"=>"application-services"
          }, 
          "current-event"=>nil, 
          "id"=>"mail-service", 
          "name"=>"Mail Service"
        }, 
        {
          "description"=>"PDF Cleaner", 
          "url"=>"https://YOURAPP.appspot.com/api/v1/services/pdf-cleaner", 
          "list"=>{
            "url"=>"https://YOURAPP.appspot.com/api/v1/service-lists/helper-services", 
            "description"=>"The little bits that help without being part of the app itself", 
            "name"=>"Helper Services", "id"=>"helper-services"
          }, 
          "current-event"=>nil, 
          "id"=>"pdf-cleaner", 
          "name"=>"PDF Cleaner"
        }, 
        {
          "description"=>"Website service",
          "url"=>"https://YOURAPP.appspot.com/api/v1/services/website", 
          "current-event"=>{
            "status"=>{
              "description"=>"The service is up", 
              "level"=>"NORMAL", 
              "default"=>true, 
              "image"=>"https://YOURAPP.appspot.com/images/icons/iconic/check_alt.png", 
              "url"=>"https://YOURAPP.appspot.com/api/v1/statuses/up", 
              "id"=>"up", 
              "name"=>"Up"
            }, 
            "url"=>"https://YOURAPP.appspot.com/api/v1/services/website/events/ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
            "timestamp"=>"Mon, 28 Apr 2014 14:48:16 GMT", 
            "sid"=>"ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
            "message"=>"Web server running A-OK", 
            "informational"=>false
          },
          "id"=>"website", 
          "name"=>"Website"
        }
      ]
=end
```

To receive an array of service ids:
```ruby
stashboard.service_ids
# =>  ["mail-service", "pdf-cleaner", "website"]
```

To get details of a service based on it's id:
```ruby
stashboard.service("website")
=begin
 =>  {
        "description"=>"Website service",
        "url"=>"https://YOURAPP.appspot.com/api/v1/services/website", 
        "current-event"=>{
          "status"=>{
            "description"=>"The service is up", 
            "level"=>"NORMAL", 
            "default"=>true, 
            "image"=>"https://YOURAPP.appspot.com/images/icons/iconic/check_alt.png", 
            "url"=>"https://YOURAPP.appspot.com/api/v1/statuses/up", 
            "id"=>"up", 
            "name"=>"Up"
          }, 
          "url"=>"https://YOURAPP.appspot.com/api/v1/services/website/events/ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
          "timestamp"=>"Mon, 28 Apr 2014 14:48:16 GMT", 
          "sid"=>"ag5zfnBsYW5ocS1zdGF0c3ISCxIFRXZlbnQYgICAgN6QwQsM", 
          "message"=>"Web server running A-OK", 
          "informational"=>false
        },
        "id"=>"website", 
        "name"=>"Website"
      }
=end
```

To generate an event for a service:
```ruby
#                       Service    Status  Message
stashboard.create_event("website", "down", "Server unavailable, attempting to restart")
```

# FAQs
Here are some of the frequesntly asked questions about this project
### Where do I get my oauth token and secret?
Once you have deployed your application onto AppSpot, you will need to run the 'setup' at *http://{app-name}.appspot.com/admin* once that is done, there is an 'credentials' link that has them both there.
