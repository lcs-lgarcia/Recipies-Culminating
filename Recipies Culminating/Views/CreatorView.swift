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
    
    @BlackbirdLiveModels({ db in try await IngridientsLis.read(from: db)
    }) var create

    @State var recipeSteps : String = ""
    @State var nameDish : String = ""
    @State var ingridients : String = ""
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    VStack{
                        Spacer()
                        Text("Name of the dish")
                            .bold()
                        TextField("Name of the dish ...", text:$nameDish )
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        Text("Ingridients")
                            .bold()
                        HStack{
                            TextField("Add the ingridients and quantities ...", text:$ingridients
                            )
                            
                            
                            Button(action: {
                                Task {
                                    try await db!.transaction { core in
                                        try core.query("INSERT INTO Creator (ingridients) VALUES (?)", ingridients)
                                    }
                                }
                                
                            }, label:{
                                Text("ADD")
                                    .font(.caption)
                            })
                            
                            
                        }
                    }
                    List{
                        ForEach(create.results){
                            currentItem in
                            Label(title: {
                                Text(currentItem.ingridients)
                            }, icon: {
                                Text("-")
                            })
                            
                            .onTapGesture {
                                Task{
                                    try await db!.transaction { core in try core.query("UPDATE Creator SET ingridients = (?) WHERE id = (?)",  currentItem.id)
                                        
                                    }
                                }
                            }
                            
                        }
                        
                        
                    }
                    Text("Steps")
                        .bold()
                    TextField("Write the steps ...", text:$recipeSteps )
                }
            }
                .navigationTitle("Create Your Recipies")
            
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
