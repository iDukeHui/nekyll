fs = require 'fs'
path = require 'path'
mkdir = (dir) ->
    if fs.existsSync dir
        return
    parent = path.dirname dir
    if not fs.existsSync(parent) and parent isnt cwd
        mkdir parent
    fs.mkdirSync dir

copyFile = (source, target) ->
    if not fs.existsSync source
        console.log source + ', is not exists'
        return
    mkdir path.dirname target
    content = fs.readFileSync source
    fs.writeFileSync target, content

copyDir = (source, target) ->
    if source is target
        console.log 'target must not is the source'
        return
    if ((new RegExp '^' + escape(source) + '/').test escape(target))
        console.log target + ' target must not in the source'
        return
    if not fs.existsSync source
        console.log source + ', is not exists'
        return
    stat = fs.statSync source
    if not stat.isDirectory()
        console.log source + ', is not directory'
        return
    mkdir target
    children = fs.readdirSync source
    for child in children
        _child = path.join source, child
        if _child is target
            continue
        _target = path.join target, child
        _stat = fs.statSync _child
        if _stat.isDirectory()
            copyDir _child, _target
        else
            copyFile _child, _target
module.exports.copyDir = copyDir