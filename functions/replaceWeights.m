function newNet = replaceWeights(oldNet,layerID,new_val,YTest,XTest,dd)
%REPLACEWEIGHTS Replace layer weights of DAGNetwork
%   newNet = replaceWeights(oldNet,layerID,newWeights)
%   oldNet = the DAGnetwork you want to replace weights.
%   layerID = the layer number of which you want to replace the weights.
%   newWeights = the matrix with the replacement weights. This should be
%   the original weights size.
% Split up layers and connections
oldLgraph = layerGraph(oldNet.Layers);
layers = oldNet.Layers;
connections = oldLgraph.Connections;
% Set new weights
if dd=='w'
layers(layerID).Weights = new_val;
elseif dd=='b'
 layers(layerID).Bias = new_val;
end
% Freeze weights, from the Matlab transfer learning example
for ii = 1:size(layers,1)
    props = properties(layers(ii));
    for p = 1:numel(props)
        propName = props{p};
        if ~isempty(regexp(propName, 'LearnRateFactor$', 'once'))
            layers(ii).(propName) = 0;
        end
    end
end
% Build new lgraph, from the Matlab transfer learning example
newLgraph = layerGraph();
for i = 1:numel(layers)
    newLgraph = addLayers(newLgraph,layers(i));
end
for c = 1:size(connections,1)
    newLgraph = connectLayers(newLgraph,connections.Source{c},connections.Destination{c});
end
% Very basic options
options = trainingOptions('adam','MaxEpochs', 1, 'Verbose',0);
% Note that you might need to change the label here depending on your
% network in my case '1' is a valid label.
newNet = trainNetwork(XTest,categorical(YTest),newLgraph,options);
% mdl=fitcknn(tr_data,tr_lab);PL_3=predict(mdl,tst_data);

end