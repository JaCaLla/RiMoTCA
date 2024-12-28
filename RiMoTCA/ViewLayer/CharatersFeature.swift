//
//  CharatersFeature.swift
//  RiMoTCA
//
//  Created by Javier Calatrava on 27/12/24.
//

import ComposableArchitecture

@Reducer
struct CharatersFeature {
    @ObservableState
    struct State: Equatable {
        var characters: [Character] = []
        var isLoading: Bool = false
    }

    enum Action {
        case fetchCharacters
        case fetchCharactersSuccess([Character])
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .fetchCharacters:
                state.isLoading = true
                state.characters = []
                return .run { send in
                    let result = await currentApp.dataManager.fetchCharacters(CharacterService())
                    switch result {
                    case .success(let characters):
                        //state.characters = characters
                        await send(.fetchCharactersSuccess(characters))
                    case .failure(let error):
                        print(error)
                    }
                }
            case .fetchCharactersSuccess(let characters):
                state.isLoading = false
                state.characters = characters
                return .none
            }
        }
    }
}
