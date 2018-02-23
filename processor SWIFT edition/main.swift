//
//  main.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

 

//print ( fromStringToNumber ( number: "6" ) + 5 );


//var humanCode: String = 
//"""
//func1
//push 1.5626268
//dup
//add
//out
//ret
//push 10
//pop [0]
//push [0]
//push [0]
//add
//out
//call func1
//push 5
//pop ax
//push 10
//pop bx
//push 14839.8433759492
//pop [ax+bx]
//hlt
//""";




//var humanCode: String = 
//"""
//push 1
//out
//hlt
//""";

//var humanCode: String = 
//"""
//push 1500
//pop r1
//mark1
//push 1
//out
//jmp mark1
//hlt
//"""; 


//var humanCode =
//"""
//push 1
//pop r1
//push 1
//pop r2
//mark1
//push r1
//push r2
//add
//dup
//out
//push r2
//pop r1
//pop r2
//jmp mark1
//hlt
//""";


//var timeBegin = Date().timeIntervalSince1970;

var humanCode = 
"""
push 150
pop r1
push 0
pop r2
push 1
pop r3
push 1
dup
pop ax
dup
push 1
dup
mark1
dup
pop bx
add
dup
out
pop cx
push bx
push cx
push r1
push r2
push r3
add
dup
pop r2
jb mark1
hlt
""";


var machineCode: String = "";

//var myCompiler = Compiler ( storage: humanCode );
var myCompiler = Compiler ( storage: humanCode, machineCodeTemp: &machineCode )

//var machineCode: String = 
//"""
//274859
//32 6 1.5626268
//12 -1
//4 -1
//3 -1
//14 -1
//32 6 10
//27 0 0
//32 0 0
//32 0 0
//4 -1
//3 -1
//23 -1.000000
//23 -1.000000
//23 -1.000000
//23 -1.000000
//23 -1.000000
//23 -1.000000
//23 -1.000000
//32 6 5
//27 7 0.000000
//32 6 10
//27 7 1.000000
//32 6 14839.8433759492
//27 3 0.000000 1.000000
//0 -1
//""";


print ( "HAHAHAHAHA: \( myCompiler.getMachineCode () )" );
var timeBegin = Date().timeIntervalSince1970;

var myProcessor = Processor ( storage: myCompiler.getMachineCode (), ramSize: 1024 );


print ( "FINAL FINAL TIME: \( Date().timeIntervalSince1970 - timeBegin )" );
