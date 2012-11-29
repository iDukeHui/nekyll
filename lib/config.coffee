fs = require "fs"
yaml = require 'js-yaml'
path = require 'path'
cwd = process.cwd()
module.exports = {
    load: (configfile) ->
        configfile = configfile or path.join cwd, '_config.yml'
        if not fs.existsSync(configfile)
            return {error: 1,message: "config file not exists"}
        filedata = fs.readFileSync(configfile, "utf-8")
        config = yaml.load(filedata)
        if typeof config isnt "object"
            return {error: 2,message: "config file is not a ymal file"}
        return config
}