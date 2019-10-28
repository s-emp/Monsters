//
//  List of monsters
//  Created by Sergey Melnikov on 28/10/2019.
//

enum MonstersList {
    // MARK: Use cases
    enum Something {
        struct Request {
        }

        struct Response {
            var result: MonstersListRequestResult
        }

        struct ViewModel {
            var state: ViewControllerState
        }
    }

    enum MonstersListRequestResult {
        case failure(MonstersListError)
        case success([MonstersListModel])
    }

    enum ViewControllerState {
        case loading
        case result([Any/*viewModel*/])
        case emptyResult
        case error(message: String)
    }

    enum MonstersListError: Error {
        case someError(message: String)
    }
}
