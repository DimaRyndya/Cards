//
//  CardsView.swift
//  Cards
//
//  Created by Dmitriy Ryndya on 05.09.2022.
//

import SwiftUI

struct CardsView: View {
    @EnvironmentObject var viewState: ViewState

    var body: some View {
        ZStack {
            CardsListView()
            if !viewState.showAllCards {
                SingleCardView()
            }
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
            .environmentObject(ViewState())
    }
}
