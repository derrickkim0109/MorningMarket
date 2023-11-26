//
//  CategoryDetailViewModel.swift
//  TimFresh_Assignment
//
//  Created by Derrick kim on 11/21/23.
//

import Foundation
import Combine
import UIKit

final class CategoryDetailViewModelWithRouter: CategoryDetailViewModel {
    private var router: CategoryRouter

    init(
        router: CategoryRouter,
        displayClassItem: AppDisplayClassInfoFetchItemModel,
        appDisplayBySubClassFetchUseCase: AppDisplayBySubClassFetchUseCaseInterface,
        appGoodsInfoFetchUseCase: AppGoodsInfoFetchUseCaseInterface
    ) {
        self.router = router
        super.init(
            displayClassItem: displayClassItem,
            appDisplayBySubClassFetchUseCase: appDisplayBySubClassFetchUseCase,
            appGoodsInfoFetchUseCase: appGoodsInfoFetchUseCase
        )
    }
}

class CategoryDetailViewModel: ObservableObject {
    @Published private(set) var fetchedAppSubDisplayClassInfoList = [AppSubDisplayClassInfoFetchItemModel]()
    @Published private(set) var fetchedAppGoodsInfoList = [AppGoodsInfoFetchItemModel]()
    @Published var showErrorAlert: Bool = false
    @Published var showToast: Bool = false

    @Published private(set) var selectedSubCategory: AppSubDisplayClassInfoFetchItemModel? {
        didSet {
            resetAppGoodsInfoList()
            fetchAppGoodsInfo()
        }
    }

    @Published private(set) var selectedSearchValue: SearchValueType = .recommended {
        didSet {
            resetAppGoodsInfoList()
            fetchAppGoodsInfo()
        }
    }

    var viewModelError: String?
    var pagination: PaginationModel?

    private let appGoodsCurrentPage = 0
    private var appGoodsSize = 20

    private let appDisplayBySubClassFetchUseCase: AppDisplayBySubClassFetchUseCaseInterface
    private let appGoodsInfoFetchUseCase: AppGoodsInfoFetchUseCaseInterface
    private let displayClassItem: AppDisplayClassInfoFetchItemModel

    private var cancellable = Set<AnyCancellable>()

    init(
        displayClassItem: AppDisplayClassInfoFetchItemModel,
        appDisplayBySubClassFetchUseCase: AppDisplayBySubClassFetchUseCaseInterface,
        appGoodsInfoFetchUseCase: AppGoodsInfoFetchUseCaseInterface
    ) {
        self.displayClassItem = displayClassItem
        self.appDisplayBySubClassFetchUseCase = appDisplayBySubClassFetchUseCase
        self.appGoodsInfoFetchUseCase = appGoodsInfoFetchUseCase
    }

    func fetchAppDisplayBySubClass() {
        appDisplayBySubClassFetchUseCase.fetch(by: displayClassItem.displayClassSequence)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.setupFetchError(error.rawValue)
                }
            } receiveValue: { [weak self] entity in
                let appDisplayClassInfoBySubDisplayClassFetchModel = AppDisplayClassInfoBySubDisplayClassFetchModelMapper.toPresentationModel(entity: entity)

                let appSubDisplayClassInfoList = appDisplayClassInfoBySubDisplayClassFetchModel.data.appSubDisplayClassInfoList

                guard !appSubDisplayClassInfoList.isEmpty else {
                    return
                }

                self?.fetchedAppSubDisplayClassInfoList.append(
                    contentsOf: appSubDisplayClassInfoList
                )

                self?.selectedSubCategory = appSubDisplayClassInfoList.first
            }
            .store(in: &cancellable)
    }

    func fetchAppGoodsInfo() {
        appGoodsInfoFetchUseCase.fetch(
            displayClassSequence: displayClassItem.displayClassSequence,
            subDisplayClassSequence: selectedSubCategory?.displayClassSequence ?? 0,
            page: appGoodsCurrentPage,
            size: appGoodsSize,
            searchValue: selectedSearchValue.rawValue
        )
        .sink { [weak self] completion in
            switch completion {
            case .finished:
                break
            case let .failure(error):
                self?.setupFetchError(error.rawValue)
            }
        } receiveValue: { [weak self] entity in
            let appGoodsInfoFetchModel = AppGoodsInfoFetchModelMapper.toPresentationModel(entity: entity)

            guard !appGoodsInfoFetchModel.data.isEmpty else {
                return
            }

            self?.appGoodsSize += 20
            self?.pagination = appGoodsInfoFetchModel.pagination

            self?.fetchedAppGoodsInfoList.append(
                contentsOf: appGoodsInfoFetchModel.data
            )
        }
        .store(in: &cancellable)
    }

    func getDisplayClassName() -> String {
        return displayClassItem.displayClassName
    }

    func didSelectSubCategory(_ item: AppSubDisplayClassInfoFetchItemModel) {
        selectedSubCategory = item
    }

    func didSelectSearchValue(_ type: SearchValueType) {
        selectedSearchValue = type
    }

    func hasNext() -> Bool {
        return pagination?.hasNext(perPage: appGoodsSize) == true
    }

    func showToastByDebounce() {
        showToast = true
    }

    func setupFetchError(_ error: String) {
        viewModelError = error
        showErrorAlert = true
    }
}

extension CategoryDetailViewModel {
    private func resetAppSubDisplayClassInfoList() {
        fetchedAppSubDisplayClassInfoList = []
        viewModelError = nil
    }

    private func resetAppGoodsInfoList() {
        fetchedAppGoodsInfoList = []
        viewModelError = nil
        appGoodsSize = 20
    }

    private func getAPPSubDisplayClassSequence() -> Int {
        return selectedSubCategory?.parentsDisplayClassSequence ?? 0
    }
}
