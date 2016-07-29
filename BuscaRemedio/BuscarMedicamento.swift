//
//  BuscarMedicamento.swift
//  BuscaRemedio
//
//  Created by Kleiton Batista on 11/07/16.
//  Copyright © 2016 Kleiton Batista. All rights reserved.
//

import UIKit

class BuscarMedicamento: UIViewController {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var apresentacao: UILabel!
    @IBOutlet weak var classe: UILabel!
    @IBOutlet weak var laboratorio: UILabel!
    @IBOutlet weak var principioativo: UILabel!
    @IBOutlet weak var produto: UILabel!
    @IBOutlet weak var cnpj: UILabel!
    override func viewDidAppear(animated: Bool) {
        //print("did appear")
       // print("view appear --> \(Medicamento.barCode)")
        buscarMedicamentoNet(Medicamento.barCode)

        
        
    }
    
    override func viewDidLoad() {
        apresentacao.text = ""
        classe.text = ""
        laboratorio.text = ""
        principioativo.text = ""
        produto.text = ""
        cnpj.text = ""
    }
    func buscarMedicamentoNet (barCode: String) -> Void{
     //   print("entrou")
        //let url = NSURL(string: "http://mobile-aceite.tcu.gov.br:80/mapa-da-saude/rest/remedios?codBarraEan=\(barCode)")
        let url = NSURL(string:"http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest/remedios?codBarraEan=\(barCode)&quantidade=1")!
 
      //  let urlbase = "http://mobile-aceite.tcu.gov.br/mapa-da-saude/rest/remedios?codBarraEan=\(barCode)"
        //print("url --> \(barCode)")
        //let url = NSURL(string: urlbase)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url){(data, response, error) in
            if let urlContent = data{
                
                do{
                    let resultado = try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
                    
                    //print(resultado["classeTerapeutica"]!)
                   // print(resultado.length)
                    //print(resultado.count)
                    //print("-------->")
                    
                   let res:NSArray = (resultado as! NSArray)
                    
                    //treahd
                    
                    let qualityOfServiceClass = QOS_CLASS_BACKGROUND
                  
                    let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
                    dispatch_async(backgroundQueue, {
                        print("This is run on the background queue")
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            self.apresentacao.text = res[0]["apresentacao"] as? String
                            //                    self.laboratorio.reloadInputViews()
                            
                            self.classe.text = res[0]["classeTerapeutica"] as? String
                            self.laboratorio.text = res[0]["laboratorio"] as? String
                            self.principioativo.text = res[0]["principioAtivo"] as? String
                            self.produto.text = res[0]["produto"] as? String
                            self.cnpj.text = res[0]["cnpj"] as? String

                        })
                    })
                    
                   print(res[0]["apresentacao"] as! String)
                    

                }catch{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    /*
     
     NSURLConnection.sendAsynchronousRequest(NSMutableURLRequest(URL: url), queue: NSOperationQueue.mainQueue(), completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
     
     do {
     if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
     print("ASynchronous\(jsonResult)")
     self.lblCpf.text = jsonResult["cpf"]! as? String
     self.lblNome.text = jsonResult["nome"] as? String
     self.lblIdade.text = jsonResult["idade"] as? String
     
     self.nome.hidden = false
     self.cpf.hidden = false
     self.idade.hidden = false
     }
     } catch let error as NSError {
     print(error.localizedDescription)
     }
     
     
     })

     
     
     
     
     */
    
    
    /*
     super.viewDidLoad()
     // consumir url que nao é https tem que alterar o plist
     let url = NSURL(string:"http://freegeoip.net/json/189.9.74.17")!
     let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, erro) in
     
     if let urlContent = data{
     
     do{
     let jsonResult =  try NSJSONSerialization.JSONObjectWithData(urlContent, options: NSJSONReadingOptions.MutableContainers)
     
     print(jsonResult["country_name"]!)
     
     }catch{
     print("Erro ao serializar o json")
     }
     
     }
     }
     task.resume()

     */
    
}
