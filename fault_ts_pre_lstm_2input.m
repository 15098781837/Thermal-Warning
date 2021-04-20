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
%ts is the real surface temperature；Save to ts_real.mat
%% Data normalization
  ts_r=ts+randn(size(ts));%Surface temperature with noise added；Save to tse.mat
  Q_r=Q+randn(size(Q));
  Q1=Q_r';
  t1=t';
  ts1=ts_r';
  tamb1=26.3*ones(size(Q1));
  c111=c11(1:14000)';c221=c22(1:14000)';k111=k11(1:14000)';k221=k22(1:14000)';
  k=20;j=2;
  input_train1=[];
  input_train2=[]; 
  input_train=[];
  input_validation1=[];
  input_validation2=[];
  input_validation=[];
  input_test1=[];
  input_test2=[];
  input_test=[];
  output_train=[];
  output_validation=[];
  output_test=[];
  for i=1:k
     input_train1= [input_train1;ts1(i:12099+i);tamb1(i:12099+i)];
     input_train2= [input_train2;Q1(i:12099+i);soc(i:12099+i)'];
     % output_train =[t1(k+1:12100+k);t1(k+2:12101+k);t1(9:12108);t1(10:12109)];
     input_validation1 = [input_validation1;ts1(12100+i:14000-j-k+i);tamb1(12100+i:14000-j-k+i)];
     input_validation2 = [input_validation2;Q1(12100+i:14000-j-k+i);soc(12100+i:14000-j-k+i)'];
     % output_validation =[t1(12101+k:14000-j);t1(12108:13998);t1(12109:13999);t1(12110:14000)];
     input_test1=[input_test1;ts1(14001-j-k+i:26000-j-k+i);tamb1(14001-j-k+i:26000-j-k+i)];
     input_test2=[input_test2;Q1(14001-j-k+i:26000-j-k+i);soc(14001-j-k+i:26000-j-k+i)'];
  end
  input_train=[input_train1;input_train2];
  input_validation=[input_validation1;input_validation2];
  input_test=[input_test1;input_test2];
  for i=1:j
      output_train=[output_train;ts(k+i:12099+k+i)'];
      output_validation=[output_validation;ts(12100+k+i:14000-j+i)'];
      output_test=[output_test;ts(14001-j+i:26000-j+i)'];
  end
   [inputn_train,inputps]=mapstd(input_train);
   [outputn_train,outputps]=mapstd(output_train);
   inputn_validation=mapstd('apply',input_validation,inputps);
   outputn_validation=mapstd('apply',output_validation,outputps);
   c112=c11(13999:16000)';c222=c22(13999:16000)';k112=k11(13999:16000)';k222=k22(13999:16000)';
%  input_test = [t2(2:2001);t2(1:2000);ts2(2:2001);ts2(1:2000);Q2(2:2001);Q2(1:2000);tamb2(2:2001)];
   outputn_test=mapstd('apply',output_test,outputps);
   inputn_test=mapstd('apply',input_test,inputps);
%% Creating LSTM regression network
inputsize=4*k;
outputsize=inputsize/2;
w1=[eye(outputsize),zeros(outputsize)];
b1=zeros(outputsize,1);
w2=[zeros(outputsize),eye(outputsize)];
b2=zeros(outputsize,1);
lgraph = layerGraph();
tempLayers = sequenceInputLayer(4*k,"Name","sequence");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    fullyConnectedLayer(40,'Weights',w1,'Bias',b1,'WeightLearnRateFactor',0,'BiasLearnRateFactor',0,'WeightL2Factor',0,"Name","fc_2")
    lstmLayer(64,"Name","lstm_2")
    dropoutLayer(0.5,"Name","dropout_2")
    lstmLayer(32,"Name","lstm_4")
    dropoutLayer(0.5,"Name","dropout_4")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    fullyConnectedLayer(40,'Weights',w2,'Bias',b2,'WeightLearnRateFactor',0,'BiasLearnRateFactor',0,'WeightL2Factor',0, "Name","fc_1")
    lstmLayer(64,"Name","lstm_1")
    dropoutLayer(0.5,"Name","dropout_1")
    lstmLayer(16,"Name","lstm_3")
    dropoutLayer(0.5,"Name","dropout_3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    concatenationLayer(1,2,"Name","concat")
    tanhLayer("Name","tanh")
    fullyConnectedLayer(32,"Name","fc_4")
    reluLayer("Name","relu")
    fullyConnectedLayer(j,"Name","fc_3")
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);
clear tempLayers;
lgraph = connectLayers(lgraph,"sequence","fc_2");
lgraph = connectLayers(lgraph,"sequence","fc_1");
lgraph = connectLayers(lgraph,"dropout_4","concat/in2");
lgraph = connectLayers(lgraph,"dropout_3","concat/in1");

options = trainingOptions('adam', ...
    'ExecutionEnvironment','cpu',...
    'MaxEpochs',550, ...
    'GradientThreshold',1, ...
    'InitialLearnRate',0.001, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropPeriod',400, ...
    'LearnRateDropFactor',0.2, ...
    'ValidationData',{inputn_validation,outputn_validation},...
    'ValidationFrequency',10,...
     'ValidationPatience',50,...
    'Verbose',0, ...
    'Plots','training-progress');

%% Training and Prediction
[net,info] = trainNetwork(inputn_train,outputn_train,lgraph,options);
net = resetState(net);
[net,LSTMoutputr_train]= predictAndUpdateState(net,inputn_train);
LSTMoutput_train=mapstd('reverse',LSTMoutputr_train,outputps);
[net,LSTMoutputr_validation]= predictAndUpdateState(net,inputn_validation);
LSTMoutput_validation=mapstd('reverse',LSTMoutputr_validation,outputps);
[net,LSTMoutputr_test]= predictAndUpdateState(net,inputn_test);
LSTMoutput_test=mapstd('reverse',LSTMoutputr_test,outputps);
%Prediction results of LSTM prediction network;Save to ts_lstm_12000.mat
LSTMoutput=[LSTMoutput_train,LSTMoutput_validation,LSTMoutput_test];
LSTMoutputr=[LSTMoutputr_train,LSTMoutputr_validation,LSTMoutputr_test];
output=[output_train,output_validation,output_test];
outputn=[outputn_train,outputn_validation,outputn_test];
%% Analysis
for i=1:j
    rmse(i) = (mean((LSTMoutput(i,:)-output(i,:)).^2))
end
for i=1:j
    mse(i) = (mean((LSTMoutput_test(i,:)-output_test(i,:)).^2))
end
for i=1:j
    figure
    plot((k+i):(16000-j+i),ts(k+i:16000-j+i),(k+i):(16000-j+i),LSTMoutput(i,:));
    legend('Real','Prediction')
end
for i=1:j
     figure
     plot(1:12000,ts(14001-j+i:26000-j+i),1:12000,LSTMoutput_test(i,:))
     legend('Real','Prediction')
end
