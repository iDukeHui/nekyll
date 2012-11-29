assert = require "assert"
path = require "path"
config = require "../lib/config"
cwd = process.cwd()

suite "Load config", () ->
    setup () ->
    teardown () ->

    test 'config file not exists', (done) ->
        file = path.join cwd, "./idukehui/_config.ymal"
        result = config.load(file)
        assert.equal result.message, 'config file not exists'
        done()

    test 'config file is not a ymal file', (done) ->
        file = path.join cwd, "../idukehui/test/_config.yaml"
        result = config.load(file)
        assert.equal result.message, 'config file is not a ymal file'
        done()
    
    test 'return must a object', (done) ->
        file = path.join cwd, "../idukehui/_config.yml"
        result = config.load(file)
        assert.equal typeof result, "object"
        done()

    test 'configs must be right', (done) ->
        configs =
            name: 'nohyes'
        file = path.join cwd, "../idukehui/_config.yml"
        result = config.load(file)
        assert.equal configs.name, result.name
        done()

