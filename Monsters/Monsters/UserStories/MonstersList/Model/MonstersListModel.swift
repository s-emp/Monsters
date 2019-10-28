//
//  Created by Sergey Melnikov on 28/10/2019.
//

/// Модель данных, описывающая ...
struct MonstersListModel: UniqueIdentifiable {
    // Example
    let uid: UniqueIdentifier
    let name: String
}

extension MonstersListModel: Equatable {
    static func == (lhs: MonstersListModel, rhs: MonstersListModel) -> Bool {
        return lhs.uid == rhs.uid
    }
}
