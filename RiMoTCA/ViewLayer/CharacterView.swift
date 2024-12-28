//
//  ContentView.swift
//  RiMoTCA
//
//  Created by Javier Calatrava on 27/12/24.
//

import SwiftUI
import ComposableArchitecture

struct CharacterView: View {
    let store: StoreOf<CharatersFeature>
    
    var body: some View {
        NavigationView {
            ZStack {
                if store.isLoading {
                    ProgressView()
                }
            ScrollView {
                    ForEach(store.characters) { character in
                        NavigationLink {
                            DetailView(character: character)
                        } label: {
                            HStack {
                                characterImageView(character.imageUrl)
                                Text("\(character.name)")
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .onAppear {
            store.send(.fetchCharacters)
        }
    }
    
    fileprivate func characterImageView(_ string: String) -> AsyncImage<_ConditionalContent<some View, some View>> {
        return AsyncImage(url: URL(string: string),
                          transaction:  .init(animation: .easeIn(duration: 0.2))) { phase in
            switch phase {
            case .success(let image):
                image .resizable() // Make the image resizable
                    .aspectRatio(contentMode: .fit) // Set the aspect ratio to fill
                    .frame(width: 100, height: 100) // Set the frame size
                    .clipped()
                
            default:
                Image(systemName: "checkmark.rectangle")
                    .clipped()
                    .foregroundColor(.white)
            }
        }
    }
}


#Preview {
    CharacterView(
    store: Store(initialState: CharatersFeature.State()) {
        CharatersFeature()
    }
  )
}
