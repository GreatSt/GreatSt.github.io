function Algo (){
    
    // This is currently a very dum implementation becouse of the use of seqEvent
    this.myBFS = function (edges1, startId){
        var queue = [];
        var visited = []; // Exchange this for distance to improve time complexity
        var allEdges = edges1.get();
        visited.push(startId);

        queue.push(startId);
        while (queue.length > 0){
            var nodeId = queue.shift();
            // Animate: current node
            seqEvent.push({isNode:true, id:nodeId});
            // Go through all the adjacent nodes and
            // push them to the list as long as it hasn't been visited
            for(var i = 0; i < allEdges.length; i++){
                if (allEdges[i].from === nodeId && !contains(visited, allEdges[i].to)){
                    queue.push(allEdges[i].to);
                    console.log("Node " + allEdges[i].to + " got pushed to the queue.");
                    visited.push(allEdges[i].to);
                    // Animate: Walking the edge
                    seqEvent.push({isNode:false, id: allEdges[i].id});
                }
            }
        }
    };
}

var contains = function (list, item){
    for(var i = 0; i < list.length; i++){
        if (list[i] === item)
            return true;
    }
    return false;
};