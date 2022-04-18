############################################################
import { Client } from "./client.js"
import * as secUtl from "secret-manager-crypto-utils"
import * as tbut from "thingy-byte-utils"

############################################################
hexChars = "0123456789abcdef"
hexMap = {}
hexMap[c] = true for c in hexChars


############################################################
export createClient = (secretKeyHex, publicKeyHex, serverURL) ->
    if !secretKeyHex
        kp = await secUtl.createKeyPairHex()
        return new Client(kp.secretKeyHex, kp.publicKeyHex, serverURL)
    else secretKeyHex = ensureHexKey(secretKeyHex)
    
    if !publicKeyHex
        publicKeyHex = await secUtl.createPublicKeyHex(secretKeyHex)        
    else
        publicKeyHex = ensureHexKey(publicKeyHex)
        pbTestHex = await secUtl.createPublicKeyHex(secretKeyHex)
        if publicKeyHex != pbTestHex then throw new Error("PublicKey does not fit secretKey!")
    return new Client(secretKeyHex, publicKeyHex, serverURL)


############################################################
ensureHexKey = (key) ->
    if key instanceof Uint8Array
        if key.length != 32 then throw new Error("Invalid key length!")
        key = tbut.bytesToHex(key)
    if typeof key != "string" then throw new Error("Invalid type, hexString or Uint8Array expected!")
    if key.charAt(1) == "x" then key = key.slice(2)
    if key.length != 64 then throw new Error("Invalid key length!")
    for c in key when !hexMap[c]? then throw new Error("Non-hex character in key!")
    return key
