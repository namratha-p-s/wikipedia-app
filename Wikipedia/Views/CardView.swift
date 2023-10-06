//
//  CardView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 10/6/23.
//

import SwiftUI

struct CardView: View {
    @State var entry: SearchResult
    @ObservedObject var detailViewModel = DetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if detailViewModel.isLoaded {
                    HStack {
                        if detailViewModel.articleDescriptions?.thumbnail != nil {
                            AsyncImage(url: URL(string: detailViewModel.articleDescriptions!.thumbnail!.source)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 125)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .aspectRatio(contentMode: .fit)
                        } else {
                            Image(systemName: "photo")
                        }
                        Spacer()
                        
                        Text(detailViewModel.articleDescriptions!.title)
                            .font(.subheadline)
                            .padding(10)
                            .lineLimit(nil)
                    }
                }
                else {
                    ProgressView()
                }
            }
            .onAppear {
                detailViewModel.getWikiDetailsRequest(entry: entry)
            }
        }
    }
}

#Preview {
    CardView(
        entry: SearchResult(title: "Sample text"))
}
