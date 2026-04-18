import Foundation
import Raptor

struct MainLayout: Layout {
    var body: some Document {
        Navigation {
            SiteHeader()
        }

        Main {
            content
        }

        Footer {
            RaptorFooter()
        }
    }
}
