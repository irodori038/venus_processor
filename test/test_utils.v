task check_value32;
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

