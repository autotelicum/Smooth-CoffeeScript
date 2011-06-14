// Copyright (c) 2009, Darrin Thompson

// Tiny javascript quickcheck port.

/**
 * Array of all declared/registered properties
 */
var allProps = [];


/**
 * deletes all declared properties
 */
function resetProps() {
    allProps = [];
}

/**
 * @class
 */
function Invalid(prop, stats) {
    /** @field */
    this.status = "invalid";

    this.prop = prop;
    this.stats = stats;
    this.name = prop.name;
}

Invalid.prototype.toString = function () {
    //return "Invalid (" + this.name + ") counts=" + this.stats;
    return "Invalid: " + this.name + " " + this.stats; // FIX: reduced logging
};

/**
 * Report class for successful tested properties.
 *
 * @class
 */
function Pass(prop, stats) {
    /** status = "pass" */
    this.status = "pass";

    /** the property this object was build for.*/
    this.prop = prop;

    /** property run statistics.*/
    this.stats = stats;

    /** The property its name.*/
    this.name = prop.name;
}

Pass.prototype.toString = function () {
    //return "Pass (" + this.name + ") counts=" + this.stats;
    return "Pass: " + this.name + " " + this.stats; // FIX: reduced logging
};

/**
 * @class
 */
function Fail(prop, stats, failedCase, shrinkedArgs) {
    this.status = "fail";
    this.prop = prop;
    this.stats = stats;
    this.failedCase = failedCase;
    this.shrinkedArgs = shrinkedArgs;
    this.name = prop.name;
}

Fail.prototype.toString = function () {
    function tagstr(tags) {
        var str, i;

        if (!tags || tags.length === 0) {
            return "";
        }

        str = "(tags: " + tags[0];
        for (i = 1; i < tags.length; i++) {
            str += ", " + tags[i];
        }
        return str + ")";
    }

    function shrinkstr(arg) {
        return arg === null ? "" : "\nminCase: " + arg;
    }

    return this.name + tagstr(this.stats.tags) +
           " failed with: counts=" + this.stats + 
           " failedCase: " + this.failedCase +
           shrinkstr(this.shrinkedArgs);
};

/**
 * Statistics class for counting number of pass/invalid runs, building
 * histograms and other statistics for reporting a property its testing
 * results.
 *
 * @class
 */
function Stats() {
    /** 
     * number of successful tests
     * @field 
     * */
    this.pass = 0;

    /** 
     * number of failed tests
     * @field 
     * */
    this.invalid = 0;

    /**
     * list of tags (created by calling Case.classify) with counts
     * @field
     */
    this.tags = [];

    /**
     * Histogram of collected values (create by calling Case.collect)
     * @field
     */
    this.collected = null;
}

/**
 * @private
 */
Stats.prototype.incInvalid = function () { 
    this.invalid += 1; 
};

/**
 * @private
 */
Stats.prototype.incPass = function () { 
    this.pass += 1; 
};

/**
 * @private
 */
Stats.prototype.addTags = function (ts) {
    var i, j, tag, found;

    for (i = 0; i < ts.length; i++) {
        tag = ts[i];
        found = false;
        for (j = 0; j < this.tags.length; j++) {
            if (this.tags[j][1] === tag) {
                found = true;
                this.tags[j][0] += 1;
            }
        }
        if (!found) {
            this.tags.push([1, tag]);
        }
    }
};

/**
 * @private
 */
Stats.prototype.newResult = function (prop) {
    if (this.pass > 0) {
        return new Pass(prop, this);
    } else {
        return new Invalid(prop, this);
    }
};

Stats.prototype.toString = function () {
    return "(pass=" + this.pass + ", invalid=" + this.invalid + ")";
};

/**
 * Probability distributions.
 *
 * @class
 */
function Distribution(d) {

    /** @ignore */
    function incBy(data, key, x) {
        var found = false, i;
        for (i = 0; i < data.length; i++) {
            if (data[i][1] === key) {
                data[i][0] += x;
                found = true;
                break;
            }
        }
        if (!found) { 
            data.push([x, key]);
        }
    }

    var data = [], j;
    for (j = 0; j < d.length; j++) {
        incBy(data, d[j][1], d[j][0]);
    }

    this.data = data;
    this.normalize();
    this.length = this.data.length;
}

