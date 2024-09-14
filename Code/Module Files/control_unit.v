`timescale 1ns / 1ps

//Kumail Hossieni
//18-08-2024

module control_unit (
    input wire clk,
    input wire [7:0] userinput,
    
    output reg ram_rd,
    output reg ram_wr,
    output reg [3:0] addr,
    output reg [7:0] ram_data_out,
    input wire [7:0] ram_data_in,
    
    output reg [7:0] alu_a,
    output reg [7:0] alu_b,
    output reg [1:0] alu_opcode,
    input wire [7:0] alu_result,
    
    output reg [7:0] reg0,  
    output reg [7:0] reg1,
    output reg [7:0] reg2,
    output reg [7:0] reg3    
);   
    reg [7:0] register [3:0];   // 4 1-byte internal registers
    
    reg [1:0] alu_state;        //Records ALU states for clock timing purposes        
    localparam ALU_IDLE = 2'b00, ALU_EXECUTE = 2'b01, ALU_RESULT = 2'b10;
    
    reg [1:0] load_state;       //Records load operations states for clock timing purposes
    localparam LOAD_IDLE = 2'b00, LOAD_WAIT = 2'b01, LOAD_EXECUTE = 2'b10;
    
    reg store_state;            //Records store operations states for for clock timing purposes
    localparam STORE_IDLE = 1'b0, STORE_FINISH = 1'b1;
        
    initial begin   //initial simulation values and states
        ram_wr = 1'b0;
        ram_rd = 1'b0;
        register[0] = 8'b0000_0000;
        register[1] = 8'b0101_0101;
        register[2] = 8'b1010_1010;
        register[3] = 8'b0000_1111;
        alu_state <= ALU_IDLE;
        load_state <= LOAD_IDLE;                
    end
    
    always @(posedge clk) begin
        case (alu_state)
            ALU_IDLE:   begin                                  
                if ( userinput[7:6] == 2'b00 ) begin        //Start ALU operation
                    ram_rd <= 1'b0;
                    ram_wr <= 1'b0;
                                                                    
                    alu_opcode <= userinput[5:4];
                    alu_a <= register[ userinput[3:2] ];
                    alu_b <= register[ userinput[1:0] ];
                        
                    alu_state <= ALU_EXECUTE;               //Proceed to next state                                                                                    
                end
            end
                   
            ALU_EXECUTE: begin                
                alu_state <= ALU_RESULT;                    //Wait 1 clock cycle for ALU operation to yield result
            end
            
            ALU_RESULT: begin                               //Set ALU output to first register in userinput and reset ALU state to idle
                register [ userinput[3:2]] <= alu_result;
                alu_state <= ALU_IDLE;
            end        
            
            default: begin
                alu_state <= ALU_IDLE;                      
            end
            
        endcase
 
        
        if ( userinput[7:6] == 2'b01 ) begin                //Start load operation
            case (load_state)
                LOAD_IDLE: begin                            //First cycle
                    ram_wr <= 1'b0;
                    ram_rd <= 1'b1;                         //Set RAM to read
                    addr <= userinput[3:0];                 
                    load_state <= LOAD_WAIT;                //Proceed to next state
                end
                
                LOAD_WAIT: begin                            //Wait 1 clock cycle
                    load_state <= LOAD_EXECUTE;
                end                
                
                LOAD_EXECUTE: begin                         //Load RAM value to register
                    register[ userinput[5:4] ] <= ram_data_in;
                    ram_rd <= 1'b0;                         //Set RAM read back to 0
                    load_state <= LOAD_IDLE;                //Go back to idle state
                end
                
                default: begin                              
                    ram_rd <= 1'b0;
                    ram_wr <= 1'b0;
                    load_state <= LOAD_IDLE;
                end               
            endcase
        end
        
        else if ( userinput[7:6] == 2'b10 ) begin           //Start store operation
            case(store_state)
                STORE_IDLE: begin
                    ram_rd <= 1'b0;
                    ram_wr <= 1'b1;                         //Set RAM to write     
              
                    addr <= userinput[3:0];                                       
                    ram_data_out <= register[ userinput[5:4] ];
                    store_state <= STORE_FINISH;     
                end
                STORE_FINISH: begin                         //set RAM write off and reset store operation state
                    ram_wr <= 1'b0;
                    store_state <= STORE_IDLE;
                end
            endcase
        end
        
        else begin
            ram_rd <= 1'b0;
            ram_wr <= 1'b0;
            load_state <= LOAD_IDLE;
            store_state <= STORE_IDLE;
        end                                      
                                                            //update internal register to output register (simulation purposes
        reg0 = register[0];
        reg1 = register[1];
        reg2 = register[2];
        reg3 = register[3];
    end           
endmodule