

htable = figure;

ax = axes('XLim',[0 4],'YLim',[0 3]);
grid on

% Load State Data
time = stateOutBus.TranState_ECEF.R_Sys_ECEF.Time;
xpos = stateOutBus.TranState_ECEF.R_Sys_ECEF.Data(:,1);
ypos = stateOutBus.TranState_ECEF.R_Sys_ECEF.Data(:,2);
theta = stateOutBus.RotState_Body_ECEF.ECEF_To_Body_Euler.Data(:,3);

% Define the box to be drawn
box_length = 0.45;  % m
box_width = 0.45;   % m
% box_length = 1.5;  % m
% box_width = 0.45;   % m
h_x = box_length/2;
h_y = box_width/2;

xmid = xpos(1);
ymid = ypos(2);

h(1) = line([xmid-h_x xmid+h_x],[ymid-h_y ymid-h_y]);
h(2) = line([xmid-h_x xmid+h_x],[ymid+h_y ymid+h_y]);
h(3) = line([xmid-h_x xmid-h_x],[ymid-h_y ymid+h_y]);
h(4) = line([xmid+h_x xmid+h_x],[ymid-h_y ymid+h_y]);
h(4).Color = [1 0 0];
h(5) = line(xmid,ymid);
h(5).Marker = 'x';
h(5).Color = [0 0 0];
t = hgtransform('Parent',ax);
set(h,'Parent',t)
Rz = eye(4);
Tcent1 = eye(4);
Tcent2 = eye(4);

npts = length(time);

plotframe(npts) = struct('cdata',[],'colormap',[]);

% Initialize the time annotation
if exist('htext') delete(htext); end
txt = sprintf('Time: %.1f  sec\n',time(1));
htext = text(0.2,2.8,txt);

u = uicontrol('Style','slider','Position',[10 50 20 340],...
'Min',1,'Max',npts,'Value',1);

%npts = 1;
j = 0;
for i = 1:npts

    % Print the simulation time
    txt = sprintf('Time: %.1f  sec\n',time(i));
    set(htext,'String',txt);
    
    if i == 1 || mod(i,1) == 0
        % Define 2 transforms to move the center of rotation to the center
        % of the sled
         Tcent1 = makehgtform('translate',[-xmid -ymid 0]);
         Tcent2 = makehgtform('translate',[xmid ymid 0]);

        % Translate the sled to the current xy position
        Trans = makehgtform('translate',[xpos(i) ypos(i) 0]);

        % Rotate the sled about the z axis
        Rz = makehgtform('zrotate',theta(i));

        % Concatenate the transforms and
        % set the transform Matrix property
    %     set(t,'Matrix',Trans*Tcent2*Rz*Tcent1)
        set(t,'Matrix',Trans*Rz*Tcent1)
    
    end
    if i == 1 || mod(i,20) == 0
        j = j+1;
        plotframe(j) = getframe;
    end
    

    u.Value = i;

    pause(1e-8)
end
pause(1)

% new_theta = 0:0.1:2*pi;
% for i = 1:length(new_theta)
%     new_Tcent1 = makehgtform('translate',[-xmid -ymid 0]);
%     new_Tcent2 = makehgtform('translate',[xmid ymid 0]);
%     new_Rz = makehgtform('zrotate',new_theta(i));
%     set(t,'Matrix',new_Tcent2*new_Rz*new_Tcent1);
%     drawnow
%     pause(0.05)
% end

% h = animatedline;
% axis([0,4*pi,-1,1])
% 
% x = linspace(0,4*pi,1000);
% y = sin(x);
% addpoints(h,x(1),y(1));
% for k = 2:length(x)
%     addpoints(h,x(k),y(k));
%     drawnow
%     clearpoints(h,x(k-1),y(k-1));
% end

% htable = animatedline;
% hsled1 = animatedline;
% axis([0 4 0 3])
% for i = 1:length(simpos.Time)
%     addpoints(htable,simpos.Data(i,1),simpos.Data(i,2));
%     addpoints(hsled1,simpos.Data(i,1)-0.5,simpos.Data(i,1)+0.5);
%     drawnow
% end

% t = hgtransform;
% surf(peaks(40),'Parent',t)
% view(-20,30)
% axis manual
% 
% ry_angle = -15*pi/180; 
% Ry = makehgtform('yrotate',ry_angle);
% %t.Matrix = Ry;
% 
% Tx1 = makehgtform('translate',[-20 0 0]);
% Tx2 = makehgtform('translate',[20 0 0]);
% t.Matrix = Tx2*Ry*Tx1;