/**
 * @private
 */
Distribution.prototype.normalize = function () {
    var sum = 0, i;
    for (i = 0; i < this.data.length; i++) {
        sum += this.data[i][0];
    }
    for (i = 0; i < this.data.length; i++) {
        this.data[i][0] /= sum;
    }
};

/**
 * finds the probability of a given value in the distribution.
 *
 * @param x any value to find probability for
 * @return the probability of x in the distribution
 */
Distribution.prototype.probability = function (x) {
    for (var i = 0; i < this.data.length; i++) {
        if (this.data[i][1] === x) {
            return this.data[i][0];
        }
    }
    return 0;
};

/**
 * finds the (first) object with the highest probability.
 *
 * @return object with highest probability
 */
Distribution.prototype.mostProbable = function () {
    var max = 0, ret = null, i;

    for (i = 0; i < this.data.length; i++) {
        if (this.data[i][0] > max) {
            max = this.data[i][0];
            ret = this.data[i][1];
        }
    }
    return ret;
};

/**
 * randomly draws a values by its probability from the distribution.
 *
 * @return any value in the distribution
 */
Distribution.prototype.pick = function () {
    var i, r = Math.random(), s = 0;

    for (i = 0; i < this.data.length; i++) {
        s += this.data[i][0];
        if (r < s) {
            return this.data[i][1];
        }
    }
};

/**
 * creates a new uniform distribution from an array of values.
 *
 * @param data an array of values
 *
 * @return a new Distribution object
 */
Distribution.uniform = function (data) {
    var i, tmp = new Array(data.length);
    for (i = 0; i < data.length; i++) {
        tmp[i] = ([1, data[i]]);
    }
    return new Distribution(tmp);
};


/**
 * draws a new value from a generator. 
 * A generator is either a function accepting a seed argument or an object
 * with a method 'arb' accepting a seed argument.
 *
 * @param gen Function or Generator object with method 'arb'
 * @param {Number} size seed argument
 *
 * @return new generated value
 */
function genvalue(gen, size) {
    if (!(gen instanceof Function)) {
        gen = gen.arb;
    }
    return gen(size);
}

/**
 * Uses the generators specific shrinking method to shrink a value the
 * generator created before. If the generator is a function or has no method
 * named 'shrink' or the objects field 'shrink' is set to null, no shrinking
 * will be done.  If a shrinking method is defined, this method is called with
 * the original seed and value the generator created. The shrinking method is
 * supposed to return an Array of shrinked(!) values or null,undefined,[] if 
 * no shrinked values could have been created.
 *
 * @param gen the generator object
 * @param size the initial seed used when creating a value
 * @param arg the value the generator created for testing
 *
 * @return an array of shrinked values or [] if no shrinked values were
 *         generated.
 *
 */
function genshrinked(gen, size, arg) {
    if (!gen || gen instanceof Function ||
        gen.shrink === undefined || gen.shrink === null)
    {
        return [];
    }

    var tmp = gen.shrink(size, arg);
    return (tmp === null || tmp === undefined) ? [] : tmp;
}

/**
 * Creates a new Property with given argument generators and a testing 
 * function. For each generator in the gens array a value is generated, 
 * so for testing a 2-ary function the gens array must contain 2 generators.
 *
 * @param {String} name the property its name
 * @param {Array} gens array of generators to draw arguments from
 * @param {Function} body property test function.
 *
 * @class
 */
function Prop(name, gens, body) {
    this.name = name;
    this.gens = gens;
    this.body = body;
}

/**
 * @private
 */
Prop.prototype.generateArgs = function (size) {
    var i, gen, args = [];

    for (i = 0; i < this.gens.length; i += 1) {
        gen = this.gens[i];
        args.push(genvalue(gen, size));
    }
    return args;
};

/**
 * @private
 */
