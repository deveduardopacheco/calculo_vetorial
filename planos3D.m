function varargout = planos3D(varargin)
% PLANOS3D MATLAB code for planos3D.fig
%      PLANOS3D, by itself, creates a new PLANOS3D or raises the existing
%      singleton*.
%
%      H = PLANOS3D returns the handle to a new PLANOS3D or the handle to
%      the existing singleton*.
%
%      PLANOS3D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLANOS3D.M with the given input arguments.
%
%      PLANOS3D('Property','Value',...) creates a new PLANOS3D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before planos3D_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to planos3D_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help planos3D

% Last Modified by GUIDE v2.5 05-Mar-2019 04:50:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @planos3D_OpeningFcn, ...
                   'gui_OutputFcn',  @planos3D_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before planos3D is made visible.
function planos3D_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to planos3D (see VARARGIN)

% Choose default command line output for planos3D
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes planos3D wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = planos3D_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
global gxmin;
global gxmax;
global gymin;
global gymax;
global gzmin;
global gzmax;
global grmin;
global grmax;
global gphimin;
global gphimax;
global gthetamin;
global gthetamax;
global gy;
global gz;
global gphi;
global gtheta;
gxmin = str2double(strcat('-',get(handles.max,'String')));
gxmax = str2double(get(handles.max,'String'));
gymin = str2double(strcat('-',get(handles.max,'String')));
gymax = str2double(get(handles.max,'String'));
gzmin = str2double(strcat('-',get(handles.max,'String')));
gzmax = str2double(get(handles.max,'String'));
grmin = 0;
grmax = str2double(get(handles.max,'String'));
gphimin = 0;
gphimax = 360;
gthetamin = 0;
gthetamax = 180;
gy = 0;
gz = 0;
gphi = 0;
gtheta = 0;
%set(handles.coordymin, 'String', strcat('-',get(handles.max,'String')));
%set(handles.coordymax, 'String', get(handles.max,'String'));
%set(handles.coordzmin, 'String', strcat('-',get(handles.max,'String')));
%set(handles.coordzmax, 'String', get(handles.max,'String'))
selecionaCoord(hObject, eventdata, handles);

function validaCampo(hObject, handles)
    uniphi = char(hex2dec('03d5'));
    unitheta = char(hex2dec('03B8'));
    unirho = char(hex2dec('03c1'));
    set(handles.alert,'String','');
    if(get(handles.radioCil,'Value') == 1)
        if(strcmp(get(hObject,'Tag'),'coordy') | strcmp(get(hObject,'Tag'),'coordymin') | strcmp(get(hObject,'Tag'),'coordymax'))
            if(str2double(get(hObject,'String')) < 0)
                set(handles.alert,'String',strcat(uniphi,' deve estar entre 0 e 360°'));
                set(hObject,'String','0');
            elseif(str2double(get(hObject,'String')) > 360)
                set(handles.alert,'String',strcat(uniphi,' deve estar entre 0 e 360°'));
                set(hObject,'String','360');
            end
        end
    elseif(get(handles.radioEsf,'Value') == 1)
        if(strcmp(get(hObject,'Tag'),'coordy') | strcmp(get(hObject,'Tag'),'coordymin') | strcmp(get(hObject,'Tag'),'coordymax'))
            if(str2double(get(hObject,'String')) < 0)
                set(handles.alert,'String',strcat(unitheta,' deve estar entre 0 e 180°'));
                set(hObject,'String','0');
            elseif(str2double(get(hObject,'String')) > 180)
                set(handles.alert,'String',strcat(unitheta,' deve estar entre 0 e 180°'));
                set(hObject,'String','180');
            end
        elseif(strcmp(get(hObject,'Tag'),'coordz') | strcmp(get(hObject,'Tag'),'coordzmin') | strcmp(get(hObject,'Tag'),'coordzmax'))
            if(str2double(get(hObject,'String')) < 0)
                set(handles.alert,'String',strcat(uniphi,' deve estar entre 0 e 360°'));
                set(hObject,'String','0');
            elseif(str2double(get(hObject,'String')) > 360)
                set(handles.alert,'String',strcat(uniphi,' deve estar entre 0 e 360°'));
                set(hObject,'String','360');
            end
        end
    end
    
    %str2double(get(hObject,'String'))

