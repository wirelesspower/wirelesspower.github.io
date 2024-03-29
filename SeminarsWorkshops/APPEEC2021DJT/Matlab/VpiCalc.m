%--------------------------------------------------------------------------
%By: Duleepa J Thrimawithana
%Date: 19-05-2019
%Description:
%This program is written to calculate the THD of Vpi 
%generated by a full-bridge converter
%--------------------------------------------------------------------------

function [] = VpiCalc( )

Vdc = 400;    %DC supply voltage
fsw = 85e3;   %Frequency of the fundamental component of Vpi 
Php = pi/2;
Ts = [0:0.01:2]/fsw; %Time series for 2 periods
Vpi = 0;
THD = [];
THD_alt = [];

for n=1:2:30
    Vpi = Vpi + (Vdc*4/pi)*(cos(n*2*pi*fsw.*Ts)*sin(n*Php/2))/n;
end

PhpAry = pi/2:pi/100:pi;

for Php = PhpAry
    
    Vpi_dis2 = 0;
    
    for n=3:2:100
        Vpi_dis2 = Vpi_dis2 + ((Vdc*2*sqrt(2)/pi)*sin(n*Php/2)/n)^2;
    end
    
    Vpi1 = (Vdc*2*sqrt(2)/pi)*sin(Php/2);
    Vpirms = 400*sqrt(Php/pi);
    
    THD = [THD 100*sqrt(Vpi_dis2)/Vpi1];
    THD_alt = [THD_alt 100*sqrt(Vpirms^2-Vpi1^2)/Vpi1];
    
end

NAry = [1:2:20]

%Ploting the resutls
figure(1)
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('V_p_i (V)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{t (\mus) }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(Ts*1e6,Vpi,'LineWidth',2);


figure(2)
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('V_p_i_(_1_) (V)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{t (\mus) }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(Ts*1e6,(Vdc*4/pi)*(cos(2*pi*fsw.*Ts)*sin(Php/2)),'LineWidth',2);


figure(3)
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('V_p_i_(_n_) (V)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{t (\mus) }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(Ts*1e6,(Vdc*4/pi)*(cos(3*2*pi*fsw.*Ts)*sin(3*Php/2)/3),'LineWidth',2);
plot(Ts*1e6,(Vdc*4/pi)*(cos(5*2*pi*fsw.*Ts)*sin(5*Php/2)/5),'LineWidth',2);
plot(Ts*1e6,(Vdc*4/pi)*(cos(11*2*pi*fsw.*Ts)*sin(11*Php/2)/11),'LineWidth',2);

figure(4)
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('THD (%)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{\phi_p / \pi }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(PhpAry./pi,THD_alt,'LineWidth',2);

figure(5)
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman','XTick',NAry);
ylabel('V_p_i_(_n_) (RMS)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{Harmonic Number}','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
bar(NAry,[[abs((1*4/pi).*sin(NAry.*pi/2))/sqrt(2)./NAry]' ...
    [abs((1*4/pi).*sin(NAry.*pi/3))/sqrt(2)./NAry]' ...
    [abs((1*4/pi).*sin(NAry.*pi/3))/sqrt(4)./NAry]'],'LineWidth',2);

end
