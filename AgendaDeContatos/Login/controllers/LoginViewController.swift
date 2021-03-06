//
//  ViewControllerLogin.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 10/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import SVProgressHUD
import IHKeyboardAvoiding
class LoginViewController: UIViewController, ServiceDelegate{

    @IBOutlet weak var bntLOGAR: UIButton!
    @IBOutlet weak var bntCARREGAR: UIButton!
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    var telaSplash = StoryboardScene.Login.splashViewController.instantiate()
    
    var auth: AuthenticationService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.auth = AuthenticationService(delegate: self)
        bntCARREGAR.layer.cornerRadius = 8
        bntCARREGAR.clipsToBounds = true
        bntLOGAR.layer.cornerRadius = 8
        bntLOGAR.clipsToBounds = true
        
        KeyboardAvoiding.avoidingView = self.view
        
        self.configDismiss()
    }
    
    @IBAction func bntLogarValidacao(_ sender: Any) {
        
        
        if let localLogin = self.txtLogin.text, let localSenha = self.txtSenha.text {
            
            if localLogin.isEmpty || localSenha.isEmpty{
                failure(type: .login, error: "")
                return
            }
                
            self.auth.login(email: localLogin, senha: localSenha)
            
            telaSplash.modalPresentationStyle = .fullScreen
            present(telaSplash, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func bntCadastro(_ sender: Any) {
        let telaCadastro = StoryboardScene.Login.viewControllerCadastro.instantiate()
        present(telaCadastro, animated: true)
    }

    func success(type: ResponseType) {
        telaSplash.dismiss(animated: true, completion: nil)
        ScreenManager.setupInitialViewController()
        
    }
    
    func failure(type: ResponseType, error: String) {
        
        telaSplash.dismiss(animated: true) {
            let erroLogin = UIAlertController(title: L10n.Msg.fracasso, message: SessionControll.shared.isConnected ? L10n.Msg.Fracasso.login : "Falha na conexão", preferredStyle: .alert)
            
            erroLogin.addAction(UIAlertAction(title: L10n.f, style: .default, handler: nil))
            
            self.present(erroLogin, animated: true)
        }
        telaSplash.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController  {
    
    func configDismiss() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.closeKeyBoard)))
    }
    
    @objc func closeKeyBoard() {
        self.view.endEditing(true)
    }
}
