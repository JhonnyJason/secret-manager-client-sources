############################################################
import { Client } from "./client.js"
import * as secUtl from "secret-manager-crypto-utils"
import * as tbut from "thingy-byte-utils"

############################################################
hexChars = "0123456789abcdef"
hexMap = {}
hexMap[c] = true for c in hexChars

defaultAuthCode = "deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef"

############################################################
export createClient = (o) ->

    # console.log(JSON.stringify(o, null, 4))

    if o.secretKeyHex?

        try secretKeyHex = ensure32BytesHex(o.secretKeyHex)
        catch err then throw new Error("error occured in ensuring the correct format of secretKeyHex!\n: "+err.message)

        if o.publicKeyHex
            try publicKeyHex = ensure32BytesHex(o.publicKeyHex)
            catch err then throw new Error("error occured in ensureing the correct format of publicKeyHex!\n: "+err.message)
        else publicKeyHex = null

        if o.authCode?
            try authCode = ensure32BytesHex(options.authCode)
            catch err then throw new Error("error occured in snsureing the correct format of authCode!\n: "+err.message)
        else authCode = null
    
    else

        secretKeyHex = null
        publicKeyHex = null

        if o.authCode? 
            try authCode = ensure32BytesHex(options.authCode)
            catch err then throw new Error("error occured in snsureing the correct format of authCode!\n: "+err.message)
        else authCode = defaultAuthCode

    
    if o.closureDate? then closureDate = o.closureDate
    else closureDate = null

    return new Client(secretKeyHex, publicKeyHex, o.serverURL, closureDate, authCode)


############################################################
ensure32BytesHex = (key) ->
    if key instanceof Uint8Array
        if key.length != 32 then throw new Error("Invalid length!")
        key = tbut.bytesToHex(key)
    if typeof key != "string" then throw new Error("Invalid type, hexString or Uint8Array expected!")
    if key.charAt(1) == "x" then key = key.slice(2)
    if key.length != 64 then throw new Error("Invalid length!")
    for c in key when !hexMap[c]? then throw new Error("Non-hex character!")
    return key
