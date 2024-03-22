//
//  NextUpScene.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

// MARK: - NextUpScene

/// This view displays a list of upcoming races along with category filters and an international (INTL) checkbox.

struct NextUpScene: View {
    
    @State private var isRefreshing = false
    
    @StateObject var viewModel: NextUpViewModel
    
    /// The main view that dynamically displays loading, error, or success views based on the state of the view model.
    
    var body: some View {
        switch viewModel.state {
        case .loading:
            loadingView
        case .failure(let error):
            errorView(error: error)
        case .success(let summaries):
            successView(summaries: summaries)
        }
    }
    
    /// Generates the success view with the provided race summaries.
    
    func successView(summaries: [RaceSummary]) -> some View {
        contentView(summaries: summaries)
            .padding(.top)
            .refreshable {
                isRefreshing = true
                viewModel.fetchNextRaces(count: NextUpViewModel.kRaceSummariesFetchedTotal)
                isRefreshing = false
            }
            .navigationBarItems(
                leading: LeadingNavigationItemsView(),
                trailing: TrailingNavigationItemsView(
                    notificationsCount: viewModel.notificationsCount
                )
            )
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Next Up Scene")
    }
    
    // MARK: - Main View
    
    /// The main view containing the scroll view with toggle view and list content.
    
    private func contentView(summaries: [RaceSummary]) -> some View {
        ScrollView {
            toggleView
            if summaries.isEmpty {
                noItemsView
            } else {
                listContent(summaries: summaries)
            }
        }
        .background(Color.Palette.background)
    }
    
    // MARK: - List Content
    
    /// The content of the list based on the view model state.
    
    @ViewBuilder
    private func listContent(summaries: [RaceSummary]) -> some View {
        LazyVStack(spacing: 1) {
            ForEach(summaries, content: SummaryItem.init)
                .background(.white)
        }
    }
    
    // MARK: - Toggle View
    
    /// The toggle view containing category checkboxes and the INTL checkbox.
    
    private var toggleView: some View {
        HStack(spacing: UI.Space.xxSmall) {
            ForEach(RaceCategory.allCases, id: \.self) { category in
                Checkbox(
                    isChecked: viewModel.selectedCategories.contains(category),
                    category: category
                ) {
                    viewModel.toggleCategorySelection(category)
                }
            }
            Spacer()
            INTLCheckboxView
        }
        .padding(.top)
        .padding([.vertical, .horizontal])
    }
    
    // MARK: - INTL Checkbox View
    
    /// The INTL checkbox view for toggling international races display.
    
    private var INTLCheckboxView: some View {
        Checkbox(
            isChecked: viewModel.isINTL,
            labelText: GlobalContent.intl
        ) {
            viewModel.toggleINTLSelection()
        }
        .accessibilityLabel("International Races Checkbox")
    }
    
    // MARK: - Loading View
    
    /// The view to display when in the loading state.
    
    @ViewBuilder
    var loadingView: some View {
        ZStack {
            UI.orangeGradient.edgesIgnoringSafeArea(.all)
            VStack(spacing: UI.Space.xSmall) {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(UI.Dimensions.LoadingView.scaleEffect)
                Text(GlobalContent.loading)
                    .font(.headline)
                    .fontWeight(.bold)
                    .accessibilityLabel(GlobalContent.loading)
            }
            .foregroundColor(.white)
        }
    }
    
    // MARK: - No Items View
    
    /// The view to display when there are no items to show based on selected filters.
    
    private var noItemsView: some View {
        VStack(alignment: .center) {
            Spacer()
            Text(Content.noRacesFound)
                .font(.headline)
                .foregroundColor(.gray)
            Spacer()
        }
        .align(.centerY)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    /// Generates the error view with the given error message.
    
    @ViewBuilder
    private func errorView(error: AppError) -> some View {
        ErrorView(error: error, retryAction: viewModel.retryAction)
    }
    
}

// MARK: - Preview

struct NextUpScene_Previews: PreviewProvider {
    
    static var previews: some View {
        NextUpScene(viewModel: .init())
    }
    
}
