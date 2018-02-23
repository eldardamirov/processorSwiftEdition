//
//  fileIO.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 18.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation


class FileIO
    {
    init ( inputText: String )
        {
        storage = inputText;
        
        storageBeginningIndex = storage.startIndex;
        storageSize = inputText.count;
        }
    
    
    
    private var storage: String = "";
    private var storageBeginningIndex: String.Index;     // Hmm, seems to be BIDLOCOD!1!!;
    private var storageSize = 0;
    
    private var currentChar: Int = 0;
    
    
    public func getNextChar() -> Character
        {
        currentChar = currentChar + 1;
        return storage [ storage.index ( storageBeginningIndex, offsetBy: ( currentChar - 1 ) ) ]
        }
       
    public func getNextString() -> String
        {
        var result: String = "";
        var notEnd: Bool = true;
        
        var currentCharTemp: String = "";
        
        while notEnd
            {
            if ( !( ( currentCharTemp == " " ) || ( currentChar >= storageSize ) ) )
                {
                currentCharTemp = String ( storage [ storage.index ( storageBeginningIndex, offsetBy: currentChar ) ] );
                
                if ( currentCharTemp != "\n" )
                    {
                    result = result + currentCharTemp;
                    }
                
                currentChar = currentChar + 1;
                } 
            else
                {
                notEnd = false;
                }
            }
        
        return result;
        }   
        
    public func getTillEndOfLine() -> String
        {
        var result: String = "";
        var notEnd: Bool = true;
        
        var currentCharTemp: String = "";
        
        while notEnd
            {
            if ( ( currentCharTemp == "\n" ) || ( currentChar >= storageSize ) )
                {
                notEnd = false;
                }
            else
                {
//                print ( "Debug: \( storage [ storage.index ( storageBeginningIndex, offsetBy: currentChar ) ] )" );
                currentCharTemp = String ( storage [ storage.index ( storageBeginningIndex, offsetBy: currentChar ) ] );

                result = result + currentCharTemp;
                
                currentChar = currentChar + 1;
                }
            
            }
        
//        result = clearFromJunk ( result ); 
        
        return result;
        }
        
    public func calculateLinesQuantity() -> Int
        {
        return ( storage.numberOfOccurances ( substring: "\n" ) + 1 );
        }
        
    public func isEnd() -> Bool
        {
        return ( currentChar > storageSize );
        }
    
    
    };
    
