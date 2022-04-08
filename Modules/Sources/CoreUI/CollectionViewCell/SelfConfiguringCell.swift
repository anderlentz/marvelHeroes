//
//  SelfConfiguringCell.swift
//  
//
//  Created by Anderson Lentz on 04/04/22.
//  Based on https://www.youtube.com/watch?v=SR7DtcT61tA&t=3s

import Foundation

public protocol SelfConfiguringCell {
    associatedtype DataType
    static var reusableIdentifier: String { get }
    
    func configure(with data: DataType)
}