function legendaRet(handles)
    text(handles.limites*1.08,0,0,'x','HorizontalAlignment','center','FontSize',10);
    text(0,handles.limites*1.08,0,'y','HorizontalAlignment','center','FontSize',10);
    text(0,0,handles.limites*1.08,'z','HorizontalAlignment','center','FontSize',10);
    
    xi = str2double(get(handles.coordx,'String'));
    yi = str2double(get(handles.coordy,'String'));
    zi = str2double(get(handles.coordz,'String'));
    
    pcolor = [0.2 0.4 1];
    pcolorm = [0.5 0.7 1];
    
     if(get(handles.mostrarPlanos,'Value') == 0)

        if(get(handles.checkx,'Value') == 0 & get(handles.checky,'Value') == 0 & get(handles.checkx,'Value') == 0)

            if(yi ~= 0)
                x = linspace(0,xi,2);
                y(1:size(x,2)) = yi;
                z(1:size(x,2)) = 0;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

            if(xi ~= 0)
                y = linspace(0,yi,2);
                z(1:size(y,2)) = 0;
                x(1:size(y,2)) = xi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

            if(xi ~= 0 & yi ~= 0)
                z = linspace(0,zi,2);
                x(1:size(z,2)) = xi;
                y(1:size(z,2)) = yi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

            if(zi ~= 0 & yi == 0 & xi ~= 0)
                x = linspace(0,xi,2);
                y(1:size(x,2)) = yi;
                z(1:size(x,2)) = zi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface

                z = linspace(0,zi,2);
                x(1:size(z,2)) = xi;
                y(1:size(z,2)) = yi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

            if(zi ~= 0 & xi == 0 & yi ~= 0)
                y = linspace(0,yi,2);
                x(1:size(y,2)) = xi;
                z(1:size(x,2)) = zi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface

                z = linspace(0,zi,2);
                x(1:size(z,2)) = xi;
                y(1:size(z,2)) = yi;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

            %plota marcações de referência atrás dos eixos caso valores de x ou
            %y sejam negativos
            if(str2double(get(handles.coordx,'String')) < 0)
                x = linspace(0,xi,2);
                y(1:size(x,2)) = 0;
                z(1:size(x,2)) = 0;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end
            if(str2double(get(handles.coordy,'String')) < 0)
                y = linspace(0,yi,2);
                z(1:size(y,2)) = 0;
                x(1:size(y,2)) = 0;
                p = plot3(x, y, z,'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            end

        end
    
    end
    
function legendaCil(handles)
    global grmax;
    ri = str2double(get(handles.coordx,'String'));
    phii = str2double(get(handles.coordy,'String'));
    zi = str2double(get(handles.coordz,'String'));
    
    pcolor = [0.2 0.4 1];
    pcolorm = [0.5 0.7 1];
    text(0,0,handles.limites*1.08,'z','HorizontalAlignment','center','FontSize',10);
    
    if(get(handles.checkx,'Value') == 1)
            %se r for variável, estender a linha
                rii = str2double(get(handles.coordxmax,'String'));
    else
                rii = ri;
    end
    
    if(phii == 0 | get(handles.checky,'Value') == 1)
    %se phi for 0 ou variável, só mostra o eixo do phi
    phi = meshgrid(linspace(0,pi/2,20));
    r = handles.limites/10;
    x = r.*cos(phi);
    y = r.*sin(phi);
    z(1:size(phi,1),0.5:size(phi,1)) = 0;
    p = plot3(x(1,:), y(1,:), z(1,:),'Color',pcolor,'linewidth',0.5); % Plot the surface
    text(handles.limites*1.05/10,handles.limites*1.05/10,0,'\phi','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
    else
            phi = meshgrid(linspace(0,phii*pi/180,50));
            r = handles.limites/10;
            x = r.*cos(phi);
            y = r.*sin(phi);
            z(1:size(phi,1),0.5:size(phi,1)) = 0;
            plot3(x(1,:), y(1,:), z(1,:),'Color',pcolor,'linewidth',0.5); % Plot the surface
            ra = handles.limites*1.4/10;
            xa = ra*cos((phii*pi/180)/2);
            ya = ra*sin((phii*pi/180)/2);
            za = 0;
            text(xa,ya,za,'\phi','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
  
            r2 = meshgrid(0:0.5:rii);
            x2 = r2.*cos(phii*pi/180);
            y2 = r2.*sin(phii*pi/180);
            z2(1:size(r2,1),0.5:size(r2,1)) = 0;
            p = plot3(x2(1,:), y2(1,:), z2(1,:),'--','Color',pcolorm,'linewidth',0.5); % Plot the surface
            
            if(ri > 1)
                rp = rii*0.3;
                xp = rp*cos(phii*pi/180);
                yp = rp*sin(phii*pi/180);
                zp = 0;
                text(xp+(handles.limites*0.1),yp+(handles.limites*0.1),zp,'\rho','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
            end
    end
    if(zi ~= 0)
                zz = linspace(0,zi,5)';
                
                if( (str2double(get(handles.coordxmin,'String')) > 0 | str2double(get(handles.coordz,'String')) < 0) & get(handles.checkx,'Value') == 1)
                    %linha em z, se r não começar em 0 ou z for negativo
                    rza(1:size(zz,1)) = str2double(get(handles.coordxmin,'String'));
                    xza = rza*cos(phii*pi/180);
                    yza = rza*sin(phii*pi/180);
                    pza = plot3(xza,yza,zz,'--','Color',pcolorm,'linewidth',0.5)
                end
                if(get(handles.checkz,'Value') == 0 & get(handles.checky,'Value') == 0)
                    %se z nem phi não for variável, plota linha em z    
                    %linha em z                
                    rz(1:size(zz,1)) = rii;
                    xz = rz*cos(phii*pi/180);
                    yz = rz*sin(phii*pi/180);
                    pz = plot3(xz,yz,zz,'--','Color',pcolorm,'linewidth',0.5)

                    %rp = ri/2;
                    zz = zi*0.6;
                    rz2 = ri*1.05;
                    xz2 = rz2*cos(phii*pi/180);
                    yz2 = rz2*sin(phii*pi/180);
                    text(xz2,yz2,zz,'z','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
                end
     end
    
    

function legendaEsf(handles)
    ri = str2double(get(handles.coordx,'String'));
    thetai = str2double(get(handles.coordy,'String'));
    phii = str2double(get(handles.coordz,'String'));
    tcolor = [1 0.2 0.6];
    pcolor = [0.2 0.4 1];
    pcolorm = [0.5 0.7 1];

    phi = meshgrid(linspace(0,pi/2,20));
    if(phii == 0 | thetai == 0 | get(handles.checkz,'Value') == 1 | get(handles.checky,'Value') == 1)
    %se phi for variável ou igual a 0, só mostra o eixo sem um ângulo
    %específico
        r = handles.limites/7;
        x = r.*cos(phi);
        y = r.*sin(phi);
        z(1:size(phi,1),0.5:size(phi,1)) = 0;
        p = plot3(x(1,:), y(1,:), z(1,:),'Color',pcolor,'linewidth',0.5); % Plot the surface
        text(handles.limites*1.3/10,handles.limites*1.3/10,0,'\phi','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
    else
        %plota arco do phi de acordo com o ângulo
        r1 = handles.limites/7;
        phi1 = linspace(0,phii*pi/180,50);
        theta1(1:size(phi1,2)) = thetai*pi/180;
        x1 = r1*cos(phi1);
        y1 = r1*sin(phi1);
        z1 = theta1*0; 
        p = plot3(x1, y1, z1,'Color',pcolor,'linewidth',0.5); % Plot the surface
        
        %plota símbolo phi
        r3 = handles.limites*0.185;
        phi3 = phii*pi/180/2;
        theta3(1:size(phi3,2)) = thetai*pi/180;
        x3 = r3*cos(phi3);
        y3 = r3*sin(phi3);
        z3 = theta3*0; 
        text(x3,y3,z3,'\phi','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
        
        
    end
    
    if(thetai == 0 | thetai == 0 | get(handles.checkz,'Value') == 1 | get(handles.checky,'Value') == 1)
    %se theta for 0, plota só o eixo sem um ângulo específico  
        theta = meshgrid(linspace(0,pi/2,20));
        rt = handles.limites/10;
        yt = rt.*cos(theta);
        zt = rt.*sin(theta);
        xt(1:size(phi,1),0.5:size(phi,1)) = 0;
        p = plot3(xt(1,:), yt(1,:), zt(1,:),'Color',tcolor,'linewidth',0.5); % Plot the surface
        text(0,handles.limites*1.2/10,handles.limites*1.2/10,'\theta','Color',tcolor,'HorizontalAlignment','center','FontSize',10);
    else
        
        if(get(handles.checkx,'Value') == 1)
            rii = str2double(get(handles.coordxmax,'String'));
        else
            rii = ri;
        end
        %plota linha horizontal ligando ao ângulo phi
        r2 = linspace(0,rii,2)*sin(thetai*pi/180);
        theta2 = pi/2;
        phi2 = phii*pi/180;
        x2 = r2*sin(theta2)*cos(phi2);
        y2 = r2*sin(theta2)*sin(phi2);
        z2 = r2*cos(theta2);
        plot3(x2,y2,z2,'--','Color',pcolorm,'linewidth',0.5);
        
        %plota linha vertical ligando ao ângulo phi
        r2 = linspace(0,rii,2)*cos(thetai*pi/180);
        theta2 = 0;
        phi2 = phii*pi/180;
        x2 = r2*sin(theta2)*cos(phi2)+rii*sin(thetai*pi/180)*cos(phii*pi/180);
        y2 = r2*sin(theta2)*sin(phi2)+rii*sin(thetai*pi/180)*sin(phii*pi/180);
        z2 = r2*cos(theta2);
        plot3(x2,y2,z2,'--','Color',pcolorm,'linewidth',0.5);
        
        %plota linha r
        r2 = linspace(0,ri,2);
        theta2 = thetai*pi/180;
        phi2 = phii*pi/180;
        x2 = r2*sin(theta2)*cos(phi2);
        y2 = r2*sin(theta2)*sin(phi2);
        z2 = r2*cos(theta2);
        plot3(x2,y2,z2,'--','Color',pcolorm,'linewidth',0.5);
        
        %plota símbolo r
        r3 = ri*0.45;
        phi3 = phii*pi/180;
        theta3(1:size(phi3,2)) = thetai*pi/180;
        x3 = r3*sin(theta3)*cos(phi3);
        y3 = r3*sin(theta3)*sin(phi3);
        z3 = r3*cos(theta3); 
        text(x3,y3,z3+(handles.limites*0.07),'r','Color',pcolor,'HorizontalAlignment','center','FontSize',10);
        
        %plota arco de acordo com ângulos theta e phi
        rt = handles.limites/10;
        theta = linspace(0,thetai*pi/180,20);
        phi = phii*pi/180;
        xt = rt*sin(theta)*cos(phi);
        yt = rt*sin(theta)*sin(phi);
        zt = rt*cos(theta);
        p = plot3(xt(1,:), yt(1,:), zt(1,:),'Color',tcolor,'linewidth',0.5); % Plot the surface
        %text(0,handles.limites*1.2/10,handles.limites*1.2/10,'\theta','Color',tcolor,'HorizontalAlignment','center','FontSize',10);
        
        %símbolo theta
        rts = handles.limites*0.15;
        theta = thetai*pi/180*0.5;
        phi = phii*pi/180;
        xts = rts*sin(theta)*cos(phi);
        yts = rts*sin(theta)*sin(phi);
        zts = rts*cos(theta);
        text(xts,yts,zts,'\theta','Color',tcolor,'HorizontalAlignment','center','FontSize',10);
    end
    
    
function selecionaCoord(hObject, eventdata, handles)
    global gxmin;
    global gxmax;
    global gymin;
    global gymax;
    global gzmin;
    global gzmax;
    global grmin;
    global grmax;
    global gphimin;
    global gphimax;
    global gthetamin;
    global gthetamax;
    global gy;
    global gz;
    global gphi;
    global gtheta;
    uniphi = char(hex2dec('03d5'));
    unitheta = char(hex2dec('03B8'));
    unirho = char(hex2dec('03c1'));
    if get(handles.radioRet,'Value') == 1
        handles.coord = 0;
        set(handles.val1,'string','x');
        set(handles.val2,'string','y');
        set(handles.val3,'string','z');
        set(handles.coordxmin, 'String', gxmin);
        set(handles.coordxmax, 'String', gxmax);
        set(handles.coordymin, 'String', gymin);
        set(handles.coordymax, 'String', gymax);
        set(handles.coordzmin, 'String', gzmin);
        set(handles.coordzmax, 'String', gzmax);
        set(handles.coordy, 'String', gy);
        set(handles.coordz, 'String', gz);
    elseif get(handles.radioCil,'Value') == 1
        handles.coord = 1;
        set(handles.val1,'string',unirho);
        set(handles.val2,'string',uniphi);
        set(handles.val3,'string','z');
        set(handles.coordxmin, 'String', grmin);
        set(handles.coordxmax, 'String', grmax);
        set(handles.coordymin, 'String', gphimin);
        set(handles.coordymax, 'String', gphimax);
        set(handles.coordzmin, 'String', gzmin);
        set(handles.coordzmax, 'String', gzmax);
        set(handles.coordy, 'String', gphi);
        set(handles.coordz, 'String', gz);
        %handles.phimin = 0;
        %handles.phimax = 2*pi;
    else
        handles.coord = 2;
        set(handles.val1,'string','r');
        set(handles.val2,'string',unitheta);
        set(handles.val3,'string',uniphi);
        set(handles.coordxmin, 'String', grmin);
        set(handles.coordxmax, 'String', grmax);
        set(handles.coordymin, 'String', gthetamin);
        set(handles.coordymax, 'String', gthetamax);
        set(handles.coordzmin, 'String', gphimin);
        set(handles.coordzmax, 'String', gphimax);
        set(handles.coordy, 'String', gtheta);
        set(handles.coordz, 'String', gphi);
    end
    set(handles.debug0,'string',handles.coord);
    planos(hObject, eventdata, handles);    
    
    function planoCar(xi,yi,zi,handles)
        if size(xi,1) == 1
            handles.xmin = -handles.limites;
            handles.xmax = handles.limites;
        end
        if size(yi,1) == 1
            handles.ymin = -handles.limites;
            handles.ymax = handles.limites;
        end   
        if size(zi,1) == 1
            handles.zmin = -handles.limites;
            handles.zmax = handles.limites;
        end
        if size(xi,1) == 1
            %set(handles.debug,'string',strcat('Plano em x =',{' '},get(handles.coordx,'String')));
            y = meshgrid(handles.ymin:0.5:handles.ymax);
            z = meshgrid(linspace(handles.zmin,handles.zmax,size(y,2)))';
            x(1:size(y,1),1:size(y,1)) = xi;
            s = surf(x, y, z, 'FaceAlpha',handles.facealpha)
            s.EdgeColor = handles.edgecolor;
            s.EdgeAlpha = handles.edgealpha;
        end
        if size(yi,1) == 1
            %set(handles.debug,'string',strcat('Plano em y =',{' '},get(handles.coordy,'String')));
            x2 = meshgrid(handles.xmin:0.5:handles.xmax);
            z2 = meshgrid(linspace(handles.zmin,handles.zmax,size(x2,2)))';
            y2(1:size(x2,1),1:size(x2,1)) = yi;
            s = surf(x2, y2, z2, z2, 'FaceAlpha',handles.facealpha)
            s.EdgeColor = handles.edgecolor;
            s.EdgeAlpha = handles.edgealpha;
        end
        if size(zi,1) == 1
            %set(handles.debug,'string',strcat('Plano em z =',{' '},get(handles.coordz,'String')));
            x3 = meshgrid(handles.xmin:0.5:handles.xmax);
            y3 = meshgrid(linspace(handles.ymin,handles.ymax,size(x3,2)))';
            z3(1:size(x3,1),1:size(x3,1)) = zi;
            s = surf(x3, y3, z3, y3, 'FaceAlpha',handles.facealpha) 
            s.EdgeColor = handles.edgecolor;
            s.EdgeAlpha = handles.edgealpha;
        end
   
    function linhaCar(xi,yi,zi,l,handles)
        if size(xi,1) == 0
            x = linspace(handles.xmin,handles.xmax,2);
            y(1:size(x,2)) = str2double(get(handles.coordy,'String'));
            z(1:size(x,2)) = str2double(get(handles.coordz,'String'));
        elseif size(yi,1) == 0
            y = linspace(handles.ymin,handles.ymax,2);
            x(1:size(y,2)) = str2double(get(handles.coordx,'String'));
            z(1:size(y,2)) = str2double(get(handles.coordz,'String'));
        elseif size(zi,1) == 0
            z = linspace(handles.zmin,handles.zmax,2)
            x(1:size(z,2)) = str2double(get(handles.coordx,'String'));
            y(1:size(z,2)) = str2double(get(handles.coordy,'String'));
        end
        if l == 'p'
            plot3(x,y,z,'Color',handles.linecolorf,'linewidth',1.3);
        else
            plot3(x,y,z,'Color',handles.linecolor,'linewidth',1.3);
        end
        
   function planoCil(ri,phii,zi,handles)
            if size(ri,1) == 1
               handles.rmin = 0;
               handles.rmax = handles.limites;
            end
            if size(phii,1) == 1
               handles.phimin = 0;
               handles.phimax = 2*pi;
            end   
            if size(zi,1) == 1
               handles.zmin = -handles.zmax;
               handles.zmax = handles.zmax;
            end
            if size(ri,1) == 1
                phi = meshgrid(linspace(handles.phimin,handles.phimax,50));
                x = ri*cos(phi);
                y = ri*sin(phi);
                z = meshgrid(linspace(handles.zmin,handles.zmax,size(phi,1)))';
                s = surf(x, y, z, 'FaceAlpha',handles.facealpha) % Plot the surface
                s.EdgeColor = handles.edgecolor;
                s.EdgeAlpha = handles.edgealpha;
            end
            if size(phii,1) == 1
                phi = phii*pi/180; %converte o angulo em graus para radianos
                sx = meshgrid(linspace(handles.rmin,handles.rmax,30));
                x2 = sx.*cos(phi);
                y2 = sx.*sin(phi);
                z2 = meshgrid(linspace(handles.zmin,handles.zmax,size(x2,1)))'; % Generate y and z data
                s = surf(x2, y2, z2, 'FaceAlpha',handles.facealpha) % Plot the surface
                s.EdgeColor = handles.edgecolor;
                s.EdgeAlpha = handles.edgealpha;
            end
            if size(zi,1) == 1
                phi = meshgrid(linspace(handles.phimin,handles.phimax,50));
                r = meshgrid(linspace(handles.rmin,handles.rmax,size(phi,2)))';
                x3 = r.*cos(phi);
                y3 = r.*sin(phi);
                z3(1:size(x3,1),1:size(x3,1)) = zi;
                s = surf(x3, y3, z3,x3, 'FaceAlpha',handles.facealpha)
                s.EdgeColor = handles.edgecolor;
                s.EdgeAlpha = handles.edgealpha;
            end
            
    function linhaCil(ri,phii,zi,l,handles)
        if size(ri,1) == 0
            phi = phii*pi/180; %converte o angulo em graus para radianos
            r = meshgrid(handles.rmin:0.5:handles.rmax);
            x = r*cos(phi);
            y = r*sin(phi);
            z(1:size(x,1),1:size(x,1)) = zi;
            p = plot3(x(1,:), y(1,:), z(1,:),'linewidth',1.3); % Plot the surface
        elseif size(phii,1) == 0
            phi = meshgrid(linspace(handles.phimin,handles.phimax,50));
            r = ri;
            x = r.*cos(phi);
            y = r.*sin(phi);
            z(1:size(phi,1),0.5:size(phi,1)) = zi;
            p = plot3(x(1,:), y(1,:), z(1,:),'linewidth',1.3); % Plot the surface
        elseif size(zi,1) == 0
            phi = phii*pi/180;
            z = (handles.zmin:1:handles.zmax)';
            r(1:size(z,1)) = ri;
            x = r*cos(phi);
            y = r*sin(phi);
            p = plot3(x,y,z,'linewidth',1.3)
        end
        if l == 'p'
            p.Color = handles.linecolorf;
        else
             p.Color = handles.linecolor;
        end
        
    function planoEsf(ri,thetai,phii,handles)
        if size(ri,1) == 1
           handles.rmin = 0;
           handles.rmax = handles.limites;
        end
        if size(thetai,1) == 1
           handles.thetamin = 0;
           handles.thetamax = pi;
        end   
        if size(phii,1) == 1
           handles.phimin = 0;
           handles.phimax = 2*pi;
        end 
        if size(ri,1) == 1
           r = ri;
           phi = linspace(handles.phimin,handles.phimax,50);
           n = 0;
           z = zeros(size(phi,2),size(phi,2));
           x= zeros(size(phi,2),size(phi,2));
           y = x;
           for t = linspace(handles.thetamin,handles.thetamax,50);
               n = n+1;
               theta(1:size(phi,2)) = t;
               x(:,n) = r*sin(theta).*cos(phi);
               y(:,n) = r*sin(theta).*sin(phi);
               z(:,n) = r*cos(theta);
           end
           s = surf(x, y, z, 'FaceAlpha',handles.facealpha) % Plot the surface 
           s.EdgeColor = handles.edgecolor;
           s.EdgeAlpha = handles.edgealpha;

        end
        if size(thetai,1) == 1
           phi = linspace(handles.phimin,handles.phimax,50);
		   n = 0;
		   theta = thetai*pi/180;
		   z = zeros(size(phi,2),size(phi,2));
		   x= zeros(size(phi,2),size(phi,2));
		   y = x;
           for t = linspace(handles.rmin,handles.rmax,70)
			   n = n+1;
               r(1:size(phi,2)) = t;
               x(:,n) = r*sin(theta).*cos(phi);
               y(:,n) = r*sin(theta).*sin(phi);
               z(:,n) = r*cos(theta);
           end
           s = surf(x, y, z,x, 'FaceAlpha',handles.facealpha) % Plot the surface 
           s.EdgeColor = handles.edgecolor;
           s.EdgeAlpha = handles.edgealpha;
        end
        if size(phii,1) == 1
           theta = linspace(handles.thetamin,handles.thetamax,50);
           phi = phii*pi/180;
           n = 0;
           z = zeros(size(theta,2),size(theta,2));
           x = zeros(size(theta,2),size(theta,2));
           y = x;
           for t = linspace(handles.rmin,handles.rmax,70)
               n = n+1;
               r(1:size(theta,2)) = t;
               x(:,n) = r.*sin(theta).*cos(phi);
               y(:,n) = r.*sin(theta).*sin(phi);
               z(:,n) = r.*cos(theta);
           end
           s = surf(x, y, z,x, 'FaceAlpha',handles.facealpha) % Plot the surface 
           s.EdgeColor = handles.edgecolor;
           s.EdgeAlpha = handles.edgealpha;
        end
        
    function linhaEsf(ri,thetai,phii,l,handles)
        if size(ri,1) == 0
               r = linspace(handles.rmin,handles.rmax,2);
               theta = thetai*pi/180;
               phi = phii*pi/180;
               x = r*sin(theta)*cos(phi);
               y = r*sin(theta)*sin(phi);
               z = r*cos(theta);
        elseif size(thetai,1) == 0
               r = ri;
               theta = linspace(handles.thetamin,handles.thetamax,50);
               phi = phii*pi/180;
               x = r*sin(theta)*cos(phi);
               y = r*sin(theta)*sin(phi);
               z = r*cos(theta);
        elseif size(phii,1) == 0
               r = ri;
               phi = linspace(handles.phimin,handles.phimax,50);
               theta(1:size(phi,2)) = thetai*pi/180;
               x = r*sin(theta).*cos(phi);
               y = r*sin(theta).*sin(phi);
               z = r*cos(theta);
        end
        if l == 'p'
            plot3(x,y,z,'Color',handles.linecolorf,'linewidth',1.3);
        else
            plot3(x,y,z,'Color',handles.linecolor,'linewidth',1.3);
        end
        
        
%função para criar pontos scatter3 criação de pontos 

function planos(hObject, eventdata, handles)
    global gxmin;
    global gxmax;
    global gymin;
    global gymax;
    global gzmin;
    global gzmax;
    global grmin;
    global grmax;
    global gphimin;
    global gphimax;
    global gthetamin;
    global gthetamax;
    global gy;
    global gz;
    global gphi;
    global gtheta;

    handles.limites = str2double(get(handles.max,'String'));
    %handles.limites = 10;
    
    handles.edgecolor = [0.4 0.4 0.4];
    handles.edgealpha = '0.2';
    handles.facealpha = '0.8';
    handles.linecolor = [0 0.8 0.8];
    handles.linecolorf = [0 0.9 0.9];
    handles.pointcolor = [0 0.8 0.8];
    handles.pointcolorf = [0 0.9 0.9];
    handles.markcolor = [0.2 0.2 0.2];
    handles.xmax = str2double(get(handles.coordxmax,'String'));
    handles.xmin = str2double(get(handles.coordxmin,'String'));
    handles.ymax = str2double(get(handles.coordymax,'String'));
    handles.ymin = str2double(get(handles.coordymin,'String'));
    handles.zmax = str2double(get(handles.coordzmax,'String'));
    handles.zmin = str2double(get(handles.coordzmin,'String'));
    handles.rmin = str2double(get(handles.coordxmin,'String'));
    handles.rmax = str2double(get(handles.coordxmax,'String'));
    set(handles.debug0,'string','');
    set(handles.debug,'string','');
    set(handles.debug1,'string','');
    
    uniphi = char(hex2dec('03d5'));
    unitheta = char(hex2dec('03B8'));
    unirho = char(hex2dec('03c1'));
       
    as = [0 0 0];
    bs = [0 0 0];
    cs = [0 0 0];
    ae = [0 0 handles.limites+1];
    be = [0 handles.limites*(1.1) 0];
    ce = [handles.limites*(1.1) 0 0];
    starts = [as;bs;cs];
    ends = [ae;be;ce];
    quiver3(starts(:,1), starts(:,2), starts(:,3), ends(:,1), ends(:,2), ends(:,3),'Color',handles.markcolor,'linewidth',0.5);
    %axis tight;
    hold on;
    
    %marcadores em x
    for i = 1:handles.limites-1
        x = linspace(-0.2,0.2,2);
        y(1:size(x,2)) = i;
        z(1:size(x,2)) = 0;
        plot3(x,y,z,'Color',handles.markcolor,'linewidth',0.5);
        %plot3(x,y,z,'Color',handles.linecolorf,'linewidth',1.3);
    end
    %marcadores em y
    for i = 1:handles.limites-1
        y = linspace(-0.2,0.2,2);
        x(1:size(y,2)) = i;
        z(1:size(y,2)) = 0;
        plot3(x,y,z,'Color',handles.markcolor,'linewidth',0.5);
        %plot3(x,y,z,'Color',handles.linecolorf,'linewidth',1.3);
    end
    %marcadores em z
    for i = 1:handles.limites-1
        x = linspace(-0.2,0.2,2);
        y(1:size(x,2)) = 0;
        z(1:size(x,2)) = i;
        plot3(x,y,z,'Color',handles.markcolor,'linewidth',0.5);
        %plot3(x,y,z,'Color',handles.linecolorf,'linewidth',1.3);
    end
    
    if get(handles.checkboxtransp,'Value') == 0
        handles.facealpha = 1;
    end
    
    if get(handles.radioRet,'Value') == 1
    %planos nas coordenadas retangulares
    legendaRet(handles);
    gxmin = str2double(get(handles.coordxmin,'String'));
    gxmax = str2double(get(handles.coordxmax,'String'));
    gymin = str2double(get(handles.coordymin,'String'));
    gymax = str2double(get(handles.coordymax,'String'));
    gzmin = str2double(get(handles.coordzmin,'String'));
    gzmax = str2double(get(handles.coordzmax,'String'));
    gy = str2double(get(handles.coordy,'String'));
    gz = str2double(get(handles.coordz,'String'));

        %planos selecionados
        if (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 1)
            set(handles.debug,'string',strcat('Superfície em x =',{' '},get(handles.coordx,'String')));
            planoCar(str2double(get(handles.coordx,'String')),[],[],handles);
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)
            set(handles.debug,'string',strcat('Superfície em y =',{' '},get(handles.coordy,'String')));
            planoCar([],str2double(get(handles.coordy,'String')),[],handles);
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)
            set(handles.debug,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
            planoCar([],[],str2double(get(handles.coordz,'String')),handles);
            %linhas selecionadas
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 0)

            if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug0,'string',strcat('Superfície em y =',{' '},get(handles.coordy,'String')));
                set(handles.debug,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
                planoCar([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);
                linhaCar([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'p',handles);
            else
                set(handles.debug,'string','Linha variando em x');
                linhaCar([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'l',handles);
            end

        elseif (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)

            if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug0,'string',strcat('Superfície em x =',{' '},get(handles.coordx,'String')));
                set(handles.debug,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
                planoCar(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),handles);
                linhaCar(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'p',handles);
            else
                set(handles.debug,'string','Linha variando em y');
                linhaCar(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'l',handles);
            end
            
        elseif (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)

             if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug0,'string',strcat('Superfície em x =',{' '},get(handles.coordx,'String')));
                set(handles.debug,'string',strcat('Superfície em y =',{' '},get(handles.coordy,'String')));
                planoCar(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],handles);
                linhaCar(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'p',handles);
             else
                set(handles.debug,'string','Linha variando em z');
                linhaCar(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'l',handles);
             end
             
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 1)
            set(handles.debug0,'string',strcat(num2str(handles.xmin),' <',{' '}, 'x <',{' '},num2str(handles.xmax)));
            set(handles.debug,'string',strcat(num2str(handles.ymin),' <',{' '}, 'y <',{' '},num2str(handles.ymax)));
            set(handles.debug1,'string',strcat(num2str(handles.zmin),' <',{' '}, 'z <',{' '},num2str(handles.zmax),'°'));
            planoCar(handles.xmin,[],[],handles);
            planoCar(handles.xmax,[],[],handles);
            planoCar([],handles.ymin,[],handles);
            planoCar([],handles.ymax,[],handles);
            planoCar([],[],handles.zmin,handles);
            planoCar([],[],handles.zmax,handles);
            

        else
            if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug0,'string',strcat('Superfície em x =',{' '},get(handles.coordx,'String')));
                set(handles.debug,'string',strcat('Superfície em y =',{' '},get(handles.coordy,'String')));
                set(handles.debug1,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
                planoCar(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);
                scatter3(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),20,handles.pointcolorf,'filled');
            else
                set(handles.debug,'string',strcat('P(',get(handles.coordx,'String'),',',get(handles.coordy,'String'),',',get(handles.coordz,'String'),')'));
                scatter3(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),15,handles.pointcolor,'filled');

            end
        end
    elseif get(handles.radioCil,'Value') == 1
    %planos nas coordenads cilíndricas
    legendaCil(handles)
    grmin = str2double(get(handles.coordxmin,'String'));
    grmax = str2double(get(handles.coordxmax,'String'));
    gphimin = str2double(get(handles.coordymin,'String'));
    gphimax = str2double(get(handles.coordymax,'String'));
    gzmin = str2double(get(handles.coordzmin,'String'));
    gzmax = str2double(get(handles.coordzmax,'String'));
    gphi = str2double(get(handles.coordy,'String'));
    handles.phimin = str2double(get(handles.coordymin,'String'))*pi/180;
    handles.phimax = str2double(get(handles.coordymax,'String'))*pi/180;
        if (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 1)
        %plano em r
            set(handles.debug,'string',strcat('Superfície em',{' '},unirho,' =',{' '},get(handles.coordx,'String')));
            planoCil(str2double(get(handles.coordx,'String')),[],[],handles);
            
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)
        %plano em z
            set(handles.debug,'string',strcat('Superfície em z =',{' '},get(handles.coordx,'String')));
            planoCil([],[],str2double(get(handles.coordz,'String')),handles);
            
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)
        %plano em phi
            set(handles.debug,'string',strcat('Superfície em',{' '},uniphi,' =',{' '},get(handles.coordy,'String'),'°'));
            planoCil([],str2double(get(handles.coordy,'String')),[],handles);

        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 0)
        %linha em rho
        
            if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug,'string',strcat('Superfície em',{' '},uniphi,' =',{' '},get(handles.coordy,'String'),'°'));
                set(handles.debug1,'string',strcat('Superfície em z =',{' '},get(handles.coordy,'String')));
                %planoCil([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);
                planoCil([],[],str2double(get(handles.coordz,'String')),handles);
                planoCil([],str2double(get(handles.coordy,'String')),[],handles);
                linhaCil([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'p',handles);
            else
                set(handles.debug,'string',strcat('Linha variando em ',{' '},unirho));
                linhaCil([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'l',handles);
            end
            
        elseif (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)
         %linha em z
         if(get(handles.mostrarPlanos,'Value') == 1)
            set(handles.debug,'string',strcat('Superfície em',{' '},uniphi,' =',{' '},get(handles.coordy,'String'),'°'));
            set(handles.debug1,'string',strcat('Superfície em',{' '},unirho,' =',{' '},get(handles.coordx,'String')));
            planoCil(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],handles);
            linhaCil(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'p',handles);
         else
            set(handles.debug,'string',strcat('Linha variando em z'));
            linhaCil(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'l',handles);
         end

        elseif (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)
            
            %linha em theta
            if(get(handles.mostrarPlanos,'Value') == 1)
                set(handles.debug,'string',strcat('Superfície em',{' '},unirho,' =',{' '},get(handles.coordx,'String')));
                set(handles.debug1,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
                planoCil(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),handles);
                linhaCil(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'p',handles);
            else
                set(handles.debug,'string',strcat('Linha variando em',{' '},uniphi));
                linhaCil(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'l',handles);
            end
        elseif (get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 0)
            
            %ponto
            set(handles.debug,'string','Ponto');
            if(get(handles.mostrarPlanos,'Value') == 1)
                              
                set(handles.debug0,'string',strcat('Superfície em',{' '},unirho,'  =',{' '},get(handles.coordx,'String')));
                set(handles.debug1,'string',strcat('Superfície em z =',{' '},get(handles.coordz,'String')));
                set(handles.debug,'string',strcat('Superfície em',{' '},uniphi,' =',{' '},get(handles.coordy,'String'),'°'));
                planoCil(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);
                
                %ponto
                r = str2double(get(handles.coordx,'String'));
                theta = str2double(get(handles.coordy,'String'))*pi/180;
                z = str2double(get(handles.coordz,'String'));
                x = r*cos(theta);
                y = r*sin(theta);
                scatter3(x,y,z,20,handles.pointcolorf,'filled'); 
               
            else
                %ponto
                r = str2double(get(handles.coordx,'String'));
                theta = str2double(get(handles.coordy,'String'))*pi/180;
                z = str2double(get(handles.coordz,'String'));
                set(handles.debug,'string',strcat('P(',get(handles.coordx,'String'),', ',get(handles.coordy,'String'),'°, ',get(handles.coordz,'String'),')'));
                
                x = r*cos(theta);
                y = r*sin(theta);
                scatter3(x,y,z,15,handles.pointcolor,'filled');
                
            end
        elseif (get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 1)
            
            %volume
            set(handles.debug0,'string',strcat(num2str(handles.rmin),' <',{' '}, unirho, {' '},'<',{' '},num2str(handles.rmax)));
            set(handles.debug,'string',strcat(num2str(handles.phimin*180/pi),'° <',{' '}, uniphi,{' '},'<',{' '},num2str(handles.phimax*180/pi),'°'));
            set(handles.debug1,'string',strcat(num2str(handles.zmin),' <',{' '}, 'z <',{' '},num2str(handles.zmin)));
            planoCil(handles.rmax,[],[],handles);
            planoCil(handles.rmin,[],[],handles);
            planoCil([],[],handles.zmin,handles);
            planoCil([],[],handles.zmax,handles);
            if((handles.phimax - handles.phimin) ~= 2*pi)
                planoCil([],handles.phimin*180/pi,[],handles);
                planoCil([],handles.phimax*180/pi,[],handles);
            end
         
        end
        
    else
    %planos nas coordenadas esféricas
        legendaEsf(handles)
        grmin = str2double(get(handles.coordxmin,'String'));
        grmax = str2double(get(handles.coordxmax,'String'));
        gthetamin = str2double(get(handles.coordymin,'String'));
        gthetamax = str2double(get(handles.coordymax,'String'));
        gphimin = str2double(get(handles.coordzmin,'String'));
        gphimax = str2double(get(handles.coordzmax,'String'));
        gtheta = str2double(get(handles.coordy,'String'));
        gphi = str2double(get(handles.coordz,'String'));
        handles.thetamin = str2double(get(handles.coordymin,'String'))*pi/180;
        handles.thetamax = str2double(get(handles.coordymax,'String'))*pi/180;
        handles.phimin = str2double(get(handles.coordzmin,'String'))*pi/180;
        handles.phimax = str2double(get(handles.coordzmax,'String'))*pi/180;
        if(get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 0)
         
             if(get(handles.mostrarPlanos,'Value') == 1)
              
               set(handles.debug0,'string',strcat('Superfície em r =',{' '}, get(handles.coordx,'String')));
               set(handles.debug,'string',strcat('Superfície em',{' '},unitheta,' =',{' '}, get(handles.coordy,'String'),'°'));
               set(handles.debug1,'string',strcat('Superfície em',{' '},uniphi,' =',{' '}, get(handles.coordz,'String'),'°'));
               planoEsf(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);

               %set(handles.debug,'string',strcat('P(',get(handles.coordx,'String'),', ',get(handles.coordy,'String'),'°, ',get(handles.coordz,'String'),'°)'));
               r = str2double(get(handles.coordx,'String'));
               theta = str2double(get(handles.coordy,'String'))*pi/180;
               phi = str2double(get(handles.coordz,'String'))*pi/180;
               x = r*sin(theta)*cos(phi);
               y = r*sin(theta)*sin(phi);
               z = r*cos(theta);
               scatter3(x,y,z,15,handles.pointcolorf,'filled'); 

             else
               set(handles.debug,'string',strcat('P(',get(handles.coordx,'String'),', ',get(handles.coordy,'String'),'°, ',get(handles.coordz,'String'),'°)'));
               r = str2double(get(handles.coordx,'String'));
               theta = str2double(get(handles.coordy,'String'))*pi/180;
               phi = str2double(get(handles.coordz,'String'))*pi/180;
               x = r*sin(theta)*cos(phi);
               y = r*sin(theta)*sin(phi);
               z = r*cos(theta);
               scatter3(x,y,z,15,handles.pointcolor,'filled'); 

             end
           
        elseif(get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 0)
           
           if(get(handles.mostrarPlanos,'Value') == 1)
               set(handles.debug,'string',strcat('Superfície em',{' '},unitheta,' =',{' '}, get(handles.coordy,'String'),'°'));
               set(handles.debug1,'string',strcat('Superfície em',{' '},uniphi,' =',{' '}, get(handles.coordz,'String'),'°'));
               planoEsf([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),handles);
               linhaEsf([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'p',handles)
           else
               set(handles.debug,'string','Linha variando em r');
               linhaEsf([],str2double(get(handles.coordy,'String')),str2double(get(handles.coordz,'String')),'l',handles)
           end
           
        elseif(get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)
           
           if(get(handles.mostrarPlanos,'Value') == 1) 
               set(handles.debug,'string',strcat('Superfície em r =',{' '}, get(handles.coordx,'String')));
               set(handles.debug1,'string',strcat('Superfície em',{' '},uniphi,' =',{' '}, get(handles.coordz,'String'),'°'));
               planoEsf(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),handles);
               linhaEsf(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'p',handles);
           else
               set(handles.debug,'string',strcat('Linha variando em',{' '},unitheta));
               linhaEsf(str2double(get(handles.coordx,'String')),[],str2double(get(handles.coordz,'String')),'l',handles)
           end
           
        elseif(get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)
           
           if(get(handles.mostrarPlanos,'Value') == 1) 
               set(handles.debug,'string',strcat('Superfície em r =',{' '}, get(handles.coordx,'String')));
               set(handles.debug1,'string',strcat('Superfície em',{' '},unitheta,' =',{' '}, get(handles.coordy,'String'),'°'));
               planoEsf(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],handles);
               linhaEsf(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'p',handles);
           else
               set(handles.debug,'string',strcat('Linha variando em',{' '},uniphi));
               linhaEsf(str2double(get(handles.coordx,'String')),str2double(get(handles.coordy,'String')),[],'l',handles); 
           end
           
        elseif(get(handles.checkx,'Value') == 0) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 1)
           
           set(handles.debug,'string',strcat('Superfície em r =',{' '}, get(handles.coordx,'String')));
           planoEsf(str2double(get(handles.coordx,'String')),[],[],handles);
           
        elseif(get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 0) && (get(handles.checkz,'Value') == 1)
           
           set(handles.debug,'string',strcat('Superfície em',{' '},unitheta,' =',{' '}, get(handles.coordy,'String'),'°'));
           planoEsf([],str2double(get(handles.coordy,'String')),[],handles);
           
        elseif(get(handles.checkx,'Value') == 1) && (get(handles.checky,'Value') == 1) && (get(handles.checkz,'Value') == 0)
           
           set(handles.debug,'string',strcat('Superfície em',{' '},uniphi,' =',{' '}, get(handles.coordz,'String'),'°'));
           planoEsf([],[],str2double(get(handles.coordz,'String')),handles);
           
        else
            %volume
            set(handles.debug0,'string',strcat(num2str(handles.rmin),' <',{' '}, 'r <',{' '},num2str(handles.rmax)));
            set(handles.debug,'string',strcat(num2str(handles.thetamin*180/pi),'° <',{' '},unitheta,{' '},'<',{' '},num2str(handles.thetamax*180/pi),'°'));
            set(handles.debug1,'string',strcat(num2str(handles.phimin*180/pi),'° <',{' '},uniphi,{' '},'<',{' '},num2str(handles.phimax*180/pi),'°'));
            planoEsf([],handles.thetamin*180/pi,[],handles);
            planoEsf([],handles.thetamax*180/pi,[],handles);
            planoEsf(handles.rmax,[],[],handles);
            planoEsf(handles.rmin,[],[],handles);
            if((handles.phimax - handles.phimin) ~= 2*pi)
                planoEsf([],[],handles.phimax*180/pi,handles);
                planoEsf([],[],handles.phimin*180/pi,handles);
            end
        end
    
    end
    %handles.edgecolor = [0.4 0.4 0.4];
    s.EdgeColor = handles.edgecolor;
    %s.EdgeAlpha = handles.edgealpha;
    %s.FaceAlpha = '0.9';
    if get(handles.checkboxwire,'Value') == 0
        shading interp 
    end
    light         % create a light
    lighting gouraud
    material dull
    colormap cool;
    %shading interp 
    set ( gca, 'xdir', 'reverse' );
    set ( gca, 'ydir', 'reverse' );
    set(gca,'xticklabel',{[]})
    set(gca,'yticklabel',{[]})
    set(gca,'zticklabel',{[]})
    afactor = 0;
    axis([-handles.limites+afactor handles.limites+afactor -handles.limites+afactor handles.limites+afactor -handles.limites+afactor handles.limites+afactor],'square');
    grid minor;
    hold off;

    if get(handles.cores3d1,'Value') == 1
        colormap summer
    elseif get(handles.cores3d2,'Value') == 1
        colormap pink
    elseif get(handles.cores3d3,'Value') == 1
        colormap bone
    elseif get(handles.cores3d4,'Value') == 1
        colormap default
    end
    zoom(1.4);
    rotate3d on;
    
    coordsel = get(handles.checkx,'Value') +  get(handles.checky,'Value') + get(handles.checkz,'Value');
    if(coordsel > 1)
        set(handles.mostrarPlanos,'Visible','off');
    else
        set(handles.mostrarPlanos,'Visible','on');
    end
    
    

