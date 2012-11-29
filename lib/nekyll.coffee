path = require 'path'
fs = require 'fs'
program = require 'commander'
cwd = process.cwd()

program
    .version('0.0.1')
    .usage('[options] [value ...]')
    .option('-p, --port <n>', 'server listen port', parseInt)
    .option('server')
    .option('generate')
    .option('init')
    .parse(process.argv)

program.on 'help', ->
    console.log '   Examples:'
    console.log ''
    console.log '       '


generate = () ->

    Config = require('./config').load()
    if Config.error
        console.error "config error: %s", Config.message
        process.exit 0

    target = path.join cwd, "_site"
    if Config.include
        require('./include').include target, Config.include
    includes = path.join cwd, '_includes'
    require("./assets").assets target, includes
    ###
    pageList = require('./page').getList()
    pages = []
    posts = []
    for page in pageList
        data = null
        data = require('./page').readPage page.path
        if data
            if page.post
                posts.push data
            else
                pages.push data
    
    #console.log pages.length
    #if pages.length > 0
    ###
    require('../lib/page').generate()
    console.log 'generate sucess'
    #server()
server = () ->
    connect = require 'connect'
    cwd = process.cwd()
    app = connect()
    app.use connect.static cwd + path.sep + '_site'
    port = program.port or 8080
    app.listen port
    console.log "Running at http://localhost:" + port
init = () ->
    template = path.join __filename, '../../template'
    require('./util').copyDir template, cwd
    console.log 'init sucess'
if program.message
    console.log '--message'
    console.log program.message
else if program.server
    server()
else if program.generate
    generate()
    server()
else if program.init
    if fs.existsSync path.join cwd, '_config.yml'
        console.log 'config file already exists'
        process.exit 0
    init()
else
    console.info 'nothing to do'