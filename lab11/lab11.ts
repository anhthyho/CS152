export {}; 
//fix for blocked-scope name var 
// https://medium.com/@muravitskiy.mail/cannot-redeclare-block-scoped-variable-varname-how-to-fix-b1c3d9cc8206
var name: string = "Monty";

class Rabbit {
	name: string;
	constructor(name: string) {
		this.name = name;
	}
}
	
var r = new Rabbit("Python");

console.log(r.name);
console.log(name);