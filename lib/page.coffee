fs = require 'fs'
path = require 'path'
#url = require 'url'
yaml = require 'js-yaml'
config = require './config'
cwd = process.cwd()

test = /^(---\s*(\n|\r\n)(.*(\n|\r\n))*)^(---\s*$(\n|\r\n)?)/m


readYaml = (filepath) ->
    filecontent  = fs.readFileSync filepath, 'utf-8'
    #console.log arr = filecontent.split "\n---\n"
    #console.log filepath
    #console.log test.test filecontent
    #console.log test.test filecontent
    data = {}
    filecontent.replace test, (objstr, $1) ->
        #console.log $1
        data = yaml.load $1
    #"---\r\nlayout:default\n---\n"
    #process.exit 0
    #return yaml.load arr[0]
    return data

readContent = (filepath) ->
    filecontent  = fs.readFileSync filepath, 'utf-8'
    return filecontent = filecontent.replace test, ''
    #process.exit 0
readPage = (filepath) ->
    yamldata = readYaml filepath
    yamldata = if yamldata is null then {} else yamldata
    #console.log (filepath.replace cwd, '').replace /.jade$/, '.html'
    data =
        path: filepath
        published: if yamldata.published then yamldata.published else false
        layout: if yamldata.layout then yamldata.layout else 'default'
        title: if yamldata.title then yamldata.title else ''
        savename: (path.join '_site', (((filepath.replace /.jade$/, '.html').replace /_posts/, 'post').replace /.md$/, '.html').replace cwd, '')
        #url: (((filepath.replace cwd, '').replace /.jade$/, '.html').replace /.md$/, '.html').replace /_posts/, 'post'
        categories: if yamldata.categories then ( if typeof yamldata.categories is 'string' then [yamldata.categories] else yamldata.categories) else []
        tags: if yamldata.tags then ( if typeof yamldata.tags is 'string' then [yamldata.tags] else yamldata.tags) else []

    if /_post/.test filepath
        data.url = getPageUrl filepath, true
    else
        data.url = getPageUrl filepath

    data.content = readContent filepath
    #filepath = filepath.replace /.jade$/, '.html'
    #console.log path.join cwd, '_site', (path.basename filepath, '.jade') + '.html'
    #console.log path.join cwd, '_site', (filepath.replace /.jade$/, '.html').replace cwd, ''
    #console.log path.relative(filepath, cwd)
    #uurl = filepath.replace(cwd, '').split path.sep
    #uurl[uurl.length - 1] = uurl[uurl.length - 1].replace /.jade$/, '.html'
    #console.log uurl.join '/'
    return data
    process.exit 0
getPageUrl = (filepath, post) ->
    post = post or false
    if not post
        uurl = filepath.replace(cwd, '').split path.sep
        uurl[uurl.length - 1] = uurl[uurl.length - 1].replace /.jade$/, '.html'
        return uurl.join '/'
    else
        uurl = filepath.replace((path.join cwd, '_posts'), '').split path.sep
        uurl[uurl.length - 1] = uurl[uurl.length - 1].replace /.md$/, '.html'
        return '/post' + uurl.join '/'
    
getList = () ->
    #Config = config.load path.join cwd, '_config.yaml'
    fileList = []
    rootfiles = fs.readdirSync cwd
    for file in rootfiles
        extname = path.extname file
        if extname is '.jade'
            fileList.push {post:false,path:path.join cwd, file}
    postfiles = fs.readdirSync path.join cwd, '_posts'
    for file in postfiles
        extname = path.extname file
        if extname is '.md'
            fileList.push {post:true, path:path.join cwd, '_posts', file}
    return fileList
summary = () ->
    pagelist = getList()
    pages = []
    for page in pagelist
        pagedata = readPage page.path
        pagedata.post = page.post
        pages.push pagedata
    data =
        posts: []
        pages: []
        categories: []
        tags: []
    tagstmp = {}
    categoriestmp = {}
    for page in pages
        if page.post
            data.posts.push page
        else
            data.pages.push page
        if page.tags.length > 0
            for tag in page.tags
                if not tagstmp[tag]
                    data.tags.push tag
                tagstmp[tag] = true
        for category in page.categories
            if not categoriestmp[category]
                data.categories.push category
            categoriestmp[category] = true

    return data

generate = () ->
    jade = require 'jade'
    data = summary()
    data.site = config.load()
    postspath = path.join cwd, '_site', 'post'
    if not fs.existsSync postspath
        fs.mkdirSync postspath
    for page in data.pages
        #console.log page
        #tmpfile = page.path + '.jade'
        #console.log path.join cwd, page.savename
        page.content = "extends ./_layouts/" + page.layout + "\n" + "block content\n" + page.content
        data.page = page
        fn = jade.compile page.content, {filename: page.path}
        
        fs.writeFileSync (path.join cwd, page.savename), fn data
    for page in data.posts
        #console.log page
        #tmpfile = page.path + '.jade'
        #console.log path.join cwd, page.savename
        
        if page.layout is "default"
            page.layout = "post"

        #console.log data.page = page
        #page.content = require("markdown").markdown.toHTML(page.content)
        Showdown = require('showdown')
        converter = new Showdown.converter()
        page.content = converter.makeHtml page.content
        data.page = page
        content = "extends ../_layouts/" + page.layout + "\nblock postcontent\n"+ "    !{page.content}"

        fn = jade.compile content, {filename: page.path}
        
        fs.writeFileSync (path.join cwd, page.savename), fn data
        #console.log url.parse page.url
    #console.log data.posts
module.exports =
    readYaml: readYaml
    readContent: readContent
    readPage: readPage
    getList: getList
    generate: generate
    summary: summary