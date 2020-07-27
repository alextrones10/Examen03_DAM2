//
//  ViewControllerListarServicios.swift
//  examen3
//
//  Created by DAMII on 7/19/20.
//  Copyright © 2020 DAMII. All rights reserved.
//

import UIKit

class ViewControllerListarServicios: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var lblCliente: UITextField!
    @IBOutlet weak var lblNumeroOrden: UITextField!
    

    @IBOutlet weak var tvListaServicios: UITableView!
    @IBOutlet weak var lblMensajes: UILabel!
    
    var oListaServicios = [ObjServicio]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tvListaServicios.dataSource = self
        self.tvListaServicios.delegate = self
        self.tvListaServicios.rowHeight = 150
        
    }
     
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return oListaServicios.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let oCelda = tableView.dequeueReusableCell(withIdentifier: "CeldasServicios", for: indexPath) as! TableViewCellServicios
                        
                        let oRegServicios=oListaServicios[indexPath.row]
                 oCelda.MostrarRegistro(pServicios: oRegServicios, pSelf: self)
                        return oCelda
       }
    
    @IBAction func btnNuevo_onclick(_ sender: Any) {
        var objServ:ObjServicio
            objServ = ObjServicio(pCodigoServicio: 0, pNombreCliente: "", pNumeroOrdenServicio: "", pFecha: "", pLinea: "", pEstado: "", pObservaciones: "")
                
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let oPantalla2 = storyBoard.instantiateViewController(withIdentifier: "ViewRegistroServicios") as! ViewControllerRegistroServicios
                   oPantalla2.CargarRegistro(pServ: objServ)
                                               
                self.present(oPantalla2, animated: true, completion: nil)
        
    }
    
    @IBAction func btnBuscar_onclick(_ sender: Any) {
        oListaServicios = [ObjServicio]()
          
        let urlListado = "http://cibertec202021-001-site1.etempurl.com/Servicio/Listar?CodigoServicio="
        + self.lblNumeroOrden.text!
         + "&NombreCliente=" + self.lblCliente.text!
        
               print (urlListado)
               let urlConsulta = URL(string: urlListado)
               let peticion = URLRequest(url: urlConsulta!)
               
               let tarea = URLSession.shared.dataTask(with: peticion)
               {Datos, Respuesta, Error in
                   print("por iniciar")
                   if (Error == nil)
                   {
                       print("Por procesar Datos")
                       print(Datos ?? "Vacio")
                       let datosCadena = NSString(data: Datos!, encoding: String.Encoding.utf8.rawValue)
                       print (datosCadena!)
                       print("Fin procesar Datos")
                       
                       DispatchQueue.main.async {
                           //Inicio Completar la lectura de objetos JSON
                           let JSON = try? JSONSerialization.jsonObject(with: Datos!, options: [])
                           
                           if let dictionary = JSON as? [[String: Any]]
                              /* let WSListaUsuarios = dictionary as? [[String: Any]]*/
                           {
                            dictionary.forEach { Registro in
                                   let CodigoServicio = Registro["CodigoServicio"] as! integer_t
                                   let NombreCliente = Registro["NombreCliente"] as? String
                                   let NumeroOrdenServicio = Registro["NumeroOrdenServicio"] as? String
                                   let Fecha = Registro["FechaProgramada"] as? String
                                   let Linea = Registro["Linea"] as? String
                                   let Estado = Registro["Estado"] as? String
                                   let Observaciones = Registro["Observaciones"] as? String
            
                                
                                let Proveedor1 = ObjServicio(pCodigoServicio: CodigoServicio, pNombreCliente: NombreCliente, pNumeroOrdenServicio: NumeroOrdenServicio, pFecha:Fecha, pLinea:Linea, pEstado:Estado, pObservaciones:Observaciones)
                                     
                                   self.oListaServicios.append(Proveedor1)
                               }
                               self.lblMensajes.text = "\(self.oListaServicios.count) Servicios Encontrados!"
                               self.tvListaServicios.reloadData()
                           }
                         }
                      }
                   else
                   {
                       print("Error")
                       print(Error ?? "Error vacio")
                   }
               }
               tarea.resume()
    }
    

      
   }

