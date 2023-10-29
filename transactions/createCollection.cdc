import NonFungibleToken from 0x05
import Nicas_legends from 0x05
 /* ## This transaction creates a collection ## */
transaction {
  prepare(acct: AuthAccount) {
    //The account must be Experia View
    let nameCollection : String = "Experia collection 1";
    let metadataCollection : {String : AnyStruct} = {
      "banner": "ipfs://QmSRydNqzGFYCap3tf32zoL2onUYpTpVm4tGx9YVS3RRDa"
    }
    let providerStorage = /storage/collection1
    let providerPrivate = /private/collection1
    let providerPublic = /public/collection1
        if acct.borrow<&Nicas_legends.Collection{NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic}>(from: providerStorage) == nil {
          log("to create collection")
          let collection <- Nicas_legends.createEmptyCollectionNFT(name: nameCollection, metadata: metadataCollection)
          acct.save(<- collection, to: providerStorage)
          if acct.borrow<&Nicas_legends.Collection{NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic}>(from: providerStorage) == nil {
            log("nil again")
          }
          acct.link<&Nicas_legends.Collection{NonFungibleToken.Provider, NonFungibleToken.Receiver, NonFungibleToken.CollectionPublic}>(providerPrivate, target: providerStorage)
          acct.link<&Nicas_legends.Collection{NonFungibleToken.CollectionPublic, Nicas_legends.CollectionPublic}>(providerPublic, target: providerStorage)
          log("Collection created!")
        } else {
          panic("Collection was created")
        }
  }
  execute {
   log("Collection Created Succes")
  }
}