Prop.prototype.generateShrinkedArgs = function (size, args) {
    // create shrinked args for each argument 
    var i, idxs, tmp, gen, countShrinked = 0, shrinked = [], newArgs = [];

    for (i = 0; i < this.gens.length; i++) {
        gen = this.gens[i];
        if ((gen instanceof Function) || gen.shrink === undefined ||
           gen.shrink === null || !(gen.shrink instanceof Function))
        {
            shrinked.push([args[i]]);
        } else {
            tmp = gen.shrink(size, args[i]);
            if (tmp === undefined || 
                (tmp instanceof Array && tmp.length === 0)) 
            {
                shrinked.push([args[i]]);
            } else {
                countShrinked++;
                shrinked.push(tmp);
            }
        }
    }

    if (countShrinked === 0) {
        return [];
    }

    // create index list to draw lists of arguments from
    idxs = new Array(this.gens.length);
    for (i = 0; i < this.gens.length; i++) {
        idxs[i] = 0;
    }

    // create list of shrinked arguments:
    while (idxs[0] < shrinked[0].length) {
        tmp = new Array(shrinked.length);
        for (i = 0; i < shrinked.length; i++) {
            tmp[i] = shrinked[i][idxs[i]];
        }
        newArgs.push(tmp);

        // adjust all indices
        while (i-- > 0) {
            idxs[i] += 1;
            if (i !== 0 && idxs[i] >= shrinked[i].length) {
                idxs[i] = 0;
            } else {
                break;
            }
        }
    }

    return newArgs;
};

/**
 * The Test Case class generated every time a property is tested.
 * An instance of Case is always passed as first argument to a property's
 * testing function so users can control the test case's properties.
 *
 * @class
 */
function Case(args) {
    this.tags = [];
    this.collected = [];
    this.args = args;
}

/**
 * tests and notifies QuickCheck if a property fails or not.
 *
 * @param bool pass false, if property failed
 */
Case.prototype.assert = function (bool) {
    if (!bool) {
        throw ("AssertFailed");
    }
};

/**
 * used to test if input is good for testing the property.
 *
 * @param bool pass false to mark property as invalid for given input.
 */
Case.prototype.guard = function (bool) {
    if (!bool) {
        throw ("InvalidCase");
    }
};

/**
 * Adds a tag to a test run.
 *
 * @param bool if true tag is added to case, else not
 * @param tag value to add
 */
Case.prototype.classify = function (bool, tag) {
    if (bool) {
        this.tags.push(tag);
    }
};

/**
 * collect builds a histogram of all collected values for all runs of the
 * property. 
 *
 * @param value value to collect
 */
Case.prototype.collect = function (value) {
    var i, found = false;
    for (i = 0; i < this.collected.length; i++) {
        if (this.collected[i][1] === value) {
            this.collected[i][0] += 1;
            found = true;
            break;
        }
    }
    if (!found) {
        this.collected.push([1, value]);
    }
};

/**
 * adds the given value to the test case its values for reporting in case of
 * failure.
 *
 * @param value the value to add
 */
Case.prototype.noteArg = function (value) {
    this.args.push(value);
};

/**
 * @private
 */
function shrinkLoop(config, prop, size, args) {
    var loop, i, testCase, failedArgs = [args], shrinkedArgs = [];

    for (loop = 0; loop < config.maxShrink; loop++) {
        // create shrinked argument lists from failed arguments

        shrinkedArgs = [];
        for (i = 0; i < failedArgs.length; i++) {
            shrinkedArgs = shrinkedArgs.concat(
                prop.generateShrinkedArgs(size, failedArgs[i]));
        }

        if (shrinkedArgs.length === 0) {
            return failedArgs.length === 0 ? null : failedArgs[0];
        }

        // create new failed arguments from shrinked ones by running the
        // property
        failedArgs = [];
        for (i = 0; i < shrinkedArgs.length; i++) {
            try {
                testCase = new Case(shrinkedArgs[i]);
                prop.body.apply(prop, [testCase].concat(shrinkedArgs[i]));
            } catch (e) {
                if (e === 'InvalidCase') {
                } else if (e === 'AssertFailed') {
                    if (loop === config.maxShrink - 1) {
                        return shrinkedArgs[i];
                    } else {
                        failedArgs.push(shrinkedArgs[i]);
                    }
                } else {
                    throw e;
                }
            }
        }
    }

    return failedArgs.length === 0 ? null : failedArgs[0];
}

