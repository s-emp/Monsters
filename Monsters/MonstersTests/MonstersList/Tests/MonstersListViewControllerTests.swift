//
//  SUT: MonstersListViewController
//
//  Collaborators:
//  MonstersListInteractor
//

import Quick
import Nimble

@testable import Monsters

class MonstersListViewControllerTests: QuickSpec {
    override func spec() {
        var viewController: MonstersListViewController!
        var interactorMock: MonstersListInteractorMock!

        beforeEach {
            interactorMock = MonstersListInteractorMock()
            viewController = MonstersListViewController(interactor: interactorMock)
        }

        describe(".doSomething") {
            it("should call method in interactor") {
                // when
                viewController.doSomething()

                // then
                expect(interactorMock.doSomethingWasCalled).to(equal(1))
                expect(interactorMock.doSomethingArguments).toNot(beNil())
            }
        }
    }
}

extension MonstersListViewControllerTests {
    enum TestData {
        static let request = MonstersList.Something.Request()
    }
}

fileprivate class MonstersListInteractorMock: MonstersListBusinessLogic {
    var doSomethingWasCalled: Int = 0
    var doSomethingArguments: MonstersList.Something.Request?

    func doSomething(request: MonstersList.Something.Request) {
        doSomethingWasCalled += 1
        doSomethingArguments = request
    }
}
