//
//  SearchHistoryListView.swift
//  XCNews
//
//  Created by henry on 2023/2/22.
//

import SwiftUI

struct SearchHistoryListView: View {
    @ObservedObject var searchVM:ArticlesSearchViewModel
    let onSubmit:(String)->()

    var body: some View {
        List{
            HStack{
                Text("Recently Searched")
                Spacer()
                Button("clear"){
                    searchVM.removeAllHistory()
                }
                .foregroundColor(.accentColor)
            }
            .listRowSeparator(.hidden)
            
            ForEach(searchVM.history, id: \.self){ history in
                Button(history){
                    onSubmit(history)
                }
                .swipeActions {
                    Button(role: .destructive, action: {
                        searchVM.removeAllHistory()
                    }, label: {
                      Label("Delete", image: "trash")
                    })
                }
            }
        }.listStyle(.plain)
    }
}

struct SearchHistoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchHistoryListView(searchVM: ArticlesSearchViewModel.shared) { _ in   
        }
    }
}
