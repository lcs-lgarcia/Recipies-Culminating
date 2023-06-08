//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
    //
import Blackbird
import SwiftUI

struct CreatorView: View {
    
    let ingridientId: Int
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({ db in try await Recipe.read(from: db)
    }) var Create
    @BlackbirdLiveModels({ db in try await Ingredient.read(from: db)
    }) var Ingr
    @BlackbirdLiveQuery (tableName: "Ingredient",{ db in try await db.query(" SELECT  FROM  WHERE ingredient_id = \(ingridientId)")
    }) var recipe
    
    @State var recipeSteps : String = ""
    @State var nameDish : String = ""
    @State var ingredients: String = ""
    
    
    
    var body: some View {
        
        
        
        NavigationView{
            ScrollView{
                VStack{
                    VStack{
                        Spacer()
                        Text("Name of the dish")
                            .bold()
                        TextField("Be original!", text:$nameDish )
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        Text("Ingridients")
                            .bold()
                        HStack{
                            TextField("Add the ingridients and quantities ...", text:$ingredients
                            )
                            .textFieldStyle(.roundedBorder)
                            
                            
                            Button(action: {
                                Task {
                                    try await db!.transaction { core in
                                        try core.query("INSERT INTO Ingredient (description)VALUES (?)", ingredients)
                                    }
                                }
                                
                            }, label:{
                                Text("ADD")
                                    .font(.caption)
                            })
                            
                            
                        }
                    }
                    List{
                        ForEach(Ingr.results){
                            currentItem in
                            Label(title: {
                                Text("\(currentItem.description)")
                            }, icon: {
                               
                            } )
                            
                            .onTapGesture {
                                Task{
                                    try await db!.transaction { core in try core.query("UPDATE Ingredient SET description = (?) WHERE id = (?)", ingredients, currentItem.recipe_id)
                                        
                                    }
                                }
                            }
                            
                        }

                        
                    }
                   Text("Steps")
                      .bold()
                   TextField("Write the steps ...", text:$recipeSteps )
                        .textFieldStyle(.roundedBorder)
                }
                
                Button(action: {
                    Task {
                        try await db!.transaction { core in
                            try core.query("""
INSERT INTO Recipe (name,steps)VALUES((?),(?)
)
""",
                                           nameDish, recipeSteps)
                        }
                        nameDish = ""
                        ingredients = ""
                        recipeSteps = ""
                    }
                }, label:{
                    Text("SAVE")
                        
                })
                
            }
                .navigationTitle("Create Your Recipies")
            
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView(ingridientId: 1)
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
