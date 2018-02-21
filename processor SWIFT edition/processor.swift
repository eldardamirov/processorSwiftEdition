//
//  processor.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 21.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation



class Processor
    {
    init ( storage storageTemp: String )
        {
        machineCode = FileIO ( inputText: storageTemp );
        
        ram.reserveCapacity ( 1024 ); // magic number;
        
        makeInstructionStack();
        
        controlCommandsDoing();
        }
    
    
    private func controlCommandsDoing() -> Int
        {
        
        while ( true )
            {
            if ( doCommand() == -9 )
                {
                return 0;
                }
            }
        
        return 0;
        }
    
    
    private var processorStack = Stack <Double>();
    private var functionBaskMarksStack = Stack <Int>();
    
    private var ram: [ Double ] = [ Double ](); // needs reservation;
    
    private var commandsQuantity: Int = 0;
    private var currentMemoryCell: Int = 0;
    private var cellQuantity: Int = 0;
    
    private var instructionArray: [ Double ] = [ Double ](); // needs reservation;
    
    private var machineCode: FileIO;
    
    // REGISTERS ARRAY
    private var registerArray: [ Double ] = [ Double ](); // needs reservation;
    
    
    
    
    private func makeInstructionStack() -> Int
        {
        commandsQuantity = machineCode.calculateLinesQuantity();
        
        cellQuantity = fromStringToNumber ( number: machineCode.getTillEndOfLine() );
        
        var currentCellTemp: Int = 0;
        
        for currentLine in 1..<commandsQuantity
            {
//            currentCellTemp = currentCellTemp + 
            }
        
        }
    
    
    private func parseLine ( currentLine: String, currentCellTemp: Int ) -> Int
        {
        var shift: Int = 0;
        var currentWord: String = "";
        var lineSize: Int = currentLine.count;
        
        var currentLineBeginningIndex: String.Index = currentLine.startIndex;
        
        for currentCharIndex in 0..<lineSize
            {
            if ( currentLine [ currentLine.index ( currentLineBeginningIndex, offsetBy: currentCharIndex ) ] == " " )
                {
                
                if ( currentWord != "" )
                    {
                    instructionArray [ currentCellTemp + shift ] = String ( currentWord );
                    }
                
                shift = shift + 1;
                
                currentWord = "";
                
                }
            else
                {
                currentWord = currentWord + String ( currentLine [ currentLine.index ( currentLineBeginningIndex, offsetBy: currentCharIndex ) ] );
                }
                
            }
        
        return shift;
        }
        
        
        
    private func doCommand() -> Int
        {
        var commandId: Int = instructionArray [ currentMemoryCell ]; 
        
        switch commandId 
            {
            case processorCommands.hlt.rawValue:
                {
                return -9;
                }
            case processorCommands.nullCommand.rawValue:
                {
                return processorCommands.nullCommand.rawValue;
                }
            case processorCommands.myOut.rawValue:
                {
                stackOut();
                return 2;
                }
            case processorCommands.add.rawValue:
                {
                stackAdd();
                return 2;
                }
            case processorCommands.sub.rawValue:
                {
                stackSub();
                return 2;
                }
            case processorCommands.mul.rawValue:
                {
                stackMul();
                return 2;
                }
            case processorCommands.myDiv.rawValue:
                {
                stackDiv();
                return 2;
                }
            case processorCommands.mySin.rawValue:
                {
                stackSin();
                return 2;
                }
            case processorCommands.myCos.rawValue:
                {
                stackCos();
                return 2;
                }
            case processorCommands.mySqrt.rawValue:
                {
                stackSqrt();
                return 2;
                }
            case processorCommands.myAbs.rawValue:
                {
                stackAbs();
                return 2;
                }
            case processorCommands.myDup.rawValue:
                {
                stackDup();
                return 2;
                }
            case processorCommands.dump.rawValue:
                {
                stackDump();
                return 2;
                }
            case processorCommands.ret.rawValue:
                {
                ////////////////////////////////////
                ////////////////////////////////////
                
                
                
                ////////////////////////////////////
                ////////////////////////////////////
                
                return 0;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            case processorCommands.hlt.rawValue:
                {
                return 2;
                }
            
            
                
            
            default:
        
            }
        
        
        }
        
        
        
        
        
        
    
    
    };






















