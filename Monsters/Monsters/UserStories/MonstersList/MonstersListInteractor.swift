//
//  List of monsters
//  Created by Sergey Melnikov on 28/10/2019.
//

protocol MonstersListBusinessLogic {
    func doSomething(request: MonstersList.Something.Request)
}

/// Класс для описания бизнес-логики модуля MonstersList
class MonstersListInteractor: MonstersListBusinessLogic {
    let presenter: MonstersListPresentationLogic
    let provider: MonstersListProviderProtocol

    init(presenter: MonstersListPresentationLogic, provider: MonstersListProviderProtocol = MonstersListProvider()) {
        self.presenter = presenter
        self.provider = provider
    }
    
    // MARK: Do something
    func doSomething(request: MonstersList.Something.Request) {
        provider.getItems { (items, error) in
            let result: MonstersList.MonstersListRequestResult
            if let items = items {
                result = .success(items)
            } else if let error = error {
                result = .failure(.someError(message: error.localizedDescription))
            } else {
                result = .failure(.someError(message: "No Data"))
            }
            self.presenter.presentSomething(response: MonstersList.Something.Response(result: result))
        }
    }
}
