export{} 

function swap(arr: number[], i: number, j: number): void {
    var tmp = arr[i];
    arr[i] = arr[j];
    arr[j] = tmp;
}
function sortAndGetLargest(arr: number[]): number {
    var tmp = arr[0]; // largest elem
    var i;
    var j;
    for (i = 0; i < arr.length; i = i + 1) {
      if (arr[i] > tmp) { tmp = arr[i]; }
      for (j=i+1; j<arr.length; j=j+1){
        if (arr[i] < arr[j]) {swap(arr,i,j);}
      }
  }
    return tmp;
}
var largest = sortAndGetLargest([99,2,43,8,0,21,12]);
console.log(largest); // should be 99, but prints 0
