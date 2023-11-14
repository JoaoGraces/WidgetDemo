//
//  CKError.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import Foundation
import SwiftUI


//Tipos de Erros padrao do Cloudkit
enum CKError: String, LocalizedError{
    case iCloudAccountNotFound
    case iCloudAccountNotDetermined
    case iCloudAccountRestricted
    case iCloudAccountUnknown
}
