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
    
    @ObservedObject var game: Game
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    TextField("Add Game Goal", text: $goalName)
                }
                HStack {
                    Spacer()
                    Button("Add Goal") {
                        guard self.goalName != "" else {return}
                        let newGoal = Goal(context: self.moc)
                        newGoal.goalName = self.goalName
                        newGoal.goalComplete = false
                        newGoal.goalOfGame = self.game
                        
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
            .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                }
                .padding(10)
                .foregroundColor(Color.white)
                .background(Color.red)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            })
        }
    }
}


struct AddGameGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newGoal = Goal(context: context)
        newGoal.goalName = "Goal 1"
        newGoal.goalComplete = false
        newGoal.goalOfGame = Game(context: context)
        newGoal.goalOfGame?.gameName = "Test Game 1"
        newGoal.goalOfGame?.gameDescription = "Maybe this will work"
        return AddGameGoalsView(game: Game()).environment(\.managedObjectContext, context)
    }
}
