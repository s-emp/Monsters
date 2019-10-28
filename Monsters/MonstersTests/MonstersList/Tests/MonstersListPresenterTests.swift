//
//  SUT: MonstersListPresenter
//
//  Collaborators:
//  MonstersListViewController
//

import Quick
import Nimble

@testable import Monsters

class MonstersListPresenterTests: QuickSpec {
    override func spec() {
        var presenter: MonstersListPresenter!
        var viewControllerMock: MonstersListViewControllerMock!

        beforeEach {
            presenter = MonstersListPresenter()
            viewControllerMock = MonstersListViewControllerMock()
            presenter.viewController = viewControllerMock
        }

        describe(".presentSomething") {
            context("successfull empty result") {
                it ("should prepare empty view model and display it in view") {
                    // when
                    presenter.presentSomething(response: TestData.successEmptyResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .emptyResult? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("successfull result") {
                it ("should prepare result view model and display it in view") {
                    // when
                    presenter.presentSomething(response: TestData.successResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .result(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }

            context("failure result") {
                it ("should prepare error view model and display it in view") {
                    // when
                    presenter.presentSomething(response: TestData.failureResponse)
                    // then
                    expect(viewControllerMock.displaySomethingWasCalled).to(beTruthy())
                    expect{ if case .error(_)? = viewControllerMock.displaySomethingArguments?.state { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension MonstersListPresenterTests {
    enum TestData {
        static let successEmptyResponse = MonstersList.Something.Response(result: .success([]))
        static let successResponse = MonstersList.Something.Response(result: .success([MonstersListModel(uid: UUID().uuidString, name: "name")]))
        static let failureResponse = MonstersList.Something.Response(result: .failure(.someError(message: "some error")))
    }
}

fileprivate class MonstersListViewControllerMock: MonstersListDisplayLogic {
    var displaySomethingWasCalled: Int = 0
    var displaySomethingArguments: MonstersList.Something.ViewModel?

    func displaySomething(viewModel: MonstersList.Something.ViewModel) {
        displaySomethingWasCalled += 1
        displaySomethingArguments = viewModel
    }
}
