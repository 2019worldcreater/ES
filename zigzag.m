function out=zigzag(in,action)
if nargin<2
	action=0;
end
i=1;                                              
j=1;                                                
switch action
	case 0                                           
		f1=0;                                      
		f2=0;                                        
		m=size(in,1);  
        if m==1
            error('错误');
        end
		for k=1:m*m/2
			out(k)=in(i,j);
			out(m*m+1-k)=in(m+1-i,m+1-j);
			if i==1 
				f2=0;
				if f1==0
					j=j+1;
					f1=1;
				else
					i=i+1;
					j=j-1;
				end
    			else
        			if j==1
            			f1=0;
            			if f2==0
                			i=i+1;
                			f2=1;
            			else
                			i=i-1;
                			j=j+1;
            			end
        			else
            			if f1==1
                			i=i+1;
                			j=j-1;
            			else
                			i=i-1;
                			j=j+1;
            			end
        			end
    			end
		end
	case 1                                
                                                
		s1=1;
        if size(in)~=1
            error('错误');
        end
		m=sqrt(size(in,2));                       
		for x=1:m
			s2=s1+x-1;
			f=mod(x,2);
			for y=s1:s2
				out(i,j)=in(y);
        		out(m+1-i,m+1-j)=in(m*m+1-y);
				switch f
					case 1
            			i=i-1;
						j=j+1;
						if y==s2
							i=i+1;
						end
					case 0
						i=i+1;
						j=j-1;
						if y==s2
							j=j+1;
						end
				end
				s1=s2+1;
			end
		end
end
end