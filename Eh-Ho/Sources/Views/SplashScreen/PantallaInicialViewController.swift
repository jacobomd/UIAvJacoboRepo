//
//  PantallaInicialViewController.swift
//  Eh-Ho
//
//  Created by Jacobo Morales Diaz on 16/10/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//

import UIKit

class PantallaInicialViewController: UIViewController {
    
    //MARK: - Outets
    @IBOutlet weak var logo_Rectangulo: UIImageView!
    @IBOutlet weak var logo_Triangulo: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var logoConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoWidthConstraint: NSLayoutConstraint!
    
    
    //MARK: - Cycle life
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Splash Screen"
        logoConstraint.constant -= view.bounds.height
        logoHeightConstraint.constant = logo.bounds.height + 300
        logoWidthConstraint.constant = logo.bounds.width + 300
        
        //createView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationsLogo()
        //createView()
    }
    
    //MARK: - Animations
    private func animationsLogo() {
        
        
        UIView.animate(withDuration: 5, delay: 0.0, options: .curveEaseOut,
                       animations: {
                        self.logoHeightConstraint.constant = self.logo.bounds.height - 300
                        self.logoWidthConstraint.constant = self.logo.bounds.width - 300
                        self.logoConstraint.constant = 0.0
                        self.view.layoutIfNeeded()
        }) { (success) in
            
            if success {
                let tabBar = TabBarController(inicio: CategoriesRouter.configureModule(),
                                              usuarios: UsersRouter.configureModule(),
                                              mensajes: CreateTopicsRouter.configureModule()
                                              )
                
                self.present(tabBar, animated: true, completion: nil)
            }
        }
        
    }
    
    //MARK: - CONSTRAINS BY CODE
    private func createView() {
        
        logo_Rectangulo.translatesAutoresizingMaskIntoConstraints = false
        //logo_Rectangulo.contentMode = .scaleAspectFill
        NSLayoutConstraint.activate([
            logo_Rectangulo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            logo_Rectangulo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            logo_Rectangulo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            logo_Rectangulo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
            ])
        
        logo_Triangulo.translatesAutoresizingMaskIntoConstraints = false
        //logo_Triangulo.contentMode = .scaleToFill
        NSLayoutConstraint.activate([
            logo_Triangulo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            logo_Triangulo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0.0),
            logo_Triangulo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0.0),
            logo_Triangulo.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
            ])
        
        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logo.heightAnchor.constraint(equalToConstant: 141.0),
            logo.widthAnchor.constraint(equalToConstant: 274.0),
            logo.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            logo.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
            ])
        
    }
    
    
}
