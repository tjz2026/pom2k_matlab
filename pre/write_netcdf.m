if (strcmp(Problem_name,'seamount'))
    ncid      =    netcdf.create('seamount.nc','NC_CLOBBER');
elseif(strcmp(Problem_name,'box'))
    ncid      =    netcdf.create('box.nc','NC_CLOBBER');
elseif(strcmp(Problem_name,'file2ic'))
    ncid      =    netcdf.create('file2ic.nc','NC_CLOBBER');
else
   fprintf('error problem_name \n');
end
imx       =    netcdf.defDim(ncid,'im',im);     jmy       =    netcdf.defDim(ncid,'jm',jm);
kbz       =    netcdf.defDim(ncid,'kb',kb);     dconst    =    netcdf.defDim(ncid,'dc',1);

rfeid     =    netcdf.defVar(ncid,'rfe','double',[dconst dconst]);
rfwid     =    netcdf.defVar(ncid,'rfw','double',[dconst dconst]);
rfnid     =    netcdf.defVar(ncid,'rfn','double',[dconst dconst]);
rfsid     =    netcdf.defVar(ncid,'rfs','double',[dconst dconst]);
zid       =    netcdf.defVar(ncid,'z','double',[dconst kbz]);
zzid      =    netcdf.defVar(ncid,'zz','double',[dconst kbz]);
dzid      =    netcdf.defVar(ncid,'dz','double',[dconst kbz]);
dzzid     =    netcdf.defVar(ncid,'dzz','double',[dconst kbz]);
uabwid    =    netcdf.defVar(ncid,'uabw','double',[dconst jmy]);
uabeid    =    netcdf.defVar(ncid,'uabe','double',[dconst jmy]);
eleid     =    netcdf.defVar(ncid,'ele','double',[dconst jmy]);
elwid     =    netcdf.defVar(ncid,'elw','double',[dconst jmy]);
elsid     =    netcdf.defVar(ncid,'els','double',[dconst imx]);
elnid     =    netcdf.defVar(ncid,'eln','double',[dconst imx]);
vabsid    =    netcdf.defVar(ncid,'vabs','double',[dconst imx]);
vabnid    =    netcdf.defVar(ncid,'vabn','double',[dconst imx]);

dxid      =    netcdf.defVar(ncid,'dx','double',[imx jmy]);
dyid      =    netcdf.defVar(ncid,'dy','double',[imx jmy]);
corid     =    netcdf.defVar(ncid,'cor','double',[imx jmy]);
east_eid  =    netcdf.defVar(ncid,'east_e','double',[imx jmy]);
north_eid =    netcdf.defVar(ncid,'north_e','double',[imx jmy]);
east_cid  =    netcdf.defVar(ncid,'east_c','double',[imx jmy]);
north_cid =    netcdf.defVar(ncid,'north_c','double',[imx jmy]);
east_uid  =    netcdf.defVar(ncid,'east_u','double',[imx jmy]);
north_uid =    netcdf.defVar(ncid,'north_u','double',[imx jmy]);
east_vid  =    netcdf.defVar(ncid,'east_v','double',[imx jmy]);
north_vid =    netcdf.defVar(ncid,'north_v','double',[imx jmy]);
hid       =    netcdf.defVar(ncid,'h','double',[imx jmy]);
artid     =    netcdf.defVar(ncid,'art','double',[imx jmy]);
aruid     =    netcdf.defVar(ncid,'aru','double',[imx jmy]);
arvid     =    netcdf.defVar(ncid,'arv','double',[imx jmy]);
fsmid     =    netcdf.defVar(ncid,'fsm','double',[imx jmy]);
dumid     =    netcdf.defVar(ncid,'dum','double',[imx jmy]);
dvmid     =    netcdf.defVar(ncid,'dvm','double',[imx jmy]);
uabid     =    netcdf.defVar(ncid,'uab','double',[imx jmy]);
elbid     =    netcdf.defVar(ncid,'elb','double',[imx jmy]);
etbid     =    netcdf.defVar(ncid,'etb','double',[imx jmy]);
dtid      =    netcdf.defVar(ncid,'dt','double',[imx jmy]);
aam2did   =    netcdf.defVar(ncid,'aam2d','double',[imx jmy]);
rotid     =    netcdf.defVar(ncid,'rot','double',[imx jmy]);
ssurfid   =    netcdf.defVar(ncid,'ssurf','double',[imx jmy]);
tsurfid   =    netcdf.defVar(ncid,'tsurf','double',[imx jmy]);
wusurfid  =    netcdf.defVar(ncid,'wusurf','double',[imx jmy]);
wvsurfid  =    netcdf.defVar(ncid,'wvsurf','double',[imx jmy]);