function coordx_Callback(hObject, eventdata, handles)
% hObject    handle to coordx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordx as text
%        str2double(get(hObject,'String')) returns contents of coordx as a double


% --- Executes during object creation, after setting all properties.
function coordx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordy_Callback(hObject, eventdata, handles)
% hObject    handle to coordy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordy as text
%        str2double(get(hObject,'String')) returns contents of coordy as a double


% --- Executes during object creation, after setting all properties.
function coordy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordz_Callback(hObject, eventdata, handles)
% hObject    handle to coordz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordz as text
%        str2double(get(hObject,'String')) returns contents of coordz as a double


% --- Executes during object creation, after setting all properties.
function coordz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkx.
function checkx_Callback(hObject, eventdata, handles)
% hObject    handle to checkx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.checkx=peaks(35);
if get(hObject,'Value') == 1
    set(handles.coordx, 'Visible', 'off')
    set(handles.coordxmin, 'Visible', 'on')
    set(handles.coordxmax, 'Visible', 'on')
    %set(handles.coordxmin, 'String', num2str(handles.limites))
    %set(handles.coordxmax, 'String', '2')
else
    set(handles.coordx, 'Visible', 'on')
    set(handles.coordxmin, 'Visible', 'off')
    set(handles.coordxmax, 'Visible', 'off')
