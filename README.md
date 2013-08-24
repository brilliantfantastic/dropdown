Dropdown
========

[![Code Climate](https://codeclimate.com/github/brilliantfantastic/dropdown.png)](https://codeclimate.com/github/brilliantfantastic/dropdown)
[![Build Status](https://travis-ci.org/brilliantfantastic/dropdown.png?branch=master)](https://travis-ci.org/brilliantfantastic/dropdown)
[![Coverage Status](https://coveralls.io/repos/brilliantfantastic/dropdown/badge.png?branch=master)](https://coveralls.io/r/brilliantfantastic/dropdown?branch=master)

Blog engine that parses Markdown files stored in Dropbox for a static blog engine.

Getting Started with Dropbox storage
====================================

1. **Create an application on Dropbox**

    1. Sign into Dropbox
    1. Visit `https://www.dropbox.com/developers/apps/create`
    1. Choose 'Dropbox API app' for 'What type of app do you want to create?'
    1. Choose 'Files and datastores' for 'What type of data does your app need to store on Dropbox?'
    1. Choose 'No -- My app needs access to files already on Dropbox' for 'Can your app be limited to its own, private folder?'
    1. Choose 'All file types -- My app needs access to a user's full Dropbox' for 'What type of files does your app need access to?'
    1. Name your application. We suggest something like '<blog name> Dropdown blog'

    Here is a screenshot of an example of a Dropbox app creation page filled out:

    ![](https://dl.dropboxusercontent.com/u/987517/oss/Dropdown/README/dropbox-create-app.png)

1. **Enter your Dropbox APP KEY and APP SECRET in environment variables**

    Once your create a Dropbox application, you will be assigned an App key and an App secret. You will want to put these values in 
    environment variables so you can use these in your Dropdown configuration settings. We highly suggest you do not put these values 
    straight into your configuration because you do not want them checked into your source control.

    For development, we recommend using [dotenv](https://github.com/bkeepers/dotenv).

    1. For Rails, add this line to your application's `Gemfile`

        ```ruby
        gem 'dotenv-rails', :groups => [:development, :test]
        ```

    1. Create a `.env` file to the root of your project
    1. Add the `.env` file to your `.gitignore`
    1. Add the following content to your `.env` file

        ```
        DROPBOX_APP_KEY=<your app key>
        DROPBOX_APP_SECRET=<your app secret>
        ```

    For production, if you application lives on Heroku, you can run the following:

    ```sh
    heroku config:set DROPBOX_APP_KEY=<your app key>
    heroku config:set DROPBOX_APP_SECRET=<your app secret>
    ```

1. **Update your Dropdown configuration**

    For Rails, create `config/initializers/dropdown.rb` with the following content:

    ```ruby
    Dropdown.configure do |c|
      c.dropbox_app_key: ENV['DROPDOWN_APP_KEY']
      c.dropdown_app_secret: ENV['DROPDOWN_APP_SECRET']
      c.dropdown_access_token: ENV['DROPDOWN_ACCESS_TOKEN']
    end
    ```

    We will be storing the `DROPDOWN_ACCESS_TOKEN` with the next step.

1. **Run `rake setup:dropbox:store_access_token`**

    This will instruct you to go to a Dropbox url to authorize your Dropbox application.

    Copy the authorization code and enter it the console.

    Your access token is now stored in an environment variable: `ENV['DROPBOX_ACCESS_TOKEN']`.

Potential Implementation
========================

## Dropbox directory structure

<pre>
  - blog-posts
  |-- markdown
      |-- random-post-1.md
      |-- random-post-2.md
  |-- html
      |-- random-post-1.html
      |-- random-post-2.html
  |-- templates
      |-- honeysuckle.handlebars
  |-- .index
</pre>

## Parsing

A rake task will be used to process a directory with Markdown files. The process will read each Markdown file and create an accompanying static file in HTML. This process will use [RedCarpet](https://github.com/vmg/redcarpet) to parse the markdown files and generate HTML files.

```ruby
  # task to process the Markdown directory
  require 'dropdown/processor'

  task :process [:source, :destination] do |t, args|
    DropDown::Processor.new(args.source, args.destination).process
  end
```

Additional functionality

```ruby
  DropDown::Processor.new.process(:all)   # same as calling DropDown::Processor.new.process
  DropDown::Processor.new.process         # uses the source and destination directories specified in the configuration
```

### Format of the generated output

Each file will have meta data stored as comments in the MarkDown:

```
Title: Deep Throat Exposed!
Author: Bob Woodward
Post: 4/4/1974

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat molestie condimentum. Vestibulum malesuada, 
lorem sit amet euismod pellentesque, tellus felis varius enim, id tincidunt leo odio aliquet ante. Maecenas metus 
lorem, pretium vitae auctor sed, blandit id quam.
```

This will generate the following html:

```html
<!-- Title: Deep Throat Exposed! -->
<!-- Author: Bob Woodward -->
<!-- Post: 4/4/1974 -->
<div class='post'>
  <div class='title'>Deep Throat Exposed!</div>
  <div class='author'>Bob Woodward</div>
  <div class='post'>19740404T....</div>
  <div class='content'>
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut volutpat molestie condimentum. Vestibulum malesuada, 
    lorem sit amet euismod pellentesque, tellus felis varius enim, id tincidunt leo odio aliquet ante. Maecenas metus 
    lorem, pretium vitae auctor sed, blandit id quam.
  </div>
</div>
```

This will also create the following row in the .index file:

```
title: Deep Throat Exposed! author: Bob Woodward post: 19740404T.... slug: deep-throat-exposed checksum: 384749403
```

## Retreiving

## Displaying

## Configuration

```ruby
  DropDown.configure do |c|
    c.base_path: 'blog_posts'
    c.source_directory: 'markdown'
    c.destination_directory: 'html'
    c.template: 'honeysuckle'
    c.dropbox_app_key: '<insert dropbox app key>'
    c.dropbox_app_secret: '<insert dropbox app secret key>'
  end
```

