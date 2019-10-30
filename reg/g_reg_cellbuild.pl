#!/usr/bin/perl

for ($i = 0; $i <= 15; $i++) {
  printf("  g_reg_cell r%x (\n", $i);
  print("    .data_i(result_i),\n");
  printf("    .data_o(data%x),\n", $i);
  printf("    .w_reserve_i(w_reserve[%d]),\n", $i);
  printf("    .w_reserve_o(w_reserved[%d]),\n", $i);
  printf("    .wb_r(wb_r[%d])\n", $i);
  print("  );\n\n");
}
