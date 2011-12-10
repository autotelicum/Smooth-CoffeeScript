(function() {
  var draw, drawMove, drawPath, movement, partial10lines, partial12lines, partial15lines, partial3lines, partial4lines, partial5lines, partial8lines, partialFree, show, showDocument, swirl, test, _;
  var __slice = Array.prototype.slice;

  show = console.log;

  showDocument = function(doc, width, height) {
    return show(doc);
  };

  draw = function(ctx) {
    var ix;
    ctx.beginPath();
    ctx.strokeStyle = 'gold';
    drawMove(ctx, (function() {
      var _results;
      _results = [];
      for (ix = 0; ix < 90; ix += 10) {
        _results.push(ix);
      }
      return _results;
    })());
    ctx.beginPath();
    ctx.strokeStyle = 'salmon';
    return drawPath(ctx, (function() {
      var _results;
      _results = [];
      for (ix = 0; ix < 90; ix += 10) {
        _results.push(ix);
      }
      return _results;
    })());
  };

  movement = function(ctx, ax, ay, cp1x, cp1y, cp2x, cp2y, x, y) {
    ctx.moveTo(ax, ay);
    return ctx.bezierCurveTo(cp1x, cp1y, cp2x, cp2y, x, y);
  };

  drawMove = function(ctx, args) {
    args.forEach(function(ix) {
      return movement(ctx, 0, 0, 30, 30, 150 + ix, 50, 110 + ix, 90);
    });
    return ctx.stroke();
  };

  _ = void 0;

  partialFree = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var arg, b;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return func.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          arg = a[_i];
          _results.push(arg != null ? arg : arg = b.shift());
        }
        return _results;
      })());
    };
  };

  swirl = partialFree(movement, _, _, 0, 30, 30, _, 50, _, 90);

  drawPath = function(ctx, args) {
    args.forEach(function(ix) {
      return swirl(ctx, 200, 150 + ix, 110 + ix);
    });
    return ctx.stroke();
  };

  _ = {};

  partial15lines = function() {
    var args, func, wrapper;
    func = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return wrapper = function() {
      var i, j, res_args;
      i = 0;
      j = 0;
      res_args = [];
      while (i < args.length) {
        if (args[i] === _) {
          res_args.push(arguments[j]);
          j++;
        } else {
          res_args.push(args[i]);
        }
        i++;
      }
      return func.apply(null, res_args);
    };
  };

  _ = {};

  partial12lines = function() {
    var args, func;
    func = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var i, j, moreargs, res_args;
      moreargs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      i = j = 0;
      res_args = [];
      while (i < args.length) {
        if (args[i] === _) {
          res_args.push(moreargs[j++]);
        } else {
          res_args.push(args[i]);
        }
        i++;
      }
      return func.apply(null, res_args);
    };
  };

  _ = {};

  partial10lines = function() {
    var args, func;
    func = arguments[0], args = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var i, j, moreargs;
      moreargs = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      i = j = 0;
      return func.apply(null, (function() {
        var _results;
        _results = [];
        while (i++ < args.length) {
          if (args[i - 1] === _) {
            _results.push(moreargs[j++]);
          } else {
            _results.push(args[i - 1]);
          }
        }
        return _results;
      })());
    };
  };

  _ = {};

  partial8lines = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var arg, b, i;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      i = 0;
      return func.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          arg = a[_i];
          if (arg === _) {
            _results.push(b[i++]);
          } else {
            _results.push(arg);
          }
        }
        return _results;
      })());
    };
  };

  _ = {};

  partial5lines = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var arg, b;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      b.reverse();
      return func.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          arg = a[_i];
          if (arg === _) {
            _results.push(b.pop());
          } else {
            _results.push(arg);
          }
        }
        return _results;
      })());
    };
  };

  _ = void 0;

  partial4lines = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var arg, b;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      b.reverse();
      return func.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          arg = a[_i];
          _results.push(arg != null ? arg : arg = b.pop());
        }
        return _results;
      })());
    };
  };

  _ = void 0;

  partial3lines = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var arg, b;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return func.apply(null, (function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = a.length; _i < _len; _i++) {
          arg = a[_i];
          _results.push(arg != null ? arg : arg = b.shift());
        }
        return _results;
      })());
    };
  };

  test = function() {
    var f, fold, g, max, min, partial;
    f = function(x, y, z) {
      return x + 2 * y + 5 * z;
    };
    g = partialFree(f, _, 1, _);
    show("g 3, 5 => " + (g(3, 5)) + " Expected: 30");
    fold = function(f, z, xs) {
      var x, _i, _len;
      for (_i = 0, _len = xs.length; _i < _len; _i++) {
        x = xs[_i];
        z = f(z, x);
      }
      return z;
    };
    max = partialFree(fold, Math.max, -Infinity, _);
    show("max [-10..10] => " + (max([-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])) + " Expected: 10");
    partial = function() {
      var a, f;
      f = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return function() {
        var b;
        b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return f.apply(null, __slice.call(a).concat(__slice.call(b)));
      };
    };
    min = partial(fold, Math.min, Infinity);
    return show("min [-10..10] => " + (min([-10, -9, -8, -7, -6, -5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])) + " Expected: -10");
  };

  partialFree = partial3lines;

  test();

}).call(this);
