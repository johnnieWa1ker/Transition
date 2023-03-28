# 🚂 Transition

`Transition` for Swift is a sufficient and super convenient solution for managing navigation within your application. You don't need to "wrap" controllers, or use "base" classes or coordinators, and etc.

Using the library comes down to creating the `Router` and `Route` classes and calling the desired method from your `UIViewController`. You don't even have to expand the controller itself with new protocols.


Here's how it works:

<p float="left">
    <img src="https://user-images.githubusercontent.com/34270490/228203142-1627bd63-eeda-4e5d-81d3-069f7921dca0.gif"  width="30%">
    <img src="https://user-images.githubusercontent.com/34270490/228204869-a6df4160-2440-4aca-9b88-86c2394a3026.gif"  width="30%">
    <img src="https://user-images.githubusercontent.com/34270490/228216974-8ae322a6-9447-45a3-b65b-da827886e753.gif"  width="30%">
</p>

## 🌱 Getting started
```swift

// 1️⃣ For UIViewController you create a router that will
// call the screen with the correct way to open
class HomeRouter: Router<HomeViewController> {}

// 2️⃣ Router should be in your UIViewController and be
// initialized at the time of the call
class HomeViewController: UIViewController {
    var router: ProfileRouter
    
    init(router: ProfileRouter) {
        self.router = router
    }
}


// 3️⃣ At the same time, each module must have its own route,
// which will describe the methods in which the new screen will be initialized
protocol ProfileRoute {
    func presentProfile()
    func pushProfile()
}

extension ProfileRoute where Self: RouterProtocol {
    // This is how the function to show the Profile in the modal window would look like
    func presentProfile() {
        // Use one of the preset opening schemes or implement your own.
        let transition = ModalTransition()
        
        // Transition needs to be passed to the router, which is stored in your controller
        // It is convenient to do this in a class that assembles a module, such as Assembly in VIPER
        let module = ProfileModule(transition: transition)
        
        // The Transition library method is called into which the opened UIViewController will be passed
        // and opening method
        open(module.view, transition: transition)
    }
    
    // This is how the function to push Profile in current Navigation stack
    func pushProfile() {
        let transition = PushTransition()
        let module = ProfileModule(transition: transition)
        open(module.view, transition: transition)
    }
}

// 4️⃣ And... that's all - you can call the router methods in your `UIViewController`
// in a convenient way for you, like this:
profileButton.addAction(
    UIAction(handler: { [weak self] _ in
        self?.router.presentProfile()
    }),
    for: .touchUpInside
)
```

## 🌠 Demo

For a better understanding of how to work with `Transition`, please check out the [demo project](https://github.com/johnnieWa1ker/Transition/tree/feature/TR-7/Example%20Apps/iOS).

## 🦖 For more

- The module's native "push" and "present" are already defined in `PushTransition` and `ModalTransition`, just pass an instance of them to the `open(_ : UIViewController, : Transition)` method.

- In addition, there is `EmbedTransition` which replaces the current controller with a new one using the `didMove(toParent _: UIViewController?)` method

- For a modal view, you can pass configuration in the BottomSheetProps object. It is supported to change all (or at least the most important) settings that will ensure the correct behavior of the screen.

```swift
// Each property replicates native settings in UIKit, you shouldn't have
// not understanding how it works. Just in case, for the BottomSheetProps properties, their documentation is duplicated
let transition = ModalTransition(
    isAnimated: true,
    isNeedToEmbedInNavigationController: false,
    modalPresentationStyle: .pageSheet,
    bottomSheetProps: BottomSheetProps(
        doNotCloseOnDrag: false,
        detents: [
            .large(),
            .medium()
        ],
        selectedDetentIdentifier: .medium,
        prefersScrollingExpandsWhenScrolledToEdge: true,
        largestUndimmedDetentIdentifier: .medium,
        preferredCornerRadius: 32,
        prefersGrabberVisible: true
    )
)
```

- If your project already uses `PanModal`, `FloatingPanel` or any other screen opening animator, you can use it in conjunction with `Transition`. Just implement your own version of the Transition protocol. Like that:

```swift
import FloatingPanel
import UIKit

final class ModalFloatingPanelTransition: NSObject {
    weak var viewController: UIViewController?
    weak var floatingPanel: FloatingPanelController?
}

// MARK: - Transition

extension ModalFloatingPanelTransition: Transition {
    func open(_ viewController: UIViewController) {
        guard let selfController = self.viewController else { return }

        guard
            let delegate = viewController as? FloatingPanelControllerDelegate
        else {
            assertionFailure("`\(viewController.self)` must conform `FloatingPanelControllerDelegate`")
            return
        }

        let fpc = FloatingPanelController()
        floatingPanel = fpc
        delegate.floatingPanel = fpc
        fpc.set(contentViewController: viewController)
        delegate.floatingPanelDidCreate(fpc)
        
        // Other FloatingPanelController settings if needed

        let controller = selfController.presentedViewController ?? selfController
        controller.present(fpc, animated: animated) { [weak delegate, weak fpc] in
            guard
                let delegate = delegate,
                let fpc = fpc
            else {
                return
            }
            delegate.floatingPanelDidPresent(fpc)
        }
    }

    func close(_ viewController: UIViewController) {
        close(viewController, completion: {})
    }

    func close(_: UIViewController, completion: @escaping () -> Void) {
        floatingPanel?.dismiss(animated: animated) { [weak self] in
            self?.floatingPanel?.set(contentViewController: nil)
            completion()
        }
    }
}
```
