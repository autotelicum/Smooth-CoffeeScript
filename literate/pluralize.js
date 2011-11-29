(function() {
  var n, test;

  test = function(points) {
    var pluralIf, pluralUnless, _base, _ref, _ref2;
    show("0: You got " + points + " point" + (points > 1 ? 's' : ''));
    pluralIf = function(stem, cond) {
      return stem + (cond ? 's' : '');
    };
    show("1: You got " + points + " " + (pluralIf('point', points > 1)));
    pluralUnless = function(stem, cond) {
      return stem + (!cond ? 's' : '');
    };
    show("2: You got " + points + " " + (pluralUnless('point', (-2 < points && points < 2))));
    if ((_ref = (_base = String.prototype).pluralIf) == null) {
      _base.pluralIf = function(cond) {
        return this + (cond ? 's' : '');
      };
    }
    show("3: You got " + points + " " + ('point'.pluralIf(points > 1)));
    show("4: You got " + points + " point" + ((_ref2 = (points > 1 ? 's' : void 0)) != null ? _ref2 : ''));
    show("5: You got " + points + " point" + ['', 's'][+(points > 1)]);
    show("6: You got " + points + " point" + ('s'.charAt(points <= 1)));
    show("7: You got " + points + " point" + (Array(1 + (points > 1)).join('s')));
    show("8: You got " + points + " point" + ([].concat((points > 1 ? 's' : void 0))));
    return show("9: You got " + points + " point" + [points > 1 ? 's' : void 0]);
  };

  for (n = -3; n <= 3; n++) {
    test(n);
  }

}).call(this);
