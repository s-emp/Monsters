//
//  Created by Sergey Melnikov on 28/10/2019.
//

protocol MonstersListProviderProtocol {
    func getItems(completion: @escaping ([MonstersListModel]?, MonstersListProviderError?) -> Void)
}

enum MonstersListProviderError: Error {
    case getItemsFailed(underlyingError: Error)
}

/// Отвечает за получение данных модуля MonstersList
struct MonstersListProvider: MonstersListProviderProtocol {
    let dataStore: MonstersListDataStore
    let service: MonstersListServiceProtocol

    init(dataStore: MonstersListDataStore = MonstersListDataStore(), service: MonstersListServiceProtocol = MonstersListService()) {
        self.dataStore = dataStore
        self.service = service
    }

    func getItems(completion: @escaping ([MonstersListModel]?, MonstersListProviderError?) -> Void) {
        if dataStore.models?.isEmpty == false {
            return completion(self.dataStore.models, nil)
        }
        service.fetchItems { (array, error) in
            if let error = error {
                completion(nil, .getItemsFailed(underlyingError: error))
            } else if let models = array {
                self.dataStore.models = models
                completion(self.dataStore.models, nil)
            }
        }
    }
}
