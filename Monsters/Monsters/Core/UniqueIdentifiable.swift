//
//  UniqueIdentifiable.swift
//  Monsters
//
//  Created by Sergey Melnikov on 28.10.2019.
//  Copyright © 2019 Sergey Melnikov. All rights reserved.
//

typealias UniqueIdentifier = String

/// Протокол определяющий поведение объектов идентфицируемых уникально
protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
