(function() {
  var Account, AccountWithFee, BinaryHeap, CoffeeKup, CoffeeScript, Container, Dictionary, FoundSeven, HTML, LimitedAccount, Point, Rabbit, WeightyRabbit, Widget, a, absolute, abyss, add, addCats, addFive, addPoints, addToSet, addTwo, andHere, argumentCounter, array, asteriskOrBrace, b, badWords, between, bits, blackRabbit, body, cartoonCrying, cat, catData, catInfo, catNames, catRecord, caught, chicken, child, chimera, chineseBox, colours, compose, confirm, count, countZeroes, counter, current, currentNumber, currentThing, dal, datePattern, deadCats, decorate, defaultTo, digitSurroundedBySpace, digits, dino, doSomething, doc, doh, draw, eatOne, echoEchoEcho, egg, element, email, empty, equals, equals10, escapeHTML, escapeHTML2, estimatedDistance, evens, extractDate, extractFootnotes, extractMother, f, fa, fatRabbit, findCats, findLivingCats, findReached, findRoute, findSequence, firstName, footnote, forEach, forEachIn, forEachOf, formatDate, fun, g, gamblerPath, getProperty, globalize, greaterThan, greaterThanTen, gulfWarOne, hasSevenTruths, hazelRabbit, heap, heightAt, holyCow, howMany, htmlDoc, i, image, imageSource, info, intensify, isAcceptable, isDefined, isHere, isNotNaN, isOdd, isUndefined, jumboRabbit, key, killerRabbit, kup, la, lacc, lastElement, lastElementPlusTen, lastName, lessthan, line, link, linkObject, linkOstrich, linkText, livingCats, luckyNumber, luigiDebt, mack, mailAddress, mailArchive, makeAddFunction, makeRabbit, makeReachedList, makeRoad, makeRoads, map, mapSquared, meteor, mi, mim, minimise, moonGravity, morethan, mysteryVariable, n, nQueen, name, names, negate, newBalance, noCatsAtAll, notABC, nothing, now, number, numbers, obj, object1, object2, object3, oldBalance, oldestCat, op, ostrich, paragraph, paragraphs, parentFunction, parenthesized, parenthesizedText, partial, partialReverse, pattern, permute, pi, point, pointID, possibleDirections, possibleRoutes, post, power, powerRec, pre, print, printArray, printBoard, processParagraph, processThing, prompt, property, propertyName, pt, quote, ra, rabbit, radius, range, re, recluseFile, reduce, removeFromSet, renderFile, renderFootnote, renderFragment, renderHTML, renderParagraph, renderRoute, rep, reptile, result, retrieveMails, roads, roadsFrom, roll, route, runOnDemand, salary, samePoint, set, shortestRoute, shortestRouteAbstract, show, showDocument, showRoute, showSortedRoute, showVariable, simpleObject, slash, sol, solve, speak, sphereSurfaceArea, splitParagraph, splitStringAt, square, startsWith, steppenwolf, stipulations, stock, storeReached, story, sum, tag, takeNormalAlternative, tautounlogical, test, testIt, testdata, text, thing, ti, timeIt, tinyRabbit, today, total, traverseRoute, ultimatum, url, value, varWhich, variable, view, wallFall, wallFall1, wallFall2, weatherAdvice, webdesign, webpage, weightedDistance, whenWasIt, whiteRabbit, word, words, x, y, yell, yourAccount, π, _, _any, _break, _every, _filter, _flatten, _forEach, _i, _j, _k, _l, _len, _len10, _len11, _len2, _len3, _len4, _len5, _len6, _len7, _len8, _len9, _m, _member, _n, _o, _p, _q, _r, _ref, _ref2, _ref3, _ref4, _ref5, _ref6, _ref7, _ref8, _ref9,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; },
    __slice = Array.prototype.slice,
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  CoffeeScript = require('coffee-script').CoffeeScript;

  _ = require('underscore');

  CoffeeKup = require('coffeekup');

  show = console.log;

  showDocument = function(doc, width, height) {
    return show(doc);
  };

  draw = function(ctx) {
    var Point, bigFont, brush, decode, drawDrabSurface, drawPreciousBrush, hidden, onmove, ontouch, renderInStyle, smallFont, surfaceText, _ref;
    Point = (function() {

      function Point(x, y) {
        this.x = x;
        this.y = y;
      }

      Point.prototype.drawDisc = function(context, style, size) {
        if (size == null) size = 10;
        context.beginPath();
        context.fillStyle = style;
        context.arc(this.x, this.y, size, 0, 2 * Math.PI, false);
        return context.fill();
      };

      return Point;

    })();
    renderInStyle = function(context, _arg, render) {
      var back, background, front;
      back = _arg.back, front = _arg.front;
      background = function(context, style) {
        context.beginPath();
        context.fillStyle = style;
        return context.fillRect(0, 0, context.canvas.width, context.canvas.height);
      };
      background(context, back);
      context.beginPath();
      context.fillStyle = front;
      return render();
    };
    drawDrabSurface = function(context, font, text, style) {
      var drawRepeatRotated;
      drawRepeatRotated = function(angle) {
        var distance, height, textWidth, x, y, _ref;
        if (angle == null) angle = 0.2;
        context.save();
        context.rotate(angle);
        context.font = font;
        distance = 2 * parseInt(font, 10);
        textWidth = context.measureText(text).width;
        height = context.canvas.height;
        for (x = 0, _ref = context.canvas.width; 0 <= _ref ? x < _ref : x > _ref; x += textWidth) {
          for (y = -height; -height <= height ? y < height : y > height; y += distance) {
            context.fillText(text, x, y);
          }
        }
        return context.restore();
      };
      return renderInStyle(context, style, drawRepeatRotated);
    };
    drawPreciousBrush = function(context, lines, style) {
      var createCanvasContext, ctxBrush;
      createCanvasContext = function(_arg) {
        var canvas, height, width, _ref;
        width = _arg.width, height = _arg.height;
        canvas = document.createElement('canvas');
        _ref = [width, height], canvas.width = _ref[0], canvas.height = _ref[1];
        return canvas.getContext('2d');
      };
      ctxBrush = createCanvasContext(context.canvas);
      renderInStyle(ctxBrush, style, function() {
        var font, text, x, y, _i, _len, _ref;
        for (_i = 0, _len = lines.length; _i < _len; _i++) {
          _ref = lines[_i], text = _ref.text, font = _ref.font, x = _ref.x, y = _ref.y;
          ctxBrush.font = font;
          ctxBrush.fillText(text, x, y);
        }
      });
      return context.createPattern(ctxBrush.canvas, 'repeat');
    };
    decode = function(nums) {
      return String.fromCharCode.apply(String, nums);
    };
    _ref = ['12px sans-serif', '52px sans-serif'], smallFont = _ref[0], bigFont = _ref[1];
    surfaceText = 'CoffeeScript   ✵   Scratch Card  ✵  ';
    hidden = [
      {
        x: 15,
        y: 100,
        font: bigFont,
        text: decode([67, 111, 102, 102, 101, 101, 83, 99, 114, 105, 112, 116])
      }, {
        x: 80,
        y: 180,
        font: bigFont,
        text: decode([73, 116, 39, 115, 32, 106, 117, 115, 116])
      }, {
        x: 30,
        y: 260,
        font: bigFont,
        text: decode([74, 97, 118, 97, 83, 99, 114, 105, 112, 116, 33])
      }, {
        x: 190,
        y: 310,
        font: smallFont,
        text: decode([68, 79, 85, 66, 76, 69, 80, 76, 85, 83, 71, 79, 79, 68])
      }
    ];
    brush = drawPreciousBrush(ctx, hidden, {
      back: 'darkgrey',
      front: 'grey'
    });
    drawDrabSurface(ctx, smallFont, surfaceText, {
      back: 'silver',
      front: '#663300'
    });
    ctx.canvas.onmousemove = onmove = function(evt) {
      var pos;
      pos = new Point(evt.pageX - ctx.canvas.offsetLeft, evt.pageY - ctx.canvas.offsetTop);
      return pos.drawDisc(ctx, brush);
    };
    return ctx.canvas.ontouchmove = ontouch = function(evt) {
      var touch, _i, _len, _ref2;
      evt.preventDefault();
      _ref2 = evt.targetTouches;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        touch = _ref2[_i];
        onmove(touch);
      }
    };
  };

  webdesign = function() {
    doctype(5);
    return html(function() {
      head(function() {
        meta({
          charset: 'utf-8'
        });
        title('My drawing | My awesome website');
        style('body {font-family: sans-serif}\nheader, nav, section, footer {display: block}');
        return coffeescript(function() {
          draw = function(ctx, x, y) {
            var angle, circle, _ref, _ref2, _results;
            circle = function(ctx, x, y) {
              ctx.beginPath();
              ctx.arc(x, y, 100, 0, 2 * Math.PI, false);
              return ctx.stroke();
            };
            ctx.strokeStyle = 'rgba(255,40,20,0.7)';
            circle(ctx, x, y);
            _results = [];
            for (angle = 0, _ref = 2 * Math.PI, _ref2 = 1 / 3 * Math.PI; 0 <= _ref ? angle < _ref : angle > _ref; angle += _ref2) {
              _results.push(circle(ctx, x + 100 * Math.cos(angle), y + 100 * Math.sin(angle)));
            }
            return _results;
          };
          return window.onload = function() {
            var canvas, context;
            canvas = document.getElementById('drawCanvas');
            context = canvas.getContext('2d');
            return draw(context, 300, 200);
          };
        });
      });
      return body(function() {
        header(function() {
          return h1('Seed of Life');
        });
        return canvas({
          id: 'drawCanvas',
          width: 550,
          height: 400
        });
      });
    });
  };

  kup = typeof exports !== "undefined" && exports !== null ? require('coffeekup') : CoffeeKup;

  webpage = kup.render(webdesign, {
    format: true
  });

  showDocument(webpage, 565, 500);

  show("Library            Version\n------------------   -------------\nCoffeescript         " + CoffeeScript.VERSION + "\nUnderscore           " + _.VERSION + "\nCoffeeKup            " + CoffeeKup.version + "\nQuickCheck           qc.js-2009");

  this.showTiming = false;

  this.globalNames = 'Account HTML Rabbit _break _forEach absolute\
 addCats addPoints addToSet between bits blackRabbit catData catNames\
 catRecord deadCats escapeHTML estimatedDistance extractDate\
 extractFootnotes extractMother fatRabbit findReached findRoute\
 footnote forEach hasSevenTruths heightAt htmlDoc image killerRabbit\
 link linkOstrich livingCats livingCats mailArchive makeReachedList\
 makeRoad makeRoads map oldestCat op paragraph paragraphs partial\
 point possibleDirections possibleRoutes power powerRec processParagraph\
 range recluseFile reduce removeFromSet renderFootnote renderHTML\
 renderParagraph retrieveMails roadsFrom route samePoint shortestRoute\
 shortestRouteAbstract simpleObject speak splitParagraph square\
 startsWith storeReached tag traverseRoute weightedDistance yell';

  this.ostrich = ostrich = 'data:image/png;base64,/9j/4AAQSkZJRgABAgAAZABkAAD/7AARRHVja3kAAQAEAAAAHgAA/+4ADkFkb2JlAGTAAAAAAf/bAIQAEAsLCwwLEAwMEBcPDQ8XGxQQEBQbHxcXFxcXHx4XGhoaGhceHiMlJyUjHi8vMzMvL0BAQEBAQEBAQEBAQEBAQAERDw8RExEVEhIVFBEUERQaFBYWFBomGhocGhomMCMeHh4eIzArLicnJy4rNTUwMDU1QEA/QEBAQEBAQEBAQEBA/8AAEQgAWgBaAwEiAAIRAQMRAf/EAIYAAAIDAQEBAAAAAAAAAAAAAAQFAgMGAAEHAQEBAQEBAAAAAAAAAAAAAAACAQMABBAAAgEDAwIDBQYFBQEAAAAAAQIDABEEITESQQVhIhNRcYGhMrFCMxQVBpHBUmJDcqIjUzQ1EQACAgICAgIDAAAAAAAAAAAAARECITFBElFhcaHBIgP/2gAMAwEAAhEDEQA/AMtBEzW3o9ICBUsWG9qPWHTavPa2TZIDENx1qxI7WvRHEA6Uwwe1evxyMg8YL6KPqe32CopZXgAQAUdBBE/l4sQw/EPQ+FNJcjs+DFI6wxsVGq738LtSXJ/c8EbGD0OOPIBqAAyk+weyr19yTt6ITxMjFG3XehJUa2hNTHdcOWVTJo4urno69D764EMGN9msviLXvRiCyATcgLXNBSEnrameQnKhGxz7KdWFoFQsrbmir+J+mq0j81qK9Mf7aU5JBZiMRqaY+cwGYWKqeJA3FKYHKi23zptjIqQmVnLBgeSrp5RsdayssjQNI3AGQgkDUr1tUcvvxkUeivkQeXXa39tC5vcV+kPzXxFiPfQQMUqtYWO5+NKtfKC34LTm5mTxlPKXgeTCwVVHhrQjRnmVD+oSwW4Gt99KIWZorBVFiOJuP6tzTjHxsJceKZQpyI+DWUEkm9yoBsSRtTbjgmxNNjH8xxhQqIyRITtyP0r8qtORLCI1IvLExDBhbS2laTgmH6QCI6yHk6cbt6h6szgdTakWefWeQqi+RmvIu21+Itp8RU3tFiCw5MT8OZCO6huOttakGjlBEZ5eIpbMuRIy2GllBB95ozFj9MlmIUMblR0otJIqZJILtfeifQ+yjsSGOYC2/W1F/p/9w2oyywjLRMVfanU2eZYjBCllIs5OpNht4ClSY8ryqsQJdiAoHtphMpjurqL3N2F9TVbIjNZ6OkpO19Bapfp2Tr6ciyzqvqPDGSzKgsSSdtL6gUz9PEfuOOJyBCWHNjsF9poPP7aqZTMJAOOu41HRgeoNaK8RJy/n2mNrieOSjHkZivIXuQCfcafYYAaOc6kCykai/wBX2mhcbtU57eJuJtIzPbrw2U2rSdiwZAkWRIto7WWMDRr7tY1Hl4DoDZMhsmR52u8YW0SnzctW8NTyoKZLEgLxBbz21BtqSTWpzO0JLOkoJGOtiygnTieVh76Q9/xUSKXJwrLEt/VjB2c25Fajq5KmZ/IzURLfe020/hQP52d2trr93f7K8m5hwQnK4AG++9GxQKncIGVfTuoZhuAaWESLPOtfY8/bjZLLcxFkPW38603n/wCofT4UsTusMYCgC/Wwq39VHyvQ7L8izoSiBgbjQjYjeo5JkWKxJa/QnX505jxhuRQvcsc+g1h40SmYmkBewTfQAmtBidjxpcaOZoNRbmisWI5amyXtb3Vm/VBkCML67bWp3h50UMKoh5MDsGPEDfVSfsrRhXJr8bGUYrLJ5kItxPQW/lV0UsarwH+Py2pR23v8bERyNzhbdGN3S/3lc/Uvv1FB9+7zldqzA2NgPNBoWnflwcW2XhsffST1AX7NQ8SzQsDpyv8AZWRkR1xpo528zlkkVRYctdSPnWsxclMvt2PloCiTIHVTuAwBsay3fHwl/c2JiJzWSfi8jg+Tz3AFvtqXrMNcHVZn82F8ObkqcogRyBNzp0vQqyvLlGeQ2JOi/wBKjYU87/DFFkMuPYq44sx+pjsSvsFIVThLY73/AIVFz5E23Clx4GXM35A1d+Yb29KGRgwtVnE/KiU2CkBaHyQGjYFb6bVR+bFSE4kNuVvGo7I6GYzumPJFO9l4A6hfCgVyJkOjWp73lY/UK3Y3OrEaUhljYagfGtaOUgWUMmmfJGwJ1tsb6i/srYftv92RMq4eawZNk5bgezxFYU71wuCCDYjY0uq+Ayz7XFlYuTF/wlSg0BW1tPdSPuGUkOohDTqvGOZtBY3vyfw3rC9v/cWfgyrIrliNGF/qH91d3HvWZ3NzyuikWKA6W9nuotN40JdV7O7h3P8AMZhkXzKiiOM9NN2+Jr3Fj5ed73NDxQAbijYmCWtpUeoRVPIZGgA2tV1h8qEjmuas9Tx6UIYgh8hlFShmEikN10ub2A9ulUP8KPX/AOZ/i3P4P4m33qOCiPNZg11tx0A1NhQWQxMY06EUc/8A5D/q+Hx8aAyfxW3361tUFtgbC1QNTPwrw/CtDM4UVjRlt/hQw26Uww/o6UWVFuwr0Iz2C163wonF3H00Bl2LgXF2or9NTxojH2G3woj+FZ/tI8H/2Q==';

  this.incrementalEvaluation = true;

  if (typeof exports !== "undefined" && exports !== null) {
    view = function(obj) {
      show(obj);
      return obj;
    };
    runOnDemand = confirm = prompt = function() {};
  }

  total = 0;

  count = 1;

  while (count <= 10) {
    total += count;
    count += 1;
  }

  total;

  total = 0;

  for (count = 1; count <= 10; count++) {
    total += count;
  }

  total;

  sum = function(v) {
    return _.reduce(v, (function(a, b) {
      return a + b;
    }), 0);
  };

  sum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]);

  Array.prototype.sum = function() {
    return this.reduce((function(a, b) {
      return a + b;
    }), 0);
  };

  show([1, 2, 3, 4, 5, 6, 7, 8, 9, 10].sum());

  delete Array.prototype.sum;

  144;

  9.81;

  2.998e8;

  100 + 4 * 11;

  (100 + 4) * 11;

  'Patch my boat with chewing gum.';

  'The programmer pondered: "0x2b or not 0x2b"';

  "Aha! It's 43 if I'm not a bit off";

  "2 + 2 gives " + (2 + 2);

  'Imagine if this was a\
 very long line of text';

  'First comes A\nthen comes B';

  "Math 101:\n  1\n+ 1\n---\n  " + (1 + 1);

  'This is the first line\nAnd this is the second';

  'A newline character is written like "\\n".';

  'con' + 'cat' + 'e' + 'nate';

  typeof 4.5;

  -(10 - 2);

  3 > 2;

  3 < 2;

  (100 < 115 && 115 < 200);

  (100 < 315 && 315 < 200);

  'Aardvark' < 'Zoroaster';

  'Itchy' !== 'Scratchy';

  true && false;

  true || false;

  (false || true) && !(false && true);

  true && !false;

  true;

  1;

  !false;

  caught = 5 * 5;

  caught = 4 * 4;

  luigiDebt = 140;

  luigiDebt = luigiDebt - 35;

  show('Also, your hair is on fire.');

  show(Math.max(2, 4));

  show(100 + Math.max(7, 4));

  show(Math.max(7, 4) + 100);

  show(Math.max(7, 4 + 100));

  show(Math.max(7, 4 + 100));

  show(Math.PI);

  if (typeof console !== "undefined" && console !== null) show(console);

  show(showDocument);

  show(1 + 2 + 3 + 4 + 5 + view(6 + 7));

  confirm('Shall we, then?', function(answer) {
    return show(answer);
  });

  prompt('Tell us everything you know', '...', function(answer) {
    return show('So you know: ' + answer);
  });

  prompt('Pick a number', '', function(answer) {
    var theNumber;
    theNumber = Number(answer);
    return show('Your number is the square root of ' + (theNumber * theNumber));
  });

  show(0);

  show(2);

  show(4);

  show(6);

  show(8);

  show(10);

  show(12);

  currentNumber = 0;

  while (currentNumber <= 12) {
    show(currentNumber);
    currentNumber = currentNumber + 2;
  }

  counter = 0;

  while (counter <= 12) {
    counter = counter + 2;
  }

  result = 1;

  counter = 0;

  while (counter < 10) {
    result = result * 2;
    counter = counter + 1;
  }

  show(result);

  line = '';

  counter = 0;

  while (counter < 10) {
    line = line + '#';
    show(line);
    counter = counter + 1;
  }

  for (number = 0; number <= 12; number += 2) {
    show(number);
  }

  for (number = 0; number <= 12; number += 2) {
    show(number);
  }

  for (number = 0; number <= 12; number += 2) {
    show(number);
  }

  counter = 0;

  while (counter < 100) {
    /*
      Every time we loop, we INCREMENT the value of counter
      Seriously, we just add one to it.
    */
    counter++;
  }

  result = 1;

  for (counter = 0; counter < 10; counter++) {
    result = result * 2;
  }

  show(result);

  line = '';

  for (counter = 0; counter < 10; counter++) {
    line = line + '#';
    show(line);
  }

  for (counter = 0; counter <= 20; counter++) {
    if (counter % 3 === 0 && counter % 4 === 0) show(counter);
  }

  for (counter = 0; counter <= 20; counter++) {
    if (counter % 4 === 0) show(counter);
    if (counter % 4 !== 0) show('(' + counter + ')');
  }

  for (counter = 0; counter <= 20; counter++) {
    if (counter % 4 === 0) {
      show(counter);
    } else {
      show('(' + counter + ')');
    }
  }

  for (counter = 0; counter <= 20; counter++) {
    if (counter > 15) {
      show(counter + '**');
    } else if (counter > 10) {
      show(counter + '*');
    } else {
      show(counter);
    }
  }

  prompt('You! What is the value of 2 + 2?', '', function(answer) {
    if (answer === '4') {
      return show('You must be a genius or something.');
    } else if (answer === '3' || answer === '5') {
      return show('Almost!');
    } else {
      return show('You are an embarrassment.');
    }
  });

  fun = true;

  if (fun !== false) show('The show is on!');

  current = 20;

  while (true) {
    if (current % 7 === 0) break;
    current++;
  }

  show(current);

  current = 20;

  while (current % 7 !== 0) {
    current++;
  }

  show(current);

  roll = Math.floor(Math.random() * 6 + 1);

  luckyNumber = 5;

  show("Your lucky number is " + luckyNumber);

  count = 0;

  while (true) {
    show(roll = Math.floor(Math.random() * 6 + 1));
    count++;
    if (roll === luckyNumber) break;
  }

  show("Luck took " + count + " roll(s)");

  luckyNumber = 3;

  show('Your lucky number is ' + luckyNumber);

  count = 0;

  while (roll !== luckyNumber) {
    show(roll = Math.floor(Math.random() * 6 + 1));
    count++;
  }

  show('You are lucky ' + Math.floor(100 / count) + '% of the time');

  show(mysteryVariable);

  mysteryVariable = 'nothing';

  show(show('I am a side effect.'));

  show(typeof iam !== "undefined" && iam !== null ? iam : void 0);

  if (typeof iam === "undefined" || iam === null) iam = 'I want to be';

  show(iam);

  if (typeof iam === "undefined" || iam === null) iam = 'I am already';

  if (typeof iam !== "undefined" && iam !== null) show(iam);

  show(false === 0);

  show('' === 0);

  show('5' === 5);

  show(null === undefined);

  show(false === 0);

  show('' === 0);

  show('5' === 5);

  show('Apollo' + 5);

  show(null + 'ify');

  show('5' * 5);

  show('strawberry' * 5);

  show(Number('5') * 5);

  prompt('What is your name?', '', function(input) {
    return show('Well hello ' + (input || 'dear'));
  });

  false || show('I am happening!');

  true || show('Not me.');

  add = function(a, b) {
    return a + b;
  };

  add(2, 2);

  power = function(base, exponent) {
    var count;
    result = 1;
    for (count = 0; 0 <= exponent ? count < exponent : count > exponent; 0 <= exponent ? count++ : count--) {
      result *= base;
    }
    return result;
  };

  power(2, 10);

  absolute = function(number) {
    if (number < 0) {
      return -number;
    } else {
      return number;
    }
  };

  absolute(-144);

  runOnDemand(function() {
    var testAbsolute;
    testAbsolute = function(name, property) {
      return testPure(absolute, [arbInt], name, property);
    };
    testAbsolute('returns positive integers', function(c, arg, result) {
      return result >= 0;
    });
    testAbsolute('positive returns positive', function(c, arg, result) {
      c.guard(arg >= 0);
      return result === arg;
    });
    testAbsolute('negative returns positive', function(c, arg, result) {
      c.guard(arg < 0);
      return result === -arg;
    });
    return test();
  });

  runOnDemand(function() {
    testPure(power, [arbInt, arbInt], 'power equals Math.pow for integers', function(c, base, exponent, result) {
      return result === c.note(Math.pow(base, exponent));
    });
    return test();
  });

  runOnDemand(function() {
    testPure(power, [arbWholeNum, arbWholeNum], 'power equals Math.pow for positive integers', function(c, base, exponent, result) {
      return result === c.note(Math.pow(base, exponent));
    });
    return test();
  });

  intensify = function(n) {
    return 2;
  };

  runOnDemand(function() {
    testPure(intensify, [arbInt], 'intensify grows by 2 when positive', function(c, arg, result) {
      c.guard(arg > 0);
      return arg + 2 === result;
    });
    testPure(intensify, [arbInt], 'intensify grows by 2 when negative', function(c, arg, result) {
      c.guard(arg < 0);
      return arg - 2 === result;
    });
    testPure(intensify, [arbConst(0)], 'only non-zero intensify grows', function(c, arg, result) {
      return result === 0;
    });
    return test();
  });

  intensify = function(n) {
    if (n > 0) {
      return n + 2;
    } else if (n < 0) {
      return n - 2;
    } else {
      return n;
    }
  };

  yell = function(message) {
    view(message + '!!');
  };

  yell('Yow');

  dino = 'I am alive';

  reptile = 'I am A-OK';

  meteor = function(reptile) {
    var possum;
    show(reptile);
    dino = 'I am extinct';
    reptile = 'I survived';
    return possum = 'I am new';
  };

  show(dino);

  meteor('What happened?');

  show(dino);

  show(reptile);

  try {
    show(possum);
  } catch (e) {
    show(e.message);
  }

  variable = 'first';

  showVariable = function() {
    return show('In showVariable, the variable holds: ' + variable);
  };

  testIt = function() {
    variable = 'second';
    show('In test, the variable holds ' + variable + '.');
    return showVariable();
  };

  show('The variable is: ' + variable);

  testIt();

  show('The variable is: ' + variable);

  andHere = function() {
    try {
      return show(aLocal);
    } catch (e) {
      return show(e.message);
    }
  };

  isHere = function() {
    var aLocal;
    aLocal = 'aLocal is defined';
    return andHere();
  };

  isHere();

  isHere = function() {
    var aLocal;
    andHere = function() {
      try {
        return show(aLocal);
      } catch (e) {
        return show(e.message);
      }
    };
    aLocal = 'aLocal is defined';
    return andHere();
  };

  isHere();

  varWhich = 'top-level';

  parentFunction = function() {
    var childFunction;
    varWhich = 'local';
    childFunction = function() {
      return show(varWhich);
    };
    return childFunction;
  };

  child = parentFunction();

  child();

  makeAddFunction = function(amount) {
    return add = function(number) {
      return number + amount;
    };
  };

  addTwo = makeAddFunction(2);

  addFive = makeAddFunction(5);

  show(addTwo(1) + addFive(1));

  powerRec = function(base, exponent) {
    if (exponent === 0) {
      return 1;
    } else {
      return base * powerRec(base, exponent - 1);
    }
  };

  show('power 3, 3 = ' + powerRec(3, 3));

  timeIt = function(func) {
    var i, start;
    start = new Date();
    for (i = 0; i < 1000000; i++) {
      func();
    }
    return show("Timing: " + ((new Date() - start) * 0.001) + "s");
  };

  add = function(n, m) {
    return n + m;
  };

  runOnDemand(function() {
    timeIt(function() {
      var p;
      return p = add(9, 18);
    });
    timeIt(function() {
      var p;
      return p = Math.pow(9, 18);
    });
    timeIt(function() {
      var p;
      return p = power(9, 18);
    });
    return timeIt(function() {
      var p;
      return p = powerRec(9, 18);
    });
  });

  chicken = function() {
    show('Lay an egg');
    return egg();
  };

  egg = function() {
    show('Chick hatched');
    return chicken();
  };

  runOnDemand(function() {
    try {
      return show(chicken() + ' came first.');
    } catch (error) {
      return show(error.message);
    }
  });

  findSequence = function(goal) {
    var find;
    find = function(start, history) {
      var _ref;
      if (start === goal) {
        return history;
      } else if (start > goal) {
        return null;
      } else {
        return (_ref = find(start + 5, '(' + history + ' + 5)')) != null ? _ref : find(start * 3, '(' + history + ' * 3)');
      }
    };
    return find(1, '1');
  };

  show(findSequence(24));

  makeAddFunction = function(amount) {
    return function(number) {
      return number + amount;
    };
  };

  show(makeAddFunction(11)(3));

  greaterThan = function(x) {
    return function(y) {
      return y > x;
    };
  };

  greaterThanTen = greaterThan(10);

  show(greaterThanTen(9));

  yell('Hello', 'Good Evening', 'How do you do?');

  yell();

  if (typeof console !== "undefined" && console !== null) {
    console.log('R', 2, 'D', 2);
  }

  text = 'purple haze';

  show(text['length']);

  show(text.length);

  nothing = null;

  try {
    show(nothing.length);
  } catch (error) {
    show(error.message);
  }

  cat = {
    colour: 'grey',
    name: 'Spot',
    size: 46
  };

  cat.size = 47;

  show(cat.size);

  delete cat.size;

  show(cat.size);

  show(cat);

  empty = {};

  empty.notReally = 1000;

  show(empty.notReally);

  thing = {
    'gabba gabba': 'hey',
    '5': 10
  };

  show(thing['5']);

  thing['5'] = 20;

  show(thing[2 + 3]);

  delete thing['gabba gabba'];

  show(thing);

  propertyName = 'length';

  text = 'mainline';

  show(text[propertyName]);

  chineseBox = {};

  chineseBox.content = chineseBox;

  show('content' in chineseBox);

  show('content' in chineseBox.content);

  show(chineseBox);

  abyss = {
    lets: 1,
    go: {
      deep: {
        down: {
          into: {
            the: {
              abyss: 7
            }
          }
        }
      }
    }
  };

  show(abyss);

  show(abyss, true);

  set = {
    'Spot': true
  };

  set['White Fang'] = true;

  delete set['Spot'];

  show('Asoka' in set);

  object1 = {
    value: 10
  };

  object2 = object1;

  object3 = {
    value: 10
  };

  show(object1 === object2);

  show(object1 === object3);

  object1.value = 15;

  show(object2.value);

  show(object3.value);

  mailArchive = {
    'the first e-mail': 'Dear nephew, ...',
    'the second e-mail': '...'
  };

  mailArchive = {
    0: 'Dear nephew, ... (mail number 1)',
    1: '(mail number 2)',
    2: '(mail number 3)'
  };

  for (current in mailArchive) {
    show('Processing e-mail #' + current + ': ' + mailArchive[current]);
  }

  mailArchive = ['mail one', 'mail two', 'mail three'];

  for (current = 0, _ref = mailArchive.length; 0 <= _ref ? current < _ref : current > _ref; 0 <= _ref ? current++ : current--) {
    show('Processing e-mail #' + current + ': ' + mailArchive[current]);
  }

  range = function(upto) {
    var i;
    result = [];
    i = 0;
    while (i <= upto) {
      result[i] = i;
      i++;
    }
    return result;
  };

  show(range(4));

  range = function(upto) {
    var i, _results;
    _results = [];
    for (i = 0; 0 <= upto ? i <= upto : i >= upto; 0 <= upto ? i++ : i--) {
      _results.push(i);
    }
    return _results;
  };

  show(range(4));

  range = function(upto) {
    var _i, _results;
    return (function() {
      _results = [];
      for (var _i = 0; 0 <= upto ? _i <= upto : _i >= upto; 0 <= upto ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this);
  };

  show(range(4));

  numbers = (function() {
    var _results;
    _results = [];
    for (number = 0; number <= 12; number += 2) {
      _results.push(number);
    }
    return _results;
  })();

  show(numbers);

  doh = 'Doh';

  show(typeof doh.toUpperCase);

  show(doh.toUpperCase());

  mack = [];

  mack.push('Mack');

  mack.push('the');

  mack.push('Knife');

  show(mack.join(' '));

  show(mack.pop());

  show(mack);

  retrieveMails = function() {
    return ["Nephew,\n\nI bought a computer as soon as I received your letter. It took me two days to make it do 'internet', but I just kept calling the nice man at the computer shop, and in the end he came down to help personally. Send me something back if you receive this, so I know whether it actually works.\n\nLove,\nAunt Emily", "Dear Nephew,\n\nVery good! I feel quite proud about being so technologically minded, having a computer and all. I bet Mrs. Goor down the street wouldn't even know how to plug it in, that witch.\n\nAnyway, thanks for sending me that game, it was great fun. After three days, I beat it. My friend Mrs. Johnson was quite worried when I didn't come outside or answer the phone for three days, but I explained to her that I was working with my computer.\n\nMy cat had two kittens yesterday! I didn't even realize the thing was pregnant. I've listed the names at the bottom of my letter, so that you will know how to greet them the next time you come over.\n\nSincerely,\nAunt Emily\n\nborn 15/02/1999 (mother Spot): Clementine, Fireball", "[... and so on ...]\n\nborn 21/09/2000 (mother Spot): Yellow Emperor, Black Leclère", "...\n\nborn 02/04/2001 (mother Clementine): Bugeye, Wolverine, Miss Bushtail", "...\n\ndied 12/12/2002: Clementine\n\ndied 15/12/2002: Wolverine", "...\n\nborn 15/11/2003 (mother Spot): White Fang", "...\n\nborn 10/04/2003 (mother Miss Bushtail): Yellow Bess", "...\n\ndied 30/05/2004: Yellow Emperor", "...\n\nborn 01/06/2004 (mother Miss Bushtail): Catharina, Fat Igor", "...\n\nborn 20/09/2004 (mother Yellow Bess): Doctor Hobbles the 2nd, Noog", "...\n\nborn 15/01/2005 (mother Yellow Bess): The Moose, Liger\n\ndied 17/01/2005: Liger", "Dear nephew,\n\nYour mother told me you have taken up skydiving. Is this true? You watch yourself, young man! Remember what happened to my husband? And that was only from the second floor!\n\nAnyway, things are very exciting here. I have spent all week trying to get the attention of Mr. Drake, the nice gentleman who moved in next\ndoor, but I think he is afraid of cats. Or allergic to them? I am\ngoing to try putting Fat Igor on his shoulder next time I see him, very curious what will happen.\n\nAlso, the scam I told you about is going better than expected. I have already gotten back five 'payments', and only one complaint. It is starting to make me feel a bit bad though. And you are right that it is probably illegal in some way.\n\n(... etc ...)\n\nMuch love,\nAunt Emily\n\ndied 27/04/2006: Black Leclère\n\nborn 05/04/2006 (mother Lady Penelope): Red Lion, Doctor Hobbles the 3rd, Little Iroquois", "...\n\nborn 22/07/2006 (mother Noog): Goblin, Reginald, Little Maggie", "...\n\ndied 13/02/2007: Spot\n\ndied 21/02/2007: Fireball", "...\n\nborn 05/02/2007 (mother Noog): Long-ear Johnson", "...\n\nborn 03/03/2007 (mother Catharina): Asoka, Dark Empress, Rabbitface"];
  };

  mailArchive = retrieveMails();

  for (i = 0, _len = mailArchive.length; i < _len; i++) {
    email = mailArchive[i];
    show("Processing e-mail #" + i + " " + email.slice(0, 16) + "...");
  }

  words = 'Cities of the Interior';

  show(words.split(' '));

  array = ['a', 'b', 'c d'];

  show(array.join(' ').split(' '));

  paragraph = 'born 15-11-2003 (mother Spot): White Fang';

  show(paragraph.charAt(0) === 'b' && paragraph.charAt(1) === 'o' && paragraph.charAt(2) === 'r' && paragraph.charAt(3) === 'n');

  show(paragraph.slice(0, 4) === 'born');

  show(paragraph.slice(0, 4) === 'born');

  startsWith = function(string, pattern) {
    return string.slice(0, pattern.length) === pattern;
  };

  startsWith = function(string, pattern) {
    return string.slice(0, pattern.length) === pattern;
  };

  show(startsWith('rotation', 'rot'));

  show('Pip'.charAt(250));

  show('Nop'.slice(1, 10));

  show('Pin'.slice(1, 10));

  catNames = function(paragraph) {
    var colon;
    colon = paragraph.indexOf(':');
    return paragraph.slice(colon + 2).split(', ');
  };

  show(catNames('born 20/09/2004 (mother Yellow Bess): ' + 'Doctor Hobbles the 2nd, Noog'));

  mailArchive = retrieveMails();

  livingCats = {
    'Spot': true
  };

  for (i = 0, _len2 = mailArchive.length; i < _len2; i++) {
    email = mailArchive[i];
    paragraphs = email.split('\n');
    for (_i = 0, _len3 = paragraphs.length; _i < _len3; _i++) {
      paragraph = paragraphs[_i];
      if (startsWith(paragraph, 'born')) {
        names = catNames(paragraph);
        for (_j = 0, _len4 = names.length; _j < _len4; _j++) {
          name = names[_j];
          livingCats[name] = true;
        }
      } else if (startsWith(paragraph, 'died')) {
        names = catNames(paragraph);
        for (_k = 0, _len5 = names.length; _k < _len5; _k++) {
          name = names[_k];
          delete livingCats[name];
        }
      }
    }
  }

  show(livingCats, true);

  if (__indexOf.call(livingCats, 'Spot') >= 0) {
    show('Spot lives!');
  } else {
    show('Good old Spot, may she rest in peace.');
  }

  for (cat in livingCats) {
    show(cat);
  }

  addToSet = function(set, values) {
    var i, _ref2, _results;
    _results = [];
    for (i = 0, _ref2 = values.length; 0 <= _ref2 ? i <= _ref2 : i >= _ref2; 0 <= _ref2 ? i++ : i--) {
      _results.push(set[values[i]] = true);
    }
    return _results;
  };

  removeFromSet = function(set, values) {
    var i, _ref2, _results;
    _results = [];
    for (i = 0, _ref2 = values.length; 0 <= _ref2 ? i <= _ref2 : i >= _ref2; 0 <= _ref2 ? i++ : i--) {
      _results.push(delete set[values[i]]);
    }
    return _results;
  };

  livingCats = {
    'Spot': true
  };

  for (_l = 0, _len6 = mailArchive.length; _l < _len6; _l++) {
    email = mailArchive[_l];
    paragraphs = email.split('\n');
    for (_m = 0, _len7 = paragraphs.length; _m < _len7; _m++) {
      paragraph = paragraphs[_m];
      if (startsWith(paragraph, 'born')) {
        addToSet(livingCats, catNames(paragraph));
      } else if (startsWith(paragraph, 'died')) {
        removeFromSet(livingCats, catNames(paragraph));
      }
    }
  }

  show(livingCats, true);

  findLivingCats = function() {
    var email, handleParagraph, paragraph, _len8, _len9, _n, _o;
    mailArchive = retrieveMails();
    livingCats = {
      'Spot': true
    };
    handleParagraph = function(paragraph) {
      if (startsWith(paragraph, 'born')) {
        return addToSet(livingCats, catNames(paragraph));
      } else if (startsWith(paragraph, 'died')) {
        return removeFromSet(livingCats, catNames(paragraph));
      }
    };
    for (_n = 0, _len8 = mailArchive.length; _n < _len8; _n++) {
      email = mailArchive[_n];
      paragraphs = email.split('\n');
      for (_o = 0, _len9 = paragraphs.length; _o < _len9; _o++) {
        paragraph = paragraphs[_o];
        handleParagraph(paragraph);
      }
    }
    return livingCats;
  };

  howMany = 0;

  for (cat in findLivingCats()) {
    howMany++;
  }

  show('There are ' + howMany + ' cats.');

  whenWasIt = {
    year: 1980,
    month: 2,
    day: 1
  };

  whenWasIt = new Date(1980, 1, 1);

  show(whenWasIt);

  show(new Date);

  show(new Date(1980, 1, 1));

  show(new Date(2007, 2, 30, 8, 20, 30));

  today = new Date();

  show("Year: " + (today.getFullYear()) + " month: " + (today.getMonth()) + " day: " + (today.getDate()));

  show("Hour: " + (today.getHours()) + " minutes: " + (today.getMinutes()) + " seconds: " + (today.getSeconds()));

  show("Day of week: " + (today.getDay()));

  today = new Date();

  show(today.getTime());

  wallFall = new Date(1989, 10, 9);

  gulfWarOne = new Date(1990, 6, 2);

  show(wallFall < gulfWarOne);

  show(wallFall === wallFall);

  show(wallFall === new Date(1989, 10, 9));

  wallFall1 = new Date(1989, 10, 9);

  wallFall2 = new Date(1989, 10, 9);

  show(wallFall1.getTime() === wallFall2.getTime());

  now = new Date();

  show(now.getTimezoneOffset());

  extractDate = function(paragraph) {
    var numberAt;
    numberAt = function(start, length) {
      return Number(paragraph.slice(start, (start + length)));
    };
    return new Date(numberAt(11, 4), numberAt(8, 2) - 1, numberAt(5, 2));
  };

  show(extractDate('died 27-04-2006: Black Leclère'));

  catRecord = function(name, birthdate, mother) {
    return {
      name: name,
      birth: birthdate,
      mother: mother
    };
  };

  addCats = function(set, names, birthdate, mother) {
    var name, _len8, _n, _results;
    _results = [];
    for (_n = 0, _len8 = names.length; _n < _len8; _n++) {
      name = names[_n];
      _results.push(set[name] = catRecord(name, birthdate, mother));
    }
    return _results;
  };

  deadCats = function(set, names, deathdate) {
    var name, _len8, _n, _results;
    _results = [];
    for (_n = 0, _len8 = names.length; _n < _len8; _n++) {
      name = names[_n];
      _results.push(set[name].death = deathdate);
    }
    return _results;
  };

  'born 15/11/2003 (mother Spot): White Fang';

  extractMother = function(paragraph) {
    var end, start;
    start = paragraph.indexOf('(mother ');
    start += '(mother '.length;
    end = paragraph.indexOf(')');
    return paragraph.slice(start, end);
  };

  show(extractMother('born 15/11/2003 (mother Spot): White Fang'));

  between = function(string, start, end) {
    var endAt, startAt;
    startAt = string.indexOf(start);
    startAt += start.length;
    endAt = string.indexOf(end, startAt);
    return string.slice(startAt, endAt);
  };

  show(between('bu ] boo [ bah ] gzz', '[ ', ' ]'));

  extractMother = function(paragraph) {
    return between(paragraph, '(mother ', ')');
  };

  findCats = function() {
    var cats, email, handleParagraph, paragraph, _len8, _len9, _n, _o;
    mailArchive = retrieveMails();
    cats = {
      'Spot': catRecord('Spot', new Date(1997, 2, 5), 'unknown')
    };
    handleParagraph = function(paragraph) {
      if (startsWith(paragraph, 'born')) {
        return addCats(cats, catNames(paragraph), extractDate(paragraph), extractMother(paragraph));
      } else if (startsWith(paragraph, 'died')) {
        return deadCats(cats, catNames(paragraph), extractDate(paragraph));
      }
    };
    for (_n = 0, _len8 = mailArchive.length; _n < _len8; _n++) {
      email = mailArchive[_n];
      paragraphs = email.split('\n');
      for (_o = 0, _len9 = paragraphs.length; _o < _len9; _o++) {
        paragraph = paragraphs[_o];
        handleParagraph(paragraph);
      }
    }
    return cats;
  };

  catData = findCats();

  show(catData['Clementine'], true);

  show(catData[catData['Clementine'].mother], true);

  formatDate = function(date) {
    return ("" + (date.getDate()) + "/") + ("" + (date.getMonth() + 1) + "/") + ("" + (date.getFullYear()));
  };

  catInfo = function(data, name) {
    var message;
    if (!(name in data)) return "No cat by the name of " + name + " is known.";
    cat = data[name];
    message = ("" + name + ",") + (" born " + (formatDate(cat.birth))) + (" from mother " + cat.mother);
    if ("death" in cat) message += ", died " + (formatDate(cat.death));
    return "" + message + ".";
  };

  show(catInfo(catData, "Fat Igor"));

  formatDate = function(date) {
    var pad;
    pad = function(number) {
      if (number < 10) {
        return "0" + number;
      } else {
        return number;
      }
    };
    return ("" + (pad(date.getDate())) + "/") + ("" + (pad(date.getMonth() + 1)) + "/") + ("" + (date.getFullYear()));
  };

  show(formatDate(new Date(2000, 0, 1)));

  oldestCat = function(data) {
    var name, oldest;
    oldest = null;
    for (name in data) {
      cat = data[name];
      if (!('death' in cat)) {
        if (oldest === null || oldest.birth > cat.birth) oldest = cat;
      }
    }
    return oldest != null ? oldest.name : void 0;
  };

  show(oldestCat(catData));

  for (cat in catData) {
    info = catData[cat];
    if (!('death' in info)) delete catData[cat];
  }

  show(oldestCat(catData));

  argumentCounter = function() {
    return show("You gave me " + arguments.length + " arguments.");
  };

  argumentCounter("Death", "Famine", "Pestilence");

  print = function() {
    var arg, _len8, _n;
    for (_n = 0, _len8 = arguments.length; _n < _len8; _n++) {
      arg = arguments[_n];
      show(arg);
    }
  };

  print('From here to', 1 / 0);

  add = function(number, howmuch) {
    if (arguments.length < 2) howmuch = 1;
    return number + howmuch;
  };

  show(add(6));

  show(add(6, 4));

  range = function(start, end) {
    var i;
    if (arguments.length < 2) {
      end = start;
      start = 0;
    }
    result = [];
    for (i = start; start <= end ? i <= end : i >= end; start <= end ? i++ : i--) {
      result.push(i);
    }
    return result;
  };

  show(range(4));

  show(range(2, 4));

  sum = function(numbers) {
    var num, _len8, _n;
    total = 0;
    for (_n = 0, _len8 = numbers.length; _n < _len8; _n++) {
      num = numbers[_n];
      total += num;
    }
    return total;
  };

  show(sum([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]));

  show(sum(range(1, 10)));

  for (name in Math) {
    show(name);
  }

  for (name in ['Huey', 'Dewey', 'Loui']) {
    show(name);
  }

  array = ['Heaven', 'Earth', 'Man'];

  array.length = 2;

  show(array);

  power = function(base, exponent) {
    var count;
    result = 1;
    for (count = 0; 0 <= exponent ? count < exponent : count > exponent; 0 <= exponent ? count++ : count--) {
      result *= base;
    }
    return result;
  };

  between = function(string, start, end) {
    var endAt, startAt;
    startAt = string.indexOf(start);
    startAt += start.length;
    endAt = string.indexOf(end, startAt);
    return string.slice(startAt, endAt);
  };

  show(between('Your mother!', '{-', '-}'));

  between = function(string, start, end) {
    var endAt, startAt;
    startAt = string.indexOf(start);
    if (startAt === -1) return;
    startAt += start.length;
    endAt = string.indexOf(end, startAt);
    if (endAt === -1) return;
    return string.slice(startAt, endAt);
  };

  show(between('bu ] boo [ bah ] gzz', '[ ', ' ]'));

  show(between('bu [ boo bah gzz', '[ ', ' ]'));

  prompt("Tell me something", "", function(answer) {
    var parenthesized;
    parenthesized = between(answer, "(", ")");
    if (parenthesized != null) {
      return show("You parenthesized '" + parenthesized + "'.");
    }
  });

  lastElement = function(array) {
    if (array.length > 0) {
      return array[array.length - 1];
    } else {
      return;
    }
  };

  show(lastElement([1, 2, void 0]));

  lastElement = function(array) {
    if (array.length > 0) {
      return array[array.length - 1];
    } else {
      throw 'Can not take the last element' + ' of an empty array.';
    }
  };

  lastElementPlusTen = function(array) {
    return lastElement(array) + 10;
  };

  try {
    show(lastElementPlusTen([]));
  } catch (error) {
    show('Something went wrong: ' + error);
  }

  currentThing = null;

  processThing = function(thing) {
    if (currentThing !== null) throw 'Oh no! We are already processing a thing!';
    currentThing = thing;
    return currentThing = null;
  };

  processThing = function(thing) {
    if (currentThing !== null) throw 'Oh no! We are already processing a thing!';
    currentThing = thing;
    try {

    } finally {
      currentThing = null;
    }
  };

  try {
    show(Sasquatch);
  } catch (error) {
    show('Caught: ' + error.message);
  }

  try {
    throw new Error('Fire!');
  } catch (error) {
    show(error.toString());
  }

  FoundSeven = {};

  hasSevenTruths = function(object) {
    var counted;
    counted = 0;
    count = function(object) {
      var name, _results;
      _results = [];
      for (name in object) {
        if (object[name] === true) if ((++counted) === 7) throw FoundSeven;
        if (typeof object[name] === 'object') {
          _results.push(count(object[name]));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };
    try {
      count(object);
      return false;
    } catch (exception) {
      if (exception !== FoundSeven) throw exception;
      return true;
    }
  };

  testdata = {
    a: true,
    b: true,
    c: false,
    d: {
      a: true,
      b: false,
      c: true,
      d: {
        a: true,
        b: {
          a: true
        }
      },
      e: {
        a: false,
        b: true,
        c: true
      }
    }
  };

  show(hasSevenTruths(testdata));

  thing = [5, 6, 7];

  doSomething = show;

  for (i = 0, _ref2 = thing.length; 0 <= _ref2 ? i < _ref2 : i > _ref2; 0 <= _ref2 ? i++ : i--) {
    doSomething(thing[i]);
  }

  for (_n = 0, _len8 = thing.length; _n < _len8; _n++) {
    element = thing[_n];
    doSomething(element);
  }

  printArray = function(array) {
    var element, _len9, _o;
    for (_o = 0, _len9 = array.length; _o < _len9; _o++) {
      element = array[_o];
      show(element);
    }
  };

  printArray([7, 8, 9]);

  forEach = function(array, action) {
    var element, _len9, _o, _results;
    _results = [];
    for (_o = 0, _len9 = array.length; _o < _len9; _o++) {
      element = array[_o];
      _results.push(action(element));
    }
    return _results;
  };

  forEach(['Wampeter', 'Foma', 'Granfalloon'], show);

  runOnDemand(function() {
    return show(forEach);
  });

  sum = function(numbers) {
    total = 0;
    forEach(numbers, function(number) {
      return total += number;
    });
    return total;
  };

  show(sum([1, 10, 100]));

  negate = function(func) {
    return function(x) {
      return !func(x);
    };
  };

  isNotNaN = negate(isNaN);

  show(isNotNaN(NaN));

  show(Math.min.apply(null, [5, 6]));

  negate = function(func) {
    return function() {
      return !func.apply(null, arguments);
    };
  };

  morethan = function(x, y) {
    return x > y;
  };

  lessthan = negate(morethan);

  show(lessthan(5, 7));

  show(Math.min.apply(Math, [5, 6]));

  negate = function(func) {
    return function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return !func.apply(null, args);
    };
  };

  morethan = function(x, y) {
    return x > y;
  };

  lessthan = negate(morethan);

  show(lessthan(5, 7));

  reduce = function(array, combine, base) {
    forEach(array, function(element) {
      return base = combine(base, element);
    });
    return base;
  };

  add = function(a, b) {
    return a + b;
  };

  sum = function(numbers) {
    return reduce(numbers, add, 0);
  };

  show(sum([1, 10, 100]));

  countZeroes = function(array) {
    counter = function(total, element) {
      if (element === 0) total++;
      return total;
    };
    return reduce(array, counter, 0);
  };

  bits = [1, 0, 1, 0, 0, 1, 1, 1, 0];

  show(countZeroes(bits));

  count = function(test, array) {
    return reduce(array, (function(total, element) {
      return total + (test(element) ? 1 : 0);
    }), 0);
  };

  equals = function(x) {
    return function(element) {
      return x === element;
    };
  };

  countZeroes = function(array) {
    return count(equals(0), array);
  };

  show(countZeroes(bits));

  map = function(array, func) {
    result = [];
    forEach(array, function(element) {
      return result.push(func(element));
    });
    return result;
  };

  show(map([0.01, 2, 9.89, Math.PI], Math.round));

  map = function(array, func) {
    return forEach(array, function(element) {
      return func(element);
    });
  };

  map = function(array, func) {
    return forEach(array, func);
  };

  map = forEach;

  show(map([0.01, 2, 9.89, Math.PI], Math.round));

  imageSource = 'http://autotelicum.github.com/Smooth-CoffeeScript';

  linkOstrich = "" + imageSource + "/img/ostrich.jpg";

  showDocument("<!DOCTYPE HTML>\n<html>\n  <head>\n    <meta charset=\"utf-8\"/>\n    <title>A quote</title>\n  </head>\n  <body>\n    <h1>A quote</h1>\n    <blockquote>\n      <p>The connection between the language in which we\n      think/program and the problems and solutions we can\n      imagine is very close. For this reason restricting\n      language features with the intent of eliminating\n      programmer errors is at best dangerous.</p>\n      <p>-- Bjarne Stroustrup</p>\n    </blockquote>\n    <p>Mr. Stroustrup is the inventor of the C++\n    programming language, but quite an insightful\n    person nevertheless.</p>\n    <p>Also, here is a picture of an ostrich:</p>\n    <img src=\"" + ostrich + "\"/>\n  </body>\n</html>", 565, 420);

  recluseFile = "% The Book of Programming\n\n%% The Two Aspects\n\nBelow the surface of the machine, the program moves.\nWithout effort, it expands and contracts. In great harmony, \nelectrons scatter and regroup. The forms on the monitor\nare but ripples on the water. The essence stays invisibly\nbelow.\n\nWhen the creators built the machine, they put in the\nprocessor and the memory. From these arise the two aspects\nof the program.\n\nThe aspect of the processor is the active substance. It is\ncalled Control. The aspect of the memory is the passive \nsubstance. It is called Data.\n\nData is made of merely bits, yet it takes complex forms.\nControl consists only of simple instructions, yet it\nperforms difficult tasks. From the small and trivial, the\nlarge and complex arise.\n\nThe program source is Data. Control arises from it. The\nControl proceeds to create new Data. The one is born from\nthe other, the other is useless without the one. This is\nthe harmonious cycle of Data and Control.\n\nOf themselves, Data and Control are without structure. The\nprogrammers of old moulded their programs out of this raw\nsubstance. Over time, the amorphous Data has crystallised\ninto data types, and the chaotic Control was restricted\ninto control structures and functions.\n\n%% Short Sayings\n\nWhen a student asked Fu-Tzu about the nature of the cycle\nof Data and Control, Fu-Tzu replied 'Think of a compiler,\ncompiling itself.'\n\nA student asked 'The programmers of old used only simple\nmachines and no programming languages, yet they made\nbeautiful programs. Why do we use complicated machines\nand programming languages?'. Fu-Tzu replied 'The builders\nof old used only sticks and clay, yet they made beautiful\nhuts.'\n\nA hermit spent ten years writing a program. 'My program can\ncompute the motion of the stars on a 286-computer running\nMS DOS', he proudly announced. 'Nobody owns a 286-computer\nor uses MS DOS anymore.', Fu-Tzu responded.\n\nFu-Tzu had written a small program that was full of global\nstate and dubious shortcuts. Reading it, a student asked\n'You warned us against these techniques, yet I find them in\nyour program. How can this be?' Fu-Tzu said 'There is no\nneed to fetch a water hose when the house is not on fire.'\n{This is not to be read as an encouragement of sloppy\nprogramming, but rather as a warning against neurotic\nadherence to rules of thumb.}\n\n%% Wisdom\n\nA student was complaining about digital numbers. 'When I\ntake the root of two and then square it again, the result\nis already inaccurate!'. Overhearing him, Fu-Tzu laughed.\n'Here is a sheet of paper. Write down the precise value of\nthe square root of two for me.'\n\nFu-Tzu said 'When you cut against the grain of the wood,\nmuch strength is needed. When you program against the grain\nof a problem, much code is needed.'\n\nTzu-li and Tzu-ssu were boasting about the size of their\nlatest programs. 'Two-hundred thousand lines', said Tzu-li,\n'not counting comments!'. 'Psah', said Tzu-ssu, 'mine is\nalmost a *million* lines already.' Fu-Tzu said 'My best\nprogram has five hundred lines.' Hearing this, Tzu-li and\nTzu-ssu were enlightened.\n\nA student had been sitting motionless behind his computer\nfor hours, frowning darkly. He was trying to write a\nbeautiful solution to a difficult problem, but could not\nfind the right approach. Fu-Tzu hit him on the back of his\nhead and shouted '*Type something!*' The student started\nwriting an ugly solution. After he had finished, he\nsuddenly understood the beautiful solution.\n\n%% Progression\n\nA beginning programmer writes his programs like an ant\nbuilds her hill, one piece at a time, without thought for\nthe bigger structure. His programs will be like loose sand.\nThey may stand for a while, but growing too big they fall\napart{Referring to the danger of internal inconsistency\nand duplicated structure in unorganised code.}.\n\nRealising this problem, the programmer will start to spend\na lot of time thinking about structure. His programs will\nbe rigidly structured, like rock sculptures. They are solid,\nbut when they must change, violence must be done to them\n{Referring to the fact that structure tends to put\nrestrictions on the evolution of a program.}.\n\nThe master programmer knows when to apply structure and\nwhen to leave things in their simple form. His programs\nare like clay, solid yet malleable.\n\n%% Language\n\nWhen a programming language is created, it is given\nsyntax and semantics. The syntax describes the form of\nthe program, the semantics describe the function. When the\nsyntax is beautiful and the semantics are clear, the\nprogram will be like a stately tree. When the syntax is\nclumsy and the semantics confusing, the program will be\nlike a bramble bush.\n\nTzu-ssu was asked to write a program in the language\ncalled  Java, which takes a very primitive approach to\nfunctions. Every morning, as he sat down in front of his\ncomputer, he started complaining. All day he cursed,\nblaming the language for all that went wrong. Fu-Tzu\nlistened for a while, and then reproached him, saying\n'Every language has its own way. Follow its form, do not\ntry to program as if you were using another language.'";

  show;

  paragraphs = recluseFile.split("\n\n");

  show("Found " + paragraphs.length + " paragraphs.");

  processParagraph = function(paragraph) {
    var header;
    header = 0;
    while (paragraph[0] === '%') {
      paragraph = paragraph.slice(1);
      header++;
    }
    return {
      type: header === 0 ? 'p' : 'h' + header,
      content: paragraph
    };
  };

  show(processParagraph(paragraphs[0]));

  paragraphs = map(recluseFile.split('\n\n'), processParagraph);

  _ref3 = paragraphs.slice(0, 3);
  for (_o = 0, _len9 = _ref3.length; _o < _len9; _o++) {
    paragraph = _ref3[_o];
    show(paragraph);
  }

  splitParagraph = function(text) {
    var fragments, indexOrEnd, takeNormal, takeUpTo;
    indexOrEnd = function(character) {
      var index;
      index = text.indexOf(character);
      if (index === -1) {
        return text.length;
      } else {
        return index;
      }
    };
    takeNormal = function() {
      var end, part;
      end = reduce(map(['*', '{'], indexOrEnd), Math.min, text.length);
      part = text.slice(0, end);
      text = text.slice(end);
      return part;
    };
    takeUpTo = function(character) {
      var end, part;
      end = text.indexOf(character, 1);
      if (end === -1) throw new Error('Missing closing ' + '"' + character + '"');
      part = text.slice(1, end);
      text = text.slice(end + 1);
      return part;
    };
    fragments = [];
    while (text !== '') {
      if (text[0] === '*') {
        fragments.push({
          type: 'emphasised',
          content: takeUpTo('*')
        });
      } else if (text[0] === '{') {
        fragments.push({
          type: 'footnote',
          content: takeUpTo('}')
        });
      } else {
        fragments.push({
          type: 'normal',
          content: takeNormal()
        });
      }
    }
    return fragments;
  };

  takeNormalAlternative = function() {
    var end, nextAsterisk, nextBrace, part;
    nextAsterisk = text.indexOf('*');
    nextBrace = text.indexOf('{');
    end = text.length;
    if (nextAsterisk !== -1) end = nextAsterisk;
    if (nextBrace !== -1 && nextBrace < end) end = nextBrace;
    part = text.slice(0, end);
    text = text.slice(end);
    return part;
  };

  processParagraph = function(paragraph) {
    var header;
    header = 0;
    while (paragraph[0] === '%') {
      paragraph = paragraph.slice(1);
      header++;
    }
    return {
      type: header === 0 ? 'p' : 'h' + header,
      content: splitParagraph(paragraph)
    };
  };

  paragraphs = map(recluseFile.split('\n\n'), processParagraph);

  _ref4 = paragraphs.slice(0, 3);
  for (_p = 0, _len10 = _ref4.length; _p < _len10; _p++) {
    paragraph = _ref4[_p];
    show(paragraph);
  }

  extractFootnotes = function(paragraphs) {
    var currentNote, footnotes, replaceFootnote;
    footnotes = [];
    currentNote = 0;
    replaceFootnote = function(fragment) {
      if (fragment.type === 'footnote') {
        ++currentNote;
        footnotes.push(fragment);
        fragment.number = currentNote;
        return {
          type: 'reference',
          number: currentNote
        };
      } else {
        return fragment;
      }
    };
    forEach(paragraphs, function(paragraph) {
      return paragraph.content = map(paragraph.content, replaceFootnote);
    });
    return footnotes;
  };

  show('Footnotes from the recluse:');

  show(extractFootnotes(paragraphs));

  show(paragraphs[20]);

  url = "http://www.gokgs.com/";

  text = "Play Go!";

  linkText = "<a href=\"" + url + "\">" + text + "</a>";

  show(_.escape(linkText));

  show(linkText);

  linkObject = {
    name: 'a',
    attributes: {
      href: 'http://www.gokgs.com/'
    },
    content: ['Play Go!']
  };

  tag = function(name, content, attributes) {
    return {
      name: name,
      attributes: attributes,
      content: content
    };
  };

  link = function(target, text) {
    return tag("a", [text], {
      href: target
    });
  };

  show(link("http://www.gokgs.com/", "Play Go!"));

  htmlDoc = function(title, bodyContent) {
    return tag("html", [tag("head", [tag("title", [title])]), tag("body", bodyContent)]);
  };

  show(htmlDoc("Quote", "In his house at R'lyeh " + "dead Cthulu waits dreaming."));

  image = function(src) {
    return tag('img', [], {
      src: src
    });
  };

  show(image(linkOstrich));

  escapeHTML = function(text) {
    var replacements;
    replacements = [[/&/g, '&amp;'], [/"/g, '&quot;'], [/</g, '&lt;'], [/>/g, '&gt;']];
    forEach(replacements, function(replace) {
      return text = text != null ? text.replace(replace[0], replace[1]) : void 0;
    });
    return text;
  };

  show(escapeHTML('< " & " >'));

  renderHTML = function(element) {
    var pieces, render, renderAttributes;
    pieces = [];
    renderAttributes = function(attributes) {
      var name;
      result = [];
      if (attributes) {
        for (name in attributes) {
          result.push(' ' + name + '="' + escapeHTML(attributes[name]) + '"');
        }
      }
      return result.join('');
    };
    render = function(element) {
      if (typeof element === 'string') {
        return pieces.push(escapeHTML(element));
      } else if (!element.content || element.content.length === 0) {
        return pieces.push('<' + element.name + renderAttributes(element.attributes) + '/>');
      } else {
        pieces.push('<' + element.name + renderAttributes(element.attributes) + '>');
        forEach(element.content, render);
        return pieces.push('</' + element.name + '>');
      }
    };
    render(element);
    return pieces.join('');
  };

  show(renderHTML(link('http://www.nedroid.com', 'Drawings!')));

  body = [tag('h1', ['The Test']), tag('p', ['Here is a paragraph ' + 'and an image...']), image(ostrich)];

  doc = htmlDoc('The Test', body);

  show(renderHTML(doc));

  footnote = function(number) {
    return tag('sup', [link('#footnote' + number, String(number))]);
  };

  show(footnote(42), 3);

  renderFragment = function(fragment) {
    if (fragment.type === 'reference') {
      return footnote(fragment.number);
    } else if (fragment.type === 'emphasised') {
      return tag('em', [fragment.content]);
    } else if (fragment.type === 'normal') {
      return fragment.content;
    }
  };

  renderParagraph = function(paragraph) {
    return tag(paragraph.type, map(paragraph.content, renderFragment));
  };

  show(renderParagraph(paragraphs[7]));

  renderFootnote = function(footnote) {
    var anchor;
    anchor = tag("a", [], {
      name: "footnote" + footnote.number
    });
    number = "[" + footnote.number + "] ";
    return tag("p", [tag("small", [anchor, number, footnote.content])]);
  };

  renderFile = function(file, title) {
    var footnotes;
    paragraphs = map(file.split('\n\n'), processParagraph);
    footnotes = map(extractFootnotes(paragraphs), renderFootnote);
    body = map(paragraphs, renderParagraph);
    body = body.concat(footnotes);
    return renderHTML(htmlDoc(title, body));
  };

  runOnDemand(function() {
    var page;
    page = renderFile(recluseFile, 'The Book of Programming');
    return showDocument(page, 565, 500);
  });

  op = {
    '+': function(a, b) {
      return a + b;
    },
    '==': function(a, b) {
      return a === b;
    },
    '!': function(a) {
      return !a;
    }
  };

  show(reduce([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], op['+'], 0));

  add = function(a, b) {
    return a + b;
  };

  show(reduce([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], add, 0));

  partial = function() {
    var a, func;
    func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
    return function() {
      var b;
      b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return func.apply(null, __slice.call(a).concat(__slice.call(b)));
    };
  };

  f = function(a, b, c, d) {
    return show("" + a + " " + b + " " + c + " " + d);
  };

  g = partial(f, 1, 2);

  g(3, 4);

  equals10 = partial(op['=='], 10);

  show(map([1, 10, 100], equals10));

  square = function(x) {
    return x * x;
  };

  try {
    show(map([[10, 100], [12, 16], [0, 1]], partial(map, square)));
  } catch (error) {
    show("Error: " + error.message);
  }

  partialReverse = function(func, a) {
    return function(b) {
      return func(b, a);
    };
  };

  mapSquared = partialReverse(map, square);

  show(map([[10, 100], [12, 16], [0, 1]], mapSquared));

  show(map([[10, 100], [12, 16], [0, 1]], function(sublist) {
    return map(sublist, function(x) {
      return x * x;
    });
  }));

  negate = function(func) {
    return function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return !func.apply(null, args);
    };
  };

  compose = function(func1, func2) {
    return function() {
      var args;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      return func1(func2.apply(null, args));
    };
  };

  isUndefined = function(value) {
    return value === void 0;
  };

  isDefined = compose((function(v) {
    return !v;
  }), isUndefined);

  show('isDefined Math.PI  = ' + isDefined(Math.PI));

  show('isDefined Math.PIE = ' + isDefined(Math.PIE));

  runOnDemand(function() {
    return show(_.functions(_));
  });

  show(roads = [
    {
      point1: 'Point Kiukiu',
      point2: 'Hanaiapa',
      length: 19
    }, {
      point1: 'Point Kiukiu',
      point2: 'Mt Feani',
      length: 15
    }
  ]);

  show(roads = {
    'Point Kiukiu': [
      {
        to: 'Hanaiapa',
        distance: 19
      }, {
        to: 'Mt Feani',
        distance: 15
      }, {
        to: 'Taaoa',
        distance: 15
      }
    ],
    'Taaoa': []
  });

  this.roads = {};

  makeRoad = function(from, to, length) {
    var addRoad;
    addRoad = function(from, to) {
      if (!(from in roads)) roads[from] = [];
      return roads[from].push({
        to: to,
        distance: length
      });
    };
    addRoad(from, to);
    return addRoad(to, from);
  };

  makeRoad('Point Kiukiu', 'Hanaiapa', 19);

  makeRoad('Point Kiukiu', 'Mt Feani', 15);

  makeRoad('Point Kiukiu', 'Taaoa', 15);

  show(roads);

  makeRoads = function(start) {
    var i, _ref5, _results;
    _results = [];
    for (i = 1, _ref5 = arguments.length; i < _ref5; i += 2) {
      _results.push(makeRoad(start, arguments[i], arguments[i + 1]));
    }
    return _results;
  };

  this.roads = {};

  makeRoads('Point Kiukiu', 'Hanaiapa', 19, 'Mt Feani', 15, 'Taaoa', 15);

  makeRoads('Airport', 'Hanaiapa', 6, 'Mt Feani', 5, 'Atuona', 4, 'Mt Ootua', 11);

  makeRoads('Mt Temetiu', 'Mt Feani', 8, 'Taaoa', 4);

  makeRoads('Atuona', 'Taaoa', 3, 'Hanakee pearl lodge', 1);

  makeRoads('Cemetery', 'Hanakee pearl lodge', 6, 'Mt Ootua', 5);

  makeRoads('Hanapaoa', 'Mt Ootua', 3);

  makeRoads('Puamua', 'Mt Ootua', 13, 'Point Teohotepapapa', 14);

  show('Roads from the Airport:');

  show(roads['Airport']);

  roadsFrom = function(place) {
    var found;
    found = roads[place];
    if (found != null) return found;
    throw new Error("No place named '" + place + "' found.");
  };

  try {
    show(roadsFrom("Hanaiapa"));
    show(roadsFrom("Hanalapa"));
  } catch (error) {
    show("Oops " + error);
  }

  gamblerPath = function(from, to) {
    var path, randomDirection, randomInteger;
    randomInteger = function(below) {
      return Math.floor(Math.random() * below);
    };
    randomDirection = function(from) {
      var options;
      options = roadsFrom(from);
      return options[randomInteger(options.length)].to;
    };
    path = [];
    while (true) {
      path.push(from);
      if (from === to) break;
      from = randomDirection(from);
    }
    return path;
  };

  show(gamblerPath('Hanaiapa', 'Mt Feani'));

  _member = function(array, value) {
    var found;
    found = false;
    array.forEach(function(element) {
      if (element === value) return found = true;
    });
    return found;
  };

  show(_member([6, 7, "Bordeaux"], 7));

  _break = {
    toString: function() {
      return "Break";
    }
  };

  _forEach = function(array, action) {
    var element, _len11, _q, _results;
    try {
      _results = [];
      for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
        element = array[_q];
        _results.push(action(element));
      }
      return _results;
    } catch (exception) {
      if (exception !== _break) throw exception;
    }
  };

  show(_forEach([1, 2, 3], function(n) {
    return n * n;
  }));

  show((function() {
    var _results;
    _results = [];
    for (i = 1; i <= 3; i++) {
      _results.push(i * i);
    }
    return _results;
  })());

  _member = function(array, value) {
    var found;
    found = false;
    _forEach(array, function(element) {
      if (element === value) {
        found = true;
        throw _break;
      }
    });
    return found;
  };

  show(_member([6, 7, "Bordeaux"], 7));

  _member = function(array, value) {
    var element, found, _len11, _q;
    found = false;
    for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
      element = array[_q];
      if (element === value) {
        found = true;
        break;
      }
    }
    return found;
  };

  show(_member([6, 7, "Bordeaux"], 7));

  show(7 === 6 || 7 === 7 || 7 === "Bordeaux");

  _any = function(array, test) {
    var element, _len11, _q;
    for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
      element = array[_q];
      if (test(element)) return true;
    }
    return false;
  };

  show(_any([3, 4, 0, -3, 2, 1], function(n) {
    return n < 0;
  }));

  show(_any([3, 4, 0, 2, 1], function(n) {
    return n < 0;
  }));

  show(_.any([3, 4, 0, -3, 2, 1], function(n) {
    return n < 0;
  }));

  _member = function(array, value) {
    partial = function() {
      var a, func;
      func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return function() {
        var b;
        b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return func.apply(null, __slice.call(a).concat(__slice.call(b)));
      };
    };
    return _.any(array, partial((function(a, b) {
      return a === b;
    }), value));
  };

  show(_member(["Fear", "Loathing"], "Denial"));

  show(_member(["Fear", "Loathing"], "Loathing"));

  _every = function(array, test) {
    var element, _len11, _q;
    for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
      element = array[_q];
      if (!test(element)) return false;
    }
    return true;
  };

  show(_every([1, 2, 0, -1], function(n) {
    return n !== 0;
  }));

  show(_every([1, 2, -1], function(n) {
    return n !== 0;
  }));

  show(_.every([1, 2, -1], function(n) {
    return n !== 0;
  }));

  _flatten = function(array) {
    var element, _len11, _q;
    result = [];
    for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
      element = array[_q];
      if (_.isArray(element)) {
        result = result.concat(_flatten(element));
      } else {
        result.push(element);
      }
    }
    return result;
  };

  show(_flatten([[1], [2, [3, 4]], [5, 6]]));

  show(_.flatten([[1], [2, [3, 4]], [5, 6]]));

  _filter = function(array, test) {
    var element, _len11, _q;
    result = [];
    for (_q = 0, _len11 = array.length; _q < _len11; _q++) {
      element = array[_q];
      if (test(element)) result.push(element);
    }
    return result;
  };

  show(_filter([0, 4, 8, 12], function(n) {
    return n < 5;
  }));

  isOdd = function(n) {
    return n % 2 !== 0;
  };

  show(_.filter([0, 1, 2, 3, 4, 5, 6], isOdd));

  possibleRoutes = function(from, to) {
    var findRoutes;
    findRoutes = function(route) {
      var continueRoute, end, notVisited;
      notVisited = function(road) {
        var _ref5;
        return !(_ref5 = road.to, __indexOf.call(route.places, _ref5) >= 0);
      };
      continueRoute = function(road) {
        return findRoutes({
          places: route.places.concat([road.to]),
          length: route.length + road.distance
        });
      };
      end = route.places[route.places.length - 1];
      if (end === to) {
        return [route];
      } else {
        return _.flatten(_.map(_.filter(roadsFrom(end), notVisited), continueRoute));
      }
    };
    return findRoutes({
      places: [from],
      length: 0
    });
  };

  show((possibleRoutes('Point Teohotepapapa', 'Point Kiukiu')).length);

  show(possibleRoutes('Hanapaoa', 'Mt Ootua'));

  shortestRoute = function(from, to) {
    var currentShortest;
    currentShortest = null;
    _.each(possibleRoutes(from, to), function(route) {
      if (!currentShortest || currentShortest.length > route.length) {
        return currentShortest = route;
      }
    });
    return currentShortest;
  };

  minimise = function(func, array) {
    var found, minScore;
    minScore = null;
    found = null;
    _.each(array, function(element) {
      var score;
      score = func(element);
      if (minScore === null || score < minScore) {
        minScore = score;
        return found = element;
      }
    });
    return found;
  };

  getProperty = function(propName) {
    return function(object) {
      return object[propName];
    };
  };

  shortestRouteAbstract = function(from, to) {
    return minimise(getProperty('length'), possibleRoutes(from, to));
  };

  show((shortestRoute('Point Kiukiu', 'Point Teohotepapapa')).places);

  show((shortestRouteAbstract('Point Kiukiu', 'Point Teohotepapapa')).places);

  heightAt = function(point) {
    var heights;
    heights = [[111, 111, 122, 137, 226, 192, 246, 275, 285, 333, 328, 264, 202, 175, 151, 222, 250, 222, 219, 146], [205, 186, 160, 218, 217, 233, 268, 300, 316, 357, 276, 240, 240, 253, 215, 201, 256, 312, 224, 200], [228, 176, 232, 258, 246, 289, 306, 351, 374, 388, 319, 333, 299, 307, 261, 286, 291, 355, 277, 258], [228, 207, 263, 264, 284, 348, 368, 358, 391, 387, 320, 344, 366, 382, 372, 394, 360, 314, 259, 207], [238, 237, 275, 315, 353, 355, 341, 332, 350, 315, 283, 310, 355, 350, 336, 405, 361, 273, 264, 228], [245, 264, 289, 340, 359, 349, 336, 303, 267, 259, 285, 340, 315, 290, 333, 372, 306, 254, 220, 220], [264, 287, 331, 365, 382, 381, 386, 360, 299, 258, 254, 284, 264, 276, 295, 323, 281, 233, 202, 160], [300, 327, 360, 355, 365, 402, 393, 343, 307, 274, 232, 226, 221, 262, 289, 250, 252, 228, 160, 160], [343, 379, 373, 337, 309, 336, 378, 352, 303, 290, 294, 241, 176, 204, 235, 205, 203, 206, 169, 132], [348, 348, 364, 369, 337, 276, 321, 390, 347, 354, 309, 259, 208, 147, 158, 165, 169, 169, 200, 147], [320, 328, 334, 348, 354, 316, 254, 315, 303, 297, 283, 238, 229, 207, 156, 129, 128, 161, 174, 165], [297, 331, 304, 283, 283, 279, 250, 243, 264, 251, 226, 204, 155, 144, 154, 147, 120, 111, 129, 138], [302, 347, 332, 326, 314, 286, 223, 205, 202, 178, 160, 172, 171, 132, 118, 116, 114, 96, 80, 75], [287, 317, 310, 293, 284, 235, 217, 305, 286, 229, 211, 234, 227, 243, 188, 160, 152, 129, 138, 101], [260, 277, 269, 243, 236, 255, 343, 312, 280, 220, 252, 280, 298, 288, 252, 210, 176, 163, 133, 112], [266, 255, 254, 254, 265, 307, 350, 311, 267, 276, 292, 355, 305, 250, 223, 200, 197, 193, 166, 158], [306, 312, 328, 279, 287, 320, 377, 359, 289, 328, 367, 355, 271, 250, 198, 163, 139, 155, 153, 190], [367, 357, 339, 330, 290, 323, 363, 374, 330, 331, 415, 446, 385, 308, 241, 190, 145, 99, 88, 145], [342, 362, 381, 359, 353, 353, 369, 391, 384, 372, 408, 448, 382, 358, 256, 178, 143, 125, 85, 109], [311, 337, 358, 376, 330, 341, 342, 374, 411, 408, 421, 382, 271, 311, 246, 166, 132, 116, 108, 72]];
    return heights[point.y][point.x];
  };

  show(heightAt({
    x: 0,
    y: 0
  }));

  show(heightAt({
    x: 11,
    y: 18
  }));

  weightedDistance = function(pointA, pointB) {
    var climbFactor, flatDistance, heightDifference;
    heightDifference = heightAt(pointB) - heightAt(pointA);
    climbFactor = heightDifference < 0 ? 1 : 2;
    flatDistance = pointA.x === pointB.x || pointA.y === pointB.y ? 100 : 141;
    return flatDistance + climbFactor * Math.abs(heightDifference);
  };

  show(weightedDistance({
    x: 0,
    y: 0
  }, {
    x: 1,
    y: 1
  }));

  point = function(x, y) {
    return {
      x: x,
      y: y
    };
  };

  addPoints = function(a, b) {
    return point(a.x + b.x, a.y + b.y);
  };

  samePoint = function(a, b) {
    return a.x === b.x && a.y === b.y;
  };

  show(samePoint(addPoints(point(10, 10), point(4, -2)), point(14, 8)));

  possibleDirections = function(from) {
    var directions, insideMap, mapSize;
    mapSize = 20;
    insideMap = function(point) {
      return point.x >= 0 && point.x < mapSize && point.y >= 0 && point.y < mapSize;
    };
    directions = [point(-1, 0), point(1, 0), point(0, -1), point(0, 1), point(-1, -1), point(-1, 1), point(1, 1), point(1, -1)];
    partial = function() {
      var a, func;
      func = arguments[0], a = 2 <= arguments.length ? __slice.call(arguments, 1) : [];
      return function() {
        var b;
        b = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
        return func.apply(null, __slice.call(a).concat(__slice.call(b)));
      };
    };
    return _.filter(_.map(directions, partial(addPoints, from)), insideMap);
  };

  show(possibleDirections(point(0, 0)));

  this.BinaryHeap = BinaryHeap = (function() {

    function BinaryHeap(scoreFunction) {
      this.scoreFunction = scoreFunction != null ? scoreFunction : function(x) {
        return x;
      };
      this.content = [];
    }

    BinaryHeap.prototype.push = function(element) {
      this.content.push(element);
      return this._bubbleUp(this.content.length - 1);
    };

    BinaryHeap.prototype.pop = function() {
      var end;
      result = this.content[0];
      end = this.content.pop();
      if (this.content.length > 0) {
        this.content[0] = end;
        this._sinkDown(0);
      }
      return result;
    };

    BinaryHeap.prototype.size = function() {
      return this.content.length;
    };

    BinaryHeap.prototype.remove = function(node) {
      var end, i, len;
      len = this.content.length;
      for (i = 0; 0 <= len ? i < len : i > len; 0 <= len ? i++ : i--) {
        if (this.content[i] === node) {
          end = this.content.pop();
          if (i !== len - 1) {
            this.content[i] = end;
            if (this.scoreFunction(end) < this.scoreFunction(node)) {
              this._bubbleUp(i);
            } else {
              this._sinkDown(i);
            }
          }
          return;
        }
      }
      throw new Error('Node not found.');
    };

    BinaryHeap.prototype._bubbleUp = function(n) {
      var parent, parentN;
      element = this.content[n];
      while (n > 0) {
        parentN = Math.floor((n + 1) / 2) - 1;
        parent = this.content[parentN];
        if (this.scoreFunction(element) < this.scoreFunction(parent)) {
          this.content[parentN] = element;
          this.content[n] = parent;
          n = parentN;
        } else {
          break;
        }
      }
    };

    BinaryHeap.prototype._sinkDown = function(n) {
      var child1, child1N, child1Score, child2, child2N, child2Score, compScore, elemScore, length, swap;
      length = this.content.length;
      element = this.content[n];
      elemScore = this.scoreFunction(element);
      while (true) {
        child2N = (n + 1) * 2;
        child1N = child2N - 1;
        swap = null;
        if (child1N < length) {
          child1 = this.content[child1N];
          child1Score = this.scoreFunction(child1);
          if (child1Score < elemScore) swap = child1N;
        }
        if (child2N < length) {
          child2 = this.content[child2N];
          child2Score = this.scoreFunction(child2);
          compScore = swap === null ? elemScore : child1Score;
          if (child2Score < compScore) swap = child2N;
        }
        if (swap !== null) {
          this.content[n] = this.content[swap];
          this.content[swap] = element;
          n = swap;
        } else {
          break;
        }
      }
    };

    return BinaryHeap;

  })();

  heap = new BinaryHeap();

  _.each([2, 4, 5, 1, 6, 3], function(number) {
    return heap.push(number);
  });

  while (heap.size() > 0) {
    show(heap.pop());
  }

  estimatedDistance = function(pointA, pointB) {
    var dx, dy;
    dx = Math.abs(pointA.x - pointB.x);
    dy = Math.abs(pointA.y - pointB.y);
    if (dx > dy) {
      return (dx - dy) * 100 + dy * 141;
    } else {
      return (dy - dx) * 100 + dx * 141;
    }
  };

  show(estimatedDistance(point(3, 3), point(9, 6)));

  makeReachedList = function() {
    return {};
  };

  storeReached = function(list, point, route) {
    var inner;
    inner = list[point.x];
    if (inner === void 0) {
      inner = {};
      list[point.x] = inner;
    }
    return inner[point.y] = route;
  };

  findReached = function(list, point) {
    var inner;
    inner = list[point.x];
    if (inner === void 0) {
      return;
    } else {
      return inner[point.y];
    }
  };

  pointID = function(point) {
    return point.x + '-' + point.y;
  };

  makeReachedList = function() {
    return {};
  };

  storeReached = function(list, point, route) {
    return list[pointID(point)] = route;
  };

  findReached = function(list, point) {
    return list[pointID(point)];
  };

  findRoute = function(from, to) {
    var addOpenRoute, open, reached, route, routeScore;
    routeScore = function(route) {
      if (route.score === void 0) {
        route.score = route.length + estimatedDistance(route.point, to);
      }
      return route.score;
    };
    addOpenRoute = function(route) {
      open.push(route);
      return storeReached(reached, route.point, route);
    };
    open = new BinaryHeap(routeScore);
    reached = makeReachedList();
    addOpenRoute({
      point: from,
      length: 0
    });
    while (open.size() > 0) {
      route = open.pop();
      if (samePoint(route.point, to)) return route;
      _.each(possibleDirections(route.point), function(direction) {
        var known, newLength;
        known = findReached(reached, direction);
        newLength = route.length + weightedDistance(route.point, direction);
        if (!known || known.length > newLength) {
          if (known) open.remove(known);
          return addOpenRoute({
            point: direction,
            from: route,
            length: newLength
          });
        }
      });
    }
    return null;
  };

  route = findRoute(point(0, 0), point(19, 19));

  runOnDemand(function() {
    return show(route);
  });

  traverseRoute = function() {
    var func, routes, _q;
    routes = 2 <= arguments.length ? __slice.call(arguments, 0, _q = arguments.length - 1) : (_q = 0, []), func = arguments[_q++];
    return _.each(__slice.call(routes), function(route) {
      var _results;
      _results = [];
      while (route) {
        func({
          x: route.point.x,
          y: route.point.y
        });
        _results.push(route = route.from);
      }
      return _results;
    });
  };

  showRoute = function() {
    var routes;
    routes = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return traverseRoute.apply(null, __slice.call(routes).concat([show]));
  };

  runOnDemand(function() {
    show('\n   Easy route');
    showRoute(route);
    show('\n   Sightseeing');
    return showRoute(findRoute(point(0, 0), point(11, 17)), findRoute(point(11, 17), point(19, 19)));
  });

  showSortedRoute = function() {
    var point, points, routes, _len11, _q, _results;
    routes = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    points = [];
    traverseRoute.apply(null, __slice.call(routes).concat([function(point) {
      return points.push(point);
    }]));
    points.sort(function(_arg, _arg2) {
      var dx, dy, x1, x2, y1, y2;
      x1 = _arg.x, y1 = _arg.y;
      x2 = _arg2.x, y2 = _arg2.y;
      if (dx = x1 - x2) return dx;
      if (dy = y1 - y2) return dy;
      return 0;
    });
    points = _.uniq(points, true, function(_arg) {
      var x, y;
      x = _arg.x, y = _arg.y;
      return "" + x + " " + y;
    });
    _results = [];
    for (_q = 0, _len11 = points.length; _q < _len11; _q++) {
      point = points[_q];
      _results.push(show(point));
    }
    return _results;
  };

  runOnDemand(function() {
    return showSortedRoute(findRoute(point(0, 0), point(11, 17)), findRoute(point(11, 17), point(19, 19)));
  });

  renderRoute = function() {
    var points, routePage, routes;
    routes = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    kup = typeof exports !== "undefined" && exports !== null ? require('coffeekup') : window.CoffeeKup;
    webdesign = function() {
      doctype(5);
      return html(function() {
        head(function() {
          return style('.map {position: absolute; left: 33px; top: 80px}');
        });
        return body(function() {
          header(function() {
            return h1('Route');
          });
          return div({
            "class": 'map'
          }, function() {
            var x, y, _len11, _q, _ref5, _results;
            img({
              src: 'http://autotelicum.github.com/' + 'Smooth-CoffeeScript/img/height-small.png'
            });
            _results = [];
            for (_q = 0, _len11 = points.length; _q < _len11; _q++) {
              _ref5 = points[_q], x = _ref5.x, y = _ref5.y;
              _results.push(img({
                "class": 'map',
                src: "" + ostrich,
                width: size,
                height: size,
                style: "left: " + (x * size) + "px; top: " + (y * size) + "px"
              }));
            }
            return _results;
          });
        });
      });
    };
    points = [];
    traverseRoute.apply(null, __slice.call(routes).concat([function(point) {
      return points.push(point);
    }]));
    routePage = kup.render(webdesign, {
      locals: {
        size: 500 / 20,
        points: points
      }
    });
    showDocument(routePage, 565, 600);
  };

  runOnDemand(function() {
    renderRoute(findRoute(point(0, 0), point(11, 17)), findRoute(point(11, 17), point(19, 19)));
    return renderRoute(findRoute(point(0, 0), point(15, 3)), findRoute(point(15, 3), point(19, 19)));
  });

  rabbit = {};

  rabbit.speak = function(line) {
    return show("The rabbit says '" + line + "'");
  };

  rabbit.speak("Well, now you're asking me.");

  speak = function(line) {
    return show("The " + this.adjective + " rabbit says '" + line + "'");
  };

  whiteRabbit = {
    adjective: "white",
    speak: speak
  };

  fatRabbit = {
    adjective: "fat",
    speak: speak
  };

  whiteRabbit.speak("Oh my ears and whiskers, " + "how late it's getting!");

  fatRabbit.speak("I could sure use a carrot right now.");

  speak.apply(fatRabbit, ['Yum.']);

  speak.call(fatRabbit, 'Burp.');

  Rabbit = (function() {

    function Rabbit(adjective) {
      this.adjective = adjective;
    }

    Rabbit.prototype.speak = function(line) {
      return show("The " + this.adjective + " rabbit says '" + line + "'");
    };

    return Rabbit;

  })();

  whiteRabbit = new Rabbit("white");

  fatRabbit = new Rabbit("fat");

  whiteRabbit.speak("Hurry!");

  fatRabbit.speak("Tasty!");

  killerRabbit = new Rabbit('killer');

  killerRabbit.speak('GRAAAAAAAAAH!');

  show(killerRabbit);

  makeRabbit = function(adjective) {
    return {
      adjective: adjective,
      speak: function(line) {
        return show(adjective + ': ' + line);
      }
    };
  };

  blackRabbit = makeRabbit('black');

  show(killerRabbit.constructor.name);

  show(blackRabbit.constructor.name);

  WeightyRabbit = (function(_super) {

    __extends(WeightyRabbit, _super);

    function WeightyRabbit(adjective, weight) {
      this.weight = weight;
      WeightyRabbit.__super__.constructor.call(this, adjective);
    }

    WeightyRabbit.prototype.adjustedWeight = function(relativeGravity) {
      return (this.weight * relativeGravity).toPrecision(2);
    };

    return WeightyRabbit;

  })(Rabbit);

  tinyRabbit = new WeightyRabbit("tiny", 1.01);

  jumboRabbit = new WeightyRabbit("jumbo", 7.47);

  moonGravity = 1 / 6;

  jumboRabbit.speak("Carry me, I weigh " + (jumboRabbit.adjustedWeight(moonGravity)) + " stones");

  tinyRabbit.speak("He ain't heavy, he is my brother");

  Account = (function() {

    function Account() {
      this.balance = 0;
    }

    Account.prototype.transfer = function(amount) {
      return this.balance += amount;
    };

    Account.prototype.getBalance = function() {
      return this.balance;
    };

    Account.prototype.batchTransfer = function(amtList) {
      var amount, _len11, _q, _results;
      _results = [];
      for (_q = 0, _len11 = amtList.length; _q < _len11; _q++) {
        amount = amtList[_q];
        _results.push(this.transfer(amount));
      }
      return _results;
    };

    return Account;

  })();

  yourAccount = new Account();

  oldBalance = yourAccount.getBalance();

  yourAccount.transfer(salary = 1000);

  newBalance = yourAccount.getBalance();

  show("Books balance: " + (salary === newBalance - oldBalance) + ".");

  AccountWithFee = (function(_super) {

    __extends(AccountWithFee, _super);

    function AccountWithFee() {
      AccountWithFee.__super__.constructor.apply(this, arguments);
    }

    AccountWithFee.prototype.fee = 5;

    AccountWithFee.prototype.transfer = function(amount) {
      return AccountWithFee.__super__.transfer.call(this, amount - this.fee);
    };

    return AccountWithFee;

  })(Account);

  yourAccount = new AccountWithFee();

  oldBalance = yourAccount.getBalance();

  yourAccount.transfer(salary = 1000);

  newBalance = yourAccount.getBalance();

  show("Books balance: " + (salary === newBalance - oldBalance) + ".");

  LimitedAccount = (function(_super) {

    __extends(LimitedAccount, _super);

    function LimitedAccount() {
      LimitedAccount.__super__.constructor.apply(this, arguments);
      this.resetLimit();
    }

    LimitedAccount.prototype.resetLimit = function() {
      return this.dailyLimit = 50;
    };

    LimitedAccount.prototype.transfer = function(amount) {
      if (amount < 0 && (this.dailyLimit += amount) < 0) {
        throw new Error("You maxed out!");
      } else {
        return LimitedAccount.__super__.transfer.call(this, amount);
      }
    };

    return LimitedAccount;

  })(Account);

  lacc = new LimitedAccount();

  lacc.transfer(50);

  show("Start balance " + (lacc.getBalance()));

  try {
    lacc.batchTransfer([-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]);
  } catch (error) {
    show(error.message);
  }

  show("After batch balance " + (lacc.getBalance()));

  Account = (function() {

    function Account() {
      this.balance = 0;
    }

    Account.prototype.transfer = function(amount) {
      return this.balance += amount;
    };

    Account.prototype.getBalance = function() {
      return this.balance;
    };

    Account.prototype.batchTransfer = function(amtList) {
      add = function(a, b) {
        return a + b;
      };
      sum = function(list) {
        return _.reduce(list, add, 0);
      };
      return this.balance += sum(amtList);
    };

    return Account;

  })();

  LimitedAccount = (function(_super) {

    __extends(LimitedAccount, _super);

    function LimitedAccount() {
      LimitedAccount.__super__.constructor.apply(this, arguments);
      this.resetLimit();
    }

    LimitedAccount.prototype.resetLimit = function() {
      return this.dailyLimit = 50;
    };

    LimitedAccount.prototype.transfer = function(amount) {
      if (amount < 0 && (this.dailyLimit += amount) < 0) {
        throw new Error("You maxed out!");
      } else {
        return LimitedAccount.__super__.transfer.call(this, amount);
      }
    };

    return LimitedAccount;

  })(Account);

  lacc = new LimitedAccount();

  lacc.transfer(50);

  show("Starting with " + (lacc.getBalance()));

  try {
    lacc.batchTransfer([-1, -2, -3, -4, -5, -6, -7, -8, -9, -10]);
  } catch (error) {
    show(error.message);
  }

  show("After batch balance " + (lacc.getBalance()));

  simpleObject = {};

  show(simpleObject.constructor.name);

  show(simpleObject.toString());

  show(_.methods(Rabbit));

  show(_.methods(Rabbit.prototype));

  show(Rabbit.prototype.constructor.name);

  Rabbit.prototype.speak('I am generic');

  Rabbit.prototype.speak('I am not initialized');

  Rabbit.prototype.speak('I am not initialized');

  show(killerRabbit.toString === simpleObject.toString);

  Rabbit.prototype.teeth = 'small';

  show(killerRabbit.teeth);

  killerRabbit.teeth = 'long, sharp, and bloody';

  show(killerRabbit.teeth);

  show(Rabbit.prototype.teeth);

  Rabbit.prototype.dance = function() {
    return show("The " + this.adjective + " rabbit dances a jig.");
  };

  killerRabbit.dance();

  Rabbit = function(adjective) {
    return this.adjective = adjective;
  };

  Rabbit.prototype.speak = function(line) {
    return show("The " + this.adjective + " rabbit says '" + line + "'");
  };

  hazelRabbit = new Rabbit("hazel");

  hazelRabbit.speak("Good Frith!");

  noCatsAtAll = {};

  if ("constructor" in noCatsAtAll) {
    show("Yes, there is a cat called 'constructor'.");
  }

  Object.prototype.allProperties = function() {
    var property, _results;
    _results = [];
    for (property in this) {
      _results.push(property);
    }
    return _results;
  };

  test = {
    x: 10,
    y: 3
  };

  show(test.allProperties());

  delete Object.prototype.allProperties;

  Object.prototype.ownProperties = function() {
    var property, _results;
    _results = [];
    for (property in this) {
      if (!__hasProp.call(this, property)) continue;
      _results.push(property);
    }
    return _results;
  };

  test = {
    'Fat Igor': true,
    'Fireball': true
  };

  show(test.ownProperties());

  delete Object.prototype.ownProperties;

  forEachOf = function(object, action) {
    var property, value, _results;
    _results = [];
    for (property in object) {
      if (!__hasProp.call(object, property)) continue;
      value = object[property];
      _results.push(action(property, value));
    }
    return _results;
  };

  chimera = {
    head: "lion",
    body: "goat",
    tail: "snake"
  };

  forEachOf(chimera, function(name, value) {
    return view("The " + name + " of a " + value + ".");
  });

  forEachIn = function(object, action) {
    var property, _results;
    _results = [];
    for (property in object) {
      if (Object.prototype.hasOwnProperty.call(object, property)) {
        _results.push(action(property, object[property]));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  test = {
    name: "Mordecai",
    hasOwnProperty: "Uh-oh"
  };

  forEachIn(test, function(name, value) {
    return view("Property " + name + " = " + value);
  });

  test = {
    name: "Mordecai",
    hasOwnProperty: "Uh-oh"
  };

  for (property in test) {
    if (!__hasProp.call(test, property)) continue;
    value = test[property];
    show("Property " + property + " = " + value);
  }

  obj = {
    foo: 'bar'
  };

  show(Object.prototype.hasOwnProperty.call(obj, 'foo') && Object.prototype.propertyIsEnumerable.call(obj, 'foo'));

  show(Object.prototype.hasOwnProperty.call(obj, '__proto__'));

  show(Object.prototype.hasOwnProperty.call(obj, '__proto__') && Object.prototype.propertyIsEnumerable.call(obj, '__proto__'));

  Dictionary = (function() {

    function Dictionary(values) {
      this.values = values != null ? values : {};
    }

    Dictionary.prototype.store = function(name, value) {
      return this.values[name] = value;
    };

    Dictionary.prototype.lookup = function(name) {
      return this.values[name];
    };

    Dictionary.prototype.contains = function(name) {
      return Object.prototype.hasOwnProperty.call(this.values, name) && Object.prototype.propertyIsEnumerable.call(this.values, name);
    };

    Dictionary.prototype.each = function(action) {
      var property, value, _ref5, _results;
      _ref5 = this.values;
      _results = [];
      for (property in _ref5) {
        if (!__hasProp.call(_ref5, property)) continue;
        value = _ref5[property];
        _results.push(action(property, value));
      }
      return _results;
    };

    return Dictionary;

  })();

  colours = new Dictionary({
    Grover: 'blue',
    Elmo: 'orange',
    Bert: 'yellow'
  });

  show(colours.contains('Grover'));

  colours.each(function(name, colour) {
    return view(name + ' is ' + colour);
  });

  slash = /\//;

  show('AC/DC'.search(slash));

  asteriskOrBrace = /[\{\*]/;

  story = 'We noticed the *giant sloth*, ' + 'hanging from a giant branch.';

  show(story.search(asteriskOrBrace));

  digitSurroundedBySpace = /\s\d\s/;

  show('1a 2 3d'.search(digitSurroundedBySpace));

  notABC = /[^ABC]/;

  show('ABCBACCBBADABC'.search(notABC));

  datePattern = /\d\d\/\d\d\/\d\d\d\d/;

  show('born 15/11/2003 (mother Spot): White Fang'.search(datePattern));

  show(/a+/.test('blah'));

  show(/^a+$/.test('blah'));

  show(/cat/.test('concatenate'));

  show(/\bcat\b/.test('concatenate'));

  parenthesizedText = /\(.*\)/;

  show("Its (the sloth's) claws were gigantic!".search(parenthesizedText));

  datePattern = /\d{1,2}\/\d\d?\/\d{4}/;

  show('born 15/11/2003 (mother Spot): White Fang'.search(datePattern));

  datePattern = /\d{1,2}\/\d\d?\/\d{4}/;

  show('born 15/11/2003 (mother Spot): White Fang'.search(datePattern));

  mailAddress = /\b[\w\.-]+@[\w\.-]+\.\w{2,3}\b/;

  mailAddress = /\b[\w\.-]+@[\w\.-]+\.\w{2,3}\b/;

  show(mailAddress.test('kenny@test.net'));

  show(mailAddress.test('I mailt kenny@tets.nets, ' + 'but it didn wrok!'));

  show(mailAddress.test('the_giant_sloth@gmail.com'));

  cartoonCrying = /boo(hoo+)+/i;

  show("Then, he exclaimed 'Boohoooohoohooo'".search(cartoonCrying));

  holyCow = /(sacred|holy) (cow|bovine|bull|taurus)/i;

  show(holyCow.test('Sacred bovine!'));

  show('No'.match(/Yes/));

  show('... yes'.match(/yes/));

  show('Giant Ape'.match(/giant (\w+)/i));

  quote = "My mind is a swirling miasma " + "(a poisonous fog thought to " + "cause illness) of titilating " + "thoughts and turgid ideas.";

  parenthesized = quote.match(/(\w+)\s*\((.*)\)/);

  if (parenthesized !== null) {
    show(("Word: " + parenthesized[1] + " ") + ("Explanation: " + parenthesized[2]));
  }

  extractDate = function(string) {
    var found;
    found = string.match(/(\d\d?)\/(\d\d?)\/(\d{4})/);
    if (found === null) throw new Error("No date found in '" + string + "'.");
    return new Date(Number(found[3]), Number(found[2]) - 1, Number(found[1]));
  };

  show(extractDate("born 5/2/2007 (mother Noog): Long-ear Johnson"));

  names = 'Picasso, Pablo\nGauguin, Paul\nVan Gogh, Vincent';

  show(names.replace(/([\w ]+), ([\w ]+)/g, '$2 $1'));

  show(names.replace(/([\w\x20]+),\u0020([\w\x20]+)/g, '$2 $1'));

  eatOne = function(match, amount, unit) {
    amount = Number(amount) - 1;
    if (amount === 1) {
      unit = unit.slice(0, unit.length - 1);
    } else if (amount === 0) {
      unit = unit + 's';
      amount = 'no';
    }
    return amount + ' ' + unit;
  };

  stock = '1 lemon, 2 cabbages, and 101 eggs';

  stock = stock.replace(/(\d+) (\w+)/g, eatOne);

  show(stock);

  escapeHTML2 = function(text) {
    var replacements;
    replacements = {
      "<": "&lt;",
      ">": "&gt;",
      "&": "&amp;",
      "\"": "&quot;"
    };
    return text.replace(/[<>&"]/g, function(character) {
      var _ref5;
      return (_ref5 = replacements[character]) != null ? _ref5 : character;
    });
  };

  show(escapeHTML2("The 'pre-formatted' tag " + "is written \"<pre>\"."));

  badWords = ['ape', 'monkey', 'simian', 'gorilla', 'evolution'];

  pattern = new RegExp(badWords.join('|'), 'i');

  isAcceptable = function(text) {
    return !pattern.test(text);
  };

  show(isAcceptable('Mmmm, grapes.'));

  show(isAcceptable('No more of that monkeybusiness, now.'));

  digits = new RegExp('\\d+');

  show(digits.test('101'));

  HTML = {
    tag: function(name, content, properties) {
      return {
        name: name,
        properties: properties,
        content: content
      };
    },
    link: function(target, text) {
      return HTML.tag('a', [text], {
        href: target
      });
    }
  };

  globalize = function(ns, target) {
    var name, _results;
    if (target == null) target = global;
    _results = [];
    for (name in ns) {
      _results.push(target[name] = ns[name]);
    }
    return _results;
  };

  globalize(HTML, typeof window !== "undefined" && window !== null);

  show(link('http://citeseerx.ist.psu.edu/viewdoc/' + 'download?doi=10.1.1.102.244&rep=rep1&type=pdf', 'What Every Computer Scientist Should Know ' + 'About Floating-Point Arithmetic'));

  range = function(start, end, stepSize, length) {
    if (stepSize === void 0) stepSize = 1;
    if (end === void 0) end = start + stepSize * (length - 1);
    result = [];
    while (start <= end) {
      result.push(start);
      start += stepSize;
    }
    return result;
  };

  show(range(0, void 0, 4, 5));

  defaultTo = function(object, values) {
    var name, value, _results;
    _results = [];
    for (name in values) {
      value = values[name];
      if (!object.hasOwnProperty(name)) {
        _results.push(object[name] = value);
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  range = function(args) {
    defaultTo(args, {
      start: 0,
      stepSize: 1
    });
    if (args.end === void 0) {
      args.end = args.start + args.stepSize * (args.length - 1);
    }
    result = [];
    while (args.start <= args.end) {
      result.push(args.start);
      args.start += args.stepSize;
    }
    return result;
  };

  show(range({
    stepSize: 4,
    length: 5
  }));

  runOnDemand(function() {
    return eval('function IamJavaScript() {' + '  alert(\"Repeat after me:' + ' Give me more {();};.\");};' + ' IamJavaScript();');
  });

  runOnDemand(function() {
    return CoffeeScript.eval('alert ((a, b) -> a + b) 3, 4');
  });

  weatherAdvice = function(weather) {
    show('When it is ' + weather);
    switch (weather) {
      case 'sunny':
        show('Dress lightly.');
        return show('Go outside.');
      case 'cloudy':
        return show('Go outside.');
      case 'tornado':
      case 'hurricane':
        return show('Seek shelter');
      default:
        return show('Unknown weather type: ' + weather);
    }
  };

  weatherAdvice('sunny');

  weatherAdvice('cloudy');

  weatherAdvice('tornado');

  weatherAdvice('hailstorm');

  for (i = 20; i < 30; i++) {
    if (i % 3 !== 0) continue;
    show(i + ' is divisible by three.');
  }

  Point = (function() {

    function Point(x, y) {
      this.x = x;
      this.y = y;
    }

    return Point;

  })();

  pt = new Point(3, 4);

  x = pt.x, y = pt.y;

  show("x is " + x + " and y is " + y);

  firstName = "Alan";

  lastName = "Turing";

  name = {
    firstName: firstName,
    lastName: lastName
  };

  show(name);

  decorate = function(_arg) {
    var firstName, lastName;
    firstName = _arg.firstName, lastName = _arg.lastName;
    return show(("Distinguished " + firstName + " ") + ("of the " + lastName + " family."));
  };

  decorate(name);

  pi = π = Math.PI;

  sphereSurfaceArea = function(r) {
    return 4 * π * r * r;
  };

  radius = 1;

  show('4 * π * r * r when r = ' + radius);

  show(sphereSurfaceArea(radius));

  evens = function(n) {
    var i, _results;
    _results = [];
    for (i = 0; 0 <= n ? i <= n : i >= n; 0 <= n ? i++ : i--) {
      if (i % 2 === 0) _results.push(i);
    }
    return _results;
  };

  show(evens(6));

  steppenwolf = {
    title: 'Tonight at the Magic Theater',
    warning: 'For Madmen only',
    caveat: 'Price of Admittance: Your Mind.',
    caution: 'Not for Everybody.'
  };

  stipulations = (function() {
    var _results;
    _results = [];
    for (key in steppenwolf) {
      text = steppenwolf[key];
      if (key === 'warning' || key === 'caveat') _results.push(text);
    }
    return _results;
  })();

  show(stipulations);

  for (_q = 0, _len11 = stipulations.length; _q < _len11; _q++) {
    ultimatum = stipulations[_q];
    if (ultimatum.match(/Price/)) show(ultimatum);
  }

  tautounlogical = "the reason is because I say so";

  splitStringAt = function(str, n) {
    return [str.substring(0, n), str.substring(n)];
  };

  _ref5 = splitStringAt(tautounlogical, 14), pre = _ref5[0], post = _ref5[1];

  _ref6 = [post, pre], pre = _ref6[0], post = _ref6[1];

  show("" + pre + " " + post);

  _ref7 = [1, 2, 3, 4, 5, 6], re = _ref7[0], mi = _ref7[1], fa = _ref7[2], sol = _ref7[3], la = _ref7[4], ti = _ref7[5];

  _ref8 = [ti, re, fa, sol, la, mi], dal = _ref8[0], ra = 3 <= _ref8.length ? __slice.call(_ref8, 1, _r = _ref8.length - 1) : (_r = 1, []), mim = _ref8[_r++];

  show("" + dal + ", " + ra + " and " + mim);

  _ref9 = re > ti ? [mi, fa] : [fa, mi], key = _ref9[0], word = _ref9[1];

  show("" + key + " and " + word);

  Widget = (function() {

    function Widget() {
      this.display = __bind(this.display, this);
    }

    Widget.prototype.id = 'I am a widget';

    Widget.prototype.display = function() {
      return show(this.id);
    };

    return Widget;

  })();

  Container = (function() {

    function Container() {}

    Container.prototype.id = 'I am a container';

    Container.prototype.callback = function(f) {
      show(this.id);
      return f();
    };

    return Container;

  })();

  a = new Widget;

  a.display();

  b = new Container;

  b.callback(a.display);

  n = 3;

  f = function() {
    return show("Say: 'Yes!'");
  };

  f();

  while (n-- > 0) {
    (function() {
      return show("Yes!");
    })();
  }

  echoEchoEcho = function(msg) {
    return msg() + msg() + msg();
  };

  show(echoEchoEcho(function() {
    return "No";
  }));

  runOnDemand(function() {
    var i, _fn, _results;
    _fn = function(i) {
      return setTimeout((function() {
        return show('With do: ' + i);
      }), 0);
    };
    for (i = 1; i <= 3; i++) {
      _fn(i);
    }
    _results = [];
    for (i = 1; i <= 3; i++) {
      _results.push(setTimeout((function() {
        return show('Without: ' + i);
      }), 0));
    }
    return _results;
  });

  BinaryHeap = (function() {

    function BinaryHeap(scoreFunction) {
      this.scoreFunction = scoreFunction != null ? scoreFunction : function(x) {
        return x;
      };
      this.content = [];
    }

    BinaryHeap.prototype.push = function(element) {
      this.content.push(element);
      return this._bubbleUp(this.content.length - 1);
    };

    BinaryHeap.prototype.pop = function() {
      var end;
      result = this.content[0];
      end = this.content.pop();
      if (this.content.length > 0) {
        this.content[0] = end;
        this._sinkDown(0);
      }
      return result;
    };

    BinaryHeap.prototype.size = function() {
      return this.content.length;
    };

    BinaryHeap.prototype.remove = function(node) {
      var end, i, len;
      len = this.content.length;
      for (i = 0; 0 <= len ? i < len : i > len; 0 <= len ? i++ : i--) {
        if (this.content[i] === node) {
          end = this.content.pop();
          if (i !== len - 1) {
            this.content[i] = end;
            if (this.scoreFunction(end) < this.scoreFunction(node)) {
              this._bubbleUp(i);
            } else {
              this._sinkDown(i);
            }
          }
          return;
        }
      }
      throw new Error('Node not found.');
    };

    BinaryHeap.prototype._bubbleUp = function(n) {
      var parent, parentN;
      element = this.content[n];
      while (n > 0) {
        parentN = Math.floor((n + 1) / 2) - 1;
        parent = this.content[parentN];
        if (this.scoreFunction(element) < this.scoreFunction(parent)) {
          this.content[parentN] = element;
          this.content[n] = parent;
          n = parentN;
        } else {
          break;
        }
      }
    };

    BinaryHeap.prototype._sinkDown = function(n) {
      var child1, child1N, child1Score, child2, child2N, child2Score, compScore, elemScore, length, swap;
      length = this.content.length;
      element = this.content[n];
      elemScore = this.scoreFunction(element);
      while (true) {
        child2N = (n + 1) * 2;
        child1N = child2N - 1;
        swap = null;
        if (child1N < length) {
          child1 = this.content[child1N];
          child1Score = this.scoreFunction(child1);
          if (child1Score < elemScore) swap = child1N;
        }
        if (child2N < length) {
          child2 = this.content[child2N];
          child2Score = this.scoreFunction(child2);
          compScore = swap === null ? elemScore : child1Score;
          if (child2Score < compScore) swap = child2N;
        }
        if (swap !== null) {
          this.content[n] = this.content[swap];
          this.content[swap] = element;
          n = swap;
        } else {
          break;
        }
      }
    };

    return BinaryHeap;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).BinaryHeap = BinaryHeap;

  runOnDemand(function() {
    var buildHeap, sortByValue;
    sortByValue = function(obj) {
      return _.sortBy(obj, function(n) {
        return n;
      });
    };
    buildHeap = function(c, a) {
      var number, _len12, _s;
      heap = new BinaryHeap;
      for (_s = 0, _len12 = a.length; _s < _len12; _s++) {
        number = a[_s];
        heap.push(number);
      }
      return c.note(heap);
    };
    declare('heap is created empty', [], function(c) {
      return c.assert((new BinaryHeap).size() === 0);
    });
    declare('heap pop is undefined when empty', [], function(c) {
      return c.assert(_.isUndefined((new BinaryHeap).pop()));
    });
    declare('heap contains number of inserted elements', [arbArray(arbInt)], function(c, a) {
      return c.assert(buildHeap(c, a).size() === a.length);
    });
    declare('heap contains inserted elements', [arbArray(arbInt)], function(c, a) {
      heap = buildHeap(c, a);
      return c.assert(_.isEqual(sortByValue(a), sortByValue(heap.content)));
    });
    declare('heap pops elements in sorted order', [arbArray(arbInt)], function(c, a) {
      var n, _len12, _ref10, _s;
      heap = buildHeap(c, a);
      _ref10 = sortByValue(a);
      for (_s = 0, _len12 = _ref10.length; _s < _len12; _s++) {
        n = _ref10[_s];
        c.assert(n === heap.pop());
      }
      return c.assert(heap.size() === 0);
    });
    declare('heap does not remove non-existent elements', [arbArray(arbInt), arbInt], expectException(function(c, a, b) {
      if (__indexOf.call(a, b) >= 0) c.guard(false);
      heap = buildHeap(c, a);
      return heap.remove(b);
    }));
    declare('heap removes existing elements', [arbArray(arbInt), arbInt], function(c, a, b) {
      var aSort, i, n, _len12, _s;
      if (!(__indexOf.call(a, b) >= 0)) c.guard(false);
      aSort = sortByValue(_.without(a, b));
      count = a.length - aSort.length;
      heap = buildHeap(c, a);
      for (i = 0; 0 <= count ? i < count : i > count; 0 <= count ? i++ : i--) {
        heap.remove(b);
      }
      for (_s = 0, _len12 = aSort.length; _s < _len12; _s++) {
        n = aSort[_s];
        c.assert(n === heap.pop());
      }
      return c.assert(heap.size() === 0);
    });
    return test();
  });

  runOnDemand(function() {
    var N, duration, i, s, start, t, v, _len12, _len13, _s, _t;
    start = new Date();
    N = 1000000;
    a = Array(N);
    for (i = 0; 0 <= N ? i < N : i > N; 0 <= N ? i++ : i--) {
      a[i] = Math.random();
    }
    s = 0;
    for (_s = 0, _len12 = a.length; _s < _len12; _s++) {
      v = a[_s];
      s += v;
    }
    t = 0;
    for (_t = 0, _len13 = a.length; _t < _len13; _t++) {
      v = a[_t];
      t += v * v;
    }
    t = Math.sqrt(t);
    duration = new Date() - start;
    show("N: " + N + " in " + (duration * 0.001) + " s");
    return show("Result: " + s + " and " + t);
  });

  permute = function(L) {
    var elem, i, p, _len12, _ref10, _ref11, _s;
    n = L.length;
    if (n === 1) {
      return (function() {
        var _len12, _results, _s;
        _results = [];
        for (_s = 0, _len12 = L.length; _s < _len12; _s++) {
          elem = L[_s];
          _results.push([elem]);
        }
        return _results;
      })();
    }
    _ref10 = [[L[0]], L.slice(1)], a = _ref10[0], L = _ref10[1];
    result = [];
    _ref11 = permute(L);
    for (_s = 0, _len12 = _ref11.length; _s < _len12; _s++) {
      p = _ref11[_s];
      for (i = 0; 0 <= n ? i < n : i > n; 0 <= n ? i++ : i--) {
        result.push(p.slice(0, i).concat(a, p.slice(i)));
      }
    }
    return result;
  };

  test = function(p, n) {
    var d, i, j, _ref10, _ref11;
    for (i = 0, _ref10 = n - 1; 0 <= _ref10 ? i < _ref10 : i > _ref10; 0 <= _ref10 ? i++ : i--) {
      for (j = _ref11 = i + 1; _ref11 <= n ? j < n : j > n; _ref11 <= n ? j++ : j--) {
        d = p[i] - p[j];
        if (j - i === d || i - j === d) return true;
      }
    }
    return false;
  };

  nQueen = function(n) {
    var p, _len12, _ref10, _results, _s, _t;
    result = [];
    _ref10 = permute((function() {
      _results = [];
      for (var _t = 0; 0 <= n ? _t < n : _t > n; 0 <= n ? _t++ : _t--){ _results.push(_t); }
      return _results;
    }).apply(this));
    for (_s = 0, _len12 = _ref10.length; _s < _len12; _s++) {
      p = _ref10[_s];
      if (!test(p, n)) result.push(p);
    }
    return result;
  };

  rep = function(s, n) {
    return ((function() {
      var _results, _s;
      _results = [];
      for (_s = 0; 0 <= n ? _s < n : _s > n; 0 <= n ? _s++ : _s--) {
        _results.push(s);
      }
      return _results;
    })()).join('');
  };

  printBoard = function(solution) {
    var board, end, n, pos, row, _len12;
    board = "\n";
    end = solution.length;
    for (row = 0, _len12 = solution.length; row < _len12; row++) {
      pos = solution[row];
      board += ("" + (end - row) + " " + (rep(' ☐ ', pos)) + " ") + ("♕ " + (rep(' ☐ ', end - pos - 1)) + "\n");
    }
    board += '   ' + ((function() {
      var _results;
      _results = [];
      for (n = 10; n < 18; n++) {
        _results.push(n.toString(18));
      }
      return _results;
    })()).join('  ').toUpperCase();
    return board + "\n";
  };

  solve = function(n) {
    var count, solution, _len12, _ref10;
    _ref10 = nQueen(n);
    for (count = 0, _len12 = _ref10.length; count < _len12; count++) {
      solution = _ref10[count];
      show("Solution " + (count + 1) + ":");
      show(printBoard(solution));
    }
    return count;
  };

  runOnDemand(function() {
    var start;
    start = new Date();
    solve(8);
    return show("Timing: " + ((new Date() - start) * 0.001) + "s");
  });

}).call(this);
