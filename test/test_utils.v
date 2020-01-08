/*task check_value32;
  input [31:0] a, b;
  input string msg;
  begin
    if (a != b) begin
      $display("-----------------------------------------");
      $display("ERROR at %s: %h != %h", msg, a, b);
      dump_values();
    end
  end
endtask

task check_value1;
  input a, b;
  input string msg;
  begin
    if (a != b) begin
      $display("-----------------------------------------");
      $display("ERROR at %s: %b != %b", msg, a, b);
      dump_values();
    end
  end
endtask
*/
task print_regs;
  begin
    $display("+---+----------+---+----------+");
    $display("|reg|  value   |reg|  value   |");
    $display("+---+----------+---+----------+");
    $write("| 0 |");
    $write(" %h ", core0.id0.register.r0.data_o);
    $write("| 8 |");
    $display(" %h |", core0.id0.register.r8.data_o);
    $write("| 1 |");
    $write(" %h ", core0.id0.register.r1.data_o);
    $write("| 9 |");
    $display(" %h |", core0.id0.register.r9.data_o);
    $write("| 2 |");
    $write(" %h ", core0.id0.register.r2.data_o);
    $write("| a |");
    $display(" %h |", core0.id0.register.ra.data_o);
    $write("| 3 |");
    $write(" %h ", core0.id0.register.r3.data_o);
    $write("| b |");
    $display(" %h |", core0.id0.register.rb.data_o);
    $write("| 4 |");
    $write(" %h ", core0.id0.register.r4.data_o);
    $write("| c |");
    $display(" %h |", core0.id0.register.rc.data_o);
    $write("| 5 |");
    $write(" %h ", core0.id0.register.r5.data_o);
    $write("| d |");
    $display(" %h |", core0.id0.register.rd.data_o);
    $write("| 6 |");
    $write(" %h ", core0.id0.register.r6.data_o);
    $write("| e |");
    $display(" %h |", core0.id0.register.re.data_o);
    $write("| 7 |");
    $write(" %h ", core0.id0.register.r7.data_o);
    $write("| f |");
    $display(" %h |", core0.id0.register.rf.data_o);
    $display("+---+----------+---+----------+");
  end
endtask

task print_mnemonic;
  input [6:0] inst_i;
  case (inst_i)
    7'b000_0000: $write("ADDx");
    7'b000_0001: $write("SUBx");
    7'b000_0010: $write("MULx");
    7'b000_0011: $write("DIVx");
    7'b000_0100: $write("CMPx");
    7'b000_0101: $write("ABSx");
    7'b000_0110: $write("ADCx");
    7'b000_0111: $write("SBCx");
    7'b000_1000: $write("SHLx");
    7'b000_1001: $write("SHRx");
    7'b000_1010: $write("ASHx");
    7'b000_1100: $write("ROLx");
    7'b000_1101: $write("RORx");
    7'b001_0000: $write("AND");
    7'b001_0001: $write("OR");
    7'b001_0010: $write("NOT");
    7'b001_0011: $write("XOR");
    7'b001_0110: $write("SETL");
    7'b001_0111: $write("SETH");
    7'b001_1000: $write("LD");
    7'b001_1001: $write("ST");
    7'b001_1100: $write("J");
    7'b001_1101: $write("JA");
    7'b001_1110: $write("NOP");
    7'b001_0111: $write("HLT");
    default: $write("UND");
  endcase
endtask
