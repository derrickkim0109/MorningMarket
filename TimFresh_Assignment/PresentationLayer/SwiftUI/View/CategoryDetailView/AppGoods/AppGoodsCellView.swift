//
//  AppGoodsCellView.swift
//  TimFresh_Assignment
//
//  Created by Derrick kim on 11/21/23.
//

import SwiftUI
import Kingfisher

struct AppGoodsCellView: View {
    @EnvironmentObject var viewModel: CategoryDetailViewModel
    let item: AppGoodsInfoFetchItemModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AppGoodsImageView()

            AppGoodsInfoView()
                .frame(width: 156)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 26)
    }

    private func AppGoodsImageView() -> some View {
        KFImage(item.makeImageURL())
            .placeholder {
                ProgressView()
            }
            .retry(maxCount: 3, interval: .seconds(5))
            .resizable()
            .frame(width: 156, height: 156)
            .overlay(alignment: .bottomTrailing) {
                IconCartButton()
                    .offset(x: -10, y: -10)
            }
    }

    private func IconCartButton() -> some View {
        Button {

        } label: {
            Image.iconCartFillImage
                .colorMultiply(Color.blue900)
                .frame(width: 16, height: 16)
                .background(
                    Circle()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.white)
                )
        }
        .frame(width: 32, height: 32)
    }

    private func AppGoodsInfoView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(item.getGoodsName())")
                    .font(.pretendard(size: 15, type: .regular))
                    .foregroundStyle(Color.black700)

                Spacer()
            }

            if item.isDiscounted() {
                OriginalPriceView()
            }

            SalePriceView()

            AppGoodsOptionView()
        }
        .frame(maxWidth: .infinity)
    }

    private func OriginalPriceView() -> some View {
        HStack(spacing: 0) {
            Text("\(item.salePrice)")
                .font(.pretendard(size: 13, type: .medium))
                .foregroundStyle(Color.gray500)
                .overlay(alignment: .center) {
                    Divider()
                        .frame(maxWidth: .infinity)
                        .frame(height: 1)
                        .background(.gray)
                }

            Text("원")
                .font(.pretendard(size: 13, type: .regular))
        }
    }

    private func SalePriceView() -> some View {
        HStack(spacing: 2) {
            if item.isDiscounted() {
                Text("\(item.getDiscountRatio())%")
                    .font(.pretendard(size: 16, type: .bold))
                    .foregroundStyle(Color.red900)
            }

            Text("\(item.discountPrice)원")
                .font(.pretendard(size: 16, type: .regular))
                .foregroundStyle(Color.black900)

            Spacer()
        }
    }

    private func AppGoodsOptionView() -> some View {
        HStack(spacing: 8) {
            Text("옵션")
                .font(.pretendard(size: 12, type: .medium))
                .foregroundStyle(Color.gray700)
                .background(
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundStyle(Color.gray300)
                        .frame(width: 29, height: 20)
                )

            Text("\(item.getGoodsOptionName())")
                .font(.pretendard(size: 12, type: .medium))
                .foregroundStyle(Color.black700)
        }
    }
}