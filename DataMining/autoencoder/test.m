
case1 = (1:500)/20;
case2 = [250:-1:1,1:250]/10;
data = rand(400,500)+[repmat(case1,200,1);repmat(case2,200,1)];
newlabelM = zeros(2,400);
newlabelM(1,1:200) = 1;
newlabelM(2,201:400) = 1;
[ theta ] = softmaxTrain( data' , newlabelM );