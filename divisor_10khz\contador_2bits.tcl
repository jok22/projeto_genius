TITLE "Sistema com Divisor e Contador";

SUBDESIGN divisor_10khz\contador_2bits
(
    clk_in       : INPUT;    -- Clock principal
    q_count[1..0]: OUTPUT;   -- Saídas do contador de 2 bits
)

VARIABLE
    -- Variáveis do Divisor de Clock
    divisor[15..0] : DFF;    -- Registrador para contar pulsos
    clk_dividido   : TFF;    -- Gera a frequência menor
    
    -- Variáveis do Contador de 2 Bits 
    ff_bit0        : TFF;
    ff_bit1        : TFF;

BEGIN
    -------------------------------------------------------
    -- 1. LÓGICA DO DIVISOR (Gera clock de saída)
    -------------------------------------------------------
    divisor[].clk = clk_in;
    clk_dividido.clk = clk_in;

    IF (divisor[].q == 2499) THEN
        divisor[].d = 0;
        clk_dividido.t = VCC;  -- Toggle para criar a borda de clock
    ELSE
        divisor[].d = divisor[].q + 1;
        clk_dividido.t = GND;
    END IF;

    -------------------------------------------------------
    -- 2. LÓGICA DO CONTADOR (Acoplado ao Divisor)
    -------------------------------------------------------
    -- O sinal gerado pelo divisor entra no CLK dos novos FFs
    ff_bit0.clk = clk_dividido.q;
    ff_bit1.clk = clk_dividido.q;

    -- Lógica do primeiro bit (sempre alterna no clock dividido)
    ff_bit0.t    = VCC;
    ff_bit0.prn  = VCC;
    ff_bit0.clrn = VCC;
    
    -- Lógica do segundo bit (alterna quando o primeiro é 1)
    ff_bit1.t    = ff_bit0.q;
    ff_bit1.prn  = VCC;
    ff_bit1.clrn = VCC;

    -------------------------------------------------------
    -- 3. ATRIBUIÇÃO DAS SAÍDAS
    -------------------------------------------------------
    q_count[0] = ff_bit0.q;
    q_count[1] = ff_bit1.q;

END;
