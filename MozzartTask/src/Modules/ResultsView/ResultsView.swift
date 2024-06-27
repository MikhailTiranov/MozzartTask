//
//  ResultsView.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 27.6.24..
//

import SwiftUI

struct ResultsView: View {
  
  // MARK: - Public (Properties)
  @StateObject var viewModel: ResultsViewModel
  
  // MARK: - Ptivate (Properties)
  private let columns = Array(
    repeating: GridItem(.flexible(), spacing: 3.0),
    count: 7
  )
  
  // MARK: - View
  var body: some View {
    ZStack {
      if viewModel.isLoading {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle(tint: .blue))        
      }
      
      ScrollView {
        VStack {
          ForEach(viewModel.games, id: \.drawID) { game in
            VStack(alignment: .leading) {
              congigureTitle(for: game)
              configureStatus(for: game)
            }
            .frame(maxWidth: .infinity, minHeight: 60.0, alignment: .leading)
            .padding(.horizontal, 10.0)
            .background(configureCellColor(for: game.status))
            
            congigureNumbers(
              for: game
                .winningNumbers?
                .list ?? []
            )
          }
        }
        .background(Color.black)
        .frame(maxWidth: .infinity)
      }
    }
    .alert(
      viewModel.errorMessage,
      isPresented: $viewModel.isError
    ) {
      Button("OK") {
        viewModel.loadGames()
      }
    }
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button(action: viewModel.loadGames) {
          Image(systemName: "goforward")
        }
        .foregroundStyle(.white)
        .disabled(viewModel.games.isEmpty)
      }
    }
    .navigationTitle("Results")
    .toolbarColorScheme(.dark, for: .navigationBar)
    .toolbarBackground(.visible, for: .navigationBar)
    .padding(.horizontal, 10.0)
    .background(Color.black)
  }
  
  // MARK: - Private (Interface)
  private func congigureTitle(for game: Game) -> Text {
    Text("Time: \(game.drawTime.formatted(date: .abbreviated, time: .shortened)) | ") +
    Text("ID: \(game.drawID.description)")
  }
  
  private func configureStatus(for game: Game) -> Text {
    switch game.status {
    case .active, .future:
      Text("Is waiting for results...")
    case .results:
      Text("Matches: \(viewModel.receiveMatchesForGame(game))/15")
    }
  }
  
  private func configureCellColor(for status: Status) -> Color {
    switch status {
    case .active, .future: .yellow
    case .results: .green
    }
  }
  
  private func congigureNumbers(
    for numbers: [Int]
  ) -> some View {
    LazyVGrid(columns: columns, spacing: 3.0) {
      ForEach(numbers, id: \.self.description) { item in
        makeCell(with: item)
      }
    }
  }
  
  private func configureColor(for value: Int) -> Color {
    let colors: [Color] = [
      .yellow,
      .orange,
      .red,
      .pink,
      .purple,
      .cyan,
      .green,
      .blue,
      .mint,
      .indigo
    ]
    
    return colors[(value - 1)/8]
  }
  
  private func makeCell(with value: Int) -> some View {
    Text("\(value)")
      .frame(
        maxWidth: .infinity,
        maxHeight: .infinity
      )
      .aspectRatio(1.0, contentMode: .fill)
      .background(
        RoundedRectangle(cornerRadius: 25.0)
          .fill(Color.black)
          .stroke(
            configureColor(for: value),
            lineWidth: 2.0
          )
      )
      .foregroundStyle(.white.opacity(0.8))
  }
}

#Preview {
  ResultsView(
    viewModel: ResultsViewModel(
      gameService: GameNetworkService()
    )
  )
}
