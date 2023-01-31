//
//  ContentView.swift
//  Chuckapi
//
//  Created by Kostiantyn Kaniuka on 31.01.2023.
//

import SwiftUI


final class LocalModel: Identifiable {
    var id: String
    var netModel: Joke
    var buttonImage: String = "heart"
    var isFavourite: Bool = false
    
    init(id: String, netModel: Joke, isFavourite: Bool) {
        self.id = id
        self.netModel = netModel
        self.isFavourite = isFavourite
    }
    
    func changeIcon() {
        buttonImage = "heart.fill"
    }
    
}

struct ContentView: View {
    @State private var localjokes: [LocalModel] = []
    @State private var likedJokes: [LocalModel] = []
    @State private var jokes: [Joke] = []
    @State private var like: Bool = false
    var buttontext: String {
        if jokes.isEmpty { return "Fetch Jokes"} else {
            return "Ask more Jokes"}
    }
    
    var body: some View {
        VStack {
            if like == false {
                List {
                    if jokes.isEmpty {
                        Text("No Jokes Loaded Yet")
                    }
                    ForEach(localjokes) { localJoke in
                        VStack {
                            AsyncImage(url: URL(string : localJoke.netModel.icon_url))
                            Text(localJoke.netModel.value)
                                .fixedSize(horizontal: false, vertical: true)
                            Button {
                                localJoke.isFavourite = true
                                localJoke.changeIcon()
                                likedJokes.append(localJoke)
                                localjokes.append(localJoke)
                                localjokes.removeLast()
                            } label: {
                                Image(systemName: localJoke.buttonImage)
                            }
                        }
                    }
                }
            }
            else {
                List {
                    if jokes.isEmpty {
                        Text("No Jokes Loaded Yet")
                    }
                    ForEach(likedJokes) { likedlJoke in
                        VStack {
                            AsyncImage(url: URL(string : likedlJoke.netModel.icon_url))
                            Text(likedlJoke.netModel.value)
                                .fixedSize(horizontal: false, vertical: true)
                            Button {
                                likedlJoke.isFavourite = true
                                likedlJoke.changeIcon()
                                likedJokes.append(likedlJoke)
                                localjokes.append(likedlJoke)
                                localjokes.removeLast()
                            } label: {
                                Image(systemName: likedlJoke.buttonImage)
                            }
                        }
                    }
                }
                
            }
            HStack{
                Button(action: {
                    Task {
                        guard let joke = await apiService() else {
                            return
                        }
                        let uuid = UUID().uuidString
                        let a = LocalModel.init(id: uuid, netModel: joke, isFavourite: false)
                        jokes.append(joke)
                        localjokes.append(a)
                    }
                })
                {
                    Label(buttontext,systemImage: "rectangle.portrait.and.arrow.forward")
                }
                .labelStyle(.titleAndIcon)
                .buttonStyle(.bordered)
                Button {
                    like.toggle()
                } label: {
                    Text("Favorite")
                    Image(systemName: "heart.fill")
                }
                .labelStyle(.titleAndIcon)
                .buttonStyle(.bordered)
            }
        }
    }
}
