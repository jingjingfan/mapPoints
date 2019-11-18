/*
 * index.js
 * 
 * 
 *
 */

const fs = require('fs');

//
function processData (data) {
	var wstream = fs.createWriteStream('neighborhoodPoly.rkt');
	let numArr = data.toString('utf8').split('\n');
	let nameArr = [];
	let endingwrap;

	//header for .rkt file requirements
	wstream.write('#lang racket\n(require "pip.rkt")\n(provide (all-defined-out))\n(define-struct neighborhood (name segs))\n\n');

	let neighborhoodPolygons = numArr.reduce((acc, currentRow, currentIndex) => {
		let curArr;
		let nextArr;
		let str; 
		let name;
		let initStr = " ";

		if(currentIndex)
			initStr = "		)))\n\n" + initStr;

		curArr = currentRow.split(',').map(Number);

		//if it's a name or empty array, will reset to string
		if(!curArr[0] || Number.isNaN(curArr[0])) {
			str = currentRow;

			if(Number.isNaN(curArr[0])){
				str = str.trim();
				name = str.replace(/\s+/g, '').slice(0,str.length-2); 
				nameArr.push(name);
				
				//initializing a neighborhood structure with define and uniquely generated name
				initStr = initStr + "(define " + name +" (neighborhood ";
				str = initStr + '"' + str.slice(0,str.length-1) + '"\n' + "	(list ";
			}
			wstream.write(str);
		}
		else if(!Number.isNaN(numArr[currentIndex+1]) && typeof(numArr[currentIndex+1]) !== 'undefined'){
			nextArr = numArr[currentIndex+1].split(',').map(Number);

			//given two points to make segmant (Ax, Ay, Bx, By)
			if(nextArr[0] && typeof(nextArr[0]) !== 'undefined'){
				str = `	(seg ${curArr[0]} ${curArr[1]} ${nextArr[0]} ${nextArr[1]})`;
				wstream.write(str);
				wstream.write('\n');
			}
		}

		endingwrap = ")))\n";
	},0)

	endingwrap = endingwrap + "(define listOfNeighborhood (list ";
	let map1 = nameArr.map(x => {
		endingwrap = endingwrap + " " + x + " ";
	})

	endingwrap += " ))"
	wstream.write(endingwrap);
	wstream.end();
}

//opens neighborhood map and process data
fs.readFile('./gr_neighborhoods.txt', (err, data) => {
	if(err){
		console.log('errrrooorrr')
	}
	processData(data);
})
















