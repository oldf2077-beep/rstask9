//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: akote
// On: 31.10.25
// 
// Copyright © 2025 RSSchool. All rights reserved.

import UIKit

class ItemsViewControllerFactory {
    static func create() -> ItemsViewController {
        let viewModel = ItemViewModel()
        return ItemsViewController(viewModel: viewModel)
    }
}



