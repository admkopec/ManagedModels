//
//  Created by Helge Heß.
//  Copyright © 2023 ZeeZide GmbH.
//

import ManagedModels

extension Fixtures {
  
  static let PersonAddressMOM = PersonAddressSchema.managedObjectModel
  
  enum PersonAddressSchema: VersionedSchema {
    static var models : [ any PersistentModel.Type ] = [
      Person.self,
      Address.self
    ]
    
    public static let versionIdentifier = Schema.Version(0, 1, 0)

    
    @Model
    final class Person: NSManagedObject {
      
      // TBD: Why are the inits required? *** NEED TO FIGURE THIS OUT
      var firstname : String
      var lastname  : String
      var addresses : Set<Address> // [ Address ]
      
      #if false
      init(firstname: String, lastname: String, addresses: [ Address ]) {
        self.init() // this does not work
        self.firstname = firstname
        self.lastname  = lastname
        self.addresses = addresses
      }
      #endif
    }
    
    @Model
    final class Address /*test*/ : NSManagedObject {
      
      var street     : String
      var appartment : String?
      var person     : Person
      
      // Either: super.init(entity: Self.entity(), insertInto: nil)
      // Or:     mark this as `convenience`
      convenience init(street: String, appartment: String? = nil, person: Person) {
        //super.init(entity: Self.entity(), insertInto: nil)
        self.init()
        self.street     = street
        self.appartment = appartment
        self.person     = person
      }
    }
  }
}
