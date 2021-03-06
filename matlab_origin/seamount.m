function[dx,dy,cor,...
    east_c,north_c,east_e,north_e,east_u,north_u,east_v,north_v,...
    h,art,aru,arv,fsm,dum,dvm,...
    tb,sb,tclim,sclim,ub,uab,elb,etb,dt,...
    aam2d,rho,rmean,rfe,rfw,rfn,rfs,...
    uabw,uabe,ele,elw,tbe,tbw,sbe,sbw,tbn,tbs,sbn,sbs] = seamount(dx,dy,cor,...
    east_c,north_c,east_e,north_e,east_u,north_u,east_v,north_v,...
    h,art,aru,arv,fsm,dum,dvm,...
    tb,sb,tclim,sclim,ub,uab,elb,etb,dt,...
    aam2d,rho,rmean,rfe,rfw,rfn,rfs,...
    uabw,uabe,ele,elw,tbe,tbw,sbe,sbw,tbn,tbs,sbn,sbs,...
    e_atmos,aam,im,jm,kb,imm1,jmm1,kbm1,slmax,zz,tbias,sbias,grav,rhoref)
    
% **********************************************************************
% *                                                                    *
% * FUNCTION    :  Sets up for seamount problem.                       *
% *                                                                    *
% **********************************************************************
%
%     Set delh > 1.0 for an island or delh < 1.0 for a seamount:

delh=0.9e0;
%     Grid size:
delx=8000.e0;
%     Radius island or seamount:
ra=25000.e0;
%     Current velocity:
vel=0.2e0;


%rho=zeros(im,jm);

for j=1:jm
	for i=1:im
%     For constant grid size:
%         dx(i,j)=delx
%         dy(i,j)=delx
%     Set up grid dimensions, areas of free surface cells, and
%     Coriolis parameter:
%
%     For variable grid size:
    	dx(i,j)=delx-delx*sin(pi*i/im)/2.0;
        dy(i,j)=delx-delx*sin(pi*j/jm)/2.0;
        cor(i,j)=1.e-4;
   
	end
end


