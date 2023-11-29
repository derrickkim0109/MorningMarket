//
//  PaginationModel.swift
//  TimFresh_Assignment
//
//  Created by Derrick kim on 11/19/23.
//

struct PaginationModel {
    let currentPage: Int32
    let elementSizeOfPage: Int32
    let totalElements: Int64
    let totalPage: Int32

    func hasNext(items: Int) -> Bool {
        return totalPage > currentPage
        && totalPage > 2
        && (items != totalElements) == false
    }
}

extension PaginationModel {
#if DEBUG
    static let completedMock = PaginationModel(
        currentPage: 0,
        elementSizeOfPage: 10,
        totalElements: 47,
        totalPage: 5
    )

    static let insufficientMock = PaginationModel(
        currentPage: 0,
        elementSizeOfPage: 0,
        totalElements: 0,
        totalPage: 0
    )
#endif
}
