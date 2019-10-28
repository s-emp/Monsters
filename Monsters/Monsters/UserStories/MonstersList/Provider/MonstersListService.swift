//
//  Created by Sergey Melnikov on 28/10/2019.
//

protocol MonstersListServiceProtocol {
    func fetchItems(completion: @escaping ([MonstersListModel]?, Error?) -> Void)
}

/// Получает данные для модуля MonstersList
class MonstersListService: MonstersListServiceProtocol {

    func fetchItems(completion: @escaping ([MonstersListModel]?, Error?) -> Void) {
        completion(nil, nil)
    }
}
