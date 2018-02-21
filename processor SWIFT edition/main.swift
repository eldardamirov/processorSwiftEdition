//
//  main.swift
//  processor SWIFT edition
//
//  Created by Эльдар Дамиров on 10.02.2018.
//  Copyright © 2018 Эльдар Дамиров. All rights reserved.
//

import Foundation

 

//print ( fromStringToNumber ( number: "6" ) + 5 );


var humanCode: String = 
"""
push 1500
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

var myCompiler = Compiler ( storage: humanCode );


print ( "GOH" );
