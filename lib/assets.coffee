path = require "path"
fs = require "fs"
cwd = process.cwd()
read = ->
    cwd = process.cwd()
    files = fs.readdirSync(cwd)
    assets = []
    for file in files
        extname = path.extname file
        if extname is '.js' or extname is '.css'
            assets.push file
    return assets

assets = (target, includes) ->
    assets = read()
    for file in assets
        content = fs.readFileSync(file).toString()
        reg = /{% include (.*) %}/g
        content.replace reg, (objstr, $1) ->
            includefile = path.join includes, $1
            #console.log includefile
            cnt = fs.readFileSync(includefile).toString()
            tmp = content.split objstr
            content = tmp[0] + cnt + tmp[1]
        #console.log (path.join target, file)
        fs.writeFileSync (path.join target, file), content
module.exports =
    read: read
    assets: assets