`include "core_struct.vh"
module ALU (
  input  CorePack::data_t a,
  input  CorePack::data_t b,
  input  CorePack::alu_op_enum  alu_op,
  output CorePack::data_t res
);

  import CorePack::*;

  // fill your code
  always_comb begin
    case (alu_op)
      // 1 ADD 
      ALU_ADD:   res = a + b;

      // 2 SUB
      ALU_SUB:   res = a - b;
    
      // 3 AND
      ALU_AND:   res = a & b;

      // 4 OR
      ALU_OR:    res = a | b;

      // 5 XOR
      ALU_XOR:   res = a ^ b;

      // 6 SLT
      ALU_SLT:   res = $signed(a) < $signed(b) ? 64'd1 : 64'd0; //有符号比较，如果 a < b，输出64位的十进制的1，否则输出0

      // 7 SLTU    
      ALU_SLTU:  res = a < b ? 64'd1 : 64'd0;                   //无符号比较 set if less than

      // 8 SLL
      ALU_SLL:   res = a << b[5:0];                             //逻辑左移，res = a << b[5:0] ，只取移位数的低6位
        
      // 9 SRL
      ALU_SRL:   res = a >> b[5:0];                             //逻辑右移，无符号右移
    
      // 10 SRA
      ALU_SRA:   res = $signed(a) >>> b[5:0];                   //算术右移>>>，保持符号位，符号扩展
    
      // 11 ADDW
      ALU_ADDW: begin                                           //32位加法，结果符号扩展到64位
        logic [31:0] temp;
        temp = $signed(a[31:0]) + $signed(b[31:0]);
        res = {{32{temp[31]}}, temp};
      end
        
      // 12 SUBW  
      ALU_SUBW: begin                                           //32位减法，结果符号扩展到64位
        logic [31:0] temp;
        temp = $signed(a[31:0]) - $signed(b[31:0]);
        res = {{32{temp[31]}}, temp};
      end
    
      // 13 SLLW
      ALU_SLLW: begin                                           //对低32位进行逻辑移位操作，然后符号扩展
        logic [31:0] temp;
        temp = a[31:0] << b[4:0];
        res = {{32{temp[31]}}, temp};
      end
    
      //14 SRLW
      ALU_SRLW: begin
        logic [31:0] temp;
        temp = a[31:0] >> b[4:0];
        res = {{32{temp[31]}}, temp};
      end
        
      // 15 SRAW    
      ALU_SRAW: begin
        logic [31:0] temp;
        temp = $signed(a[31:0]) >>> b[4:0];
        res = {{32{temp[31]}}, temp};
      end
      
      // 16 ALU_DEFAULT
      ALU_DEFAULT: begin
        res = 64'd0;
      end

    endcase
  end

endmodule