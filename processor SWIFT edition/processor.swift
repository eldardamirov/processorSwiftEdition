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
    init ( storage storageTemp: String, ramSize: Int )
        {
        machineCode = FileIO ( inputText: storageTemp );
        
        ram.reserveCapacity ( ramSize ); // magic number;
        for _ in 0..<ramSize
            {
            ram.append ( Double() );
            }
        
        processorStack.boost();
        
        
        for _ in 0..<registerQuantity
            {
            registerArray.append ( Double() );
            }
        
        makeInstructionStack();
        
        controlCommandsDoing();
        }
        
    deinit 
        {
//        print ( "TOTAL AMIGON" );
        }
    
    
    private func controlCommandsDoing() -> Int
        {
        var temp: Int = 0;
        while ( true )
            {
            temp = doCommand();
            if ( ( temp == -9 ) || ( temp == processorCommands.nullCommand.rawValue ) )
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
    
    
    private func clearFromJunk ( _ inputString: String ) -> String
        {        
        if ( inputString [ inputString.index ( before: inputString.endIndex ) ] == "\n" )
            {
            return String ( inputString.prefix ( inputString.count - 1 ) );
            }
        else
            {
            return inputString;
            }
        
        }
    
    
    private func makeInstructionStack() -> Int
        {
        commandsQuantity = machineCode.calculateLinesQuantity();
        
        cellQuantity = fromStringToNumber ( number: clearFromJunk ( machineCode.getTillEndOfLine() ) );
        
        for _ in 0..<( cellQuantity + 5 )
            {
            instructionArray.append ( Double() );
            }
        
        var currentCellTemp: Int = 0;
        
        for _ in 1..<commandsQuantity
            {
            currentCellTemp = currentCellTemp + parseLine ( currentLine: machineCode.getTillEndOfLine(), currentCellTemp: currentCellTemp );
            }
        
        return currentCellTemp;
        }
    
    
    private func parseLine ( currentLine: String, currentCellTemp: Int ) -> Int
        {
        var shift: Int = 0;
        var currentWord: String = "";
        let lineSize: Int = currentLine.count;
        
            let currentLineBeginningIndex: String.Index = currentLine.startIndex;
        
        for currentCharIndex in 0..<lineSize
            {
            if ( currentLine [ currentLine.index ( currentLineBeginningIndex, offsetBy: currentCharIndex ) ] == " " )
                {
                
                if ( currentWord != "" )
                    {
                    instructionArray [ currentCellTemp + shift ] = Double ( currentWord )!;
                    }
                
                shift = shift + 1;
                
                currentWord = "";
                
                }
            else
                {
                currentWord = currentWord + String ( currentLine [ currentLine.index ( currentLineBeginningIndex, offsetBy: currentCharIndex ) ] );
                }
                
            }
        
        if ( currentWord != "" && currentWord != "\n" )
            {
//            instructionArray [ currentCellTemp + shift ] = Double ( clearFromJunk ( currentWord ) )!;
            instructionArray [ currentCellTemp + shift ] = Double ( clearFromJunk ( currentWord ) )!;
            shift = shift + 1;
            }
        
        
        
        return shift;
        }
        
        
        
    private func doCommand() -> Int
        {
            let commandId: Int = Int ( instructionArray [ currentMemoryCell ] ); 
        
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
            case processorCommands.pop.rawValue:
                do {
                    let operandaModifier = instructionArray [ currentMemoryCell + 1 ]
                
                    returnState = popMe ( operandaModifier: Int ( operandaModifier ) );
                }
            case processorCommands.push.rawValue:
                do {
                    let operandaModifier = self.instructionArray [ currentMemoryCell + 1 ];
                
                returnState = pushMe ( operandaModifier: Int ( operandaModifier ) );
                }
            case processorCommands.myIn.rawValue:
                do {
                stackIn();
                
                returnState = 0;
                }
            case processorCommands.call.rawValue:
                do {
                functionBaskMarksStack.push ( valueToPush: ( currentMemoryCell + 2 ) );
                currentMemoryCell = Int ( instructionArray [ currentMemoryCell + 1 ] + 1 );
                
                returnState = 0;
                }
            case processorCommands.jmp.rawValue:
                do {
                currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                
                returnState = 0;
                }
            case processorCommands.je.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                        let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                        let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    if ( first == second )
                        {
                        currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
                returnState = 0;
                }
            case processorCommands.jne.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                        let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                        let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    print ( "IT IS JNE: first \( first ) and second \( second )" );
                    
                    if ( first != second )
                        {
                        print ( "CURRENT MEMCELL BEFORE: \( currentMemoryCell )" );
                        currentMemoryCell = Int ( instructionArray [ currentMemoryCell + 1 ] + 1 );
                        print ( "CURRENT MEMCELL AFTER: \( currentMemoryCell )" );
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
                returnState = 0;
                }
            case processorCommands.ja.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                        let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                        let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    if ( first > second )
                        {
                        currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
                returnState = 0;
                }
            case processorCommands.jae.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                        let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                        let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    if ( first >= second )
                        {
                        currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
                returnState = 0;
                }
            case processorCommands.jb.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                        let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                        let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    if ( first < second )
                        {
                        currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
                returnState = 0;
                }
            case processorCommands.jbe.rawValue:
                do {
                if ( self.processorStack.size() >= 2 )
                    {
                    let first: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    let second: Double = self.processorStack.top();
                    self.processorStack.pop();
                    
                    if ( first <= second )
                        {
                        currentMemoryCell = Int(instructionArray [ currentMemoryCell + 1 ] + 1);
                        returnState = 0;
                        }
        
                    }
                else
                    {
                    self.currentMemoryCell = currentMemoryCell + 2;
                    }
                        
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
            
            
            default:
                do {
                returnState = -7;
                }
        
            }
        
        return returnState;
        }
        
    
    

    private func pushMe ( operandaModifier: Int ) -> Int
        {
        if ( operandaModifier == 0 )
            {
            processorStack.push ( valueToPush: ram [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] );

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }
        
        if ( operandaModifier == 1 )
            {
                processorStack.push ( valueToPush: ram [ Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) ] );

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }
        
        if ( operandaModifier == 2 )
            {
                processorStack.push ( valueToPush: ram [ Int ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) + Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] ) ) ] );

            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == 3 )
            {
            // processorStack.push ( ram [ Int ( registerArray [ Int ( Int ( instructionArray [  ] )! )! ] )! ] )
                processorStack.push ( valueToPush: ram [ Int ( ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) + Int ( instructionArray [ currentMemoryCell + 3 ] ) ) ) ] );

            currentMemoryCell = currentMemoryCell + 4;
            return 0;     
            }

        if ( operandaModifier == 4 )
            {
            let tempIndex1: Int = Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] );
            let tempIndex2: Int = Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] );
