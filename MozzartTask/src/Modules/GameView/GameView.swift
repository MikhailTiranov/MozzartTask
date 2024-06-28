//
//  GameView.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 25.6.24.
//

import SwiftUI

struct GameView: View {
  
  // MARK: - Public (Properties)
  @StateObject var viewModel: GameViewModel
  @Environment(\.presentationMode) var presentationMode
  
  // MARK: - Private (Properties)
  private let data = Array(1...80)
  private let columns = Array(
    repeating: GridItem(.flexible(), spacing: 3.0),
    count: 8
  )
  
  private let odds: [Int: Double] = [
    1: 3.75,
    2: 14,
    3: 65,
    4: 275,
    5: 1350,
    6: 6500,
    7: 25000,
    8: 125000
  ]
  
  // MARK: - View
  var body: some View {
    VStack(alignment: .leading) {
      LazyVGrid(columns: columns, spacing: 3.0) {
        ForEach(data, id: \.self.description) { item in
          makeCell(with: item)
        }
      }
      .padding(.horizontal, 2.0)
      .padding(.top, 10.0)
      
      Spacer()
      
      VStack {
        HStack {
          Text("Odds")
            .font(.title)
            .padding(.horizontal)
            .background(
              UnevenRoundedRectangle(
                cornerRadii: .init(
                  bottomLeading: 30.0,
                  bottomTrailing: 30.0
                )
              )
              .fill(Color.secondaryBackground)
            )
            .foregroundStyle(Color.darkText)
            .padding(.leading, 30.0)
          
          Spacer()

          Text("Chosen Numbers: \(viewModel.chosenNumbersCount)/15")
            .font(.caption)
            .padding(.horizontal)
            .foregroundStyle(Color.darkText)
        }

        ScrollView(.horizontal, showsIndicators: false) {
          HStack(spacing: 6.0) {
            ForEach(odds.sorted(by: <), id: \.key) { value in
              makeOddCell(with: value.0, value: value.1)
            }
          }
          .padding([.horizontal, .bottom], 20.0)
        }
      }
      .background(
        UnevenRoundedRectangle(
          cornerRadii: .init(
            topLeading: 30.0,
            topTrailing: 30.0
          )
        )
        .fill(Color.secondaryBackground)
        .ignoresSafeArea(edges: .bottom)
      )
      .foregroundStyle(Color.primaryText)
    }
    .disabled(viewModel.isBetMade)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button("Bet") { viewModel.makeBet() }
        .foregroundStyle(
          viewModel.isBetMade
          ? Color.warningColor
          : viewModel.isBetButtonDisabled ? .darkText : .primaryText
        )
        .disabled(viewModel.isBetButtonDisabled)
      }
    }
    .alert(
      "You made the Bet!",
      isPresented: $viewModel.messageIsPresented
    ) {
      Button("OK") { presentationMode.wrappedValue.dismiss() }
    }
    .toolbarColorScheme(.dark, for: .navigationBar)
    .toolbarBackground(.visible, for: .navigationBar)
    .navigationTitle(congigureTitle(for: viewModel.game))
    .navigationBarTitleDisplayMode(.inline)
    .background(Color.vagueBackground)
    .ignoresSafeArea(edges: .bottom)
  }
  
  // MARK: - Private (Interface)
  private func congigureTitle(for game: Game) -> Text {
    Text("Time: \(game.drawTime.formatted(date: .omitted, time: .shortened)) | ") +
    Text("ID: \(game.drawID.description)")
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
          .fill(Color.background)
          .stroke(
            viewModel.isNumberChosen(value)
            ? configureColor(for: value)
            : .borderColor,
            lineWidth: 2.0
          )
      )
      .foregroundStyle(Color.secondaryText)
      .onTapGesture { viewModel.handleTapOnNumber(value) }
  }
  
  private func configureColor(for value: Int) -> Color {
    Color.mixedColors[(value - 1)/8]
  }
  
  private func makeOddCell(with key: Int, value: Double) -> some View {
    VStack(spacing: 5.0) {
      Text(key, format: .number)
        .font(.headline)
      Divider()
        .background(Color.borderColor)
      Text(value, format: .number)
        .font(.headline)
    }
    .fontWeight(defineValueIsBold(key) ? .bold : .regular)
    .frame(width: 70)
  }
  
  private func defineValueIsBold(_ value: Int) -> Bool {
    switch viewModel.chosenNumbersCount {
    case let x where x < 8 && x > 0:
      value == x
    case let x where x >= 8:
      value == 8
    default:
      false
    }
  }
}

#Preview {
  NavigationView {
    GameView(
      viewModel: GameViewModel(
        game: .mock,
        gameService: GameNetworkService()
      )
    )
  }
}
