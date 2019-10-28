//
//  SUT: MonstersListBuilder
//
//  Collaborators:
//  MonstersListViewController
//  MonstersListInteractor
//  MonstersListPresenter
//  MonstersListProvider
//

import Quick
import Nimble

@testable import Monsters

class MonstersListBuilderTests: QuickSpec {
    override func spec() {
        var builder: MonstersListBuilder!

        beforeEach {
            builder = MonstersListBuilder()
        }

        describe(".build") {
            it("should build module parts") {
                // when
                let controller = builder.set(initialState: TestData.initialState).build() as? MonstersListViewController
                let interactor = controller?.interactor as? MonstersListInteractor
                let presenter = interactor?.presenter as? MonstersListPresenter

                // then
                expect(controller).toNot(beNil())
                expect(interactor).toNot(beNil())
                expect(presenter).toNot(beNil())
            }

            it("should set dependencies between module parts") {
                // when
                let controller = builder.set(initialState: TestData.initialState).build() as? MonstersListViewController
                let interactor = controller?.interactor as? MonstersListInteractor
                let presenter = interactor?.presenter as? MonstersListPresenter

                // then
                expect(presenter?.viewController).to(beIdenticalTo(controller))
            }
        }
    }
}

extension MonstersListBuilderTests {
    enum TestData {
        static let initialState = MonstersList.ViewControllerState.loading
    }
}
