############################################################
export postData = (url, data) ->
    options =
        method: 'POST'
        credentials: 'omit'
        body: JSON.stringify(data)
        headers:
            'Content-Type': 'application/json'

    try
        response = await fetch(url, options)
        if !response.ok then throw new Error("Response not ok - status: "+response.status+"!")
        return response.json()
    catch err then throw new Error("Network Error: "+err.message)

############################################################
export getData = (url) ->
    try 
        response = await fetch(url)
        if !response.ok then throw new Error("Response not ok - status: "+response.status+"!")
        return response.json()
    catch err then throw new Error("Network Error: "+err.message)


############################################################
export getAsset = (url) ->
    try 
        response = await fetch(url)
        if !response.ok then throw new Error("Response not ok - status: "+response.status+"!")
        return URL.createObjectURL(await response.blob())
    catch err then throw new Error("Network Error: "+err.message)
