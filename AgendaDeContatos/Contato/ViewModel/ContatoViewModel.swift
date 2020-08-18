//
//  ContatoViewModel.swift
//  AgendaDeContatos
//
//  Created by Gabriel Aderaldo on 12/08/20.
//  Copyright © 2020 Gabriel Aderaldo. All rights reserved.
//

import Foundation

//DFIXME: Remover Excesso de espaços vazios

struct ContatoView{
    
    var id: String = " "
    var nome: String = " "
    var foto: String = " "
    var email: String = " "
    var fone: String = " "
    var token:String = " "


    var fotoUrl: URL? {
        return URL(string: self.foto)
    }
}


class ContatoViewModel{
    
    
    static func save(_ contato:Contato){
        
        try? uiRealm.write{
            uiRealm.add(contato,update: .modified)
        }
        
        
        
        
    }
    
    
    static func save(_ contatos:[Contato]){
        self.removeContatos()
        
        try? uiRealm.write{
            uiRealm.add(contatos,update: .modified)
        }
    }
    
    
    
    
    
    static func removeContatos() {
        let objects = uiRealm.objects(Contato.self)
        try? uiRealm.write{
            uiRealm.delete(objects)
        }
    }
    
    
    static func getAsView(_ contato:Contato?) -> ContatoView {
        guard let contato = contato else { return ContatoView() }
        
        var contatoView = ContatoView()
        
        
        contatoView.id = contato.id ?? " "
        contatoView.nome = contato.nome ?? " "
        contatoView.foto = contato.foto ?? " "
        contatoView.email = contato.email ?? " "
        contatoView.fone = contato.fone ?? " "
        
        
        return contatoView
    }
    
    
    static func getAsView(sequence: [Contato]) -> [ContatoView] {
        
        var contatos: [ContatoView] = []
        
        sequence.forEach{ (contato) in
            contatos.append(self.getAsView(contato))
        }
        
        return contatos
        
        
    }
    
  
    static func get() -> [Contato] {
        let results = uiRealm.objects(Contato.self)
        
        
        var contatos: [Contato] = []
        contatos.append(contentsOf: results)
        
        return contatos
    }
    
   
    
    static func getViews() -> [ContatoView] {
        
        return self.getAsView(sequence: self.get())
        
    }
    
    
    static func getContato() -> Contato? {
        return uiRealm.objects(Contato.self).first
    }
    
    
    static func getContatoView() -> ContatoView {
        return self.getAsView(self.getContato())
    }
    
    
    
    
    
}

