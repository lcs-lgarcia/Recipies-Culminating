//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//

import SwiftUI

struct CreatorView: View {
    
    @State var nameDish : String = ""
    @State var ingridientsList : String = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    Spacer()
                   
                        TextField("Name of the dish ...", text:$nameDish )
                            
                    
                    Text("     ")
                }
                HStack{
                    Spacer()
                   
                        TextField("Add the ingridients and quantities ...", text:$ingridientsList
                        )
                            
                   
              
                    
                    
                }
            
                
            }
                .navigationTitle("Create Your Recipies")
            
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
