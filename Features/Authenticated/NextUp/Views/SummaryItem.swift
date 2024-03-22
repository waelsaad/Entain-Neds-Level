//
//  SummaryItem.swift
//  Neds
//
//  Created by Wael Saad on 17/3/2024.
//  Copyright © 2024 NetTrinity. All rights reserved.
//

import SwiftUI

struct SummaryItem: View {
    
    let raceSummary: RaceSummary
    
    // MARK: - Body
    
    /// The body of the SummaryRow view, containing the main view components.
    
    var body: some View {
        VStack(spacing: UI.Space.small) {
            mainView
        }
        .background(.white)
        .frame(maxWidth: .infinity)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(accessibilityLabel)
        .padding(.vertical, UI.Padding.raceRow.vertical)
    }
    
    // MARK: - Private Views
    
    /// The main view structure of the summary row, including content, timeline, and disclosure indicator.
    
    private var mainView: some View {
        HStack {
            contentView
            Spacer()
            timelineView
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
            DisclosureIndicator()
        }
        .padding(.horizontal)
        .contentShape(Rectangle())
        .frame(alignment: .center)
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel)
    }
    
    /// The view containing the label information (image and text).
    
    private var contentView: some View {
        HStack(spacing: UI.Space.xxxSmall) {
            imageView
                .accessibilityHidden(true)
            labelsView
        }
    }

    /// The view structure for labels such as title and country.
    
    private var labelsView: some View {
        VStack(alignment: .leading, spacing: UI.Space.xxxSmall) {
            titleView
                .accessibility(label: Text("\(raceSummary.label) \(raceSummary.venueCountry.rawValue)"))
            countryView
        }
    }

    /// The view displaying the image associated with the race.
    
    private var imageView: some View {
        Image(raceSummary.category.imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(size: UI.IconSize.listItemIcon)
            .accessibility(hidden: true)
    }

    /// Determines the appropriate text color based on the race's start status.
    
    var textColor: Color {
        if raceSummary.isLessThanFiveMinutesAway {
            return .red
        } else if raceSummary.isStarted {
            return .Palette.primary
        } else {
            return .black
        }
    }

    /// The view displaying the text information about the race.
    
    private var titleView: some View {
        Text(raceSummary.label)
            .foregroundColor(Color(.darkGray))
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: true, vertical: false)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibility(label: Text("Race: \(raceSummary.label)"))
    }

    /// The view displaying the text information about the race.
    
    private var countryView: some View {
        Text(raceSummary.venueCountry.rawValue)
            .font(.system(size: 14))
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: true, vertical: false)
            .frame(maxWidth: .infinity, alignment: .leading)
            .accessibility(label: Text("Country: \(raceSummary.venueCountry.rawValue)"))
    }
    
    /// The view displaying the timeline information.
    
    var timelineView: some View {
        TimelineView(.periodic(from: Date(), by: UI.TimeLineShedule.nextRaces)) { _ in
            Text(raceSummary.advertisedStart.date.formattedString)
                .monospacedDigit()
                .foregroundStyle(textColor)
        }
        .accessibility(label: Text("Start Time: \(raceSummary.advertisedStart.date.formattedString)"))
    }

    /// The accessibility label for the SummaryItem.
    
    private var accessibilityLabel: Text {
        let statusText: String
        if raceSummary.isLessThanFiveMinutesAway {
            statusText = "Starting soon"
        } else if raceSummary.isStarted {
            statusText = "Started"
        } else {
            statusText = "Not started"
        }
        
        return Text("\(raceSummary.label) in \(raceSummary.venueCountry.rawValue), \(statusText)")
    }
    
}

// MARK: - Preview

struct SummaryRow_Previews: PreviewProvider {
    
    static var previews: some View {
        let sampleRaceSummary = RaceSummary(
            raceID: "0e585683-ec46-4caa-b45c-0682a5f4bba9",
            raceName: "Tasbreeders Night 5Th April Plate (C1)",
            raceNumber: 1,
            meetingID: "ee3656cc-8c7e-4e01-a4eb-8344de47eddb",
            meetingName: "Launceston",
            category: .greyhound,
            advertisedStart: AdvertisedStart(seconds: Date().timeIntervalSince1970),
            venueID: "377c03a4-6154-4b32-b8f0-ecfc8a6869ef",
            venueName: "Launceston",
            venueState: "TAS",
            venueCountry: .aus
        )
        return SummaryItem(raceSummary: sampleRaceSummary)
            .previewLayout(.fixed(width: 320, height: 100))
    }
    
}
