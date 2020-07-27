//
//  ObjListar.swift
//  examen3
//
//  Created by DAMII on 7/19/20.
//  Copyright © 2020 DAMII. All rights reserved.
//

import UIKit

class ObjServicio: NSObject {
    
    var CodigoServicio: integer_t
    var NombreCliente: String
    var NumeroOrdenServicio: String
    var Fecha: String
    var Linea: String
    var Estado: String
    var Observaciones: String
    
    override init() {
        self.CodigoServicio = 0
        self.NombreCliente = ""
        self.NumeroOrdenServicio = ""
        self.Fecha = ""
        self.Linea = ""
        self.Estado = ""
        self.Observaciones = ""
    }
    
    init(pCodigoServicio: integer_t, pNombreCliente: String!, pNumeroOrdenServicio: String!, pFecha: String!, pLinea: String!, pEstado: String!, pObservaciones: String!) {
        
           self.CodigoServicio = pCodigoServicio
           self.NombreCliente = pNombreCliente
           self.NumeroOrdenServicio = pNumeroOrdenServicio
           self.Fecha = pFecha
           self.Linea = pLinea
           self.Estado = pEstado
           self.Observaciones = pObservaciones
       }

}
