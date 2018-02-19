//
//  compiler.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 19.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

struct command  
    {
    var commandId: Int = 0;
    var operandaModifier: Int = -1;
    var argument: Double = 0;
    var argument2: Double = 0;
    
    var argumentS: String = "";
    var argumentS2: String = "";
    
    }


class compiler 
    {
    private var compilationStartTime: Double = 0;
    private var compilationFinishTime: Double = 0;
    
    init ( storage storageTemp: String )
        {
        compilationStartTime = Date().timeIntervalSince1970;
        
        print ( "COMPILATION..." );
        
        storage = FileIO ( inputText: storageTemp );
        
        
        linesQuantity = storage.calculateLinesQuantity();
        
        
        makeMachineCode();
        }
        
    
    
    //----------------------------------------------------------------------
    var commandInMemoryLocation: Int = -1;
    //----------------------------------------------------------------------
    var storage: FileIO;    // HMM, looks like BIDLOKOD!!!
    var jumpMarks: [ ( String, Int ) ] = [ ( "", 0 ) ];
    
    //----------------------------------------------------------------------
    var linesQuantity: Int = 0;
    var commandsArray: [ command ] = [ command() ];  
    
    //----------------------------------------------------------------------
    
    private func makeMachineCode()
        {
        commandsArray.reserveCapacity ( linesQuantity );
        
        var currentInputLine: String = "";
        
        //----------------------------------------------------------------------
        var currentCommandTemp: String = "";
        var currentArgumentTemp: String = "";
        var currentCommandIdTemp: Int = 0;
        //----------------------------------------------------------------------
        
        
        
        
        for currentCommand in 0..<linesQuantity
            {
            currentInputLine   = storage.getTillEndOfLine();
            currentCommandTemp = getWordInString ( inputString: currentInputLine, mode: 0 );

            currentCommandIdTemp = getCommandId ( tempCommand: currentCommandTemp );
            
            
            commandsArray [ currentCommand ].commandId = currentCommandIdTemp;
            
            if ( ( currentCommandIdTemp < processorCommands.borderJump.rawValue ) && ( currentCommandIdTemp != processorCommands.nullCommand.rawValue ) )
                {
                
                commandInMemoryLocation = commandInMemoryLocation + 2;
                
                }
            else if ( currentCommandIdTemp != processorCommands.nullCommand.rawValue )
                {
                
                if ( currentCommandIdTemp < processorCommands.borderArgument.rawValue )
                    {
                    
                    commandsArray [ currentCommand ].commandId = currentCommandIdTemp;
                    commandsArray [ currentCommand ].operandaModifier = -2;
                    commandsArray [ currentCommand ].argumentS = clearFromSpaces ( currentArgumentTemp: getWordInString ( inputString: currentInputLine, mode: 1 ) ); 
                    
                    
                    commandInMemoryLocation = commandInMemoryLocation + 2;
                    }
                else
                    {
                    currentArgumentTemp = clearFromSpaces ( currentArgumentTemp: getWordInString ( inputString: currentInputLine, mode: 1 ) ); 
                    
                    if ( currentArgumentTemp.count == 0 )
                        {
                        commandsArray [ currentCommand ].operandaModifier = -1;  
                        commandInMemoryLocation = commandInMemoryLocation + 2;
                        
                        }
                    else
                        {
                        commandInMemoryLocation = commandInMemoryLocation + /// currentCommandArgument;
                        }
                    
                    }
                
                
                }
            
            
            
            }
        
        

        
        
        }


    private func getWordInString ( inputString: String, mode: Int ) -> String
        {
        var inputString = inputString;
        var inputStringSize = inputString.count - 1;
        var result: String = "";
        var inputStringBeginningIndex: String.Index = inputString.startIndex;

        if ( mode == 0 )
            {
            var currentChar = 0;

            while ( ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != " " ) && ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != "\n" ) && ( currentChar <= inputStringSize ) )
                {
                result = result + String ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] );

                currentChar = currentChar + 1;
                }

            return result;
            }

        if ( mode == 1 )
            {
            var currentChar = 0;

            while ( ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != " " ) && ( currentChar < inputStringSize ) && ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != "\n" ) )
                {
                currentChar = currentChar + 1;
                }

            if ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] == " " )
                {
                currentChar = currentChar + 1;
                }

            if ( ( currentChar <= inputStringSize ) && ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != "\n" ) )
                {

                while ( ( currentChar <= inputStringSize ) && ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] != "\n" ) )
                    {
                    result = result + String ( inputString [ inputString.index ( inputStringBeginningIndex, offsetBy: currentChar ) ] );

                    currentChar = currentChar + 1;
                    }


                return result;
                }

            }


        return "";
        }


    
    private func clearFromSpaces ( currentArgumentTemp: String ) -> String
        {
        var result: String = "";
        var argumentLength: Int = currentArgumentTemp.count;
        
        var currentArgumentTempBeginningIndex = currentArgumentTemp.startIndex;
        
        for currentChar in 0..<argumentLength
            {
            if ( currentArgumentTemp [ currentArgumentTemp.index ( currentArgumentTempBeginningIndex, offsetBy: currentChar ) ] != " " )
                {
                result = result + String ( currentArgumentTemp [ currentArgumentTemp.index ( currentArgumentTempBeginningIndex, offsetBy: currentChar ) ] );
                }
            }
        
        return result;
        }



    private func getCommandId ( tempCommand: String ) -> Int
        {
        if ( tempCommand == haultCommandHuman )
            {                
            return processorCommands.hlt.rawValue;
            }
        if ( tempCommand == pushCommandHuman )
            {                
            return processorCommands.push.rawValue;
            }
        if ( tempCommand == popCommandHuman )
            {                
            return processorCommands.pop.rawValue;
            }
        if ( tempCommand == inputFromKeyboardCommandHuman )
            {                
            return processorCommands.myIn.rawValue;
            }
        if ( tempCommand == outputCommandHuman )
            {                
            return processorCommands.myOut.rawValue;
            }
        if ( tempCommand == additionCommandHuman )
            {
            return processorCommands.add.rawValue;
            }
        if ( tempCommand == substituteCommandHuman )
            {
            return processorCommands.sub.rawValue;
            }
        if ( tempCommand == multiplicationCommandHuman )
            {                
            return processorCommands.mul.rawValue;
            }
        if ( tempCommand == divisionCommandHuman )
            {                
            return processorCommands.myDiv.rawValue;
            }
        if ( tempCommand == sinusCommandHuman )
            {                
            return processorCommands.mySin.rawValue;
            }  
        if ( tempCommand == cosinusCommandHuman )
            {                
            return processorCommands.myCos.rawValue;
            }
        if ( tempCommand == squareRootCommandHuman )
            {
            return processorCommands.mySqrt.rawValue;
            }
        if ( tempCommand == moduleCommandHuman )
            {                
            return processorCommands.myAbs.rawValue;
            }
        if ( tempCommand == duplicationCommandHuman )
            {                
            return processorCommands.myDup.rawValue;
            }
        if ( tempCommand == dumpCommandHuman )
            {                
            return processorCommands.dump.rawValue;
            }
        if ( tempCommand == jmpCommandHuman )
            {
            return processorCommands.jmp.rawValue;
            }
        if ( tempCommand == jeCommandHuman )
            {
            return processorCommands.je.rawValue;
            }
        if ( tempCommand == jneCommandHuman )
            {
            return processorCommands.jne.rawValue;
            }
        if ( tempCommand == jaCommandHuman )
            {
            return processorCommands.ja.rawValue;
            }
        if ( tempCommand == jaeCommandHuman )
            {
            return processorCommands.jae.rawValue;
            }
        if ( tempCommand == jbCommandHuman )
            {
            return processorCommands.jb.rawValue;
            }
        if ( tempCommand == jbeCommandHuman )
            {
            return processorCommands.jbe.rawValue;
            }
        if ( tempCommand == callCommandHuman )
            {
            return processorCommands.call.rawValue;
            }
        if ( tempCommand == returnCommandHuman )
            {
            return processorCommands.ret.rawValue;
            }
        
        
        return processorCommands.nullCommand.rawValue;
        }



    };










