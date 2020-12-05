import matplotlib.pyplot as plt
import math

depth = 5 #cm
density = 1 #g/cm^3
g = 980 #cm/s^2
tension = 72.75 #mN/m
lambdaa = 1500 #(lambda)cm #example
widthofunit = 100 #cm
amplitude = 25 #cm #example
K = amplitude * depth ** ( 1/4 ) #const.
velocity = 421 #m/s #example


t=15 #PRINT SEVERAL TIME



omega = ( 2*math.pi ) * velocity / lambdaa


for layer in range ( 0 , 8 ) :

    for n in range ( 1 , 101 , 2 ) :

        

        x = ( widthofunit / 2 ) * n
    
        y = - ( widthofunit / 2 ) - ( layer * widthofunit )
        
        x1 = x + amplitude * math.cos ( - omega * ( t -  (n-1) * widthofunit / ( velocity * 2 )   ) )
    
        y1 = y + amplitude * math.sin ( - omega * ( t -  (n-1) * widthofunit / ( velocity * 2 )   ) )
                
            
        
        
        plt.plot ( x1 , y1 ,"r*")
    


    depth -= 10
    
    amplitude = k * (-depth) ** (- 1 / 4)


plt.xlim(0,6000)
plt.ylim(-1000,0)
plt.show()

#議題.....
#波速
#水分子震動半徑隨深度變化
