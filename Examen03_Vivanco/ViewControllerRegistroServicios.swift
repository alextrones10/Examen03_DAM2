//
//  ViewControllerRegistroServicios.swift
//  examen3
//
//  Created by DAMII on 7/19/20.
//  Copyright © 2020 DAMII. All rights reserved.
//

import UIKit

class ViewControllerRegistroServicios: UIViewController {
    
    
    @IBOutlet weak var tfCodigoServicio: UITextField!
    @IBOutlet weak var tfNombreCliente: UITextField!
    @IBOutlet weak var tfNumeroOrden: UITextField!
    @IBOutlet weak var tfFecha: UITextField!
    @IBOutlet weak var tfLinea: UITextField!
    @IBOutlet weak var tfEstado: UITextField!
    @IBOutlet weak var tfObservaciones: UITextField!
    
    
    @IBOutlet weak var lblMensaje: UILabel!
    
    var objServiciosInternoRegistro: ObjServicio!
   
    
    public func CargarRegistro(pServ: ObjServicio)
    {
        self.objServiciosInternoRegistro = pServ
    }
  
    func MostrarDatos()
       {
           tfCodigoServicio.text = String(objServiciosInternoRegistro.CodigoServicio)
           tfNombreCliente.text = objServiciosInternoRegistro.NombreCliente
           tfNumeroOrden.text = objServiciosInternoRegistro.NumeroOrdenServicio
           tfFecha.text = objServiciosInternoRegistro.Fecha
           tfLinea.text = objServiciosInternoRegistro.Linea
           tfEstado.text = objServiciosInternoRegistro.Estado
           tfObservaciones.text = objServiciosInternoRegistro.Observaciones
       }
    
    @IBAction func btnAtras_onclick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let oPantalla2 = storyBoard.instantiateViewController(withIdentifier: "ViewListarServicios") as! ViewControllerListarServicios
                                           
        self.present(oPantalla2, animated: true, completion: nil)
    }
    @IBAction func btnGrabar_onclick(_ sender: Any) {
        var pTipoTransaccion:String="N"
        self.lblMensaje.text = "Nuevo Servicio Registrado...!"
        
        if (objServiciosInternoRegistro.CodigoServicio>0)
        {
           pTipoTransaccion = "A"
            self.lblMensaje.text = "Servicio Actualizado...!"
        }
           
        let urlListado = "http://cibertec202021-001-site1.etempurl.com/Servicio/RegistraModifica?Accion=" + pTipoTransaccion +
                   "&CodigoServicio=" + String(objServiciosInternoRegistro.CodigoServicio) +
                   "&NombreCliente=" + self.tfNombreCliente.text! +
                   "&NumeroOrdenServicio=" + self.tfNumeroOrden.text! +
                   "&FechaProgramada=" + self.tfFecha.text! +
                   "&Linea=" + self.tfLinea.text! +
                   "&Estado=" + self.tfEstado.text! +
                   "&Observaciones=" + self.tfObservaciones.text!
        
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
                                   
                                    if let objProveedortmp = JSON as? [String: Any]
                                                      {
                                           let CodigoServicio = objProveedortmp["CodigoServicio"] as! integer_t
                                                       self.objServiciosInternoRegistro.CodigoServicio = CodigoServicio
                                                       self.tfCodigoServicio.text = String (CodigoServicio)
                                             
                                   }
                                  
                               }
                              
                           }
                           else
                           {
                               print("Error")
                               print(Error ?? "Error vacio")
                            self.lblMensaje.text = "Error!!"
                               //let strCadena = Error as! String
                               //self.tvMensaje.text = strCadena
                           }
                       }
                       tarea.resume()
    }
    
    
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MostrarDatos()

       
    }
     

}
