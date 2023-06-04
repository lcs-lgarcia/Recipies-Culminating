import Blackbird
import Foundation

struct IngridientsLis: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var ingridients: String
    @BlackbirdColumn var steps: String
    
}




