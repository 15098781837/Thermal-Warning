lstmoutput=importdata('ts_lstm_12000.mat');
lstmoutput=lstmoutput(:,1:10000)';
rlsoutput=importdata('ts_model_12000.mat');
rlsoutput=rlsoutput(1:10000,:);
output0=importdata('tse.mat');
output=[output0(14000:23999),output0(14001:24000)];
real_output0=importdata('ts_real.mat');
real_output=[real_output0(14000:23999),real_output0(14001:24000)];

output_boost=output;
for k=11:10000
    lstmoutput_10=lstmoutput(k-10:k-1,1);
    rlsoutput_10=rlsoutput(k-10:k-1,1);
    output_10=output(k-10:k-1,1);
    E_lstm=max(abs(lstmoutput_10-output_10));
    E_rls=max(abs(rlsoutput_10-output_10));
    e_lstm=sum((lstmoutput_10-output_10).^2)./(E_lstm.^2)./10;
    e_rls=sum((rlsoutput_10-output_10).^2)./(E_rls.^2)./10;
    a_lstm0=log((1-e_lstm)./e_lstm);
    a_rls0=log((1-e_rls)./e_rls);
    a_lstm=exp(a_lstm0)./(exp(a_lstm0)+exp(a_rls0));
    a_rls=exp(a_rls0)./(exp(a_lstm0)+exp(a_rls0));
    output_boost(k,:)=a_lstm.*lstmoutput(k,:)+a_rls.*rlsoutput(k,:);
end
%output_boost is the prediction result of the coupling model; Save to ts_boost_10000.mat

mse_rls = (mean((rlsoutput(11:10000,1)-real_output(11:10000,1)).^2))
mse_lstm= (mean((lstmoutput(11:10000,1)-real_output(11:10000,1)).^2))
mse_boost = (mean((output_boost(11:10000,1)-real_output(11:10000,1)).^2))
mse_rls2 = (mean((rlsoutput(11:10000,2)-real_output(11:10000,2)).^2))
mse_lstm2= (mean((lstmoutput(11:10000,2)-real_output(11:10000,2)).^2))
mse_boost2 = (mean((output_boost(11:10000,2)-real_output(11:10000,2)).^2))
figure;
plot(11:2000,real_output(11:2000,1),11:2000,output_boost(11:2000,1),11:2000,rlsoutput(11:2000,1),11:2000,lstmoutput(11:2000,1));
legend('real','boost','rls','lstm')
figure
plot(11:10000,real_output(11:4000,2),11:10000,output_boost(11:4000,2),11:10000,rlsoutput(11:4000,2),11:10000,lstmoutput(11:4000,2));
legend('real','boost','rls','lstm')