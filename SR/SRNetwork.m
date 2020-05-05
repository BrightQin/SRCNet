tempLayers = imageInputLayer([224 224 3],"Name","imageinput");
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([4 4],32,"Name","conv_1","BiasInitializer","narrow-normal","Padding","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_1")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([4 4],64,"Name","conv_2","BiasInitializer","narrow-normal","Padding","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_2")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([4 4],128,"Name","conv_3","BiasInitializer","narrow-normal","Padding","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_3")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([4 4],256,"Name","conv_4","BiasInitializer","narrow-normal","Padding","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_4")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    convolution2dLayer([4 4],512,"Name","conv_5","Padding","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_5")
    transposedConv2dLayer([4 4],256,"Name","transposed-conv_1","BiasInitializer","narrow-normal","Cropping","same","Stride",[2 2],"WeightsInitializer","narrow-normal")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_4")
    leakyReluLayer(0.01,"Name","leakyrelu_6")
    transposedConv2dLayer([4 4],128,"Name","transposed-conv_2","BiasInitializer","narrow-normal","Cropping","same","Stride",[2 2],"WeightsInitializer","narrow-normal")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_3")
    leakyReluLayer(0.01,"Name","leakyrelu_7")
    transposedConv2dLayer([4 4],64,"Name","transposed-conv_3","BiasInitializer","narrow-normal","Cropping","same","Stride",[2 2],"WeightsInitializer","narrow-normal")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_2")
    leakyReluLayer(0.01,"Name","leakyrelu_8")
    transposedConv2dLayer([4 4],32,"Name","transposed-conv_4","BiasInitializer","narrow-normal","Cropping","same","Stride",[2 2],"WeightsInitializer","narrow-normal")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_1_1")
    leakyReluLayer(0.01,"Name","leakyrelu_9")
    transposedConv2dLayer([4 4],16,"Name","transposed-conv_5_1","BiasInitializer","narrow-normal","Cropping","same","Stride",[2 2],"WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_10")
    transposedConv2dLayer([4 4],3,"Name","transposed-conv_5_2","BiasInitializer","narrow-normal","Cropping","same","WeightsInitializer","narrow-normal")
    leakyReluLayer(0.01,"Name","leakyrelu_11")];
lgraph = addLayers(lgraph,tempLayers);

tempLayers = [
    additionLayer(2,"Name","addition_1_2")
    clippedReluLayer(1,"Name","clippedrelu")
    regressionLayer("Name","regressionoutput")];
lgraph = addLayers(lgraph,tempLayers);

% clean up helper variable
clear tempLayers;

lgraph = connectLayers(lgraph,"imageinput","conv_1");
lgraph = connectLayers(lgraph,"imageinput","addition_1_2/in1");
lgraph = connectLayers(lgraph,"leakyrelu_1","conv_2");
lgraph = connectLayers(lgraph,"leakyrelu_1","addition_1_1/in2");
lgraph = connectLayers(lgraph,"leakyrelu_2","conv_3");
lgraph = connectLayers(lgraph,"leakyrelu_2","addition_2/in2");
lgraph = connectLayers(lgraph,"leakyrelu_3","conv_4");
lgraph = connectLayers(lgraph,"leakyrelu_3","addition_3/in2");
lgraph = connectLayers(lgraph,"leakyrelu_4","conv_5");
lgraph = connectLayers(lgraph,"leakyrelu_4","addition_4/in2");
lgraph = connectLayers(lgraph,"transposed-conv_1","addition_4/in1");
lgraph = connectLayers(lgraph,"transposed-conv_2","addition_3/in1");
lgraph = connectLayers(lgraph,"transposed-conv_3","addition_2/in1");
lgraph = connectLayers(lgraph,"transposed-conv_4","addition_1_1/in1");
lgraph = connectLayers(lgraph,"leakyrelu_11","addition_1_2/in2");
