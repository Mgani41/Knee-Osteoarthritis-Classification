function [Alpha_pos]=HYB(Max_iter,lb,ub,dim,tst_lab,XTrain,XTest,YTrain,YTest,la,iii,ini_weight,net,pop_size,dd)
% initialize alpha, beta, and delta_pos
Alpha_pos=zeros(1,dim);
Alpha_score=inf; %change this to -inf for maximization problems

Beta_pos=zeros(1,dim);
Beta_score=inf; %change this to -inf for maximization problems

Delta_pos=zeros(1,dim);
Delta_score=inf; %change this to -inf for maximization problems

%Initialize the positions of search agents
Positions=initialization1(ub,lb,dim,pop_size);
Convergence_curve=zeros(1,Max_iter);

l=0;% Loop counter

% Main loop
while l<Max_iter
    for i=1:size(Positions,1)              
        
        % Calculate objective function for each search agent
%         fitness=obj(Positions(i,:),tst_lab);
        fitness=obj(XTest,YTest,net,Positions(i,:),tst_lab,ini_weight,la,iii,dd);
        % Update Alpha, Beta, and Delta
        if fitness<Alpha_score
                Alpha_score=fitness; % Update alpha
                Alpha_pos=Positions(i,:);
                    end
        
        if fitness>Alpha_score && fitness<Beta_score 
            Beta_score=fitness; % Update beta
            Beta_pos=Positions(i,:);
                   end
        
        if fitness>Alpha_score && fitness>Beta_score && fitness<Delta_score 

            Delta_score=fitness; % Update delta
            Delta_pos=Positions(i,:);
                        
        end
    end
    
    
    a=2-l*((2)/Max_iter); % a decreases linearly fron 2 to 0
    
    % Update the Position of search agents including omegas
    for i=1:size(Positions,1)
        for j=1:size(Positions,2)     
                       
            r1=rand(); % r1 is a random number in [0,1]
            r2=rand(); % r2 is a random number in [0,1]
            
            A1=2*a*r1-a; 
            C1=2*r2; 
            
            D_alpha=abs(C1*Alpha_pos(j)-Positions(i,j));
            X1=Alpha_pos(j)-A1*D_alpha;
                       
            r1=rand();
            r2=rand();
            
            A2=2*a*r1-a; 
            C2=2*r2; 
            
            D_beta=abs(C2*Beta_pos(j)-Positions(i,j));
            X2=Beta_pos(j)-A2*D_beta;      
            
            r1=rand();
            r2=rand(); 
            
            A3=2*a*r1-a;
            C3=2*r2;
            
            D_delta=abs(C3*Delta_pos(j)-Positions(i,j)); 
            X3=Delta_pos(j)-A3*D_delta;           
            
            Positions_(i,j)=(X1+X2+X3)/3;
           
            
        end
    end
    l=l+1;    
end
end



