//
//  SUT: MonstersListModel
//

import Quick
import Nimble

@testable import Monsters

class MonstersListModelTests: QuickSpec {
    override func spec() {
        describe("equalit operator") {
            it("should return true for same objects"){
                expect(TestData.model == TestData.model).to(beTrue())
            }

            it("should return false for objects with different uid"){
                expect(TestData.model == TestData.differentUidModel).to(beFalse())
            }

            it("should ignore name attribute for equality"){
                expect(TestData.model == TestData.differentNameModel).to(beTrue())
            }
        }
    }
}

extension MonstersListModelTests {
    enum TestData {
        static let uid = UUID().uuidString
        static let name = "Name"
        static let model = MonstersListModel(uid: uid, name: name)
        static let differentUidModel = MonstersListModel(uid: UUID().uuidString, name: name)
        static let differentNameModel = MonstersListModel(uid: uid, name: "differentName")

        static let defaultEntitiesCollectionCount = 1
        static func entitiesCollection(withCount count: Int = defaultEntitiesCollectionCount) -> [MonstersListModel] {
            var collection: [MonstersListModel] = []
            while collection.count < count {
                collection.append(MonstersListModel(uid: UUID().uuidString, name: "name"))
            }
            return collection
        }
    }
}
