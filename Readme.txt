
Introduction:
------------
Thank you for the opportunity of doing this code challenge. I felt like I was Leonardo da Vinci drawing the Mona Lisa :], please kindly read below:-

Instructions:
------------
Version 15.3 (15E204a) Targeting iOS 16.2. I am about to purchase an expensive Apple machine.

1- Ensure you have SwiftLint Installed on your machine - use brew install swiftlint.
2- double click on Neds.xcworkspace
3- Simply Run the app.

You may review the .swiftlint.yml to check all enforced rules to force best practice.

Next to Go / Next Up Races iOS as in Neds
-----------------------------------------

This iOS app is designed to display 'Next to Go' races using the Entain API. It fulfills the requirements outlined in the technical task provided by Entain and includes additional features such as MVVM design pattern implementation, scalable layouts, testing, and accessibility support including documentation.

It all started with the endpoint :)

Features:-
----------

MVVM Design Pattern (with Repository and Service):
--------------------------------------------------
SwiftUI
MVVM with State-Driven UI.
Separates concerns into models, views, and view models for clean and maintainable code.
Models: Represents data structures.
Views: Displays UI elements.
View Models: Handles business logic and data processing.

Scalable Endpoint Pattern:
-------------------------
Utilizes scalable endpoint patterns for handling API requests and responses efficiently.

Generic API Implementation with Repository and Services:
-------------------------------------------------------

Implements generic API services and repositories for data fetching and management.

Navigation View with Gradient:
------------------------------
Includes navigation features with gradient effects similar to Neds for enhanced user experience.

Error Screen and Network Connectivity Check:
--------------------------------------------
Displays an error screen when there is no network connectivity.
Interpert Decodable Error Response from Server to human readable format.
Implements network connectivity checks to provide a seamless user experience.

Extra Features:-

INTL (International Races) Support:
-----------------------------------

Adds support for international races in addition to local races.

Subtitle Display for Countries:
--------------------------------
Displays subtitles with country information instead of state information as in Neds.

Countdown Timer with Color Changes:
-----------------------------------
Includes countdown timers to display time in minutes and seconds for each race.
Changes timer color to red when the race is about to start.

Other:-

Clean and Decoupled Code:
-------------------------
Ensures clean and decoupled code for views and methods for improved maintainability and readability.
Utilizes fully decodable objects for parsing the full JSON response from the API.

Implemented Required Business Rules

Added Unit Tests.

Implemented generic use of Font but didn't get to use it because of time constraints.

Easy to use Font implementation for the font Montserrat so you can do something like this:
    Text(text)
        .font(.montserrat.semibold(size: UI.FontSize.title))
        
If I had more time, I would have could have spent more time on Unit Tests but I had limited time due to another code challange and an interview. I would have also implemented skeleton for loading and the bottom tabbar. None the less I hope you find the solution provided to your satasifaction and forgive me if I missed something :]

Thank you again.

Wael
