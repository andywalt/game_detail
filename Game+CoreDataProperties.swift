//
//  Game+CoreDataProperties.swift
//  Game Detail
//
//  Created by Andy Walters on 12/11/19.
//  Copyright © 2019 Andy Walt. All rights reserved.
//
//

import Foundation
import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var gameDescription: String?
    @NSManaged public var gameName: String?
    @NSManaged public var goal: NSSet?
    
    public var wrappedGameName: String {
        gameName ?? "Unknown Game"
    }
    
    public var wrappedGameDescription: String {
        gameDescription ?? "Unknown Game Description"
    }
    
    public var goalArray: [Goal] {
        let set = goal as? Set<Goal> ?? []
        
        return set.sorted {
            $0.wrappedGoalName < $1.wrappedGoalName
        }
    }

}

// MARK: Generated accessors for goal
extension Game {

    @objc(addGoalObject:)
    @NSManaged public func addToGoal(_ value: Goal)

    @objc(removeGoalObject:)
    @NSManaged public func removeFromGoal(_ value: Goal)

    @objc(addGoal:)
    @NSManaged public func addToGoal(_ values: NSSet)

    @objc(removeGoal:)
    @NSManaged public func removeFromGoal(_ values: NSSet)

}