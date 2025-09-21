module alu_tb;

  parameter BW = 16; // bitwidth

  logic signed [BW-1:0] in_a;
  logic signed [BW-1:0] in_b;
  logic        [2:0] opcode;
  logic signed [BW:0] out;
  logic        [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );

  // Generate stimuli to test the ALU
  initial begin
    in_a = '0;
    in_b = '0;
    opcode = '0;
    #10ns;
    $display("a\t b\t opcode\t out\t flags");
    for(int i=0; i<10; i++) begin
      in_a=$urandom_range(-2**(BW-1), 2**(BW-1)-1);
      in_b=$urandom_range(-2**(BW-1), 2**(BW-1)-1);
      opcode=$urandom_range(0,7);
      #10
      $display("%d\t%d\t%b\t%d\t%b", in_a, in_b, opcode, out, flags);
    end
    $finish
  end
endmodule
