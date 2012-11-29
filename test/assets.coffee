assert = require "assert"
path = require "path"
fs = require "fs"
cwd = process.cwd()
suite "load and compile assets files", () ->
    setup () ->
    teardown () ->

    test 'read assets file in the cwd path', (done) ->
        files = require("../lib/assets").read()
        assert.equal files.length, 2
        done()

    test 'generators the assets file', (done) ->
        target = path.join cwd, '_site'
        includes = path.join cwd, '_includes'
        require("../lib/assets").assets target, includes
        g_file = path.join cwd, "_site/style.css"
        t_file = path.join cwd, "test/style.css"
        g_content = fs.readFileSync g_file, "utf-8"
        t_content = fs.readFileSync t_file, "utf-8"
        assert.equal g_content, t_content
        done()
    