//
//  Card.swift
//  Zane Swafford
//
//  Created by Zane Swafford on 4/22/15.
//  Copyright (c) 2015 Zane Swafford. All rights reserved.
//

import Foundation
import MapKit

class Card {
    let coverPhotoName: String?
    let photoNamesAlbum: Array<String>?
    let location: CLLocationCoordinate2D?
    let text: String?
    let url: NSURL?
    
    init(dictionary:NSDictionary) {
        coverPhotoName = dictionary["coverPhoto"] as? String
        photoNamesAlbum = dictionary["photoAlbum"] as? Array<String>
        
        if let urlString = dictionary["url"] as? String {
            url = NSURL(string: urlString)
        } else {
            url = nil
        }
        
        if let locationTuple = dictionary["location"] as? (Double, Double) {
            location = CLLocationCoordinate2DMake(locationTuple.0, locationTuple.1)
        } else {
            location = nil
        }
        
        if let escapedText = dictionary["text"] as? String {
            text = escapedText.stringByReplacingOccurrencesOfString("\\n", withString:"\n", options:nil, range:nil)
        } else {
            text = nil
        }
    }
    
    class func loadCardsFromFile(path:String) -> [Card]
    {
        var cards:[Card] = []
        
        var error:NSError? = nil
        if let data = NSData(contentsOfFile: path, options:nil, error:&error),
            json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error:&error) as? NSDictionary,
            cardsDictionary = json["cards"] as? [NSDictionary] {
                for cardDictionary in cardsDictionary {
                    let card = Card(dictionary: cardDictionary)
                    cards.append(card)
                }
        }
        return cards
    }
}
