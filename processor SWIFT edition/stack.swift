//
//  stack.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation


class Stack <typeOfData>   
    {
    private var storage = [ typeOfData ]();
    private var stackSize: Int = 0;
    
    public func boost()
        {
        storage.reserveCapacity ( 100 );
        }
    
    public func push ( valueToPush value: typeOfData )
        {
        storage.append ( value );
        
        stackSize = stackSize + 1;
        }

    public func pop()
        {
        if ( empty() )
            {
            storage.removeLast();
            
            stackSize = stackSize - 1;
            }
            
        
        }
	
    
    public func empty() -> Bool
        {
        return ( stackSize > 0 );
        }


    public func size() -> Int
        {
        return stackSize;
        }
        
    public func top() -> typeOfData
        {
        //// TEMP SOLUTION a.k.a kostil'
        if ( self.size() > 0 )
            {
            return storage [ ( stackSize - 1 ) ];
            }
        else
            {
            return 0.0 as! typeOfData;
            }
        }

    };


//// ----------------------------------------------------------------------------------------
//let poisonInt = 12345678;
//let poisonDouble: Double = Double.nan;
//let poisonFloat: Float = Float.nan;
//let poisonCharacter: Character = "-";
//// ----------------------------------------------------------------------------------------
//
//
//struct stackElement <typeOfData> 
//    {
//    var elementValue: typeOfData;
//    // var elementHashValue: Int = 0;
//    }
//
//
//class Stack <typeOfData>
//    {
//    init ( tempStackCapacity: Int )
//        {
//        stackCapacity = tempStackCapacity;
//        
//        var temp: typeOfData;
//        
//        
//        
////        switch ( { () -> typeOfData.Type in var temp: typeOfData; return type ( of: temp ) } )
////        switch ( temp ) 
////            {
////            case type ( of: Int ):
////                {
////                poisonValue = poisonInt;
////                }
////            
////            default:
////                return 0;
////                
////                
////            };
//        }
//        
//    deinit 
//        {
//        // 
//        
//        }
//    
//    
//    public func printItAll()
//        {
//        for currentElement in stackArray
//            {
//            print ( "\( currentElement )\n" );
//            }
//        }
//        
//    private func setPoisonValue()
//        {
//        var temp: typeOfData;
//                
//        if ( type ( of: temp ) == type ( of: poisonInt ) )
//            {
//            poisonValue = poisonInt;
//            }
//        }
//    
//        
//
//    private var stackArray: [ stackElement <typeOfData> ] = [];
//    private var stackCurrentElement = 0, stackCapacity = 0;
//    private var stackCurrentSize = 0;
//    private var isOk = true;
//    
//    private var poisonValue: typeOfData;
//    
//    
//        
//    
//    
//        
//        
//    }

