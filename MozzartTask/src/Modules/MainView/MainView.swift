//
//  MainView.swift
//  MozzartTask
//
//  Created by Mihail Tiranov on 24.6.24.
//

import SwiftUI

struct MainView: View {
  
  // MARK: - Public (Properties)
  @ObservedObject var viewModel: MainViewModel
  
  // MARK: - View
  var body: some View {
    NavigationView {
      VStack(spacing: .zero) {
        HStack {
          NavigationLink(
            destination:
              ResultsView(
                viewModel: ResultsViewModel(
                  gameService: viewModel.gameService
                )
              )
              .toolbarRole(.editor)
          ) {
            Text("Results")
              .foregroundStyle(Color.primary)
          }
          Spacer()
          
          Text("🇬🇷 Greek keno 20/80")
            .font(.title2)
          
          Spacer()
          
          NavigationLink(
            destination:
              WebPage()
              .toolbarRole(.editor)
          ) {
            Text("Bets")
              .foregroundStyle(Color.primary)
          }
        }

        HStack {
          Text("Time")
            .font(.headline)
            .frame(width: 100.0, height: 50.0, alignment: .leading)
            
          Spacer()
          Text("Bet remaining time")
            .font(.headline)
            .frame(width: 200.0, height: 50.0, alignment: .trailing)
        }
        .padding(.horizontal, 20.0)
        .background(
          Capsule()
            .fill(Color.cellBackground)
        )
        .padding(.vertical, 10.0)
        
        ScrollView(showsIndicators: false) {
          VStack(spacing: 2.0) {
            ForEach(viewModel.games, id: \.drawID) { game in
              NavigationLink(
                destination:
                  GameView(
                    viewModel: GameViewModel(
                      game: game,
                      gameService: viewModel.gameService
                    )
                  )
                  .toolbarRole(.editor)
              ) {
                HStack {
                  let time = (
                    game.drawTime - viewModel.current
                  ).timeIntervalSince1970
                  
                  Text(
                    game.drawTime,
                    format: .dateTime.hour().minute()
                  )
                  .font(.subheadline)
                  
                  Spacer()
                  
                  Text(time <= .zero ? "00:00" : time.positionalTime)
                    .font(.subheadline)
                    .foregroundStyle(time < 60.0 ? Color.warningColor : Color.primaryText)
                }
                .frame(height: 40.0)
              }
              
              Divider()
                .background(Color.primary)
            }
          }
          .padding(.horizontal, 20.0)
        }
        
        Spacer()
      }
      .padding([.horizontal, .top])
      .foregroundStyle(Color.primaryText)
      .background(Color.vagueBackground)
      .ignoresSafeArea(edges: .bottom)
      .alert(
        viewModel.errorMessage,
        isPresented: $viewModel.isError
      ) {
        Button("OK") { viewModel.loadGames() }
      }
    }
  }
}

#Preview {
  MainView(
    viewModel: MainViewModel(
      gameService: GameNetworkService()
    )
  )
}
