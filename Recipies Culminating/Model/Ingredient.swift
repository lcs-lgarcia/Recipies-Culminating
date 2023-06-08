import Blackbird
import Foundation

struct Ingredient: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var description: String
    @BlackbirdColumn var recipe_id: Int
}

