---
title: A post
---
h1. Jekyll

By Tom Preston-Werner, Nick Quaranto, and many awesome contributors!

Jekyll is a simple, blog aware, static site generator. It takes a template directory (representing the raw form of a website), runs it through Textile or Markdown and Liquid converters, and spits out a complete, static website suitable for serving with Apache or your favorite web server. This is also the engine behind "GitHub Pages":http://pages.github.com, which you can use to host your project's page or blog right here from GitHub.

h2. Getting Started

#Hello
##Hello
###hello

    var fs = require("fs");
    var path = require("path");

## Note

  > **Please note** that I, [Corey](https://github.com/coreyti), am not the author
  > of Showdown. Rather, I found it some time back at <http://attacklab.net/showdown/>
  > (website removed, see: <http://wayback.archive.org/web/*/http://attacklab.net/showdown>)
  > and wanted to see it available on GitHub.
  >
  > All credit and praise for authoring this library should go to John Fraser.
  >
  > Oh, and John Gruber of course.
  >
  > That said, Showdown *is* evolving. See below for a list of contributors and an
  > overview of their contributions to the project.
  >
  > Apologies for any confusion or perceived misinformation.
  >
  > Cheers,<br/>
  > Corey

* "Install":http://wiki.github.com/mojombo/jekyll/install the gem
* Read up about its "Usage":http://wiki.github.com/mojombo/jekyll/usage and "Configuration":http://wiki.github.com/mojombo/jekyll/configuration
* Take a gander at some existing "Sites":http://wiki.github.com/mojombo/jekyll/sites
* Fork and "Contribute":http://wiki.github.com/mojombo/jekyll/contribute your own modifications
* Have questions? Post them on the "Mailing List":http://groups.google.com/group/jekyll-rb

h2. Diving In

* "Migrate":http://wiki.github.com/mojombo/jekyll/blog-migrations from your previous system
* Learn how the "YAML Front Matter":http://wiki.github.com/mojombo/jekyll/yaml-front-matter works
* Put information on your site with "Template Data":http://wiki.github.com/mojombo/jekyll/template-data
* Customize the "Permalinks":http://wiki.github.com/mojombo/jekyll/permalinks your posts are generated with
* Use the built-in "Liquid Extensions":http://wiki.github.com/mojombo/jekyll/liquid-extensions to make your life easier

h2. Runtime Dependencies

* RedCloth: Textile support (Ruby)
* Liquid: Templating system (Ruby)
* Classifier: Generating related posts (Ruby)
* Maruku: Default markdown engine (Ruby)
* Directory Watcher: Auto-regeneration of sites (Ruby)
* Pygments: Syntax highlighting (Python)

h2. Developer Dependencies

* Shoulda: Test framework (Ruby)
* RR: Mocking (Ruby)
* RedGreen: Nicer test output (Ruby)
* RDiscount: Discount Markdown Processor (Ruby)

h2. License

See LICENSE.