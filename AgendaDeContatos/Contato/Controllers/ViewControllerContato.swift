//
//  ViewControllerContato.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 11/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import UIKit
import Kingfisher

//FIXME: É recomendado utilizar uma celular costumizada. Depois posso te ensinar isso tambem.
//FIXME: utilizar funções da tableView comoo heightForRow, heightForHeader, heightForFooter para costumiza-la melhor


class ViewControllerContato: UIViewController, ServiceDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lbNomeLogin: UILabel!
    
    
    @IBOutlet weak var imgFotoContato: UIImageView!
    
    
    var auth:  ContatoService!
    var autorizacaoLogin: AuthenticationService!
    var contact: [ContatoView] = []
    var usuario: UsuarioViewModel!

    
    
    @IBOutlet weak var nomeHeaderContatos: UILabel!
    @IBOutlet weak var imagemContatos: UIImageView!
    
    @IBOutlet weak var tableViewContatos: UITableView!
    
    
    //criando o carregamento de atualizacao...
    let myRefreshControll: UIRefreshControl = {
        let refreshcontroll = UIRefreshControl()
        refreshcontroll.addTarget(self, action: #selector(ViewControllerContato.refresh), for: .valueChanged)
        return refreshcontroll
    }()
    
    
    @objc private func refresh(){
        self.auth.listarContato()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.autorizacaoLogin = AuthenticationService(delegate: self)
        self.auth = ContatoService(delegate: self)
        self.tableViewContatos.delegate = self
        self.tableViewContatos.dataSource = self
        
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: ""))
      //  imageView.kf.setImage(with: URL(string: ""))
        
        //lbNomeLogin.text = nomeFoto.name
        
//        self.tableViewContato.refreshControl = self.refreshControl
        
       
        /*Criando a parte do view do Header*/
        var nomeHeader = SessionControll.shared.usuario.name
        var fotoHeader = SessionControll.shared.usuario.photoUrl
        
        imgFotoContato.layer.cornerRadius = 60
        imgFotoContato.clipsToBounds = true
       // imgFotoContato.layer.borderWidth = 2
       // imgFotoContato.layer.borderColor = UIColor.lightGray.cgColor
        
        nomeHeaderContatos.text = nomeHeader
        imgFotoContato.kf.setImage(with:fotoHeader)
        
        
        self.tableViewContatos.refreshControl = myRefreshControll
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //imagemContatos.kf.setImage(with: )
        self.auth.listarContato()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contact.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celulat = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        celulat.textLabel?.text = contact[indexPath.row].nome
        
        // print("Contato: \(contact[indexPath.row].fotoUrl)")
        celulat.imageView?.kf.setImage(with: contact[indexPath.row].fotoUrl)
        
        return celulat
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let telaDetalhes = StoryboardScene.Contato.detalhesViewController.instantiate()
        telaDetalhes.contact = contact[indexPath.row]
        present(telaDetalhes, animated: true)

    }
    
    
    
    
    @IBAction func bntContatoAtualizar(_ sender: Any) {
      
        self.autorizacaoLogin.logout()//Utilzando o logout certo agr...
        /*
        self.auth.logout()
      */
        
        
//        let Main = StoryboardScene.Main.initialScene.instantiate()
//
//        func deslogar(){
//            Main.modalPresentationStyle = .fullScreen
//            present(Main, animated: true)
//        }
//
//        let telacontato = StoryboardScene.Contato.viewControllerContato.instantiate()
//        telacontato.dismiss(animated: true,completion: deslogar)
        
    
 }
    
    
    @IBAction func bntContatoCadastrar(_ sender: Any) {
        
        
        let TelaCadastroContato = StoryboardScene.Contato.viewControllerCadastroContato.instantiate()
        TelaCadastroContato.modalPresentationStyle = .fullScreen
        present(TelaCadastroContato, animated: true)
        
    }
    
    func success(type: ResponseType) {
        
        switch type {
        case .logout:
            
            ScreenManager.setupInitialViewController()
            
        case .listagemContato:
            
            self.contact = ContatoViewModel.getViews()
            
            tableViewContatos.reloadData()
            
        default:
            break
        }
        
        
        self.myRefreshControll.endRefreshing()
    }
    
    func failure(type: ResponseType, error: String) {
        
        switch type {
        case .logout:
            ScreenManager.setupInitialViewController()
        default:
            break
        }
        self.myRefreshControll.endRefreshing()
    }
    
}
