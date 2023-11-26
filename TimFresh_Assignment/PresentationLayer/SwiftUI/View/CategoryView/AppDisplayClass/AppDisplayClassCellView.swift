//
//  AppDisplayClassCellView.swift
//  TimFresh_Assignment
//
//  Created by Derrick kim on 11/20/23.
//

import SwiftUI
import Kingfisher

struct AppDisplayClassCellView: View {
    @EnvironmentObject var viewModel: CategoryViewModel

    let item : AppDisplayClassInfoFetchItemModel

    var body: some View {
        NavigationLink {
            viewModel.nextScreen(item: item)
        } label: {
            appDisplayClassCellInfoView()
        }
    }

    private func appDisplayClassCellInfoView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            appDisplayClassImageView()

            Spacer()

            Text(item.displayClassName)
                .font(.pretendard( size: 12, type: .medium))
                .foregroundStyle(Color.gray900)

            Spacer()
        }
    }

    private func appDisplayClassImageView() -> some View {
        KFImage(item.makeImageURL())
            .placeholder {
                ProgressView()
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .resizable()
            .frame(width: 72, height: 70)
    }
}
