assert = require "assert"
path = require "path"
fs = require "fs"
cwd = process.cwd()
template = require('../lib/template')
suite "load page", () ->
    setup ->
    teardown ->

    test 'compile source with data', (done) ->

        source = """
---
layout: default
title: i am title
---
<div>
    <h1>Blog Posts</h1>
</div>
"""
        layout =
            name: 'default'
            content: """
---
---
<!DOCTYPE html>
<html>
<head>
    <title>{{ page.title }}</title>
</head>
<body>
    <div id="main">
        {{ content }}
    </div>
</body
</html>

            """

        result = """   
<!DOCTYPE html>
<html>
<head>
    <title>i am title</title>
</head>
<body>
    <div id="main">
        <div>
    <h1>Blog Posts</h1>
</div>
    </div>
</body
</html>
        """
        #console.log source
        #fn = template.compile source
        #assert.equal fn(data), '<title>'+data.page.title+'</title>'
        template.setLayout layout
        fn = template.compile source
        console.log fn
        #assert.equal template.compile(source), result
        done()

    test 'compile source with layout', (done) ->
        data =
            page:
                title: 'i am title'
                layout: 'default'
        source = """
<div></div>
"""
        console.log source
        #fn = template.compile source, data.page.layout
        #assert.equal fn(data), '<title>'+data.page.title+'</title>'
        done()