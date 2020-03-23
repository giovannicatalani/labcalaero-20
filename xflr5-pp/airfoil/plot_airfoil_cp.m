filename       = 'data/NACA 0012.dat';
delimiterIn    = ' ';
headerlinesIn  = 1;
format long;
airfoil_struct = importdata(filename,delimiterIn,headerlinesIn);


fields = fieldnames(airfoil_struct);
coord  = char(fields(1));

airfoil_coord = airfoil_struct.(coord);

l=sqrt((diff(airfoil_coord(:,2))).^2+(diff(airfoil_coord(:,1))).^2);
cos_theta=-diff(airfoil_coord(:,1))./l;
sin_theta=diff(airfoil_coord(:,2))./l;


for i=1:6
    
alfa=i;
filename       = ['data/naca0012-cp-a' num2str(i) '0.txt'];
delimiterIn    = ' ';
headerlinesIn  = 6;
format long;

analysis_struct = importdata(filename,delimiterIn,headerlinesIn);

fields = fieldnames(analysis_struct);
analysis  = char(fields(1));

airfoil_analysis = analysis_struct.(analysis);
cp=0.5*(airfoil_analysis(1:end-1,2)+airfoil_analysis(2:end,2));
a=(cp.*cos_theta);
b=(a.*l);
c=(cp.*sin_theta);
d=(c.*l);
cl_c=-sum(b(:,1));
cd_c=sum(d(:,1));
cl(i)=cl_c*cos(alfa*pi/180)+cd_c*sin(alfa*pi/180);
cd(i)=cd_c*cos(alfa*pi/180)-cl_c*sin(alfa*pi/180);


end
figure
plot(cl,'r-')
