%--------------------------------------------------------------------------
%By: Duleepa J Thrimawithana
%Date: 13-06-2019
%Description:
%This program is written to calculate the THD of Vpi 
%generated by a full-bridge converter
%--------------------------------------------------------------------------

function [] = IPTDesign( )

Vin = 400;
Qpt = 400;
Lpt = 18.73e-6; %Initial value but scalled N^2
Vout = 200; 
Qst = 200;
Lst = 18.73e-6;     %Initial value but scalled N^2

k = 0.1;
fs = 85e3;
Po = 2e3;

ws=2*pi*fs;

VApt = Po*sqrt(Qpt/Qst)/k
VAst = VApt*Qst/Qpt

MaxEff = (k-1/sqrt(Qpt*Qst))/(k+1/sqrt(Qpt*Qst))

Ipt = sqrt(VApt/(ws*Lpt));

if Ipt > Vin/(ws*Lpt)
    Lpteq = Vin/(ws*Ipt)
    Lpi = Lpteq
    Cpt = 1/(ws^2*Lpi)
    Cpi = 1/(ws^2*(Lpt-Lpteq))
end

Ist = sqrt(VAst/(ws*Lst));

if Ist > Vout/(ws*Lst)
    Lsteq = Vout/(ws*Ist)
    Lsi = Lsteq
    Cst = 1/(ws^2*Lsi)
    Csi = 1/(ws^2*(Lst-Lsteq))
end