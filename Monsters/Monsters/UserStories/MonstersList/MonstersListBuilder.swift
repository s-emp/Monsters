//
//  List of monsters
//  Created by Sergey Melnikov on 28/10/2019.
//

import UIKit

class MonstersListBuilder: ModuleBuilder {

    var initialState: MonstersList.ViewControllerState?

    func set(initialState: MonstersList.ViewControllerState) -> MonstersListBuilder {
        self.initialState = initialState
        return self
    } 

    func build() -> UIViewController {
        let presenter = MonstersListPresenter()
        let interactor = MonstersListInteractor(presenter: presenter)
        let controller = MonstersListViewController(interactor: interactor)

        presenter.viewController = controller
        return controller
    }
}
