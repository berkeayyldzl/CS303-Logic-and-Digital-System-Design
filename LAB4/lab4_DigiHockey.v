
module DigiHockey(
    input clk, 
    input rst,
    input START,
    input [1:0] DIRECTION,
    input [2:0] INIT_Y_POS,
    output reg [2:0] X_COORD,
    output reg [2:0] Y_COORD);

    reg isMovingRight;
    reg [1:0] isMovingUp;

    reg started;
    reg [1:0] direction_reg;

    always @(posedge clk or posedge rst) begin

        if (rst) begin

            Y_COORD <= 0;
            X_COORD <= 0;
            isMovingRight <= 1'b1; // 1 means right
            isMovingUp <= 2'b10;
            direction_reg <= 0;

        end

        else if(START) begin
            Y_COORD <= INIT_Y_POS;
            started <= 1'b1;

            if(DIRECTION == 2'b01) begin
                isMovingUp <= 2'b01;
            end
            else if(DIRECTION == 2'b10) begin
                isMovingUp <= 2'b00;
            end
            else if(DIRECTION == 2'b00) begin
                isMovingUp <= 2'b10;
            end
            
        end

        else begin

            if (started) begin

                if (isMovingRight) begin //starts with moving right

                    if (X_COORD == 4) begin //right wall
                        
                        X_COORD <= X_COORD - 1; 

                        isMovingRight <= 1'b0; // direction is now left
                    end 

                    else begin //if not hit a wall, continue as planned
                        
                        X_COORD <= X_COORD + 1;
                    end
                end
                
                else begin

                    if (X_COORD == 0) begin //left wall
                        
                        X_COORD <= X_COORD + 1;

                        isMovingRight <= 1'b1; // direction is now right

                    end 
                    
                    else begin //if not hit a wall,continue as planned
                        
                        X_COORD <= X_COORD - 1;

                    end

                end

                case(isMovingUp) //for the up movement

                2'b01: begin // up
                    if ((X_COORD == 4 && Y_COORD == 4)) begin //right top 

                        X_COORD <= X_COORD - 1;
                        Y_COORD <= Y_COORD - 1;
                        isMovingUp <= 2'b00; // goes down
                        isMovingRight <= 1'b0; // goes left
    
                    end
                    else if ((X_COORD == 0 && Y_COORD == 4)) begin //left top
                    
                        X_COORD <= X_COORD + 1;
                        Y_COORD <= Y_COORD - 1;
                        isMovingUp <= 2'b00; // goes down
                        isMovingRight <= 1'b1; // goes right
                    end
                    else if (Y_COORD == 4) begin //top wall
                        
                        Y_COORD <= Y_COORD - 1;
                        isMovingUp <= 2'b00; // change direction to down
                        
                    end else

                        Y_COORD <= Y_COORD + 1;
                end

                2'b00: begin // down
                    if ((X_COORD == 4 && Y_COORD == 0)) begin //right bottom
                    
                        X_COORD <= X_COORD - 1;
                        Y_COORD <= Y_COORD + 1;
                        isMovingUp <= 2'b01; // goes up
                        isMovingRight <= 1'b0; // goes left
                    end
                    else if ((X_COORD == 0 && Y_COORD == 0)) begin //left bottom
                    
                        X_COORD <= X_COORD + 1;
                        Y_COORD <= Y_COORD + 1;
                        isMovingUp <= 2'b01; // goes down
                        isMovingRight <= 1'b1; // goes right
                    end
                    else if (Y_COORD == 0) begin //down wall
                        
                        Y_COORD <= Y_COORD + 1;
                        isMovingUp <= 2'b01; // change direction to up

                    end else

                        Y_COORD <= Y_COORD - 1;
                end
                2'b10: begin // down

                    if (Y_COORD == 0) begin //down wall
                        
                        Y_COORD <= Y_COORD ;
                        isMovingUp <= 2'b10; // change direction to up

                    end else

                        Y_COORD <= Y_COORD;
                end

                endcase 
                

                 

                

                

                

            end
            
        end

    end

endmodule

