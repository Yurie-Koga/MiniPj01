//
//  Crawler.swift
//  Crawler
//
//  Created by Uji Saori on 2021-03-14.
//

import Foundation

let fm = FileManager.default

func crawl(path: String, indent: String = "") {
    var isDir: ObjCBool = false
    if fm.fileExists(atPath: path, isDirectory: &isDir) {
        if isDir.boolValue {
            let contents = try! fm.contentsOfDirectory(at: URL(string: path)!, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for i in 0..<contents.count {
                if i < contents.count - 1 {
                    print("\(indent)├─ \(contents[i].lastPathComponent)")
                    crawl(path: contents[i].path, indent: indent + "│    ")
                } else {
                    print("\(indent)└─ \(contents[i].lastPathComponent)")
                    if fm.fileExists(atPath: contents[i].path, isDirectory: &isDir) {
                        if isDir.boolValue {
                            crawl(path: contents[i].path, indent:  indent + "     ")
                        } else {
                            crawl(path: contents[i].path, indent: "│    " + indent)
                        }
                    }
                }
            }
        }
    }
}
