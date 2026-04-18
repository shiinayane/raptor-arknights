import Foundation
import Raptor

@main
struct RaptorWebsite {
    static func main() async {
        var site = ShiinaBlog()

        do {
            try await site.publish()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct ShiinaBlog: Site {
    var name = "My Blog"
    var titleSuffix = " – My Awesome Site"
    var url = URL(static: "https://www.shiinayane.com")

    var author = "shiinayane"

    var homePage = Home()
    var layout = MainLayout()
}