/**
 * tests the property.
 *
 * @param {Config} config configuration to test property with
 * @return depending on test result a Pass, Fail or Invalid object
 */
Prop.prototype.run = function (config) {
    var args, testCase, dist, shrinkedArgs,
        stats = new Stats(), size = 0, collected = [];

    while (config.needsWork(stats)) {
        args = this.generateArgs(size);
        testCase = new Case(args);
        try {
            this.body.apply(this, [testCase].concat(args));
            stats.incPass();
        }
        catch (e) {
            if (e === "AssertFailed") {
                dist = !testCase.collected || 
                        testCase.collected.length === 0 ?  null : 
                            new Distribution(testCase.collected);

                shrinkedArgs = shrinkLoop(config, this, size, args);
                return new Fail(this, stats, args, shrinkedArgs, 
                                testCase.tags, dist);
            } else if (e === "InvalidCase") {
                stats.incInvalid();
            } else {
                throw (e);
            }
        }
        size += 1;
        stats.addTags(testCase.tags);
        collected = collected.concat(testCase.collected);
    }

    stats.collected = !collected || collected.length === 0 ? null :
                        new Distribution(collected);

    return stats.newResult(this);
};

/**
 * Builds and registers a new property.
 *
 *
 * @param name the property's name
 * @param gens Array of generators (length == arity of body function). The
 *             Entry at position i will drive the i-th argument of the body
 *             function.
 * @param body the properties testing function
 *
 * @return a new registered Property object.
 */
function declare(name, gens, body) {
    var theProp = new Prop(name, gens, body);
    allProps.push(theProp);
    return theProp;
}

/**
 * Testing Configuration.
 *
 * @param pass maximum passes per property
 * @param invalid maximum invalid tests per property
 * @param maxShrink maximum number of shrinking steps per property
 *
 * @class
 */
function Config(pass, invalid, maxShrink) {
    this.maxPass = pass;
    this.maxInvalid = invalid;
    this.maxShrink = arguments.length < 3 ? 3 : maxShrink;
}

/**
 * tests if runloop should continue testing a property based
 * on test statistics to date.
 *
 * @private
 */
Config.prototype.needsWork = function (count) {
    return count.invalid < this.maxInvalid &&
        count.pass < this.maxPass;
};

function runAllProps(config, listener) {
    var once, i = 0;

    if (typeof setTimeout !== 'undefined') {
        // Use set timeout so listeners can draw in response to events.
        once = function () {
            if (i >= allProps.length) {
                listener.done();
                return;
            }
            var currentProp = allProps[i],
                result = currentProp.run(config);
            listener.noteResult(result);
            i += 1;
            setTimeout(once, 0);
        };
        once();
    } else {
        for (; i < allProps.length; i++) {
            listener.noteResult(allProps[i].run(config));
        }
    }
}

// generic 'console' listener. When overwriting implement log and warn
/**
 * Abstract class for building 'console' based listeners.
 * Subclasses MUST implement the functions:
 * <ul>
 *   <li>passed</li>
 *   <li>invalid</li>
 *   <li>log</li>
 *   <li>failure</li>
 * </ul>
 *
 * @param maxCollected maximum number of collected elements to display in
 *                     console
 *
 * @class
 */
function ConsoleListener(maxCollected) {
    this.maxCollected = maxCollected || -1;
}

/**
 * Callback to be called for every tested property.
 *
 * @param result a property its test result (Pass, Invalid, Failure)
 */
