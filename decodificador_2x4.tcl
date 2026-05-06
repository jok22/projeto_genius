TITLE "Decodificador 2 para 4";

SUBDESIGN decodificador_2x4
(
    a0, a1         : INPUT;
    d0, d1, d2, d3 : OUTPUT;
)
BEGIN
    -- O operador "!" representa a porta NOT (inversor)
    -- O operador "&" representa a porta AND
    
    d0 = !a0 & !a1;  -- d0 é 1 quando a0=0 e a1=0
    d1 =  a0 & !a1;  -- d1 é 1 quando a0=1 e a1=0
    d2 = !a0 &  a1;  -- d2 é 1 quando a0=0 e a1=1
    d3 =  a0 &  a1;  -- d3 é 1 quando a0=1 e a1=1
END;