tbeid     =    netcdf.defVar(ncid,'tbe','double',[jmy kbz]);
sbeid     =    netcdf.defVar(ncid,'sbe','double',[jmy kbz]);
ubwid     =    netcdf.defVar(ncid,'ubw','double',[jmy kbz]);
ubeid     =    netcdf.defVar(ncid,'ube','double',[jmy kbz]);
sbwid     =    netcdf.defVar(ncid,'sbw','double',[jmy kbz]);
tbwid     =    netcdf.defVar(ncid,'tbw','double',[jmy kbz]);
tbnid     =    netcdf.defVar(ncid,'tbn','double',[imx kbz]);
tbsid     =    netcdf.defVar(ncid,'tbs','double',[imx kbz]);
sbnid     =    netcdf.defVar(ncid,'sbn','double',[imx kbz]);
sbsid     =    netcdf.defVar(ncid,'sbs','double',[imx kbz]);
vbsid     =    netcdf.defVar(ncid,'vbs','double',[imx kbz]);
vbnid     =    netcdf.defVar(ncid,'vbn','double',[imx kbz]);

tbid     =    netcdf.defVar(ncid,'tb','double',[imx jmy kbz]);
sbid     =    netcdf.defVar(ncid,'sb','double',[imx jmy kbz]);
tclimid  =    netcdf.defVar(ncid,'tclim','double',[imx jmy kbz]);
sclimid  =    netcdf.defVar(ncid,'sclim','double',[imx jmy kbz]);
ubid     =    netcdf.defVar(ncid,'ub','double',[imx jmy kbz]);
rhoid    =    netcdf.defVar(ncid,'rho','double',[imx jmy kbz]);
rmeanid  =    netcdf.defVar(ncid,'rmean','double',[imx jmy kbz]);
vbid     =    netcdf.defVar(ncid,'vb','double',[imx jmy kbz]);

netcdf.endDef(ncid);

netcdf.putVar(ncid,rfeid,rfe);          netcdf.putVar(ncid,rfwid,rfw);
netcdf.putVar(ncid,rfnid,rfn);          netcdf.putVar(ncid,rfsid,rfs);
netcdf.putVar(ncid,zid,z);              netcdf.putVar(ncid,zzid,zz);
netcdf.putVar(ncid,dzid,dz);            netcdf.putVar(ncid,dzzid,dzz);
netcdf.putVar(ncid,uabwid,uabw);        netcdf.putVar(ncid,uabeid,uabe);
netcdf.putVar(ncid,eleid,ele);          netcdf.putVar(ncid,elwid,elw);
netcdf.putVar(ncid,dxid,dx);            netcdf.putVar(ncid,dyid,dy);
netcdf.putVar(ncid,corid,cor);          netcdf.putVar(ncid,east_eid,east_e);
netcdf.putVar(ncid,north_eid,north_e);  netcdf.putVar(ncid,east_cid,east_c);
netcdf.putVar(ncid,north_cid,north_c);  netcdf.putVar(ncid,east_uid,east_u);
netcdf.putVar(ncid,north_uid,north_u);  netcdf.putVar(ncid,east_vid,east_v);
netcdf.putVar(ncid,north_vid,north_v);  netcdf.putVar(ncid,hid,h);
netcdf.putVar(ncid,artid,art);          netcdf.putVar(ncid,aruid,aru);
netcdf.putVar(ncid,arvid,arv);          netcdf.putVar(ncid,fsmid,fsm);
netcdf.putVar(ncid,dumid,dum);          netcdf.putVar(ncid,dvmid,dvm);
netcdf.putVar(ncid,uabid,uab);          netcdf.putVar(ncid,elbid,elb);
netcdf.putVar(ncid,etbid,etb);          netcdf.putVar(ncid,dtid,dt);
netcdf.putVar(ncid,aam2did,aam2d);      netcdf.putVar(ncid,wusurfid,wusurf);
netcdf.putVar(ncid,wvsurfid,wvsurf);    netcdf.putVar(ncid,tbeid,tbe);
netcdf.putVar(ncid,sbeid,sbe);          netcdf.putVar(ncid,sbwid,sbw);
netcdf.putVar(ncid,tbwid,tbw);          netcdf.putVar(ncid,tbnid,tbn);
netcdf.putVar(ncid,tbsid,tbs);          netcdf.putVar(ncid,sbnid,sbn);
netcdf.putVar(ncid,sbsid,sbs);          netcdf.putVar(ncid,tbid,tb);
netcdf.putVar(ncid,sbid,sb);            netcdf.putVar(ncid,tclimid,tclim);
netcdf.putVar(ncid,sclimid,sclim);      netcdf.putVar(ncid,ubid,ub);
netcdf.putVar(ncid,rhoid,rho);          netcdf.putVar(ncid,rmeanid,rmean);
netcdf.putVar(ncid,vbid,vb);            netcdf.putVar(ncid,rotid,rot);
netcdf.putVar(ncid,elsid,els);          netcdf.putVar(ncid,elnid,eln);
netcdf.putVar(ncid,vabsid,vabs);        netcdf.putVar(ncid,vabnid,vabn);
netcdf.putVar(ncid,ubwid,ubw);          netcdf.putVar(ncid,ubeid,ube);
netcdf.putVar(ncid,vbsid,vbs);          netcdf.putVar(ncid,vbnid,vbn);
netcdf.putVar(ncid,ssurfid,ssurf);      netcdf.putVar(ncid,tsurfid,tsurf);
netcdf.close(ncid);