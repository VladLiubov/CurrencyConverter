//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import Combine
import SwiftUI

class RootViewController: SwiftUIViewController, UIGestureRecognizerDelegate {
  typealias ViewModel = RootViewModel
  
  private let viewModel: ViewModel
  private var cancellables = Set<AnyCancellable>()
  
  init(_ viewModel: ViewModel) {
    self.viewModel = viewModel
    
    super.init(nibName: nil, bundle: nil)
    
    subscribe()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  required public init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func loadView() {
    super.loadView()
    
    setupNavBar()
      
    add(view: {
      ContainerView(viewModel)
    }, holderView: self.view) { holderView, contentView in
      holderView.addSubviewFillingToEdges(contentView)
    }
  }
}

// - Subscribe
private extension RootViewController {
  
  func subscribe() {
    viewModel.$state.sink { [weak self] state in
      self?.update(with: state)
    }.store(in: &cancellables)
  }
    
  func update(with state: ViewModel.State) {
     updateShowedScreen(state.showedScreen)
  }
    func setupNavBar() {
      navigationItem.title = "Currency Converter"
      
      let appearance = UINavigationBarAppearance()
      appearance.backgroundColor = UIColor.systemBlue
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
      
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.compactAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
  
  func updateShowedScreen(_ screen: ViewModel.State.Screen?) {
    guard viewModel.state.showedScreen != screen else { return }
    
    switch screen {
    default:
    break
    }
  }
}

