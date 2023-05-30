//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//

import SwiftUI

struct CreatorView: View {
    
    @State var nameDish : String = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                
                TextField("Name of the dish ...", text:$nameDish )
            
                
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
