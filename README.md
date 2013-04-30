DropDown
========

Blog engine that parses Markdown files stored in Dropbox for a static blog engine.

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
  require 'dropdown/processing'

  task :process [:source, :destination] do |t, args|
    DropDown::Processing.process(args.source, args.destination)
  end
```

Additional functionality

```ruby
  DropDown::Processing.process(:all)  # same as calling DropDown::Processing.process
  DropDown::Processing.process        # uses the source and destination directories specified in the configuration
```

### Format of the generated output

Each file will have meta data stored as comments in the MarkDown:

```
##################################
# Title: Deep Throat Exposed!
# Author: Bob Woodward
# Post: 4/4/1974
##################################

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

