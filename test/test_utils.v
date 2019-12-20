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
    $display("+---+----------+");
    $display("|reg|  value   |");
    $display("+---+----------+");
    $write("| 0 |");
    $display(" %h |", core0.id0.register.r0.data_o);
    $write("| 1 |");
    $display(" %h |", core0.id0.register.r1.data_o);
    $write("| 2 |");
    $display(" %h |", core0.id0.register.r2.data_o);
    $write("| 3 |");
    $display(" %h |", core0.id0.register.r3.data_o);
    $write("| 4 |");
    $display(" %h |", core0.id0.register.r4.data_o);
    $write("| 5 |");
    $display(" %h |", core0.id0.register.r5.data_o);
    $write("| 6 |");
    $display(" %h |", core0.id0.register.r6.data_o);
    $write("| 7 |");
    $display(" %h |", core0.id0.register.r7.data_o);
    $write("| 8 |");
    $display(" %h |", core0.id0.register.r8.data_o);
    $write("| 9 |");
    $display(" %h |", core0.id0.register.r9.data_o);
    $write("| a |");
    $display(" %h |", core0.id0.register.ra.data_o);
    $write("| b |");
    $display(" %h |", core0.id0.register.rb.data_o);
    $write("| c |");
    $display(" %h |", core0.id0.register.rc.data_o);
    $write("| d |");
    $display(" %h |", core0.id0.register.rd.data_o);
    $write("| e |");
    $display(" %h |", core0.id0.register.re.data_o);
    $write("| f |");
    $display(" %h |", core0.id0.register.rf.data_o);
    $display("+---+----------+");
  end
endtask
