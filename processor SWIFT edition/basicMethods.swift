//
//  basicMethods.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation


extension String
    {
    func numberOfOccurances ( substring find: String ) -> Int
        {
        return ( ( ( self.components ( separatedBy: find ) ).count - 1 ) );
        }
    }




func isDigit ( inputChar: Character ) -> Bool
    {
    if ( ( inputChar >= "0" ) && ( inputChar <= "9" ) )
        {
        return true;
        }
    else
        {
        return false;
        }
    
    }


func isLetter ( inputChar: Character ) -> Bool
    {
//    var temp: Int = Int ( String ( inputChar ) )!;
    
    if ( ( inputChar >= "a" ) && ( inputChar <= "z" ) )
        {
        return true;
        }
    else
        {
        return false;
        }
    
    }


func isArithmetic ( inputChar: Character ) -> Bool
    {
    if ( ( inputChar == "+" ) || ( inputChar == "-" ) || ( inputChar == "*" ) || ( inputChar == "/" ) )
        {
        return true;
        }
    else
        {
        return false;
        }
    
    }


func fromStringToInt ( figure: Character ) -> Int
    {
    let figureInt: Int = Int ( String ( figure ) )!;
    
    if ( ( figureInt - zero ) < 10 )
        {
        return ( figureInt - zero );
        }
    else
        {
        let letterA: Int = Int ( "A" )!;
        return ( figureInt - ( letterA - 10 ) );
        }
    
    }


func fromStringToNumber ( number: String ) -> Int
    {
    var result = 0;
    
    for i in 0..<number.count
        {
        
        result = result + fromStringToInt ( figure: number [ number.index ( number.startIndex, offsetBy: i ) ] ) * myPow ( 10, ( number.count - i - 1 ) );
        }
    
    return result;
    }
    
    
    
func myPow ( _ baseNumber: Int, _ degree: Int ) -> Int
    {
    var result: Int = 1;

    for _ in 0..<degree
        {
        result = result * baseNumber; 
        }
        
    return result;
    }  
    
    
func clearFromJunk ( _ inputString: String ) -> String
    {  
    if ( inputString.count == 0 )
        {
        return "";
        }
        
    if ( inputString [ inputString.index ( before: inputString.endIndex ) ] == "\n" )
        {
        return String ( inputString.prefix ( inputString.count - 1 ) );
        }
    else
        {
        return inputString;
        }
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
