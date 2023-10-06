//
//  CardView.swift
//  Wikipedia
//
//  Created by Namratha P Somachudan on 10/6/23.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    @State var entry: SearchResult
    @ObservedObject var detailViewModel = DetailViewModel()
    let height: CGFloat
    
    var body: some View {
        VStack {
            if detailViewModel.isLoaded {
                HStack {
                    if detailViewModel.articleDescriptions?.thumbnail != nil {
                        KFImage(URL(string: detailViewModel.articleDescriptions!.thumbnail!.source))
                            .placeholder {                                Image(systemName: "arrow.2.circlepath.circle")
                                    .font(.largeTitle)
                                    .opacity(0.3)
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: height, height: height)
                    } else {
                        Image("default")
                            .resizable()
                            .scaledToFit()
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

#Preview {
    CardView(
        entry: SearchResult(title: "Sample text"), height: 10)
}
