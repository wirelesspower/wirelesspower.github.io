%--------------------------------------------------------------------------
%By: Duleepa J Thrimawithana
%Date: 19-05-2019
%Description:
%This program is written to calculate the power output of an 
%series compensated IPT pick-up
%--------------------------------------------------------------------------

function [] = PowerSCP( )

f = 85e3;   %Frequency of the fundamental component of current in primary coil  
Lpt = 20e-6;    %Inductance of the primary coils
Ipt = 10;  %RMS current in the primary coil (fundamental)
k = 0.1; %Coupling between coils
w = 2*pi*f; %Angular frequency

LoR = [0:0.01:10]; %Represents wLst/RL as power is plotted against this

VApt = w*Lpt*Ipt^2; %VA in the primary coil 

%Power delivered to load vs LoR normalised wrt VApt (i.e. mW/VA)

%At ideal tuning, dL = 0
dL = 0; 
PowerSCP_0dL = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+dL^2.*LoR.^2))/VApt;

%At 10% change in compensation, dL = 0.1
dL = 0.1;   
PowerSCP_0dL1 = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+dL^2.*LoR.^2))/VApt;

%At 20% change in compensation, dL = 0.2
dL = 0.2;    
PowerSCP_0dL2 = 1000*(k^2*w*Lpt*Ipt^2.*LoR./(1+dL^2.*LoR.^2))/VApt;


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
plot(LoR,PowerSCP_0dL,'LineWidth',2);
plot(LoR,PowerSCP_0dL1,'LineWidth',2);
plot(LoR,PowerSCP_0dL2,'LineWidth',2);

%legend('k=0.1','k=0.15','k=0.2','Location','northeast');
%legend BOXON
end
