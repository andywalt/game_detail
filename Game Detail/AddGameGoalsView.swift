//
//  AddGameGoalsView.swift
//  Game Detail
//
//  Created by Andy Walters on 12/12/19.
//  Copyright © 2019 Andy Walt. All rights reserved.
//

import SwiftUI
import CoreData




struct AddGameGoalsView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Game.entity(), sortDescriptors: []) var games: FetchedResults<Game>
    @Environment(\.presentationMode) var presentationMode
    
    @State private var goalName = ""
    
    var game: Game
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Add Game Goal", text: $goalName)
                }
                HStack {
                    Spacer()
                    Button("Add Goal") {
                        let newGoal = Goal(context: self.moc)
                        newGoal.goalName? = self.$goalName
                        
                        
                        //newGoal.goalOfGame?.gameName = "Testing"
                        do {
                            try self.moc.save()
                            self.presentationMode.wrappedValue.dismiss()
                        } catch {
                            print("Whoops! \(error.localizedDescription)")
                        }
                    }
                }
            }
            .navigationBarTitle("Add Game Goal")
        }
    }
}

#if DEBUG
struct AddGameGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newGoal = Goal(context: context)
        newGoal.goalName = "Goal 1"
        newGoal.goalComplete = false
        newGoal.goalOfGame = Game(context: context)
        newGoal.goalOfGame?.gameName = "Testing"
        return AddGameGoalsView(game: newGoal(goal:)).environment(\.managedObjectContext, context)
    }
}
#endif
