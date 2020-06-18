function [RA,locrec] = jdfly2(loc1,loc2,loc3,R)

vec1=loc1-loc2;
vec2=loc3-loc2;
vec3 = loc1-loc2;
ang1=acos(vec1*vec2'/norm(vec1)/norm(vec2));

RA = norm(loc1-loc2)+R*ang1;


end