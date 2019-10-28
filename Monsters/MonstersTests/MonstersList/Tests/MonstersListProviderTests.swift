//
//  SUT: MonstersListProvider
//
//  Collaborators:
//  MonstersListService
//  MonstersListDataStore
//

import Quick
import Nimble

@testable import Monsters

class MonstersListProviderTests: QuickSpec {
    override func spec() {
        var provider: MonstersListProvider!
        var serviceMock: MonstersListServiceMock!
        var dataStoreMock: MonstersListDataStoreMock!

        var getItemsResult: (items: [MonstersListModel]?, error: MonstersListProviderError?)

        beforeEach {
            serviceMock = MonstersListServiceMock()
            dataStoreMock = MonstersListDataStoreMock()
            provider = MonstersListProvider(dataStore: dataStoreMock, service: serviceMock)

            getItemsResult = (nil, nil)
        }

        describe(".getItems") {
            context("cache is empty") {
                beforeEach {
                    dataStoreMock.models = nil
                }

                it ("should request data from service") {
                    // when
                    provider.getItems { (_, _) in }
                    // then
                    expect(serviceMock.fetchItemsWasCalled).to(equal(1))
                }

                context("successfull response"){
                    it("should save data to store"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (TestData.responseData, nil)
                        // when
                        provider.getItems { (_, _) in }
                        // then
                        expect(dataStoreMock.models).to(equal(TestData.responseData))
                    }

                    it("should return result in callback"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (TestData.responseData, nil)
                        // when
                        provider.getItems { getItemsResult = ($0, $1) }
                        // then
                        expect(getItemsResult.items).to(equal(TestData.responseData))
                        expect(getItemsResult.error).to(beNil())
                    }
                }

                context("failed response"){
                    it("should not update store"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (nil, TestData.responseError)
                        // when
                        provider.getItems { (_, _) in }
                        // then
                        expect(dataStoreMock.models).to(beNil())
                    }

                    it("should return error in callback"){
                        // given
                        serviceMock.fetchItemsCompletionStub = (nil, TestData.responseError)
                        // when
                        provider.getItems { getItemsResult = ($0, $1) }
                        // then
                        expect(getItemsResult.items).to(beNil())
                        expect{ if case .getItemsFailed(_)? = getItemsResult.error { return true }; return false }.to(beTrue())
                    }
                }
            }
        }

        context("cache fulfilled"){
            it("should not call service"){
                // given
                dataStoreMock.models = TestData.responseData
                // when
                provider.getItems { (_, _) in }
                // then
                expect(serviceMock.fetchItemsWasCalled).to(equal(0))
            }

            it("should return data in callback"){
                // given
                dataStoreMock.models = TestData.responseData
                // when
                provider.getItems { getItemsResult = ($0, $1) }
                // then
                expect(getItemsResult.items).to(equal(TestData.responseData))
                expect(getItemsResult.error).to(beNil())
            }
        }
    }
}

extension MonstersListProviderTests {
    enum TestData {
        static let responseData = MonstersListModelTests.TestData.entitiesCollection()
        static let responseError = APIClientError.other
    }
}

fileprivate class MonstersListServiceMock: MonstersListServiceProtocol {
    var fetchItemsWasCalled: Int = 0
    var fetchItemsArguments: (([MonstersListModel]?, APIClientError?) -> Void)?
    var fetchItemsCompletionStub: (result: [MonstersListModel]?, error: APIClientError?)

    func fetchItems(completion: @escaping ([MonstersListModel]?, Error?) -> Void) {
        fetchItemsWasCalled += 1
        fetchItemsArguments = completion
        completion(fetchItemsCompletionStub.result, fetchItemsCompletionStub.error)
    }
}

fileprivate class MonstersListDataStoreMock: MonstersListDataStore {

}

fileprivate class ErrorMock: Error {}

enum APIClientError: Error {
    case other
}
