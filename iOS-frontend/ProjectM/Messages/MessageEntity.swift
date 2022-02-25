//
//  MessageEntity.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/1/21.
//

import ARKit
import RealityKit

// This class creats our message entity
// Entity: element in our AR world which holds behavior and appeareance of entity.
// Ex: a user message is an entity
// HasAnchoring: allows us to anchor/attach a virtual object(Ex: user message) to the real world
// Ex: if user attachs message to Bell Tower
// ARScreenSpace: contains the functionality of our message in the AR space.
// Ex: can user edit the message
class MessageEntity: Entity, HasARScreenSpace {
    var arScreenSpace = ARScreenSpace()
    // Initialize a new message and the position and orientation of
    // the hit test result relative to the world coordinate system.
    init(frame: CGRect){
        super.init()
        //self.transform.matrix = worldTransform
        arScreenSpace.view = MessageView(frame: frame, user_message: self)
    }
    // Subclass Entity requires use to include 'required init()' so our code will run
    required init() {
        fatalError("init() has not been implemented")
    }
}
