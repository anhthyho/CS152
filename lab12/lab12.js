//traps (has, get, set, deleteProperty, apply, construct)
//traps (gtOwnPropertyDescriptor, getPrototypeOf, setPrototypeOf, isExtensible
// preventExtensions, defineProperty, ownKeys)

let roHandler = {
    has: function(t,prop) {
        console.log(t.constructor.name + " has: " + prop);
        return prop in t; },
    get: function(t,prop,rcvr) {
        console.log(t.constructor.name + " gets: " + prop);
        Reflect.get(...arguments);},
    set: function(t, prop, val, rcvr) { 
        console.log(t.constructor.name + " set: " + prop + " to " + val);
        t[prop] = val; 
        return true;},
    deleteProperty: function(t, prop) { 
        console.log(t.constructor.name + " delete: " + prop );
        return delete t[prop]; },
    apply: function(target, thisArg, args){
        console.log(target + " apply: " + thisArg + " to " + args );
        return target.apply(thisArg, args);
    },
    construct: function(tars, args){
        console.log("construct new " + tar + " with " + args);
        return new tars(...args)
    },
    getOwnPropertyDescription: function(t,prop){
        console.log(t.constructor.name + " prop desc: " + prop );
        return Object.getOwnPropertyDescriptor(t,p);
    },
    getPrototypeOf: function(t){
        console.log(t.constructor.name + " get prototype of: " + Object.getPrototypeOf(t));
        return Object.getPrototypeOf(t);
     }, 
    setPrototypeOf: function(t, prop){
        console.log(t.constructor.name + " set prototype to: " + prop);
        return Object.setPrototypeOf(t,prop);
    }, 
    isExtensible: function(t){
        console.log(t.constructor.name + " is extensible " + Reflect.isExtensible(t));
        return Reflect.isExtensible(t);
    },
    preventExtensions: function(t){
        console.log(t.constructor.name + " prevents extensions " + Object.preventExtensions(t));
        return Object.preventExtensions(t);
    }, 
    defineProperty: function(t, k, d){
        console.log(t.constructor.name + " define props " + k + " " + d);
       return Object.defineProperty(t,k,d)
    }, 
    ownKeys: function(t){
        console.log(t.constructor.name + " key: " + Reflect.ownKeys(t));
        return Reflect.ownKeys(t);
    } }; 
    
function trace(obj){
    return new Proxy(obj, roHandler)
}
var constantVals = {
    pi: 3.14,
    e: 2.718,
    goldenRatio: 1.30357 };
    
var p = new trace(constantVals);
//ignore undefined print from console.log

//get
p.pi;

//delete
delete p.pi;

//set
p.pi = 3;

//traps (gtOwnPropertyDescriptor, getPrototypeOf, setPrototypeOf, isExtensible
// preventExtensions, defineProperty, ownKeys

Object.getOwnPropertyDescriptor(p);
Object.getOwnPropertyDescriptor(p);
Object.isExtensible(p);
for (k of Object.keys(p)){console.log(k)}; 