% dx=repmat( (delx-delx*sin(pi*[1:im]'/im)/2.0), 1, jm );
% dy=repmat( (delx-delx*sin(pi*[1:jm]/jm)/2.0), im, 1  );
% cor=1.e-4;

%     Calculate horizontal coordinates of grid points and rotation
%     angle.
%
%     NOTE that this is introduced solely for the benefit of any post-
%     processing software, and in order to conform with the requirements
%     of the NetCDF Climate and Forecast (CF) Metadata Conventions.
%
%     There are four horizontal coordinate systems, denoted by the
%     subscripts u, v, e and c ("u" is a u-point, "v" is a v-point,
%     "e" is an elevation point and "c" is a cell corner), as shown
%     below. In addition, "east_*" is an easting and "north_*" is a
%     northing. Hence the coordinates of the "u" points are given by
%     (east_u,north_u).
%
%     Also, if the centre point of the cell shown below is at
%     (east_e(i,j),north_e(i,j)), then (east_u(i,j),north_u(i,j)) are
%     the coordinates of the western of the two "u" points,
%     (east_v(i,j),north_v(i,j)) are the coordinates of the southern of
%     the two "v" points, and (east_c(i,j),north_c(i,j)) are the
%     coordinates of the southwestern corner point of the cell. The
%     southwest corner of the entire grid is at
%     (east_c(1,1),north_c(1,1)).
%
%                      |              |
%                    --c------v-------c--
%                      |              |
%                      |              |
%                      |              |
%                      |              |
%                      u      e       u
%                      |              |
%                      |              |
%                      |              |
%                      |              |
%                    --c------v-------c--
%                      |              |
%
%
%     NOTE that the following calculation of east_c and north_c only
%     works properly for a rectangular grid with east and north aligned
%     with i and j, respectively:
%
%triA=[1 0 0]   triB=[1 1 1]
%     [1 1 0]        [0 1 1] 
%     [1 1 1]        [0 0 1]
%    Compute east_c and north_c
for j=1:jm
    east_c(1,j)=0.e0;
    for i=2:im
        east_c(i,j)=east_c(i-1,j)+dx(i-1,j);
    end
end

for i=1:im
    north_c(i,1)=0.e0;
    for j=2:jm
        north_c(i,j)=north_c(i,j-1)+dy(i,j-1);
    end
end

% triA=tril(ones(im,im));
% triB=triu(ones(jm,jm));
% 
% tmp=triA*dx;
% east_c=[zeros(1,jm); tmp(1:(im-1),:)];
% 
% tmp=dy*triB;
% north_c=[zeros(im,1) tmp(:,1:(jm-1))];

%
%     The following works properly for any grid:
%
%     Elevation points:
%
for j=1:jm-1
	for i=1:im-1
    	east_e(i,j)=(east_c(i,j)+east_c(i+1,j)+east_c(i,j+1)+east_c(i+1,j+1))/4.e0;
        north_e(i,j)=(north_c(i,j)+north_c(i+1,j)+north_c(i,j+1)+north_c(i+1,j+1))/4.e0;
    end
end
%     Extrapolate ends:
for i=1:im-1
    east_e(i,jm)=((east_c(i,jm)+east_c(i+1,jm))*3.e0-east_c(i,jm-1)-east_c(i+1,jm-1))/4.e0;
    north_e(i,jm)=((north_c(i,jm)+north_c(i+1,jm))*3.e0-north_c(i,jm-1)-north_c(i+1,jm-1))/4.e0;
end
%
for j=1:jm-1
	east_e(im,j)=((east_c(im,j)+east_c(im,j+1))*3.e0-east_c(im-1,j)-east_c(im-1,j+1))/4.e0;
    north_e(im,j)=((north_c(im,j)+north_c(im,j+1))*3.e0-north_c(im-1,j)-north_c(im-1,j+1))/4.e0;
end
%
east_e(im,jm)=east_e(im-1,jm)+east_e(im,jm-1)-(east_e(im-2,jm)+east_e(im,jm-2))/2.e0;
north_e(im,jm)=north_e(im-1,jm)+north_e(im,jm-1)-(north_e(im-2,jm)+north_e(im,jm-2))/2.e0;

%     u-points:
for j=1:jm-1
	for i=1:im
    	east_u(i,j)=(east_c(i,j)+east_c(i,j+1))/2.e0;
        north_u(i,j)=(north_c(i,j)+north_c(i,j+1))/2.e0;
    end
end
%     Extrapolate ends:
for i=1:im
	east_u(i,jm)=(east_c(i,jm)*3.0-east_c(i,jm-1))/2.e0;
    north_u(i,jm)=(north_c(i,jm)*3.0-north_c(i,jm-1))/2.e0;
end

%     v-points:
for j=1:jm
	for i=1:im-1
    	east_v(i,j)=(east_c(i,j)+east_c(i+1,j))/2.e0;
        north_v(i,j)=(north_c(i,j)+north_c(i+1,j))/2.e0;
    end
end
%     Extrapolate ends:
for j=1:jm
    east_v(im,j)=(east_c(im,j)*3.0-east_c(im-1,j))/2.e0;
    north_v(im,j)=(north_c(im,j)*3.0-north_c(im-1,j))/2.e0;
end

%     rot is the angle (radians, anticlockwise) of the i-axis relative
%     to east, averaged to a cell centre:
%
%     (NOTE that the following calculation of rot only works properly
%     for this particular rectangular grid)
%
rot=zeros(im,jm);

%     Define depth:
for i=1:im
    for j=1:jm
        h(i,j)=4500.e0*(1.e0-delh...
                            *exp(-((east_c(i,j)...
                                    -east_c((im+1)/2,j))^2 ...
                                    +(north_c(i,j)...
                                     -north_c(i,(jm+1)/2))^2)...
                                     /ra^2));
		if(h(i,j) < 1.e0) 
               h(i,j)=1.e0;
        end
	end 
end 

%     Close the north and south boundaries to form a channel:
for i=1:im
    h(i,1)=1.e0;
    h(i,jm)=1.e0;
end 

%     Calculate areas and masks:
[art,aru,arv,fsm,dum,dvm]=areas_masks(art,aru,arv,fsm,dum,dvm,...
        im,jm,dx,dy,h);


%     Adjust bottom topography so that cell to cell variations
%     in h for not exceed parameter slmax:
if(slmax < 1.e0) 
	[h] = slpmax(h,im,jm,fsm,slmax);
end

%     Set initial conditions:


for k=1:kbm1
	for j=1:jm
    	for i=1:im
            tb(i,j,k)=5.e0+15.e0*exp(zz(k)*h(i,j)/1000.e0)-tbias;
            sb(i,j,k)=35.0-sbias;
            tclim(i,j,k)=tb(i,j,k);
            sclim(i,j,k)=sb(i,j,k);
            ub(i,j,k)=vel*dum(i,j);
    	end
   end
end 

%     Initialise uab and vab as necessary
%     (NOTE that these have already been initialised to zero in the
%     main program):
uab=vel*dum;

%     Set surface boundary conditions, e_atmos, vflux, wusurf,
%     wvsurf, wtsurf, wssurf and swrad, as necessary
%     (NOTE:
%      1. These have all been initialised to zero in the main program.
%      2. The temperature and salinity of inflowing water must be
%         defined relative to tbias and sbias.):

%     Initialise elb, etb, dt and aam2d:
elb=-e_atmos;
etb=-e_atmos;
dt=h-e_atmos;
aam2d=aam(:,:,1);

[sb,tb,rho]=dens(sb,tb,rho,im,jm,kbm1,tbias,sbias,grav,rhoref,zz,h,fsm);

%     Generated horizontally averaged density field (in this
%     application, the initial condition for density is a function
%     of z (the vertical cartesian coordinate) -- when this is not
%     so, make sure that rmean has been area averaged BEFORE transfer
%     to sigma coordinates):

for k=1:kbm1
   for j=1:jm
       for i=1:im
          rmean(i,j,k) = rho(i,j,k);
       end
   end
end
%     Set lateral boundary conditions, for use in subroutine bcond
%     (in the seamount problem, the east and west boundaries are open,
%     while the south and north boundaries are closed through the
%     specification of the masks fsm, dum and dvm):
rfe=1.e0;
rfw=1.e0;
rfn=1.e0;
rfs=1.e0;

for j=2:jmm1
	uabw(j)=uab(2,j);
    uabe(j)=uab(imm1,j);
%    Set geostrophically conditioned elevations at the boundaries:
    ele(j)=ele(j-1)-cor(imm1,j)*uab(imm1,j)/grav*dy(imm1,j-1);
    elw(j)=elw(j-1)-cor(2,j)*uab(2,j)/grav*dy(2,j-1);
end

%     Adjust boundary elevations so that they are zero in the middle
%     of the channel:
elejmid=ele(jmm1/2);
elwjmid=elw(jmm1/2);

for j=2:jmm1
    ele(j)=(ele(j)-elejmid)*fsm(im,j);
    elw(j)=(elw(j)-elwjmid)*fsm(2,j);
end
  
%     Set thermodynamic boundary conditions (for the seamount
%     problem, and other possible applications, lateral thermodynamic
%     boundary conditions are set equal to the initial conditions and
%     are held constant thereafter - users may, of course, create
%     variable boundary conditions):
for k=1:kbm1
	for j=1:jm
   		tbe(j,k)=tb(im,j,k);
        tbw(j,k)=tb(1,j,k);
        sbe(j,k)=sb(im,j,k);
        sbw(j,k)=sb(1,j,k);
	end
 
	for i=1:im
        tbn(i,k)=tb(i,jm,k);
        tbs(i,k)=tb(i,1,k);
        sbn(i,k)=sb(i,jm,k);
        sbs(i,k)=sb(i,1,k);
  	end
end
return 
end

