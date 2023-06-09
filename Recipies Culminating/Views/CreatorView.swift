//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
    //
import Blackbird
import SwiftUI

struct CreatorView: View {
    
  
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({ db in try await Recipe.read(from: db)
    }) var Create
    @BlackbirdLiveModels({ db in try await Ingredient.read(from: db)
    }) var Ingre
   
   
    @State var ingredients: [String] = []
    
    @State var recipeSteps : String = ""
    @State var nameDish : String = ""
    @State var ingredient: String = ""
    
 
   
    var body: some View {
        
        NavigationView{
                
                VStack{
                    
                    
                    Text("Name of the dish")
                        .bold()
                    TextField("Be original!", text:$nameDish )
                        .textFieldStyle(.roundedBorder)
                    
                    VStack{
                        Text("Ingredients")
                            .bold()
                        HStack{
                            TextField("Add the ingredients and quantities ...", text:$ingredient
                            )
                            .textFieldStyle(.roundedBorder)
                            Button(action: {
                                
                                ingredients.append(ingredient)
                                
                            }, label:{ Text("ADD")})
//                            Button(action: {
//                                Task {
//                                    try await db!.transaction { core in
//                                        try core.query("INSERT INTO Ingredient (description, recipe_id) VALUES ((?), (?))", ingredients)
//                                    }
//
//                                    ingredients = ""
//
//                                }
//                            }, label:{
//
//                                    .font(.caption)
//
//                            })
                            
                        }
                        
                        ForEach(ingredients, id: \.self) { currentIngredient in
                        Label(title: {
                            Text(currentIngredient)
                        }, icon: {
                            
                        } )
                            
                            
                            
                            
                        }
                        .scaledToFit()
                        
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
                            ingredient = ""
                            recipeSteps = ""
                        }
                        Task {
                            try await db!.transaction { core in
                                try core.query("""
INSERT INTO Ingredient (description,recipe_id) VALUES((?), (?)
)
""",
                                               ingredient)
                            }
                        }
                    }, label:{
                        Text("SAVE")
                        
                    })
                    
                
           
        }
        .navigationTitle("Create Your Recipes")
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
