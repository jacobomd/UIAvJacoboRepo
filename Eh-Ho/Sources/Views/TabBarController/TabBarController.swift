//
//  TabBarController.swift
//  Eh-Ho
//
//  Created by Ignacio Garcia Sainz on 16/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    let inicio: UIViewController
    let usuarios: UIViewController
    let mensajes: UIViewController
   // let ajustes: UIViewController

    
    init(inicio: UIViewController, usuarios: UIViewController, mensajes: UIViewController) {
        self.inicio = inicio
        self.usuarios = usuarios
        self.mensajes = mensajes
        //self.ajustes = ajustes
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBar()
    }
    
    override func awakeFromNib() {
    
    }
    
    private func configureTabBar() {
        let inicio = self.inicio
        inicio.tabBarItem = UITabBarItem(title: "Inicio",
                                                       image: UIImage(named: "tabBar_inicioOff")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                       selectedImage: UIImage(named: "tabBar_inicioOn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let usuarios = self.usuarios
        usuarios.tabBarItem = UITabBarItem(title: "Usuarios",
                                                image: UIImage(named: "tabBar_usuarioOff")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                                selectedImage: UIImage(named: "tabBar_usuarioOn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let mensajes = self.mensajes
        mensajes.tabBarItem = UITabBarItem(title: "Mensajes",
                                        image: UIImage(named: "tabBar_mensajeOff")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                        selectedImage: UIImage(named: "tabBar_mensajeOn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        let ajustes = UIViewController()
        ajustes.tabBarItem = UITabBarItem(title: "Ajustes",
                                           image: UIImage(named: "tabBar_ajustesOff")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal),
                                           selectedImage: UIImage(named: "tabBar_ajustesOn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal))
        
        
       
        
        let colorSelected = UIColor(red: 291/255, green: 99/255, blue: 0/255, alpha: 1.0)
        let colorUnSelected = UIColor(red: 12/255, green: 12/255, blue: 12/255, alpha: 1.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: colorSelected], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: colorUnSelected], for: .normal)

        self.tabBar.barTintColor = .white
        
        let controllers = [inicio, usuarios, mensajes, ajustes]
        self.viewControllers = controllers.map { UINavigationController(rootViewController: $0) }
     

    }

}
