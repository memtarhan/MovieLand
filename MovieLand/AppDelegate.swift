//
//  AppDelegate.swift
//  MovieLand
//
//  Created by Mehmet Tarhan on 25/09/2021.
//  Copyright © 2021 MEMTARHAN. All rights reserved.
//

import Swinject
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var assembler: Assembler?

    var rootViewController: UIViewController? {
        get { return window?.rootViewController }
        set {
            window?.rootViewController = newValue
            window?.makeKeyAndVisible()
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initWindow()
        initDI()
        initUI()
        initNavigationBar()

        return true
    }

    /// - Initializing window
    private func initWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
    }

    /// - Initializing dependency injection
    private func initDI() {
        assembler = Assembler([
            /// - Servies
            MovieServiceAssembly(),

            /// - Scenes
            DetailsAssembly(),
            HomeAssembly(),
        ])

        assembler?.apply(assembly: ViewControllerFactoryAssembly(assembler: assembler!))
    }

    /// - Initializing UI w/ initial view controller
    func initUI() {
        rootViewController = assembler?.resolver.resolve(HomeViewImplementable.self) as? UIViewController
    }

    /// - Initializing UINavigationBar
    private func initNavigationBar() {
        let appearence = UINavigationBar.appearance()
        appearence.tintColor = .white
        appearence.backgroundColor = .clear
        appearence.shadowImage = UIImage()
        appearence.setBackgroundImage(UIImage(), for: .default)
        appearence.isTranslucent = true
    }
}