end
planos(hObject, eventdata, handles);
%patch([1 -1 -1 1], [1 1 -1 -1], [0 0 0 0], [1 1 -1 -1])
% Hint: get(hObject,'Value') returns toggle state of checkx


% --- Executes on button press in checky.
function checky_Callback(hObject, eventdata, handles)
% hObject    handle to checky (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    set(handles.coordy, 'Visible', 'off')
    set(handles.coordymin, 'Visible', 'on')
    set(handles.coordymax, 'Visible', 'on')
else
    set(handles.coordy, 'Visible', 'on')
    set(handles.coordymin, 'Visible', 'off')
    set(handles.coordymax, 'Visible', 'off')
end
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checky


% --- Executes on button press in checkz.
function checkz_Callback(hObject, eventdata, handles)
% hObject    handle to checkz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    set(handles.coordz, 'Visible', 'off')
    set(handles.coordz, 'Visible', 'off')
    set(handles.coordzmin, 'Visible', 'on')
    set(handles.coordzmax, 'Visible', 'on')
else
    set(handles.coordz, 'Visible', 'on')
    set(handles.coordzmin, 'Visible', 'off')
    set(handles.coordzmax, 'Visible', 'off')
end
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkz


% --- Executes on button press in mostrarPlanos.
function mostrarPlanos_Callback(hObject, eventdata, handles)
% hObject    handle to mostrarPlanos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of mostrarPlanos


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radioRet.
function radioRet_Callback(hObject, eventdata, handles)
% hObject    handle to radioRet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selecionaCoord(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radioRet


% --- Executes on button press in radioCil.
function radioCil_Callback(hObject, eventdata, handles)
% hObject    handle to radioCil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selecionaCoord(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radioCil


% --- Executes on button press in radioEsf.
function radioEsf_Callback(hObject, eventdata, handles)
% hObject    handle to radioEsf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selecionaCoord(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of radioEsf


% --- Executes on button press in checkboxtransp.
function checkboxtransp_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxtransp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxtransp


% --- Executes on button press in checkboxwire.
function checkboxwire_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxwire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);

% Hint: get(hObject,'Value') returns toggle state of checkboxwire



function max_Callback(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of max as text
%        str2double(get(hObject,'String')) returns contents of max as a double


% --- Executes during object creation, after setting all properties.
function max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordxmin_Callback(hObject, eventdata, handles)
% hObject    handle to coordxmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordxmin as text
%        str2double(get(hObject,'String')) returns contents of coordxmin as a double


% --- Executes during object creation, after setting all properties.
function coordxmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordxmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordxmax_Callback(hObject, eventdata, handles)
% hObject    handle to coordxmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordxmax as text
%        str2double(get(hObject,'String')) returns contents of coordxmax as a double


% --- Executes during object creation, after setting all properties.
function coordxmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordxmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordymin_Callback(hObject, eventdata, handles)
% hObject    handle to coordymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordymin as text
%        str2double(get(hObject,'String')) returns contents of coordymin as a double


% --- Executes during object creation, after setting all properties.
function coordymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordymax_Callback(hObject, eventdata, handles)
% hObject    handle to coordymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordymax as text
%        str2double(get(hObject,'String')) returns contents of coordymax as a double


% --- Executes during object creation, after setting all properties.
function coordymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordzmin_Callback(hObject, eventdata, handles)
% hObject    handle to coordzmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordzmin as text
%        str2double(get(hObject,'String')) returns contents of coordzmin as a double


% --- Executes during object creation, after setting all properties.
function coordzmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordzmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function coordzmax_Callback(hObject, eventdata, handles)
% hObject    handle to coordzmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%validaCampo(hObject, handles);
planos(hObject, eventdata, handles);
% Hints: get(hObject,'String') returns contents of coordzmax as text
%        str2double(get(hObject,'String')) returns contents of coordzmax as a double


% --- Executes during object creation, after setting all properties.
function coordzmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coordzmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkboxsim.
function checkboxsim_Callback(hObject, eventdata, handles)
% hObject    handle to checkboxsim (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of checkboxsim


% --- Executes on button press in cores3d1.
function cores3d1_Callback(hObject, eventdata, handles)
% hObject    handle to cores3d1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of cores3d1


% --- Executes on button press in cores3d2.
function cores3d2_Callback(hObject, eventdata, handles)
% hObject    handle to cores3d2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of cores3d2


% --- Executes on button press in cores3d3.
function cores3d3_Callback(hObject, eventdata, handles)
% hObject    handle to cores3d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of cores3d3


% --- Executes on button press in cores3d4.
function cores3d4_Callback(hObject, eventdata, handles)
% hObject    handle to cores3d4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
planos(hObject, eventdata, handles);
% Hint: get(hObject,'Value') returns toggle state of cores3d4