ConsoleListener.prototype.noteResult = function (result) {
    var i, tags, tag, distr, d,
        status_string = result.status + ": " + result.name;

    if (result.status === "pass") {
        this.passed(result);
        //this.log(result.counts);
    } else {
        this.invalid(status_string);
        //this.log(result);           // FIX: reduced logging
        this.log("pass="+result.stats.pass+", "+
                 "invalid="+result.stats.invalid+"\n"+
                 "shrinkedArgs="+result.shrinkedArgs);
    }
    if (result.status === "fail") {
        this.failure("Failed case:");
        this.log(result.failedCase);
    }

    //print tags
    tags = result.stats.tags;
    if (tags && tags.length > 0) {
        this.log('tags:');
        for (i = 0; i < tags.length;i++) {
            tag = tags[i];
            if (tag instanceof Array) {
                this.log(tag[0] + " : " + tag[1]);
            } else {
                this.log(tag);
            }
        }
    }

    //print histogram statistics if present
    if (this.maxCollected !== 0 && 
        result.stats.collected && 
        result.stats.collected.length > 0)
    {
        distr = result.stats.collected;
        distr = distr.data.slice(
            0, this.maxCollected === -1 ? distr.data.length :
               Math.min(distr.data.length, this.maxCollected));

        distr.sort(function (a, b) {
            return -1 * (a[0] - b[0]);
        });

        this.log('collected:');
        for (i = 0; i < distr.length; i++) {
            d = distr[i];
            this.log(d[0] * 100 + "% : " + d[1]);
        }
    }

};

/**
 * Callback to notify listener that testing all properties finished.
 */
ConsoleListener.prototype.done = function (result) {
    this.log('done.');
};

/**
 * MUST BE IMPLEMENTED BY SUBCLASSES.
 * Used by the ConsoleListener to print a message.
 * @param msg the message to print
 */
ConsoleListener.prototype.log = function(msg) {
    throw("to be implemented by subclass");
}

/**
 * MUST BE IMPLEMENTED BY SUBCLASSES.
 * Print a pass message.
 * @param msg the message to print
 */
ConsoleListener.prototype.passed = function(msg) {
    throw("to be implemented by subclass");
}

/**
 * MUST BE IMPLEMENTED BY SUBCLASSES.
 * Print an invalid property message.
 * @param msg the message to print
 */
ConsoleListener.prototype.invalid = function(msg) {
    throw("to be implemented by subclass");
}

/**
 * MUST BE IMPLEMENTED BY SUBCLASSES.
 * Print a failure message.
 * @param msg the message to print
 */
ConsoleListener.prototype.failure = function(msg) {
    throw("to be implemented by subclass");
}

/**
 * QuickCheck callback for FireBug sending property results to FireBug's
 * console
 *
 * @extends ConsoleListener
 * @class
 */
function FBCListener(maxCollected) { 
    this.maxCollected = maxCollected || 0;
}
FBCListener.prototype = new ConsoleListener();
FBCListener.prototype.passed = function (str) {
    console.log(str);
}
FBCListener.prototype.invalid = function (str) { 
    console.warn(str); 
};
FBCListener.prototype.failure = function (str) { 
    console.error(str); 
};
FBCListener.prototype.log = function (str) {
    console.log(str);
}

/**
 * QuickCheck callback for Rhino sending property results to stdout.
 *
 * @extends ConsoleListener
 * @class
 */
function RhinoListener(maxCollected) {
    this.maxCollected = maxCollected || 10;
}
RhinoListener.prototype = new ConsoleListener();
RhinoListener.prototype.log = function (str) { 
    print(str.toString()); 
};
RhinoListener.prototype.passed = function (str) {
    //print message in green
    print('\033[32m' + str.toString() + '\033[0m');
}
RhinoListener.prototype.invalid = function (str) {
    //print message in yellow
    print('\033[33m' + str.toString() + '\033[0m');
}
RhinoListener.prototype.failure = function (str) {
    //print message in red
    print('\033[31m' + str.toString() + '\033[0m');
}

// some starter generators and support utilities.

function frequency(/** functions */) {
    var d = new Distribution(arguments);
    return function () {
        return d.pick();
    };
}

function choose(/** values */) {
    var d = Distribution.uniform(arguments);
    return function () {
        return d.pick();
    };
}

function randWhole(top) {
    return Math.floor(Math.random() * top);
}

function randInt(top) {
    return randWhole(2 * top) - top;
}

function randRange(a, b) {
    return randWhole(b - a) + a;
}

function randFloatUnit() {
    return Math.random();
}

/**
 * Passes the size 'seed' argument use to drive generators directly to the
 * property its test function.
 *
 * @constant
 */
var justSize = {
    arb: function (size) { 
            return size; 
        },
    shrink: null
};

function arbChoose(/** generators... */) {
    var d = Distribution.uniform(arguments);
    return {
        arb: function (size) {
                return genvalue(d.pick(), size);
            },
        shrink: null
    };
}

