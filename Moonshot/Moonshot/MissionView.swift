//
//  MissionView.swift
//  Moonshot
//
//  Created by Patrick Quilty on 6/30/22.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let crew: [CrewMember]
    let mission: Mission
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 6)
                        .padding(.top)
                    Text("Launched: \(mission.formattedLaunchDate)") .foregroundColor(.white)
                        .font(.headline)
                    VStack(alignment: .leading) {
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(crew, id: \.role) { crewMember in
                                    NavigationLink {
                                        AstronautView(astronaut: crewMember.astronaut)          } label: {
                                        HStack {
                                            Image(crewMember.astronaut.id)
                                                .resizable()
                                                .frame(width: 104, height: 72)
                                                .clipShape(Circle())
                                                .overlay(Circle()
                                                .strokeBorder(.white, lineWidth: 1))
                                            VStack(alignment: .leading) {
                                                Text(crewMember.astronaut.name)
                                                    .foregroundColor(.white)
                                                    .font(.headline)
                                                Text(crewMember.role)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(.horizontal)
                                    }
                                }
                            }
                        }
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.lightBackground)
                            .padding(.vertical)
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
