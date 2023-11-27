//
//  MockAppDisplayClassInfoDataSource.swift
//  TimFresh_AssignmentTests
//
//  Created by Derrick kim on 11/27/23.
//

import Foundation
import Combine
import Moya
@testable import TimFresh_Assignment

final class MockAppDisplayClassInfoDataSource: AppDisplayClassInfoDataSourceInterface {
    var scenario: Scenario = .success

    var appDisplayClassInfoResponseDTO = AppDisplayClassDTOObjectMother.getListResultAppDisplayClassInfoResponseDTOWithCompleteData()
    var networkError = MoyaError.statusCode(.init(statusCode: 400, data: Data()))

    func fetchAppDisplayClassInfoList() -> AnyPublisher<ListResultAppDisplayClassInfoResponseDTO, MoyaError> {
        switch scenario {
        case .success:
            return Just(appDisplayClassInfoResponseDTO)
                .setFailureType(to: MoyaError.self)
                .eraseToAnyPublisher()
        case .failure:
            return Fail(error: networkError)
                .eraseToAnyPublisher()
        }
    }
}