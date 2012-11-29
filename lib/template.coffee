yaml = require 'js-yaml'

layouts = []
yamltest = /^(---\s*(\n|\r\n)(.*(\n|\r\n))*)^(---\s*$(\n|\r\n)?)/m


setLayout = (layout) ->
    data = null
    content = layout.content.replace yamltest, (objstr, $1) ->
        data = yaml.load $1
        return objstr = ''
    layouts[layout.name] =
        data: data
        content: content
compile = (source) ->
    data = null
    
    source = source.replace yamltest, (objstr, $1) ->
        data = yaml.load $1
        return objstr = ''
    #console.log paramtest.test layouts[data.layout].content
    laycontent = layouts[data.layout].content
    open = '{{'
    close = '}}'
    flag = true
    pre = 0
    cur = null
    code = null
    codes = []
    trim = null
    t = ''
    for n,i in laycontent
        cur = laycontent.indexOf (if flag then open else close), i
        console.log cur
        if cur < pre
            console.log flag
            if flag
                code = laycontent.slice pre + close.length
                codes.push code
            else
                console.log 'error'
            break
        code = laycontent.slice i, cur
        pre = cur
        if flag
            i = cur + open.length
        else
            i = cur + close.length
        flag = not flag
    #console.log codes
    
    return ''
    body = []
    console.log fn = Function.apply Function, body
    compiled = fn.apply this, []
    #console.log source
    console.log compiled ''
    return compiled
module.exports =
    setLayout: setLayout
    compile: compile