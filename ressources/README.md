# Secret Manager Client 

## Background
On the journey to a simplemost, accessible and open authentication-model the idea of the [Secret Manager](https://hackmd.io/PZjpRfzPSBCqS-8K54x2jA?view) has been conceived. It is a small contained service which exclusivly deals with storing and sharing secrets among its' served clients. Every component like services or user-interfaces will use this Secret Manager to exchange critical secrets for authentication.

This is convenience Library to interact with the Secret Manager Service. It deals with the encryption parts so you could use it directly as a simple remote data-store for your secrets.

- The [Interface Specification](https://hackmd.io/EtJSEnxjTVOOvRJdWGJlYw?view)


Current Functionality
---------------------

The exported object is a factory for clients. All itsmethods are async.

*Note: when we create the client the createClient function is synchronous. This means we could immediately proceed using the client. However this means there wasn't any successful server-communication yet, neither would the keys be ready necessarily.*

Ensure the keys are ready - `await client.keysReady`
Ensure we had successful communication with the server - `await client.ready`

*Note: when any regular async method is being used, then it would automatically await for client.ready.*

```coffeescript
import { createClient } from "secret-manager-client"

## create a client
client = await createClient( options )
ClientObject = createClient( OptionsObject )

# get produced keys
await client.keysReady
privateKey = client.secretKeyHex
publicKey = client.publicKeyHex

## client methods
client.updateServerURL( newServerURL, authCode )
client.updateServerURL( String, StringHex )


client.getSecretSpace()

client.getSecret( secretId )
client.getSecret( String )

client.getSecretFrom( secretId, setterNodeId ) # a secret setterNodeId has set for us
client.getSecretFrom( String, StringHex )


client.setSecret( secretId, secret )
client.setSecret( String, String )

client.deleteSecret( secretId )
client.deleteSecret( String )


client.acceptSecretsFrom( fromNodeId ) # only then fromNodeId may set secrets for us
client.acceptSecretsFrom( StringHex )

client.stopAcceptSecretsFrom( fromNodeId )
client.stopAcceptSecretsFrom( StringHex )


client.shareSecretTo( shareToNodeId, secretId, secret ) # set a secret for shareToNodeId
client.shareSecretTo( StringHex, String, String )

client.deleteSharedSecret( sharedToNodeId, secretId )
client.deleteSharedSecret( StringHex, String )
```

### createClient( options )
The `options` look like this:
```js
{
    "secretKeyHex": "...",
    "publicKeyHex": "...",
    "serverURL": "...",
    "closureDate": "...",
    "authCode": "..."
}
```

The `createClient` may work in 3 ways:

1. We already have keys and the server knows about it (recreate an otherwise existing client)
2. We use self-defined keys which the server does not know yet 
3. We create a client without defining keys


For 1.) we donot neeed to provide an `authCode`. For 2.) and 3.) we require an authCode, as this will create a new secret space on the server. If in this case no authCode is provided, then the client would set a default authCode as `deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef` - it is then totally dependent on the specific service and how the maintainer configured it, if it would accept this new client or not. Potentially receiving the error: "No new anonymous clients are accepted!"


The authCode has the same requirements as the keys. Should be 32bytes long and encoded in hex -> string of 64 hex characters.

Strictly speaking, only the serverURL is mandatory.

The `createClient` functionn is synchronous - so it would immediately return a client object. However potentially the client could not be constructed, because of server-side issues or the key-generation has not been completed. 


---

All sorts of inputs are welcome, thanks!

---

# License

[Unlicense JhonnyJason style](https://hackmd.io/nCpLO3gxRlSmKVG3Zxy2hA?view)