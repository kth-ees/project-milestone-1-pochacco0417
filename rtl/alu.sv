module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic signed [BW-1:0] in_a,
  input  logic signed [BW-1:0] in_b,
  input  logic        [2:0] opcode,
  output logic signed [BW:0] out,
  output logic        [2:0] flags // {overflow, negative, zero}
  );

  always_comb begin
    out='0;
    case (opcode)
      3'b000: out=in_a+in_b;
      3'b001: out=in_a-in_b //out=in_a+(~in_b+1'b1);
      3'b010: out=in_a&in_b;
      3'b011: out=in_a|in_b;
      3'b100: out=in_a^in_b;
      3'b101: out=in_a+1;
      3'b110: out=in_a;
      3'b111: out=in_b;
      default: out='0;
    endcase
  end

  always_comb begin
    flags[2]=1'b0;
    if(opcode==3'b000) begin
      if((in_a[BW-1]&in_b[BW-1]&~out[BW-1])|(~in_a[BW-1]&~in_b[BW-1]&out[BW-1]))
        flags[2]=1'b1;
    end else if(opcode==3'b001) begin
      if((in_a[BW-1]&~in_b[BW-1]&~out[BW-1])|(~in_a[BW-1]&in_b[BW-1]&out[BW-1]))
        flags[2]=1'b1;
    end
  end

  assign flags[1]=out[BW];
  assign flags[0]=~|out;      

endmodule




