//
//  List of monsters
//  Created by Sergey Melnikov on 28/10/2019.
//

import UIKit

protocol MonstersListPresentationLogic {
    func presentSomething(response: MonstersList.Something.Response)
}

/// Отвечает за отображение данных модуля MonstersList
class MonstersListPresenter: MonstersListPresentationLogic {
    weak var viewController: MonstersListDisplayLogic?

    // MARK: Do something
    func presentSomething(response: MonstersList.Something.Response) {
        var viewModel: MonstersList.Something.ViewModel
        
        switch response.result {
        case let .failure(error):
            viewModel = MonstersList.Something.ViewModel(state: .error(message: error.localizedDescription))
        case let .success(result):
            if result.isEmpty {
                viewModel = MonstersList.Something.ViewModel(state: .emptyResult)
            } else {
                viewModel = MonstersList.Something.ViewModel(state: .result(result))
            }
        }
        
        viewController?.displaySomething(viewModel: viewModel)
    }
}