/**
 * Generator builder. The created generator will always return the given
 * constant value.
 */
function arbConst(/** values... */) {
    var d = Distribution.uniform(arguments);
    return {
        arb: function () { return d.pick(); }
    };
}


/**
 * Boolean value generator. Generates true or false by 50:50 chance.
 *
 * @constant
 */
var arbBool = {
    arb: choose(false, true)
};

/**
 * Null generator. Always generates 'null'.
 *
 * @constant
 */
var arbNull = arbConst(null);

/**
 * Integer value generator. All generated values are >= 0.<br/>
 * Supports shrinking.
 *
 * @constant
 */
var arbWholeNum = {
    arb: randWhole,
    shrink: function (size, x) {
        var tmp = x, ret = [];
        while (true) {
            if (0 === (tmp = Math.floor(tmp / 2))) {
                break;
            }
            ret.push(x - tmp);
        }
        return ret;
    }
};

/**
 * Integer value generator.  <br/>
 * Supports shrinking.
 *
 * @constant
 */
var arbInt = {
    arb: randInt,
    shrink: function (size, x) {
        var tmp = x, ret = [];
        if (x < 0) {
            ret.push(-x);
        }

        while (true) {
            tmp = tmp / 2;
            if (tmp === 0) {
                break;
            }

            tmp = tmp < 0 ? Math.ceil(tmp) : Math.floor(tmp);
            ret.push(x - tmp);
        }
        return ret;
    }
};

/**
 * Float value generator. Generates a floating point value in between 0.0 and
 * 1.0. <br/>
 * Supports shrinking.
 *
 * @constant
 */
var arbFloatUnit = {
    arb: randFloatUnit,
    shrink: function (size, x) {
        var tmp, ret = [];

        if (x < 0) {
            ret.push(-x);
            tmp = Math.ceil(x);
        } else {
            tmp = Math.floor(x);
        }

        if (tmp !== x) ret.push(tmp);

        return ret;
    }
};

function arbRange(a, b) {
    var min = Math.min(a, b),
        max = Math.max(a, b);

    return function (size) {
        return Math.floor(Math.random() * (max - min)) + min;
    };
}

function arbNullOr(otherGen) {
    //return arbSelect(otherGen, arbNull);
    var d = new Distribution([[10, arbNull], [90, otherGen]]);
    return {
        arb: function (size) {
                return genvalue(d.pick(), size);
            },
        shrink: function (size, a) {
            if (a === null) {
                return [];
            } else {
                return [null].concat(genshrinked(otherGen, size, a));
            }
        }
    };
}

/**
 * Array shrinking strategy. Will build new Arrays by removing one element 
 * from given array.
 */
function arrShrinkOne(size, arr) {
    if (!arr || arr.length === 0) return [];
    if (arr.length === 1) return [[]];

    function copyAllBut(idx) {
        var i, tmp = new Array(arr.length - 1);
        for (i = 0; i < arr.length; i++) {
            if (i === idx) {
                continue;
            }
            tmp[i < idx ? i : i - 1] = arr[i];
        }
        return tmp;
    }

    var i, ret = new Array(arr.length);
    for (i = 0; i < arr.length; i++) {
        ret[i] = copyAllBut(i);
    }
    return ret;
}

/**
 * Array generator. Generates array of arbitrary length with given generator.
 *
 * @param {Generator} innerGen the generator create the resulting array its
 *                    values from
 * @param [shrinkStrategy] optional shrinking strategy. Default is
 *        'arrShrinkOne'
 */
function arbArray(innerGen, shrinkStrategy) {
    function gen(size) {
        var i, list = [],
            listSize = randWhole(size);
        for (i = 0; i < listSize; i += 1) {
            list.push(genvalue(innerGen, size));
        }
        return list;
    }

    return { arb: gen, shrink: shrinkStrategy || arrShrinkOne };
}

/**
 * Property test function modifier. Using this modifier, it is assumed that 
 * the testing function will throw an exception and if not the property will
 * fail.
 */
function expectException(fn) {
    return function (c) {
        try {
            fn.apply(this, arguments);
        } catch (e) {
            if (e === 'AssertFailed' || e === 'InvalidCase') {
                throw e;
            }
            c.assert(true);
            return;
        }
        c.assert(false);
    };
}

