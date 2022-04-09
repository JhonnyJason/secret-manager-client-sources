############################################################
import { Client } from "./client.js"
import * as noble from "@noble/ed25519"
import * as tbut from "thingy-byte-utils"

############################################################
newSecretBytes = noble.utils.randomPrivateKey
bytesToHex = noble.utils.bytesToHex

############################################################
export createClient = (secretKeyHex, publicKeyHex, serverURL) ->
    if !secretKeyHex
        secretKeyHex = bytesToHex(newSecretBytes())
        publicKey = await noble.getPublicKey(secretKeyHex)        
        publicKeyHex = bytesToHex(publicKey)
    if !publicKeyHex
        publicKey = await noble.getPublicKey(secretKeyHex)        
        publicKeyHex = bytesToHex(publicKey)
    return new Client(secretKeyHex, publicKeyHex, serverURL)


