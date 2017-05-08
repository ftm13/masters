var clicksToColor = { 1 : "cyan", 2 : "brown", 3 : "red", 4 : "orange", 5 : "yellow"};
var clicksToHexCode = {0 : "#fff", 1 : "#00A0B0", 2 : "#6A4A4C", 3 : "#CC333F", 4 : "#EB6841" , 5 : "#EDC951"}

function gridData() {
    // Pass it in as a variable
    var numStacks = 5;
    var numBlocks = 5;

    var data = new Array();
    data.numStacks = numStacks;
    data.numBlocks = numBlocks;

    var width = 50;
    var height = 50;
    var click = 0;
    var yInitialPos = 1 + (numBlocks - 1) * height;

    var xpos = 1; //starting xpos and ypos at 1 so the stroke will show when we make the grid below
    var ypos = yInitialPos;

    // Iterate through the stacks
    for (var stack = 0; stack < numStacks; stack++) {
        data.push(new Array());

        // Iterate through the blocks on the stack
        for (var block = 0; block < numBlocks; block ++) {
            data[stack].push({
            x: xpos,
            y: ypos,
            width: width,
            height: height,
            click: click
            })

            // Increase the height (i.e. shrink y as the top left has coordinates (0,0) and positive down
            ypos -= height;
        }

        // Reset y position
        ypos = yInitialPos

        // Move to next stack
        xpos += width
    }

    return data;
}

var gridData1 = gridData();  
// I like to log the data to the console for quick debugging
console.log(gridData1);
console.log(gridData1.numBlocks);
console.log("Hellowwww");
console.log("Does this get picked up?");

var grid1 = d3.select("#grid1")
    .append("svg")
    .attr("width","510px")
    .attr("height","510px");
    
var row1 = grid1.selectAll(".row")
    .data(gridData1)
    .enter().append("g")
    .attr("class", "row");
    
var column1 = row1.selectAll(".square")
    .data(function(d) { return d; })
    .enter().append("rect")
    .attr("class","square")
    .attr("x", function(d) { return d.x; })
    .attr("y", function(d) { return d.y; })
    .attr("width", function(d) { return d.width; })
    .attr("height", function(d) { return d.height; })
    .style("fill", "#fff")
    .style("stroke", "#222")
    .on('click', function(d) {
       d.click = (d.click + 1) % 6 ;
       var colourCode = clicksToHexCode[d.click];
       console.log(colourCode);
       d3.select(this).style("fill", colourCode);
    });

var gridData2 = gridData();  
// I like to log the data to the console for quick debugging
console.log(gridData);

var grid2 = d3.select("#grid2")
    .append("svg")
    .attr("width","510px")
    .attr("height","510px");
    
var row2 = grid2.selectAll(".row")
    .data(gridData2)
    .enter().append("g")
    .attr("class", "row");
    
var column2 = row2.selectAll(".square")
    .data(function(d) { return d; })
    .enter().append("rect")
    .attr("class","square")
    .attr("x", function(d) { return d.x; })
    .attr("y", function(d) { return d.y; })
    .attr("width", function(d) { return d.width; })
    .attr("height", function(d) { return d.height; })
    .style("fill", "#fff")
    .style("stroke", "#222")
    .on('click', function(d) {
          d.click = (d.click + 1) % 6 ;
          var colourCode = clicksToHexCode[d.click];
          console.log(colourCode);
          d3.select(this).style("fill", colourCode);
    });

function toAspInitial(grid) {
    var currStack = [];

    for(var stack = 0; stack < grid.numStacks; stack++) {

        for(var block = 0; block < grid.numBlocks; block++) {
            currBlock = grid[stack][block];
            if((currBlock.click) % 6 == 0) break;

            // Add the element on top of the stack
            if(block == 0) {
                var previousBlock = "s" + stack.toString();
            } else {
            // Add the block on top of the previous one
                var prevBlockNum = block - 1;
                var previousBlock = "b" + stack.toString() + prevBlockNum.toString();
            }

            var holdsAt = "holdsAt(";
            var blockName = "b" + stack.toString() + block.toString();
            var predicate = holdsAt + "on(" + blockName + ',' + previousBlock + ')' + ',' + '1' + ').';
            //console.log(predicate);

            // Add the on relation
            currStack.push(predicate);
        }
    }

    return currStack;
}

function toAspInitialColours(grid) {
    var currStack = [];

    for(var stack = 0; stack < grid.numStacks; stack++) {
        for(var block = 0; block < grid.numBlocks; block++) {
            currBlock = grid[stack][block];
            if((currBlock.click) % 6 == 0) break;

            var holdsAt = "holdsAt(";
            var blockName = "b" + stack.toString() + block.toString();

            var colPredicate = holdsAt + "block_col(" + blockName + ',' + clicksToColor[currBlock.click % 6] + ')' + ',' + '1' + ').';
            currStack.push(colPredicate);
        }
    }

    return currStack;
}

function toAspTargetColours(grid) {
    var currStack = [];

    for(var stack = 0; stack < grid.numStacks; stack++) {
        for(var block = 0; block < grid.numBlocks; block++) {
            currBlock = grid[stack][block];
            if((currBlock.click) % 6 == 0) break;

            var goalState = "goalState(";
            var blockName = "b" + stack.toString() + block.toString();

            // Add the colour of the block as well
            var colPredicate = goalState + "block_col(" + blockName + ',' + clicksToColor[currBlock.click % 6] + ')'+ ').';
            currStack.push(colPredicate);
        }
    }

    return currStack;
}

function toAspTarget(grid) {
    var currStack = [];

    for(var stack = 0; stack < grid.numStacks; stack++) {

        for(var block = 0; block < grid.numBlocks; block++) {
            currBlock = grid[stack][block];
            if((currBlock.click) % 6 == 0) break;

            // Add the element on top of the stack
            if(block == 0) {
                var previousBlock = "s" + stack.toString();
            } else {
            // Add the block on top of the previous one
                var prevBlockNum = block - 1;
                var previousBlock = "b" + stack.toString() + prevBlockNum.toString();
            }

            var goalState = "goalState(";
            var blockName = "b" + stack.toString() + block.toString();
            var predicate = goalState + "on(" + blockName + ',' + previousBlock + ')' + ').';

            // Add the on relation
            currStack.push(predicate);
        }
    }

    return currStack;
}

function addExample(type) {
    console.log("You clicked the button HHEHE");
    //console.log(gridData1);

    var trainingExample = {
        "initialState" : toAspInitial(gridData1).concat(toAspInitialColours(gridData1)), //["one", "two"],
        "finalState" : toAspTarget(gridData2).concat(toAspTargetColours(gridData1)), //["three", "four"],
        "action" : $('#action').val() + '.',
        "positive" : type
    }
    console.log(JSON.stringify(trainingExample));

    $.ajax({
          type: "POST",
          contentType : 'application/json; charset=utf-8',
          dataType : 'json',
          url: "http://localhost:8080/add-training-example",
          data: JSON.stringify(trainingExample), // Note it is important
          success :function(result) {
           // do what ever you want with data
           console.log(result);
         }
    });
}

function performLearning() {
     $.get("http://localhost:8080/perform-learning?ruleName=" + $('#rule').val(), function(data, status){
                $('#hyp').val(data);
                alert("Data: " + data + "\nStatus: " + status);
            });
}