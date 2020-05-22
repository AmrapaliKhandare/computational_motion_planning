function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************
m1= zeros(3,1);
m2= zeros(3,1);
c= zeros(6,4);
syms a b
T1=[P1(1,1),P1(1,2);P1(2,1),P1(2,2);P1(3,1),P1(3,2);P1(1,1),P1(1,2);P1(2,1),P1(2,2)];
T2=[P2(1,1),P2(1,2);P2(2,1),P2(2,2);P2(3,1),P2(3,2);P2(1,1),P2(1,2);P2(2,1),P2(2,2)];
 
for i=1:3
   for j= 1:4
       if j ==1
           a=T1(i+2,1);
           b=T1(i+2,2);
           m1(i,1) =(T1(i+1,2)-T1(i,2))/(T1(i+1,1)-T1(i,1));
           if m1(i,1) == inf || m1(i,1) == -inf
               c(i,j) = a-(T1(i,1) -T1(i,2)/m1(i,1)+ b/m1(i,1));
           else
               c(i,j) = b - (m1(i,1)*a-m1(i,1)*T1(i,1)+T1(i,2));
           end
       else
           a=T2(j-1,1);
           b=T2(j-1,2);
           m1(i,1) =(T1(i+1,2)-T1(i,2))/(T1(i+1,1)-T1(i,1));
           if m1(i,1) == inf || m1(i,1) == -inf
               c(i,j) = a-(T1(i,1) -T1(i,2)/m1(i,1)+ b/m1(i,1));
           else
               c(i,j) = b - (m1(i,1)*a-m1(i,1)*T1(i,1)+T1(i,2));
           end
          
       end
   end
end

for i=1:3
   for j= 1:4
       if j ==1
           a=T2(i+2,1);
           b=T2(i+2,2);
           m2(i,1) =(T2(i+1,2)-T2(i,2))/(T2(i+1,1)-T2(i,1));
           if m2(i,1) == inf || m2(i,1) == -inf
               c(i+3,j) = a-(T2(i,1) -T2(i,2)/m2(i,1)+ b/m2(i,1));
           else
               c(i+3,j) = b - (m2(i,1)*a-m2(i,1)*T2(i,1)+T2(i,2));
           end
       else
           a=T1(j-1,1);
           b=T1(j-1,2);
            m2(i,1) =(T2(i+1,2)-T2(i,2))/(T2(i+1,1)-T2(i,1));
           if m2(i,1) == inf || m2(i,1) == -inf
               c(i+3,j) = a-(T2(i,1) -T2(i,2)/m2(i,1)+ b/m2(i,1));
           else
               c(i+3,j) = b - (m2(i,1)*a-m2(i,1)*T2(i,1)+T2(i,2));
           end
          
       end
   end
end
a=zeros(1,6);
for i=1:6
   if c(i,1)<0 && c(i,2)>0 && c(i,3)>0 && c(i,4)>0
       a(1,i) = false;
   elseif c(i,1)>0 && c(i,2)<0 && c(i,3)<0 && c(i,4)<0
       a(1,i) = false;
   else
       a(1,i) = true;
   end
end

for i=1:6
   if a(1,i)== false
       flag = false;
       break
   else
       flag= true;
   end
end
% *******************************************************************
end
