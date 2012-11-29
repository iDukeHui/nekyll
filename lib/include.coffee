path = require 'path'
fs = require 'fs'
EventEmitter = require('events').EventEmitter
emitter =  new EventEmitter()
Walker = require "iwalk"
cwd = process.cwd()

copyend_callback = null
counter = 0
exec = require('child_process').exec

emitter.on 'copyend', () ->
    counter--
    if counter is 0
        copyend_callback()
emitter.on 'error', (err) ->
    console.log err
    site = path.join cwd,"../idukehui/_site"
    exec 'rm -rf ' + site, (err, stdout, stderr) ->
        exec 'mkdir ' + site, (err, stdout, stderr) ->
            process.exit 0
include_func = (includes, callback) ->
    copyend_callback = callback
    counter = includes.length
    for dir in includes
        oldpath = path.join cwd + '/', '../idukehui/', dir
        newpath = path.join cwd + '/' + '../idukehui/_site',dir
        exec 'cp -rf ' + oldpath + ' ' + newpath, (err, stdout, stderr) ->
            if err isnt null
                console.log err
                process.exit 0
                emitter.emit 'error', err
            else
                emitter.emit 'copyend'
rm = (() ->
    interator = (url, dirs) ->
        stat = fs.statSync url
        if stat.isDirectory()
            dirs.unshift url
            inner url, dirs
        else if stat.isFile()
            fs.unlinkSync url
     
    inner = (_path, dirs) ->
        arr = fs.readdirSync _path
        for el in arr
            interator _path + path.sep + el, dirs


    return (dir) ->
        dirs = []
        try
            interator dir, dirs
            for el in dirs
                fs.rmdirSync el
        catch error
            console.log error.message
            #process.exit 0
    )()

copy = (_path) ->
    stat =  fs.statSync (_path)
    newpath = path.join cwd, '_site' ,_path.replace cwd, ""
    if (stat.isDirectory())
        if fs.existsSync newpath
            fs.unlinkSync newpath
            fs.mkdirSync newpath
        else
            fs.mkdirSync newpath
        ###
        if not fs.existsSync newpath
            fs.mkdirSync newpath
        else
            files = fs.readdirSync newpath
            for file in files
                if not fs.statSync(_path).isDirectory()
                fs.rm
        ###
        _paths = fs.readdirSync _path
        for __path in _paths
            copy path.join _path, __path
        
    else
        fdr = fs.openSync _path, 'r'
        fdw = fs.openSync newpath, 'w'
        bytesRead = 1
        pos = 0
        BUF_LENGTH = 64 * 1024
        _buff = new Buffer BUF_LENGTH
        whileFunc = () ->
            bytesRead = fs.readSync fdr, _buff, 0, BUF_LENGTH, pos
            fs.writeSync fdw, _buff, 0, bytesRead
            pos += bytesRead
        whileFunc() while bytesRead > 0
        fs.closeSync fdr
        

include = (target, includes) ->
    
    
    if not fs.existsSync target
        fs.mkdirSync target
    else
        rm target
        #process.exit 0
        fs.mkdirSync target
        #console.log 'rm end'
    for dir in includes
        oldpath = path.join cwd, dir
        newpath = path.join target, dir
        if fs.existsSync oldpath
            copy(oldpath)
module.exports =
    include: include
        ###
        include_func
        site = path.join cwd,"../idukehui/_site"

        exec 'rm -rf ' + site, (err, stdout, stderr) ->
            exec 'mkdir ' + site, (err, stdout, stderr) ->
                include_func includes, callback
        ###
