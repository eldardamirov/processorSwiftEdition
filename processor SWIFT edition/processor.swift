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
        var commandId: Int = Int ( instructionArray [ currentMemoryCell ] ); 
        
        var returnState: Int = 0;
        
        switch commandId 
            {
            case processorCommands.hlt.rawValue:
                do {
                returnState = -9;
                }
            case processorCommands.nullCommand.rawValue:
                do {
                returnState = processorCommands.nullCommand.rawValue; 
                }
            case processorCommands.myOut.rawValue:
                do {
                self.stackOut();
                returnState = 2;
                }
            case processorCommands.add.rawValue:
                do {
                stackAdd();
                returnState = 2;
                }
            case processorCommands.sub.rawValue:
                do {
                stackSub();
                returnState = 2;
                }
            case processorCommands.mul.rawValue:
                do {
                stackMul();
                returnState = 2;
                }
            case processorCommands.myDiv.rawValue:
                do {
                stackDiv();
                returnState = 2;
                }
            case processorCommands.mySin.rawValue:
                do {
                stackSin();
                returnState = 2;
                }
            case processorCommands.myCos.rawValue:
                do {
                stackCos();
                returnState = 2;
                }
            case processorCommands.mySqrt.rawValue:
                do {
                stackSqrt();
                returnState = 2;
                }
            case processorCommands.myAbs.rawValue:
                do {
                stackAbs();
                returnState = 2;
                }
            case processorCommands.myDup.rawValue:
                do {
                stackDup();
                returnState = 2;
                }
            case processorCommands.dump.rawValue:
                do {
                stackDump();
                returnState = 2;
                }
            case processorCommands.ret.rawValue:
                do {
                ////////////////////////////////////
                ////////////////////////////////////
                
                if ( functionBaskMarksStack.size() > 0 )
                    {
                    currentMemoryCell = functionBaskMarksStack.top();
                    functionBaskMarksStack.pop();
                    }
                else
                    {
                    currentMemoryCell = currentMemoryCell + 2;
                    }
                
                ////////////////////////////////////
                ////////////////////////////////////
                
                returnState = 0;
                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
//            case processorCommands.hlt.rawValue:
//                {
//                return 2;
//                }
            
            
            default:
                {
                returnState = -7;
                }
        
            }
        
        return returnState;
        }
        
        
        
    private func stackOut() 
        {
        print ( "\( processorStack.top() )" );
        
        processorStack.pop();
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackAdd()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        temp = temp + processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: temp );
    
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    
    private func stackSub()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        temp = temp - processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: temp );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackMul()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        temp = temp * processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: temp );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
    
    private func stackDiv()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        temp = temp / processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: temp );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackSin()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: sin ( temp ) );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackCos()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: cos ( temp ) );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackSqrt()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: sqrt ( temp ) );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackAbs()
        {
        var temp: Double = 0;
        
        temp = processorStack.top();
        processorStack.pop();
        
        processorStack.push ( valueToPush: abs ( temp ) );
    
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackDup()
        {
        processorStack.push ( valueToPush: processorStack.top() );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    private func stackDump()
        {
        /////////   WHERE IS MY DUUUUUUUUUUUMP??
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
//    private func stackPopS()
//        {
//        processorStack.pop();
//        
//        currentMemoryCell = currentMemoryCell + 2;
//        }
    
    private func stackIn()
        {
        var temp: Double = Double ( readLine() )!;
        
        processorStack.push ( valueToPush: temp );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    
        
    
    
    };






















