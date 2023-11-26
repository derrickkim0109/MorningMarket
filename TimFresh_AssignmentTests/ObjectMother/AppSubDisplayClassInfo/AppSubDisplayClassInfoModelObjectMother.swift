//
//  AppSubDisplayClassInfoModelObjectMother.swift
//  TimFresh_AssignmentTests
//
//  Created by Derrick kim on 11/26/23.
//

@testable import TimFresh_Assignment

struct AppSubDisplayClassInfoModelObjectMother {
    static func getAppSubDisplayClassInfoFetchModelWithCompleteData() -> AppSubDisplayClassInfoFetchModel {
        return AppSubDisplayClassInfoFetchModel(
            displayClassName: "농축수산물",
            appSubDisplayClassInfoList: getAppSubDisplayClassInfoFetchItemModelListWithCompleteData()
        )
    }

    static func getAppSubDisplayClassInfoFetchModelWithEmptyData() -> AppSubDisplayClassInfoFetchModel {
        return AppSubDisplayClassInfoFetchModel(
            displayClassName: "농축수산물",
            appSubDisplayClassInfoList: []
        )
    }

    static func getAppSubDisplayClassInfoFetchItemModelListWithCompleteData(count: Int = 20) -> [AppSubDisplayClassInfoFetchItemModel] {
        return (0..<count).map { _ in getAppSubDisplayClassInfoFetchItemModelWithCompleteData() }
    }

    static func getAppSubDisplayClassInfoFetchItemModelWithCompleteData() -> AppSubDisplayClassInfoFetchItemModel {
        return AppSubDisplayClassInfoFetchItemModel.completedMock
    }
}
