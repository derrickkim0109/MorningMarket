//
//  MockAppMainQuickMenuFetchDataSource.swift
//  MorningMarketTests
//
//  Created by Derrick kim on 11/27/23.
//

import Foundation
import Combine
import Moya
@testable import MorningMarket

final class MockAppMainQuickMenuFetchDataSource: AppMainQuickMenuFetchDataSourceInterface {
    var scenario: Scenario = .success

    var appMainQuickMenuResponseDTO = AppMainQuickMenuDTOObjectMother.getListResultAppMainQuickMenuResponseDTOWithCompleteData()
    var networkError = MoyaError.statusCode(.init(statusCode: 500, data: Data()))
    
    func fetchAppMainQuickMenuList() -> AnyPublisher<ListResultAppMainQuickMenuResponseDTO, MoyaError> {
        switch scenario {
        case .success:
            return Just(appMainQuickMenuResponseDTO)
                .setFailureType(to: MoyaError.self)
                .eraseToAnyPublisher()
        case .failure:
            return Fail(error: networkError)
                .eraseToAnyPublisher()
        }
    }
}