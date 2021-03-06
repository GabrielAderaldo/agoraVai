// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

// swiftlint:disable sorted_imports
import Foundation
import UIKit

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Storyboard Scenes

// swiftlint:disable explicit_type_interface identifier_name line_length type_body_length type_name
internal enum StoryboardScene {
  internal enum Contato: StoryboardType {
    internal static let storyboardName = "Contato"

    internal static let atualizarViewController = SceneType<AgendaDeContatos.AtualizarViewController>(storyboard: Contato.self, identifier: "AtualizarViewController")

    internal static let cadastroContatoViewController = SceneType<AgendaDeContatos.CadastroContatoViewController>(storyboard: Contato.self, identifier: "CadastroContatoViewController")

    internal static let contatoViewController = SceneType<AgendaDeContatos.ContatoViewController>(storyboard: Contato.self, identifier: "ContatoViewController")

    internal static let detalhesViewController = SceneType<AgendaDeContatos.DetalhesViewController>(storyboard: Contato.self, identifier: "DetalhesViewController")
  }
  internal enum LaunchScreen: StoryboardType {
    internal static let storyboardName = "LaunchScreen"

    internal static let initialScene = InitialSceneType<UIKit.UIViewController>(storyboard: LaunchScreen.self)
  }
  internal enum Login: StoryboardType {
    internal static let storyboardName = "Login"

    internal static let splashViewController = SceneType<AgendaDeContatos.SplashViewController>(storyboard: Login.self, identifier: "SplashViewController")

    internal static let viewControllerCadastro = SceneType<AgendaDeContatos.CadastroViewController>(storyboard: Login.self, identifier: "ViewControllerCadastro")

    internal static let viewControllerLogin = SceneType<AgendaDeContatos.LoginViewController>(storyboard: Login.self, identifier: "ViewControllerLogin")
  }
  internal enum Main: StoryboardType {
    internal static let storyboardName = "Main"

    internal static let initialScene = InitialSceneType<AgendaDeContatos.ViewController>(storyboard: Main.self)
  }
}
// swiftlint:enable explicit_type_interface identifier_name line_length type_body_length type_name

// MARK: - Implementation Details

internal protocol StoryboardType {
  static var storyboardName: String { get }
}

internal extension StoryboardType {
  static var storyboard: UIStoryboard {
    let name = self.storyboardName
    return UIStoryboard(name: name, bundle: BundleToken.bundle)
  }
}

internal struct SceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type
  internal let identifier: String

  internal func instantiate() -> T {
    let identifier = self.identifier
    guard let controller = storyboard.storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
      fatalError("ViewController '\(identifier)' is not of the expected class \(T.self).")
    }
    return controller
  }
}

internal struct InitialSceneType<T: UIViewController> {
  internal let storyboard: StoryboardType.Type

  internal func instantiate() -> T {
    guard let controller = storyboard.storyboard.instantiateInitialViewController() as? T else {
      fatalError("ViewController is not of the expected class \(T.self).")
    }
    return controller
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