//            processorStack.push ( valueToPush: ram [ Int ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) - Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] )! )! ] );
            processorStack.push ( valueToPush: ram [ Int ( tempIndex1 - tempIndex2 ) ] );
            
            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == 5 )
            {
            processorStack.push ( valueToPush: ram [ Int ( ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) + Int ( instructionArray [ currentMemoryCell + 3 ] ) ) ) ] );

            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == 6 )
            {
            processorStack.push ( valueToPush: instructionArray [ currentMemoryCell + 2 ] );

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }
        
        if ( operandaModifier == 7 )
            {
                processorStack.push ( valueToPush: registerArray [ Int ( instructionArray [ Int ( currentMemoryCell + 2 ) ] ) ] );

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }

        return -1;
        }


    private func popMe ( operandaModifier: Int ) -> Int
        {
        if ( operandaModifier == 0 )
            {
            ram [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] = processorStack.top();
            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }
        
        if ( operandaModifier == 1 )
            {
//            ram [ Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ) ] ) ] = processorStack.top();
            ram [ Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) ] = processorStack.top();
            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }
        
        if ( operandaModifier == 2 )
            {
            // processorStack.push ( ram [ Int ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] )! + Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] )! )! ] );
            ram [ Int ( ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) + Int ( instructionArray [ currentMemoryCell + 3 ] ) ) ) ] = processorStack.top();
            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == 3 )
            {
            let tempIndex1: Int = Int ( instructionArray [ currentMemoryCell + 2 ] );
            let tempIndex2: Int = Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] );
            
            // processorStack.push ( ram [ Int ( registerArray [ Int ( Int ( instructionArray [  ] )! )! ] )! ] )
            // processorStack.push ( ram [ Int ( ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] )! + Int ( instructionArray [ currentMemoryCell + 3 ] )! ) )! ] );
//            ram [ Int ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) + Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] )! )! ] = processorStack.top();

            ram [ Int ( Int ( registerArray [ tempIndex1 ] ) + tempIndex2 ) ] = processorStack.top();

            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 4;
            return 0;     
            }

        if ( operandaModifier == 4 )
            {
            ram [ Int ( ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) - Int ( instructionArray [ currentMemoryCell + 3 ] ) ) )] = processorStack.top();
            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == 5 )
            {
            let tempIndex1: Int = Int ( instructionArray [ currentMemoryCell + 2 ] );
            let tempIndex2: Int = Int ( instructionArray [ currentMemoryCell + 2 ] );
            
//            ram [ Int ( Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 2 ] ) ] ) - Int ( registerArray [ Int ( instructionArray [ currentMemoryCell + 3 ] ) ] )! )! ] = processorStack.top();
            ram [ Int ( Int ( registerArray [ tempIndex1 ] ) - tempIndex2 ) ] = processorStack.top();


            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 4;
            return 0;
            }

        if ( operandaModifier == -1 )
            {
            processorStack.pop()

            currentMemoryCell = currentMemoryCell + 2;
            return 0;
            }
        
        if ( operandaModifier == 7 )
            {
            registerArray [ Int ( instructionArray [ Int ( currentMemoryCell + 2 ) ] ) ] = processorStack.top();
            processorStack.pop();

            currentMemoryCell = currentMemoryCell + 3;
            return 0;
            }

        return -1;
        }
        
        
        
    private func stackOut() 
        {
        print ( "OUT: \( processorStack.top() )" );
        
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
        var temp: String = readLine()!;
        
        processorStack.push ( valueToPush: Double ( temp )! );
        
        currentMemoryCell = currentMemoryCell + 2;
        }
        
    
        
    
    
    };






















