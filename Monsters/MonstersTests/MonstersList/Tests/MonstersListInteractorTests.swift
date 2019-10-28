//
//  SUT: MonstersListInteractor
//
//  Collaborators:
//  MonstersListProvider
//  MonstersListPresenter
//

import Quick
import Nimble

@testable import Monsters

class MonstersListInteractorTests: QuickSpec {
    override func spec() {
        var interactor: MonstersListInteractor!
        var presenterMock: MonstersListPresenterMock!
        var providerMock: MonstersListProviderMock!

        beforeEach {
            providerMock = MonstersListProviderMock()
            presenterMock = MonstersListPresenterMock()
            interactor = MonstersListInteractor(presenter: presenterMock, provider: providerMock)
        }

        describe(".doSomething") {
            it("should get data from provider") {
                // when
                interactor.doSomething(request: TestData.request)
                // then
                expect(providerMock.getItemsWasCalled).to(equal(1))
            }

            context("getItems successfull"){
                it("should prepare success response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (result: TestData.models, error: nil)
                    // when
                    interactor.doSomething(request: TestData.request)
                    // then
                    expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect{ if case .success(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }

            context("getItems failed"){
                it("should prepare failed response and call presenter"){
                    // given
                    providerMock.getItemsCompletionStub = (result: nil, error: TestData.getItemsFailedError)
                    // when
                    interactor.doSomething(request: TestData.request)
                    // then
                    expect(presenterMock.presentSomethingWasCalled).to(equal(1))
                    expect(presenterMock.presentSomethingArguments).toNot(beNil())
                    expect{ if case .failure(_)? = presenterMock.presentSomethingArguments?.result { return true }; return false }.to(beTrue())
                }
            }
        }
    }
}

extension MonstersListInteractorTests {
    enum TestData {
        static let request = MonstersList.Something.Request()
        static let models = MonstersListModelTests.TestData.entitiesCollection()

        fileprivate static let underlyingError = ErrorMock()
        fileprivate static let getItemsFailedError = MonstersListProviderError.getItemsFailed(underlyingError: underlyingError)
    }
}

fileprivate class MonstersListProviderMock: MonstersListProviderProtocol {
    var getItemsWasCalled: Int = 0
    var getItemsArguments: (([MonstersListModel]?, MonstersListProviderError?) -> Void)?
    var getItemsCompletionStub: (result: [MonstersListModel]?, error: MonstersListProviderError?) = (nil, nil)

    func getItems(completion: @escaping ([MonstersListModel]?, MonstersListProviderError?) -> Void) {
        getItemsWasCalled += 1
        getItemsArguments = completion
        completion(getItemsCompletionStub.result, getItemsCompletionStub.error)
    }
}

fileprivate class MonstersListPresenterMock: MonstersListPresentationLogic {
    var presentSomethingWasCalled: Int = 0
    var presentSomethingArguments: MonstersList.Something.Response?

    func presentSomething(response: MonstersList.Something.Response) {
        presentSomethingWasCalled += 1
        presentSomethingArguments = response
    }
}

fileprivate class ErrorMock: Error { }
