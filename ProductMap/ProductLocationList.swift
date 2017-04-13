//
//  ProductLocationList.swift
//  ProductMap
//
//  Created by Trevin Wisaksana on 4/12/17.
//  Copyright © 2017 Trevin Wisaksana. All rights reserved.
//


import UIKit
import MapKit

class ProductLocationList: NSObject {
    
    var products = [ProductLocation]()
    
    override init() {
        
        products += [ProductLocation(name:"Connie's Pizza",latitude:41.84937922,longitude:-87.6410584  )]
        products += [ProductLocation(name:"Connie's Pizza",latitude:41.90146341,longitude: -87.62848137 )]
        products += [ProductLocation(name:"Connie's Pizza",latitude:41.85110748,longitude: -87.61286663 )]
        products += [ProductLocation(name:"Connie's Pizza",latitude:41.89224916,longitude:-87.60951805  )]
        products += [ProductLocation(name:"Giordano's",latitude:42.00302015,longitude:-87.81630768  )]
        products += [ProductLocation(name:"Giordano's",latitude:41.79915575,longitude:-87.59028088)]
        products += [ProductLocation(name:"Giordano's",latitude:41.85776469,longitude:-87.66138509)]
        products += [ProductLocation(name:"Giordano's",latitude:41.95296188,longitude:-87.77541371)]
        products += [ProductLocation(name:"Pequod's",latitude:41.92185084,longitude:-87.66451631)]
        products += [ProductLocation(name:"Pizzeria DUE",latitude:41.89318499,longitude:-87.62661003)]
        products += [ProductLocation(name:"Pizzeria UNO",latitude:41.8924923,longitude:-87.626859)]
        products += [ProductLocation(name:"Gino's East",latitude:41.8959379,longitude:-87.6229284)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.95340615,longitude:-87.73214376)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.87169869,longitude:-87.62737565)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.96074325,longitude:-87.6835484)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.88411358,longitude:-87.65808167)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.85186556,longitude:-87.72202439)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.90239382,longitude:-87.62846892)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.89031406,longitude:-87.63388913)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.92911995,longitude:-87.65359186)]
        products += [ProductLocation(name:"Lou Malnati's",latitude:41.9089214,longitude:-87.6775678)]
    }
    
}
