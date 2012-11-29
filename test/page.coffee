assert = require "assert"
path = require "path"
fs = require "fs"
cwd = process.cwd()

suite "load page", () ->
    setup ->
    teardown ->

    test 'load page and summary page data from yaml ', (done) ->
        testdata =
            layout: 'default'
        file = path.join cwd, 'test/pagetest1.jade'
        data = require('../lib/page').readYaml file
        #process.exit 0
        assert.equal data.layout, testdata.layout
        done()

    test 'load page content exclude the yaml str', (done) ->
        teststr = "div#loading\r\n    |loading"
        file = path.join cwd, 'test/pagetest1.jade'
        content = require('../lib/page').readContent file
        assert.equal teststr, content
        done()

    test 'load page in the root path and config  ,exname .jade', (done) ->
        #{published, layout, filename, savename, content, title, url, date, id, categories, tags }
        testdata =
            published: false
            layout: 'default'
            savename: '_site'+path.sep+'test'+path.sep+'pagetest1.html'
            content: 'div#loading\r\n    |loading'
            title: 'I am a test page'
            url: '/test/pagetest1.html'
            #date: '2012-11-11'
            #id: ''
            categories: ['hehe', 'bb']
            tags: ['node.js', 'txt']
        file = path.join cwd, 'test/pagetest1.jade'

        data = require('../lib/page').readPage file
        for k,v of testdata
            if typeof v is "object"
                for _v,_k in v
                    assert.equal _v, data[k][_k]
            else
                assert.equal data[k], v
        
        done()

    test 'get pages list', (done) ->
        pageList = require('../lib/page').getList()
        assert.equal pageList.length, 10
        done()
        

    test 'loop pages and summary data', (done) ->
        data = require('../lib/page').summary()
        assert.equal data.posts.length, 9
        assert.equal data.pages.length, 1
        assert.equal data.categories.length, 2
        assert.equal data.tags.length, 3
        done()


    test 'compile and save the pages ', (done) ->
        pageList = require('../lib/page').generate()
        files = fs.readdirSync path.join cwd, '_site'
        arr = []
        for file in files
            extname = path.extname file
            if extname is '.html'
                arr.push file

        assert.equal arr.length, 1
        files = fs.readdirSync path.join cwd, '_site', 'post'
        assert.equal files.length, 9
        done()

