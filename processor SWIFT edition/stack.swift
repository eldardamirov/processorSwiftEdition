//
//  stack.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

// ----------------------------------------------------------------------------------------
let poisonInt = 12345678;
let poisonDouble: Double = Double.nan;
let poisonFloat: Float = Float.nan;
let poisonCharacter: Character = "-";
// ----------------------------------------------------------------------------------------


struct stackElement <typeOfData> 
    {
    var elementValue: typeOfData;
    // var elementHashValue: Int = 0;
    }


class Stack <typeOfData>
    {
    init ( tempStackCapacity: Int )
        {
        stackCapacity = tempStackCapacity;
        }
        
    deinit 
        {
        // 
        
        }
    
    
    public func printItAll()
        {
        
        }
    
        
    private var stackCapacity: Int = 0;
    
    
        
        
    }
