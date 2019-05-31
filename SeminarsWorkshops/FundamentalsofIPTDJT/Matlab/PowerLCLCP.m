%--------------------------------------------------------------------------
%By: Duleepa J Thrimawithana
%Date: 19-05-2019
%Description:
%This program is written to calculate the power output of an 
%parallel compensated IPT pick-up
%--------------------------------------------------------------------------

function [] = PowerLCLCP( )

f = 85e3;   %Frequency of the fundamental component of current in primary coil  
Lpt = 20e-6;    %Inductance of the primary coils
Ipt = 10;  %RMS current in the primary coil (fundamental)
k = 0.1; %Coupling between coils
w = 2*pi*f; %Angular frequency

RoL = [0:0.01:10]; %Represents RL/wLst as power is plotted against this

VApt = w*Lpt*Ipt^2; %VA in the primary coil 

LRatio = 1; %Ratio between Lsi/Lst

%Power delivered to load vs RoL normalised wrt VApt (i.e. mW/VA)

%At ideal tuning, dL = 0
dL = 0; 
PowerPCP_0dL = 1000*(k^2*w*Lpt*Ipt^2.*RoL./((1+(dL/(1+dL))*LRatio)^2+(dL^2/(1+dL)^2).*RoL.^2))/VApt;

%At 10% change in compensation, dL = 0.1
dL = 0.1;   
PowerPCP_0dL1 = 1000*(k^2*w*Lpt*Ipt^2.*RoL./((1+(dL/(1+dL))*LRatio)^2+(dL^2/(1+dL)^2).*RoL.^2))/VApt;

%At 20% change in compensation, dL = 0.2
dL = 0.2;    
PowerPCP_0dL2 = 1000*(k^2*w*Lpt*Ipt^2.*RoL./((1+(dL/(1+dL))*LRatio)^2+(dL^2/(1+dL)^2).*RoL.^2))/VApt;

%Ploting the resutls
figure(1)
%set(gcf,'PaperPosition', [17, 210, 560, 420],'PaperUnits','points' )
axes1 = axes('Parent',gcf);
hold(axes1,'on');
set(axes1,'FontSize',14,'XColor',[0.5 0.5 0.5],'YColor',[0.5 0.5 0.5],...
    'GridColor',[0.9 0.9 0.9],'MinorGridColor',[0.9 0.9 0.9],...
    'XGrid','on','YGrid','on','FontName','Times New Roman');
ylabel('Power per VA (mW/VA)','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
xlabel('{R_L/\omega L_s_t }','Color',[0.15 0.15 0.15],'FontName','Times New Roman');
plot(RoL,PowerPCP_0dL,'LineWidth',2);
plot(RoL,PowerPCP_0dL1,'LineWidth',2);
plot(RoL,PowerPCP_0dL2,'LineWidth',2);

%legend('k=0.1','k=0.15','k=0.2','Location','northeast');
%legend BOXON


end
