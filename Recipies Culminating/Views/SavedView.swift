//
//  SavedView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//
import Blackbird
import SwiftUI

struct SavedView: View {
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @BlackbirdLiveModels({ db in
        try await Creator.read(from: db)
    }) var savedRecipes
    @BlackbirdLiveModels({ db in
        try await Ingridient.read(from: db)
    }) var savedIngr
    
    var body: some View {
       
        NavigationView{
            
            List(savedRecipes.results, id: \.ingridients_id){currentRecipe in
                VStack(alignment:.leading){
                    Text(currentRecipe.name)
                        .bold()
                    List(savedIngr.results, id: \.id){currentRecipe in
                        VStack(alignment:.leading){
                            Text(currentRecipe.ingridients)
                        }
                    }
                    Text("Steps")
                        .bold()
                    Text(currentRecipe.steps)
                        
                   
                }
            }
            .navigationTitle("Your Recipes")
        }
        
    }
    
    
    func removeRows(at offsets: IndexSet) {
        
        Task{
            try await db!.transaction{ core in
                
                var idList = ""
                for offset in offsets {
                    idList += "\(savedRecipes.results[offset].id),"
                }
                print(idList)
                idList.removeLast()
                print(idList)
                
                try core.query("DELETE FROM Creator WHERE id IN (?)", idList)
            }
        }
    }
}
    struct SavedView_Previews: PreviewProvider {
        static var previews: some View {
            SavedView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }

