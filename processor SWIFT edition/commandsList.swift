//
//  commandsList.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

enum processorCommands: Int
    {
    case hlt = 0, nullCommand,
    myIn, myOut,  
    add, sub, mul, myDiv,
    mySin, myCos, mySqrt, myAbs,
    myDup, dump, 
    ret,
    borderJump,
    jmp, je, jne, ja, jae, jb, jbe, call,
    borderArgument, 
    pushR, popR, // I don't think that it is really important;
    pop,
    pushS, popS, // I don't think that it is really important;
    pushRAM, popRAM, // I don't think that it is really important;
    push
    }


let registerQuantity: Int = 11;

enum registers: Int
    {
    case ax = 0, bx, cx, dx,
    r1, r2, r3, r4,
    n1, n2, nS
    }


// -------------------------------------------- PROCESSOR HUMAN CODE COMMANDS --------------------------------------------

let haultCommandHuman = "hlt";

let pushCommandHuman = "push";
let popCommandHuman = "pop";

let inputFromKeyboardCommandHuman = "in";
let outputCommandHuman = "out";

let additionCommandHuman = "add";
let substituteCommandHuman = "sub";
let multiplicationCommandHuman = "mul";
let divisionCommandHuman = "div";

let sinusCommandHuman = "sin";
let cosinusCommandHuman = "cos";
let squareRootCommandHuman = "sqrt";
let moduleCommandHuman = "abs";

let duplicationCommandHuman = "dup";
let dumpCommandHuman = "dump";

let jmpCommandHuman = "jmp";
let jeCommandHuman = "je";
let jneCommandHuman = "jne";
let jaCommandHuman = "ja";
let jaeCommandHuman = "jae";
let jbCommandHuman = "jb";
let jbeCommandHuman = "jbe";

let callCommandHuman = "call";
let returnCommandHuman = "ret";

// ----------------------------------------------------------------------------------------



var zero: Int = Int ( "0" )!;








 
