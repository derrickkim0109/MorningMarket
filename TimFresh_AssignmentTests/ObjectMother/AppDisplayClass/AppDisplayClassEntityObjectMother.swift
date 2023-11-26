//
//  AppDisplayClassEntityObjectMother.swift
//  TimFresh_AssignmentTests
//
//  Created by Derrick kim on 11/26/23.
//

@testable import TimFresh_Assignment

struct AppDisplayClassEntityObjectMother {
    static func getAppDisplayClassInfoFetchEntityWithCompleteData() -> AppDisplayClassInfoFetchEntity {
        return AppDisplayClassInfoFetchEntity(data: getAppSearchItemEntityListWithCompleteData(), message: "")
    }

    static func getAppDisplayClassInfoFetchEntityWithEmptyData() -> AppDisplayClassInfoFetchEntity {
        return AppDisplayClassInfoFetchEntity(data: [], message: "")
    }

    static func getAppSearchItemEntityListWithCompleteData(count: Int = 20) -> [AppDisplayClassInfoFetchItemEntity] {
        return (0..<count).map { _ in getAppDisplayClassInfoFetchItemEntityWithCompleteData() }
    }

    static func getAppDisplayClassInfoFetchItemEntityWithCompleteData() -> AppDisplayClassInfoFetchItemEntity {
        return AppDisplayClassInfoFetchItemEntity.completedMock
    }
}
