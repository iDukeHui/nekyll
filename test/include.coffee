assert = require "assert"
path = require "path"
fs = require "fs"
include = require '../lib/include'
cwd = process.cwd()

suite "config include test", () ->
    setup () ->
        #clear the target dir
    teardown () ->
        #rmove the test files
        
    test 'nothing to include', (done) ->
        file = path.join cwd, "../idukehui/test/include1._config.yml"
        config = require("../lib/config").load file
        if config and config.include
            assert.equal config.include, null
        done()
    
    test 'config include must be a array', (done) ->
        file = path.join cwd, "../idukehui/test/include2._config.yml"
        config = require("../lib/config").load file
        assert.equal typeof(config.include), "object"
        done()

suite "config include test", () ->
    setup () ->
        #clear the target dir
    teardown () ->
        #rmove the test files

    test 'copy the include dir', (done) ->
        file = path.join cwd, "../idukehui/test/include2._config.yml"
        config = require("../lib/config").load file
        require('../lib/include').include (path.join cwd, '_site'),config.include
        csspath = path.join cwd, "../idukehui/_site/css"
        assert.equal fs.existsSync(csspath), true
        cssfile = path.join cwd, "../idukehui/_site/css/style.css"
        assert.equal fs.existsSync(cssfile), true
        done()
        ###
        , (err) ->
            csspath = path.join cwd, "../idukehui/_site/css"
            assert.equal fs.existsSync(csspath), true
            cssfile = path.join cwd, "../idukehui/_site/css/style.css"
            assert.equal fs.existsSync(cssfile), true
            done()
        ###