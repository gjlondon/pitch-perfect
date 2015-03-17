//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by George London on 3/15/15.
//  Copyright (c) 2015 Rogueleaderr. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filepathURL: NSURL!
    var title: String!
    init(filepathURL: NSURL, title: String) {
        self.filepathURL = filepathURL
        self.title = title
    }
}