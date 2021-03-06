%--------------------------------------------------------------------------
%By: Duleepa J Thrimawithana
%Date: 19-05-2019
%Description:
%This program is written to calculate the power output of an 
%uncompensated IPT pick-up
%--------------------------------------------------------------------------

function [] = PowerUCP( )

f = 85e3;   %Frequency of the fundamental component of current in primary coil  
Lpt = 20e-6;    %Inductance of the primary coils
Ipt = 100;  %RMS current in the primary coil (fundamental)

w = 2*pi*f; %Angular frequency

LoR = [0:0.01:5]; %Represents wLst/RL as PowerUCP is plotted against this

VApt = w*Lpt*Ipt^2; %VA in the primary coil 

%Power delivered to load vs LoR normalised wrt VApt (i.e. mW/VA)

%At c oupling coefficient between primary and pick-up coils, k = 0.1
k = 0.1;    
PowerUCP_0k1 = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+LoR.^2))/VApt;

%At c oupling coefficient between primary and pick-up coils, k = 0.15
k = 0.15;    
PowerUCP_0k15 = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+LoR.^2))/VApt;

%At c oupling coefficient between primary and pick-up coils, k = 0.2
k = 0.2;    
PowerUCP_0k2 = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+LoR.^2))/VApt;


%Ploting the resutls
figure(1)
%set(gcf,'PaperPosition', [17, 210, 560, 420],'PaperUnits','points' )
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('Power per VA (mW/VA)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{\omega L_s_t/R_L }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(LoR,PowerUCP_0k1,'LineWidth',2);
hold on
plot(LoR,PowerUCP_0k15,'LineWidth',2);
hold on
plot(LoR,PowerUCP_0k2,'LineWidth',2);

%legend('k=0.1','k=0.15','k=0.2','Location','northeast');
%legend BOXON
end
