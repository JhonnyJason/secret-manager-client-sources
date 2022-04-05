############################################################
import { Client } from "./client.js"
import * as noble from "@noble/ed25519"
import tbut from "thingy-byte-utils"

############################################################
newSecretBytes = noble.utils.randomPrivateKey

############################################################
export createClient = (secretKeyHex, publicKeyHex, serverURL) ->
    if !secretKeyHex
        secretKeyHex = tbut.bytesToHex(newSecretBytes())
        publicKeyHex = await noble.getPublicKey(secretKeyHex)
    if !publicKeyHex
        publicKeyHex = await noble.getPublicKey(secretKeyHex)
    return new Client(secretKeyHex, publicKeyHex, serverURL)


