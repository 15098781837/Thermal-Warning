%% Generating data
tin=load('26.3in.txt');
tsurface=load('26.3surface.txt');
I=load('I6.txt');
for i=1:40001
    if mod(floor(i/100),2)==0
        I(i,2)=I(i,2);
    else
        I(i,2)=-I(i,2);
    end
end
tin(:,1)=tin(:,1)-6.43216080402010e+002 ;
tsurface(:,1)=tsurface(:,1)-6.63316582914573e+002;
x=0:1:3200;
Tin=interp1(tin(:,1),tin(:,2),x);
Tin=Tin';
Tsurface=interp1(tsurface(:,1),tsurface(:,2),x);
Tsurface=Tsurface';
r1=load('r.txt');
soc=zeros(16000,1);
soc(1)=0.8;
Q=zeros(3201,1);
t=zeros(3201,1);
t(1)=Tin(1);
Q(1)=I(1,2)*I(1,2)*interp1(r1(:,1),r1(:,2),t(1));
ts=zeros(3201,1);
ts(1)=Tsurface(1);
%% Generating data using models
k1=1.286;k2=0.3009;c1=264.7;c2=30.7;

c11=zeros(16000,1); c22=zeros(16000,1);k11=zeros(16000,1);k22=zeros(16000,1);
k11(1)=1.286;k22(1)=0.3009;c11(1)=264.7;c22(1)=30.7;
theta=zeros(4,16000);
 for i=2:1:2000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,i)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(i)=k1;k22(i)=k2;c11(i)=c1;c22(i)=c2;
     t(i)=(1/c1)*Q(i-1)+(1-k1/c1)*t(i-1)+(k1/c1)*ts(i-1);
     ts(i)=(k1/c2)*t(i-1)+(1-(k1+k2)/c2)*ts(i-1)+(k2/c2)*26.3;
     Q(i)=I(i,2)*I(i,2)*interp1(r1(:,1),r1(:,2),t(i));
     soc(i)=soc(i-1)-I(i-1,2)/(10*3600);
 end
 for k=2001:4000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=4001:6000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
    k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
    soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=6001:8000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
    soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=8001:10000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=10001:12000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
    k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=12001:14000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
    k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=14001:16000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
    soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end  
 for k=16001:18000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
    k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=18001:20000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
    soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end  
 for k=20001:22000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
    k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 for k=22001:24000
     k1=(1+0.0001)*k1;k2=(1+0.0001)*k2;c1=(1-0.0001)*c1;c2=(1-0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
    soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end  
 for k=24001:26000
     k1=(1-0.0001)*k1;k2=(1-0.0001)*k2;c1=(1+0.0001)*c1;c2=(1+0.0001)*c2;
     theta(:,k)=[1-k1/c1+(k1-k2)/c2;k1*k1/c1/c2-1+k1/c1;k1/c1/c2;k1*k2/c1/c2];
     k11(k)=k1;k22(k)=k2;c11(k)=c1;c22(k)=c2;
     t(k)=(1/c1)*Q(k-1)+(1-k1/c1)*t(k-1)+(k1/c1)*ts(k-1);
     ts(k)=(k1/c2)*t(k-1)+(1-(k1+k2)/c2)*ts(k-1)+(k2/c2)*26.3;
     Q(k)=I(k,2)*I(k,2)*interp1(r1(:,1),r1(:,2),t(k));
     soc(k)=soc(k-1)-I(k-1,2)/(10*3600);
 end
 figure;
 plot(1:26000,t,1:26000,ts)
 figure;
 plot(1:26000,I(1:26000,2),1:26000,Q);
 %% The method of electrothermal model
       tse=importdata('tse.mat') ; 
       Qe=importdata('Qe.mat') ; 
       para2=zeros(26000,4);
       tk=t(2:26000);
       tk_1=t(1:25999);
       tsk=tse(3:26000);
       tsk_1=tse(2:25999);
       tsk_2=tse(1:25998);
       
       Qk=Qe(3:26000);
       Qk_1=Qe(2:25999);
       Qk_2=Qe(1:25998);

       tamb=26.3*ones(size(Qk));
       lamda1=[tsk_1,tsk_2,Qk_2,tamb]';
       y=tse(3:26000);
       theta10=[0;0;0;0];
       P10=1e9*eye(4);
       theta_ls(:,1)=theta10;
        
    for k=1:98
        K1=P10*lamda1(:,k)/(1+lamda1(:,k)'*P10*lamda1(:,k));
        theta1=theta10+K1*(y(k)-lamda1(:,k)'*theta10);
        P1=(eye(4)-K1*lamda1(:,k)')*P10/1;
        P10=P1;
        theta10=theta1; 
        theta_ls(:,k+1)=theta10;
    end
    ts_pre_model=zeros(16000,1);
    ts_pre_model2=zeros(16001,1);
    for k=99:25998
        ts_pre_model(k+2)=[ts(k+1),ts(k),Q(k),26.3]*theta10;
        ts_pre_model2(k+3)=[ts_pre_model(k+2),ts(k+1),Q(k+1),26.3]*theta10;
        K1=P10*lamda1(:,k)/(1+lamda1(:,k)'*P10*lamda1(:,k));
        theta1=theta10+K1*(y(k)-lamda1(:,k)'*theta10);
        P1=(eye(4)-K1*lamda1(:,k)')*P10/1;
        P10=P1;
        theta10=theta1; 
        theta_ls(:,k+1)=theta10;
    end
    ts_model_12000=[ts_pre_model(14000:25999),ts_pre_model2(14001:26000)];
    %Prediction results of electrothermal model；Save to file ts_model_12000.mat
    mse = (mean((ts_pre_model(14001:24000)-ts(14001:24000)).^2))
    mse2=(mean((ts_pre_model2(14001:24000)-ts(14001:24000)).^2))
%     figure;
%     plot(1:1:12000,ts_pre_model(14001:24000),1:1:12000,ts(14001:24000)) 
%     legend('prediction','real value');
%     figure;
%     plot(1:1:12000,ts_pre_model2(14001:26000),1:1:12000,ts(14001:26000))
%     legend('prediction','real value');    
   