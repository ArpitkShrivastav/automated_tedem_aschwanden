;goto, step1
wave_ =['94','131','171','193','211','335']
dir = '/home/arpit/Documents/Project1_Forward modelling/automated_tedem_aschwanden/'
fileset=dir+'aia_2011-02-15_0000' ;   (searchstring for datafiles)
io=3 ;   (0=screen, 3=color postscript file)
ct=3 ;   (IDL color table)
nsig=3 ;   (contrast in number of standard deviations)
nsm=7 ;   (smoothing boxcar of limb profiles)
aia_coalign_test,fileset,wave_,io,ct,nsig,nsm,h_km,dx,dy
data_files = fileset+'_'+wave_+'.fits'
te_range=[0.5,20]*1.e6 ;   ([K], valid temperature range for DEM solutions)
tsig=0.1*(1+1*findgen(10)) ;   (values of Gaussian logarithmic temperature widths)
q94=1.0 ;   (correction factor for low-temperature 94 A response)
fov=[-1,-1,1,1]*1.15 ;   (field-of-view [x1,y1,x2,y2] in solar radii)
npix=8 ;   (macropixel size=8x8 pixels, yields 512x512 map)
vers='a' ;   (version number of label in filenames used for full images)
teem_table='teem_table.sav' ;   (savefile that contains DEM loopup table)
teem_map =fileset+vers+'_teem_map.sav' ;   (savefile that contains EM and Te maps)
teem_jpeg=fileset+vers+'_teem_map.jpg' ;   (jpg-file that shows EM and Te maps)
aia_teem_table2,data_files,wave_,tsig,te_range,q94,teem_table
aia_teem_map2,data_files,fov,wave_,npix,teem_table,teem_map
aia_teem_disp2,teem_map,te_range,t1,teem_jpeg
fov=[-0.03,-0.52,0.60,0.11] ;   (field-of-view [x1,y1,x2,y2] of AR 1158)
npix=2 ;   (macropixel size=2x2 pixels, yields 512x512 map)
vers='b' ;   (version number or label in filenames used for AR 1158)
teem_map =fileset+vers+'_teem_map.sav' ;   (savefile that contains EM and Te maps)
teem_jpeg=fileset+vers+'_teem_map.jpg' ;   (jpg-file that shows EM and Te maps)
aia_teem_map2,data_files,fov,wave_,npix,teem_table,teem_map
aia_teem_disp2,teem_map,te_range,t1,teem_jpeg
;iwave=1 ;   (0,1,2,3,4,5 = number of wavelength filter for tracing)
;nsig=3 ;   (number of standard deviations to display flux contrast)
;aia_loop_manu,fileset,wave_,iwave,fov,nsig,vers
vers='c' ;   (label in filename)
fov=[0.00,-0.45,0.45,-0.10] ;   (field-of-view [x1,y1,x2,y2] in solar radii)
rmin=25 ;   (minimum curvature radius of loop in pixels)
wid=3 ;   (typical half width of loop in pixels)
nsig=1.0 ;   (threshold level in flux standard deviations)
qfill=0.35 ;   (minimum filling factor of traced structure)
reso=10 ;   (output resolution of traced loops in pixels)
n=10000 ;   (maximum limit of traced structures)
test=n+1 ;   (minimum number of traced loop structure)
cutoff=0.01 ;   (minimum loop length in solar radii)
para=[rmin,wid,nsig,qfill,reso,n]
aia_loop_auto,fileset,wave_,fov,para,test,cutoff,vers
ns_step=5 ;   (number of loop points to integrate along loop)
nw=25 ;   (loop cross-sectional width in pixels)
segmin=0.1;   (minimum loop length in solar units to display)
vers='c' ;   (version label)
chimax=2.0;   (upper limit of acceptable chi-square)
test=0 ;   (1=display of fits to each loop cross-section)
cubefile =fileset+vers+'_teem_cube.sav' ;   (name of savefile for loop EM and Te values)
aia_loop_autodem,fileset,wave_,fov,ns_step,nw,segmin,vers,teem_table,chimax,test
END
