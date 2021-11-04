//
//  Tab.swift
//  OnboardingUIInversion
//
//  Created by King Copones on 11/4/21.
//


import SwiftUI

struct Tab: Identifiable {
    var id = UUID().uuidString
    var title: String
    var subTitle: String
    var description: String
    var image: String
    var color: Color
}

var tabs: [Tab] = [
Tab(title: "Build", subTitle: "your resume", description: "Your profile is your resume. Setup your profile to attract more recruiters.", image: "resume", color: Color("peach")),
Tab(title: "Search", subTitle: "different jobs", description: "Find jobs that fits your skillsets. You may send your resume afterwards.", image: "search", color: Color("lime")),
Tab(title: "Filter", subTitle: "job vacancies", description: "For faster job browsing, you can filter jobs via skills, salary, location, and benefits.", image: "personalize", color: Color("lilac"))
    
]
