//
//  List of monsters
//  Created by Sergey Melnikov on 28/10/2019.
//

import UIKit

protocol MonstersListDisplayLogic: class {
    func displaySomething(viewModel: MonstersList.Something.ViewModel)
}

class MonstersListViewController: UIViewController {
    let interactor: MonstersListBusinessLogic
    var state: MonstersList.ViewControllerState

    init(interactor: MonstersListBusinessLogic, initialState: MonstersList.ViewControllerState = .loading) {
        self.interactor = interactor
        self.state = initialState
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle
    override func loadView() {
        let view = MonstersListView(frame: UIScreen.main.bounds)
        self.view = view
        // make additional setup of view or save references to subviews
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
    }

    // MARK: Do something
    func doSomething() {
        let request = MonstersList.Something.Request()
        interactor.doSomething(request: request)
    }
}

extension MonstersListViewController: MonstersListDisplayLogic {
    func displaySomething(viewModel: MonstersList.Something.ViewModel) {
        display(newState: viewModel.state)
    }

    func display(newState: MonstersList.ViewControllerState) {
        state = newState
        switch state {
        case .loading:
            print("loading...")
        case let .error(message):
            print("error \(message)")
        case let .result(items):
            print("result: \(items)")
        case .emptyResult:
            print("empty result")
        }
    }
}
