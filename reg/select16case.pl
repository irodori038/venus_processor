#!/usr/bin/perl

for ($i = 0 ; $i <= 15 ; $i++){
    $num = substr(unpack(B8,  pack(C, $i)),4,4);
    print ("        4'b", $num, ": select16 = data");
    print (sprintf("%x",$i), ";\n");
}
