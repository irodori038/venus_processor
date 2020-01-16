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
    $display("+------------------+------------------+------------------+------------------+");
    $display("|reg   value   rsv |reg   value   rsv |reg   value   rsv |reg   value   rsv |");
    $display("+------------------+------------------+------------------+------------------+");
    $display("| 0   %h  %b  | 4   %h  %b  | 8   %h  %b  | c   %h  %b  |",
              core0.id0.register.r0.data_o,
              core0.id0.register.r0.w_reserve_o,
              core0.id0.register.r4.data_o,
              core0.id0.register.r4.w_reserve_o,
              core0.id0.register.r8.data_o,
              core0.id0.register.r8.w_reserve_o,
              core0.id0.register.rc.data_o,
              core0.id0.register.rc.w_reserve_o,
            );
    $display("| 1   %h  %b  | 5   %h  %b  | 9   %h  %b  | d   %h  %b  |",
              core0.id0.register.r1.data_o,
              core0.id0.register.r1.w_reserve_o,
              core0.id0.register.r5.data_o,
              core0.id0.register.r5.w_reserve_o,
              core0.id0.register.r9.data_o,
              core0.id0.register.r9.w_reserve_o,
              core0.id0.register.rd.data_o,
              core0.id0.register.rd.w_reserve_o,
            );
    $display("| 2   %h  %b  | 6   %h  %b  | a   %h  %b  | e   %h  %b  |",
              core0.id0.register.r2.data_o,
              core0.id0.register.r2.w_reserve_o,
              core0.id0.register.r6.data_o,
              core0.id0.register.r6.w_reserve_o,
              core0.id0.register.ra.data_o,
              core0.id0.register.ra.w_reserve_o,
              core0.id0.register.re.data_o,
              core0.id0.register.re.w_reserve_o,
            );
    $display("| 3   %h  %b  | 7   %h  %b  | b   %h  %b  | f   %h  %b  |",
              core0.id0.register.r3.data_o,
              core0.id0.register.r3.w_reserve_o,
              core0.id0.register.r7.data_o,
              core0.id0.register.r7.w_reserve_o,
              core0.id0.register.rb.data_o,
              core0.id0.register.rb.w_reserve_o,
              core0.id0.register.rf.data_o,
              core0.id0.register.rf.w_reserve_o,
            );
    $display("+------------------+------------------+------------------+------------------+");
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

task write_args;
  input [31:0] inst;
  begin
    $write(" r%h,", inst[23:20]);
    if (~inst[24]) $write(" r%h", inst[19:16]);
    else $write(" %d", inst[15:0]);
  end
endtask

task display_flags;
  input [5:0] flags_i;
  begin
    $display("+----+----+----+----+----+----+");
    $display("| ZF | PF | NF | CF | OF | UF |");
    $display("+----+----+----+----+----+----+");
    $display(
      "|  %b |  %b |  %b |  %b |  %b |  %b |",
      flags_i[5], flags_i[4], flags_i[3],
      flags_i[2], flags_i[1], flags_i[0],);
    $display("+----+----+----+----+----+----+");
  end
endtask

task display_cc;
  input [2:0] cc;
  begin
    $write("CC: ");
    case (cc)
      3'b000: $display("always (000)");
      3'b001: $display("zero (001)");
      3'b010: $display("positive (010)");
      3'b011: $display("negative (011)");
      3'b100: $display("carry (100)");
      3'b101: $display("overflow (101)");
      default: $display("????? (%b)", cc);
    endcase
  end
endtask

task display_ctrl_line;
  input inte, logic, shift, ld, st, br, immf;
  begin
    $display("+----+----+----+----+----+----+----+");
    $display("| IN | LO | SH | LD | ST | BR | IM |");
    $display("+----+----+----+----+----+----+----+");
    $display(
      "|  %b |  %b |  %b |  %b |  %b |  %b |  %b |",
      inte, logic, shift, ld, st, br, immf
    );
    $display("+----+----+----+----+----+----+----+");
  end
endtask

task dump_data_memory;
  integer [15:0] addr;
  begin
    $display("--- memory dump ---");
    for (addr = 0; addr < 16'ha; addr = addr + 1'h1) begin
      $write("%h: ", addr);
      $display("%h", core0.ex0.ls0.data_mem.mem_bank[addr]);
    end
  end
endtask
