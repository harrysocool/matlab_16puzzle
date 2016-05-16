%%
trzdata(:,1:16) = zscore(train_data(:,1:16),0,2);
trzdata(:,17) = zscore(train_data(:,17),0,1);
% trzdata(:,17) = log(train_data(:,17));
% score(:,2) = trzdata(:,17);
%%
trzdata = zscore([train_data(:,1:16),train_data(:,17)],0,2);
%%
net = cascadeforwardnet(20);
net = train(net,trzdata(:,1:16)',trzdata(:,17)');
%%
c = cvpartition(score_list(:,6),'Holdout',0.8);
trIdx = c.training(1);
trdata = trzdata(trIdx,:);
%%
% trzdata = zscore([train_data(:,1:16),score_list(:,3)],0,2);
for i = 1:size(trdata,1)
    score_list1(i,2) = trdata(i,17);
    score_list1(i,3) = (net(trdata(i,1:16)')*1);
    disp(i);
end
%%
figure(1);
subplot(1,2,1)
plot(score_list1(:,2),'r.');
xlabel('8,736 sample states','Fontsize',16);
ylabel('Normalised length of solution sequence');
subplot(1,2,2)
plot(score_list1(:,3),'r.');
ylabel('Normalised length of solution sequence');
xlabel('8,736 sample states','Fontsize',16);
% plot(score_list(:,3),'b');
%%
boxplot([score_list1(:,2),score_list1(:,3)],'labels',{'Actual h(n)','Neural network h(n)'})
ylabel('Normalised length of solution sequence','Fontsize',14)
%%
score_list1(:,4) = 2.^(score_list1(:,3));
% score_list1(:,4) = 10*score_list1(:,4);
% score_list1(:,4) = 2.5*round(score_list1(:,4));


