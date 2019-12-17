var Rabbit = (function () {
    function Rabbit(name) {
        this.name = name;
    }
    return Rabbit; 
}());

var name = "Monty";
var r = new Rabbit("Python");

console.log(r.name);
console.log(name);