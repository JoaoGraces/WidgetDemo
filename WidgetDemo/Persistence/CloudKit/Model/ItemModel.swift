//
//  ItemModel.swift
//  WidgetDemo
//
//  Created by Gabriel Ribeiro Noronha on 14/11/23.
//

import Foundation
import CloudKit
import SwiftUI

struct ItemModel: Hashable {
//    let idAcessorio : UUID
    let name: String
    let record: CKRecord
    let preco: Int
//    let imageURL: URL?
}
