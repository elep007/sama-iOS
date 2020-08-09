//
//  Box.swift
//  PSHotels
//
//  Created by Panacea-Soft on 1/19/18.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation


class LiveData<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?

    var value: T {
        didSet {
            //bind()
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(listener: @escaping Listener) {
        self.listener = listener
        listener(value)
    }
}