/**
 * Property test function modifier. Instead of finishing testing when an
 * unexpected exception is thrown, the offending property is marked as failure
 * and QuickCheck will continue.
 */
function failOnException(fn) {
    return function (c) {
        try {
            fn.apply(this, arguments);
        } catch (e) {
            if (e === 'AssertFailed' || e === 'InvalidCase') {
                throw e;
            }
            c.assert(false);
        }
    };
}

/**
 * Date value generator. Always generates a new Date object by calling 
 * 'new Date()'.
 *
 * @constant
 */
var arbDate = {
    arb: function () { 
        return new Date(); 
    }
};

function arbMod(a, fn) {
    return {
        arb: function (size) {
            return fn(genvalue(a, size));
        }
    };
}

/**
 * Character value generator.
 * Will generate any character with char code in range 32-255.
 *
 * @constant
 */
var arbChar = arbMod(arbRange(32, 255),
                     function (num) {
                         return String.fromCharCode(num);
                     });

/**
 * String value generator. All characters in the generated String
 * are in range 32-255.<br/>
 * Supports shrinking.
 *
 * @constant
 */
var arbString = new function () {
    var a = arbArray(arbRange(32, 255));

    this.arb = function (size) {
        var tmp = genvalue(a, size);
        return String.fromCharCode.apply(String, tmp);
    };

    this.shrink = function (size, str) {
        var i, ret = [], tmp = new Array(str.length);
        for (i = 0; i < str.length; i++) {
            tmp[i] = str.charCodeAt(i);
        }

        tmp = genshrinked(a, size, tmp);
        ret = [];
        for (i = 0; i < tmp.length; i++) {
            ret.push(String.fromCharCode.apply(String, tmp[i]));
        }
        return ret;
    };

    return this;
};

/**
 * 'undefined' generator. Always generates 'undefined'.
 *
 * @constant
 */
var arbUndef = arbConst(undefined);

function arbUndefOr(opt) {
    var d = new Distribution([[10, arbUndef], [90, opt]]);
    return {
        arb: function (size) {
            return genvalue(d.pick(), size);
        },
        shrink: function (size, a) {
            return a === undefined || a === null ? 
                       [] : 
                       genshrinked(opt, size, a);
        }
    };
}


/**********************************************/
/*            Exports for CommonJS            */
/**********************************************/
if (exports) {
    exports.allProps = allProps;
    exports.resetProps = resetProps;

    exports.Invalid = Invalid;
    exports.Pass = Pass;
    exports.Fail = Fail;
    exports.Stats = Stats;
    exports.Distribution = Distribution;

    exports.genvalue = genvalue;
    exports.genshrinked = genshrinked;

    exports.Prop = Prop;
    exports.Case = Case;

    exports.declare = declare;
    exports.Config = Config;
    exports.runAllProps = runAllProps;

    exports.ConsoleListener = ConsoleListener;
    exports.FBCListener = FBCListener;
    exports.RhinoListener = RhinoListener;

    exports.frequency = frequency;
    exports.choose = choose;
    exports.randWhole = randWhole;
    exports.randInt = randInt;
    exports.randRange = randRange;
    exports.randFloatUnit = randFloatUnit;

    exports.justSize = justSize
    exports.arbChoose = arbChoose;
    exports.arbConst = arbConst;
    exports.arbBool = arbBool;
    exports.arbNull = arbNull
    exports.arbWholeNum = arbWholeNum
    exports.arbInt = arbInt;
    exports.arbFloatUnit = arbFloatUnit;
    exports.arbRange = arbRange;
    exports.arbNullOr = arbNullOr;

    exports.arrShrinkOne = arrShrinkOne;
    exports.arbArray = arbArray

    exports.expectException = expectException
    exports.failOnException = failOnException

    exports.arbDate = arbDate;
    exports.arbMod = arbMod;
    exports.arbChar = arbChar;
    exports.arbString = arbString;
    exports.arbUndef = arbUndef;
    exports.arbUndefOr = arbUndefOr;
}
/**********************************************/
/*               End of Exports               */
/**********************************************/
