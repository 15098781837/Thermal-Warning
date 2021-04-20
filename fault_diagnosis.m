ts=importdata('ts_real.mat');
output_boost=importdata('ts_boost_10000.mat');
output_boost=output_boost(11:10000,:);
a=zeros(23999,1);
 for i=1:23999
     if max(ts(i:i+1))>45
         a(i)=1;
     else
         a(i)=0;
     end
 end
a0=a(14000:23999);
a0=a0(11:10000);
%% Data normalization
input_train=output_boost(1:7000,:)';
input_validation=output_boost(7001:9990,:)';
input_test=output_boost(7001:9990,:)';
[inputn_train,inputps]=mapstd(input_train);
inputn_validation=mapstd('apply',input_validation,inputps);
inputn_test=mapstd('apply',input_test,inputps);
for i=1:7000
    XTrain{i,1}=inputn_train(:,i);
end
for i=1:2990
    XValidation{i,1}=inputn_validation(:,i);
end
for i=1:2990
    XTest{i,1}=inputn_test(:,i);
end
strLable=num2str(a0);
one=ones(2000,1);
one=num2str(one);
for i=1:7000
    TrainLable{i,1}=strLable(i);
end
for i=1:2990
    ValidationLable{i,1}=strLable(7000+i);
end
for i=1:2990
    TestLable{i,1}=strLable(7000+i);
end
YTrain=categorical(TrainLable);
YValidation=categorical(ValidationLable);
YTest=categorical(TestLable);
 
%% Create LSTM classification network
lgraph = [ ...
sequenceInputLayer(4)
bilstmLayer(100,'OutputMode','last')
fullyConnectedLayer(2)
softmaxLayer
classificationLayer]
% lgraph = [
%       sequenceInputLayer(2,"Name","sequence")
%       lstmLayer(64,"Name","lstm_1",'OutputMode','last')
%       dropoutLayer(0.4,"Name","dropout_1")
%       tanhLayer("Name","tanh_1")
%       fullyConnectedLayer(32,"Name","fc_1")
%       reluLayer("Name","relu_2")
%       fullyConnectedLayer(2,"Name","fc_3")
%       softmaxLayer("Name","soft")
%       classificationLayer("Name","classofocationoutput")];
%       lstmLayer(32,"Name","lstm_3",'OutputMode','last')
%       dropoutLayer(0.4,"Name","dropout_3")
lgraph = layerGraph();
tempLayers = sequenceInputLayer(2,"Name","sequence");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    lstmLayer(64,"Name","lstm_1",'OutputMode','sequence')
    dropoutLayer(0.2,"Name","dropout_1")
    lstmLayer(32,"Name","lstm_3",'OutputMode','last')
    dropoutLayer(0.2,"Name","dropout_3")];
lgraph=addLayers(lgraph,tempLayers);

tempLayers = [
    lstmLayer(64,"Name","lstm_2",'OutputMode','sequence')
    dropoutLayer(0.2,"Name","dropout_2")
    lstmLayer(16,"Name","lstm_4",'OutputMode','last')
    dropoutLayer(0.2,"Name","dropout_4")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    concatenationLayer(1,2,"Name","concat")
    tanhLayer("Name","tanh_1")
    fullyConnectedLayer(32,"Name","fc_1")
    
    reluLayer("Name","relu_2")
    fullyConnectedLayer(2,"Name","fc_3")
    softmaxLayer("Name","soft")
    classificationLayer("Name","classofocationoutput")
    ];
lgraph = addLayers(lgraph,tempLayers);

lgraph = connectLayers(lgraph,"sequence","lstm_1");
lgraph = connectLayers(lgraph,"sequence","lstm_2");
lgraph = connectLayers(lgraph,"dropout_3","concat/in1");
lgraph = connectLayers(lgraph,"dropout_4","concat/in2");
clear tempLayers;

options = trainingOptions('adam', ...
    'ExecutionEnvironment','gpu',...
    'MaxEpochs',200, ...
    'MiniBatchSize',512,...
    'SequenceLength','longest',...
    'InitialLearnRate',0.0001,...
    'Shuffle','never',...
    'GradientThreshold',1,...
    'ValidationData',{XValidation,YValidation},...
    'ValidationFrequency',10,...
    'ValidationPatience',10,...
    'LearnRateDropPeriod',50, ...
    'LearnRateDropFactor',0.2, ...
    'Verbose',0, ...
    'Plots','training-progress');
%% Training and Prediction
[net,info] = trainNetwork(XTrain,YTrain,lgraph,options);
YPred=classify(net,XTest);
YTest=string(YTest);
YTest=double(YTest);
YPred=string(YPred);
YPred=double(YPred);
acc=sum(YPred==YTest)./numel(YTest);
TP=0;FP=0;FN=0;TN=0;
for i=1:2990
    if YTest(i)==YPred(i)
        if YPred(i)==1
            TP=TP+1;
        else
            TN=TN+1;
        end
    else
        if YPred(i)==1
            FP=FP+1;
        else
            FN=FN+1;
        end
    end
end
p=TP/(TP+FP);
r=TP/(TP+FN);
F1=2*p*r/(p+r);
trainloss=info.TrainingLoss;
trainaccuracy=info.TrainingAccuracy; 


% d2=smoothdata(trainloss);
% d1=smoothdata(trainaccuracy);
% figure;
% plotyy(1:1:56400,d1,1:1:56400,d2)
% trainloss=info.TrainingLoss;
% trainaccuracy=info.TrainingAccuracy; 
% d2=smooth(trainloss);
% d1=smooth(trainaccuracy);
% figure;
% plotyy(1:1:2600,d1,1:1:2600,d2)          
         
