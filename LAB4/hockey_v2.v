module hockey(

    input clk,
    input rst,
    
    input BTN_A,
    input BTN_B,
    
    input [1:0] DIR_A,
    input [1:0] DIR_B,
    
    input [2:0] Y_in_A,
    input [2:0] Y_in_B,
   
	
	output reg [2:0] X_COORD,
	output reg [2:0] Y_COORD


    );

    wire [1:0] combined_button;

    parameter
        IDLE = 4'b0000, //0th state
        DISP = 4'b0001, //1st state
        HIT_B = 4'b0010, //2nd state
        HIT_A = 4'b0011, //3rd state
        SEND_A = 4'b0100, //4th state
        SEND_B = 4'b0101, //5th state
        RESP_A = 4'b0110, //6th state
        RESP_B = 4'b0111, //7th state
        GOAL_A = 4'b1000, //8th state
        GOAL_B = 4'b1001, //9th state
        TheEnd = 4'b1010; //10th state

    assign combined_button = {BTN_A, BTN_B};

    reg [3:0] states;
    reg [6:0] counter;

    reg [1:0] dirY;

    reg [1:0] scoreB;
    reg [1:0] scoreA;

    reg [3:0] next_state;
    reg turn;


    always @(posedge clk or posedge rst)
    begin

        if (rst) begin

            Y_COORD <= 0;
            X_COORD <= 0;
            counter <= 0;
            turn <= 0;
            scoreA <= 0;
            scoreB <= 0;
            dirY <= 0;
            //combined_button <= 0;


            states <= IDLE;

        end

        else begin
            
            case (states)
                IDLE: begin
                    
                    if (combined_button == 2'b10) begin

                        turn <= 0;
                        next_state <= DISP;

                        
                    end
                    else if (combined_button == 2'b01) begin

                        turn <= 1;
                        next_state <= DISP;
                        
                    end
                    else if ((combined_button == 2'b00) || (combined_button == 2'b11)) begin
                        
                        next_state <= IDLE;

                    end

                end

                DISP: begin

                    if (counter < 100) begin

                        counter <= counter + 1;
                        next_state <= DISP;
                        
                    end
                    else begin
                        
                        counter <= 0;
                        
                        if (turn == 1) begin

                            next_state <= HIT_B;
                            
                        end

                        else begin

                            next_state <= HIT_A;
                            
                        
                        end

                    end

                end

                HIT_B: begin
                    
                    if ((BTN_B == 1) && (Y_in_B < 5)) begin

                        X_COORD <= 4;
                        Y_COORD <= Y_in_B;
                        dirY <= DIR_B;

                        next_state <= SEND_A;
                        
                    end

                    else begin

                        next_state <= HIT_B;
                        
                    end
                end

                HIT_A: begin
                    
                    if ((BTN_A == 1) && (Y_in_A < 5)) begin

                        X_COORD <= 0;
                        Y_COORD <= Y_in_A;
                        dirY <= DIR_A;

                        next_state <= SEND_B;
                        
                    end

                    else begin

                        next_state <= HIT_A;
                        
                    end

                end

                SEND_A: begin
                    
                    if (counter < 100) begin

                        counter <= counter + 1;

                        next_state <= SEND_A;
                        
                    end

                    else begin
                        
                        counter <= 0;

                        if (dirY == 2'b10) begin

                            if (Y_COORD == 0) begin

                                dirY <= 2'b01;
                                Y_COORD <= Y_COORD + 1;

                                if (X_COORD > 1) begin

                                    X_COORD <= X_COORD - 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 0;
                                    
                                    next_state <= RESP_A;

                                end
                                
                            end

                            else begin

                                Y_COORD <= Y_COORD - 1;

                                if (X_COORD > 1) begin

                                    X_COORD <= X_COORD - 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 0;
                                    
                                    next_state <= RESP_A;

                                end
                                

                            end
                            
                        end

                        else if (dirY == 2'b01) begin

                            if (Y_COORD == 4) begin

                                dirY <= 2'b10;
                                Y_COORD <= Y_COORD - 1;

                                if (X_COORD > 1) begin

                                    X_COORD <= X_COORD - 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 0;
                                    
                                    next_state <= RESP_A;

                                end

                                
                            end

                            else begin

                                Y_COORD <= Y_COORD + 1;

                                if (X_COORD > 1) begin

                                    X_COORD <= X_COORD - 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 0;
                                    
                                    next_state <= RESP_A;

                                end
                                

                            end
                            
                        end

                        else if (dirY == 2'b00) begin

                            if (X_COORD > 1) begin

                                X_COORD <= X_COORD - 1;

                                next_state <= SEND_A;
                                
                            end

                            else begin
                                
                                X_COORD <= 0;
                                
                                next_state <= RESP_A;

                            end
                            
                        end

                    end

                end


                SEND_B: begin
                    
                    if (counter < 100) begin

                        counter <= counter + 1;

                        next_state <= SEND_B;
                        
                    end

                    else begin
                        
                        counter <= 0;

                        if (dirY == 2'b10) begin

                            if (Y_COORD == 0) begin

                                dirY <= 2'b01;
                                Y_COORD <= Y_COORD + 1;

                                if (X_COORD < 3) begin

                                    X_COORD <= X_COORD + 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 4;

                                    next_state <= RESP_B;

                                end

                                
                                
                            end

                            else begin

                                Y_COORD <= Y_COORD - 1;

                                if (X_COORD < 3) begin

                                    X_COORD <= X_COORD + 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 4;

                                    next_state <= RESP_B;

                                end

                                
                                

                            end
                            
                        end

                        else if (dirY == 2'b01) begin

                            if (Y_COORD == 4) begin

                                dirY <= 2'b10;
                                Y_COORD <= Y_COORD - 1;

                                if (X_COORD < 3) begin

                                    X_COORD <= X_COORD + 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 4;

                                    next_state <= RESP_B;

                                end

                                

                                
                            end

                            else begin

                                Y_COORD <= Y_COORD + 1;

                                if (X_COORD < 3) begin

                                    X_COORD <= X_COORD + 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    X_COORD <= 4;

                                    next_state <= RESP_B;

                                end

                                
                                

                            end
                            
                        end

                        else if (dirY == 2'b00) begin

                            if (X_COORD < 3) begin

                                X_COORD <= X_COORD + 1;

                                next_state <= SEND_B;
                                
                            end

                            else begin
                                
                                X_COORD <= 4;

                                next_state <= RESP_B;

                            end

                        end

                    end

                end

                RESP_A: begin
                    
                    if (counter < 100) begin

                        if ((BTN_A == 1) && (Y_COORD == Y_in_A)) begin

                            X_COORD <= 1;
                            counter <= 0;

                            if (DIR_B == 2'b10) begin

                                if (Y_COORD == 0) begin

                                    dirY <= 2'b01;
                                    Y_COORD <= Y_COORD + 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    dirY <= DIR_A;
                                    Y_COORD <= Y_COORD - 1;

                                    next_state <= SEND_B;

                                end
                                
                            end

                            else if (DIR_B == 2'b01) begin

                                if (Y_COORD == 4) begin

                                    dirY <= 2'b10;
                                    Y_COORD <= Y_COORD - 1;

                                    next_state <= SEND_B;
                                    
                                end

                                else begin
                                    
                                    dirY <= DIR_A;
                                    Y_COORD <= Y_COORD + 1;

                                    next_state <= SEND_B;

                                end
                                
                            end

                            else if (DIR_B == 2'b00) begin

                                dirY <= DIR_B;

                                next_state <= SEND_B;
                                
                            end


                        end

                        else begin
                            
                            counter <= counter + 1;

                            next_state <= RESP_A;


                        end
                        
                    end

                    else begin
                        
                        counter <= 0;
                        scoreB <= scoreB + 1;

                        next_state <= GOAL_B;
                    end

                end


                RESP_B: begin

                    if (counter < 100) begin

                        if ((BTN_B == 1) && (Y_COORD == Y_in_B)) begin

                            X_COORD <= 3;
                            counter <= 0;

                            if (DIR_A == 2'b10) begin

                                if (Y_COORD == 0) begin

                                    dirY <= 2'b01;
                                    Y_COORD <= Y_COORD + 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    dirY <= DIR_B;
                                    Y_COORD <= Y_COORD - 1;

                                    next_state <= SEND_A;

                                end
                                
                            end

                            else if (DIR_A == 2'b01) begin

                                if (Y_COORD == 4) begin

                                    dirY <= 2'b10;
                                    Y_COORD <= Y_COORD - 1;

                                    next_state <= SEND_A;
                                    
                                end

                                else begin
                                    
                                    dirY <= DIR_B;
                                    Y_COORD <= Y_COORD + 1;

                                    next_state <= SEND_A;

                                end
                                
                            end

                            else if (DIR_A == 2'b00) begin

                                dirY <= DIR_A;

                                next_state <= SEND_A;
                                
                            end


                        end

                        else begin
                            
                            counter <= counter + 1;

                            next_state <= RESP_B;


                        end
                        
                    end

                    else begin
                        
                        counter <= 0;
                        scoreA <= scoreA + 1;

                        next_state <= GOAL_A;
                    end
                    
                end

                GOAL_A: begin
                    
                    if (counter < 100) begin

                        counter <= counter + 1;

                        next_state <= GOAL_A;
                        
                    end

                    else begin
                        
                        counter <= 0;

                        if (scoreA == 3) begin

                            turn <= 0;
                            next_state <= TheEnd;
                            
                        end

                        else begin
                            
                            next_state <= HIT_B;

                        end


                    end

                end


                GOAL_B: begin
                    
                    if (counter < 100) begin

                        counter <= counter + 1;

                        next_state <= GOAL_B;
                        
                    end

                    else begin
                        
                        counter <= 0;

                        if (scoreB == 3) begin

                            turn <= 1;

                            next_state <= TheEnd;
                            
                        end

                        else begin
                            
                            next_state <= HIT_A;

                        end

                    end 

                end

                TheEnd: begin
                    
                    next_state <= TheEnd;

                end

            endcase

            states <= next_state;

        end

    end
    
endmodule
