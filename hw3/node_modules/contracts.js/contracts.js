// NOTE: This library uses non-standard JS features (although widely supported).
// Specifically, it uses Function.name.

function any(v) {
  return true;
}

function isNumber(v) {
  if (isNaN(v)){
    return false;
  }
  else {
    if (typeof v === 'number'){
      return true;
    }
    else {
      return false;
    }
  }
}
isNumber.expected = "number";

//
// ***YOUR CODE HERE***
// IMPLEMENT THE FOLLOWING CONTRACTS
//
function isBoolean(bool) {
  if (bool === true || bool === false) {
    return true;
  }
  else {
    return false;
  }
}
isBoolean.expected = "boolean";

function isDefined(v) {
  if (v !== null && v !== undefined) {
    return true;
  }
  else {
    return false;
  }
}
isDefined.expected = "defined";

function isString(str) {
  if (typeof str === 'string' || str instanceof String) {
    return true;
  }
  else {
    return false;
  }
}
isString.expected = "string";

function isNegative(v) {
  if (isNaN(v)) {
    return false;
  }
  else {
    if (v < 0) {
      return true;
    }
    else {
      return false;
    }
  }
}
isNegative.expected = "negative number";

function isPositive(v) {
  if (isNaN(v)) {
    return false;
  }
  else {
    if (v > 0 && typeof v === 'number') {
      return true;
    }
    else {
      return false;
    }
  }
}
isPositive.expected = "positive number";


// Combinators:

function and() {
  let args = Array.prototype.slice.call(arguments);
  let cont = function (v) {
    for (let i in args) {
      if (!args[i].call(this, v)) {
        return false;
      }
    }
    return true;
  }
  cont.expected = expect(args[0]);
  for (let i = 1; i < args.length; i++) {
    cont.expected += " and " + expect(args[i]);
  }
  return cont;
}



//
// ***YOUR CODE HERE***
// IMPLEMENT THESE CONTRACT COMBINATORS
//

//Takes a variable number of contracts; returns true if any of
//the original contracts return true.
function or() {
  let args = Array.prototype.slice.call(arguments);
  let cont = function (v) {
    for (let i in args) {
      if (args[i].call(this, v)) {
        return true;
      }
    }
    return false;
  }
  cont.expected = expect(args[0]);
  for (let i = 1; i < args.length; i++) {
    cont.expected += " or " + expect(args[i]);
  }
  return cont;
};

//Takes a single contract; returns a contract that returns true
//only if the original contract returns false.
function not(cont) {
  let notC = function (v) {
    let res = cont.call(this, v);
    return !res;
  }
  notC.expected = "not " + cont.expected;
  return notC;
};



// Utility function that returns what a given contract expects.
function expect(f) {
  // For any contract function f, return the "expected" property
  // if it is specified.  (This allows developers to specify what
  // the expected property should be in a more readable form.)
  if (f.expected) {
    return f.expected;
  }
  // If the function name is available, use that.
  if (f.name) {
    return f.name;
  }
  // In case an anonymous contract is specified.
  return "ANONYMOUS CONTRACT";
}

//takes in prelist, post, and function f
//if pre cond not met, throw exception to blame caller 
//specifies using contracts in p1 
function contract(preList, post, f) {
  // ***YOUR CODE HERE***
  for (let i = 0; i < preList.length; i++) {
    let cond = preList[i].call(this, arguments[i]);
    if (!cond) {
      throw new Error("Contract violation in position " + i + ". Expected " + cond.expected + " but received " + arguments[i]);
    }
    let res = f.apply(this, args);
    if (!post(res)) {
      throw new Error("Contract violation. Expected " + post.expect + " but returned " + res + "d. Blame -> " + f.name);
    }
    return res;
  }
}


module.exports = {
  contract: contract,
  any: any,
  isBoolean: isBoolean,
  isDefined: isDefined,
  isNumber: isNumber,
  isPositive: isPositive,
  isNegative: isNegative,
  isInteger: Number.isInteger,
  isString: isString,
  and: and,
  or: or,
  not: not,
};
