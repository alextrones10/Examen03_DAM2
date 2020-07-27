//
//  TableViewCellServicios.swift
//  examen3
//
//  Created by DAMII on 7/19/20.
//  Copyright © 2020 DAMII. All rights reserved.
//

import UIKit

class TableViewCellServicios: UITableViewCell {
      
    
    @IBOutlet weak var lblCliente: UILabel!
    @IBOutlet weak var lblNumeroOrden: UILabel!
    @IBOutlet weak var lblFecha: UILabel!
    
    @IBOutlet weak var btnVerRegistro: UIButton!
    
    
    var objServiciosInterno: ObjServicio!
    var ObjSelf: ViewControllerListarServicios!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    public func MostrarRegistro(pServicios: ObjServicio, pSelf: ViewControllerListarServicios)
       {
           self.objServiciosInterno = pServicios
           self.lblNumeroOrden.text = pServicios.NumeroOrdenServicio
           self.lblCliente.text = pServicios.NombreCliente
           self.lblFecha.text = pServicios.Fecha
           self.ObjSelf = pSelf
           
       }
    
    @IBAction func btnVer_onclick(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let oPantalla2 = storyBoard.instantiateViewController(withIdentifier: "ViewRegistroServicios") as! ViewControllerRegistroServicios
        oPantalla2.CargarRegistro(pServ: objServiciosInterno)
                   
           ObjSelf.present(oPantalla2, animated: true, completion: nil)
    }
    
    
}
