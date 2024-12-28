//
//  DetailView.swift
//  RiMo
//
//  Created by Javier Calartrava on 9/6/24.
//

import SwiftUI

struct DetailView: View {
//    @StateObject var detailViewModel: DetailViewModel = DetailViewModel(character: .sample)
    let character: Character
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: character.imageUrl))
                .clipShape(Circle())
            Form {
                Section {
                    LabeledContent("form_name".localized, value: character.name)
                    LabeledContent("form_status".localized, value: character.status)
                    LabeledContent("form_species".localized, value: character.species)
                    
                } header: {
                    Text("section_character".localized)
                }
                Section {
                    LabeledContent("form_location".localized, value: character.location)
                    LabeledContent("form_type".localized, value: character.type)
                } header: {
                    Text("section_site".localized)
                }
                Section {
                    LabeledContent("form_numberOfEpisodes".localized, value: "\(character.numberOfEpisodes)")
                } header: {
                    Text("section_episodes".localized)
                }
            }.background(Color.green)
        }

    }
}

#Preview {
    DetailView(character: .sampleMorty)
}

