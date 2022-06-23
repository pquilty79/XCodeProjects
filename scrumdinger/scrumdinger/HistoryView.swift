//
//  HistoryView.swift
//  scrumdinger
//
//  Created by Patrick Quilty on 6/23/22.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                if let transcript = history.transcript {
                    Text("Transcript")
                        .font(.headline)
                        .padding(.top)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}
extension History {
    var attendeeString: String {
        ListFormatter.localizedString(byJoining: attendees.map { $0.name })
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var history: History {
        History(attendees: [DailyScrum.Attendee(name: "Maria"), DailyScrum.Attendee(name: "April")], lengthInMinutes: 5, transcript: "Hello, my name is Inigo Montoya, you killed my father, prepare to die")
    }
    static var previews: some View {
        HistoryView(history: history)
    }
}
