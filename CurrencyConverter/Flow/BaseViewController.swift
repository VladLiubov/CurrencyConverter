//
//  BaseViewController.swift
//  Posthumously
//
//  Created by Kostiantyn Nikitchenko on 25.04.2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
  public enum ForwardIntent {
    case present
    case presentWithNavigation
    case push
    case root
    case rootWithNavigation
  }

  public enum BackwardIntent {
    case dismiss
    case pop
  }
}

extension BaseViewController {

  func add(viewController: UIViewController) {
    addChild(viewController)
    viewController.didMove(toParent: self)
  }

  func remove(viewController: UIViewController) {
    viewController.willMove(toParent: nil)
    viewController.view.removeFromSuperview()
    viewController.removeFromParent()
  }

}

extension BaseViewController {

  func show(_ controller: UIViewController, intent: ForwardIntent, animated: Bool = true, completion: @escaping () -> () = {}) {
    switch intent {
    case .present:
      assert(presentedViewController == nil, "Can't present on presentedViewController")

      present(controller, animated: animated, completion: completion)
    case .presentWithNavigation:
      assert(presentedViewController == nil, "Can't present on presentedViewController")

      let navigationController = UINavigationController(rootViewController: controller)

      present(navigationController, animated: animated, completion: completion)
    case .push:
      assert(navigationController != nil, "Only can push in navigation controller")

      DispatchQueue.main.async {
        self.navigationController?.pushViewController(controller, animated: animated)
      }
    case .root:
      DispatchQueue.main.async {
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
      }
    case .rootWithNavigation:
      assert(presentedViewController == nil, "Can't present on presentedViewController")
      
      DispatchQueue.main.async {
        let navigationController = UINavigationController(rootViewController: controller)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
      }
    }
  }

  func hide(intent: BackwardIntent, animated: Bool = true, completion: @escaping () -> () = {}) {
    switch intent {
    case .dismiss:
      dismiss(animated: animated, completion: completion)
    case .pop:
      assert(navigationController != nil, "Only can pop in navigation controller")

      navigationController?.popViewController(animated: animated)
    }
  }
}
