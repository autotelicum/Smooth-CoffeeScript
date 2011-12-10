(function() {
  var kup, show, showDocument, webapp, webpage;

  show = console.log;

  showDocument = function(doc, width, height) {
    return show(doc);
  };

  kup = typeof exports !== "undefined" && exports !== null ? require('coffeekup') : window.CoffeeKup;

  webapp = function() {
    doctype(5);
    return html(function() {
      head(function() {
        meta({
          charset: 'utf-8'
        });
        title('Histogram');
        return style('body        {color: #FFFFFF;  background-color: #404040}\
             #background {position: absolute; top:  40px; left: 20px}\
             #image      {position: absolute; top:   0px; left: 80px}\
             #picture    {position: absolute; top:   0px; left: 80px}\
             #histogram  {position: absolute; top: 140px; left:  0px}');
      });
      body(function() {
        return div({
          id: 'background'
        }, function() {
          var _ref;
          img({
            id: 'image',
            width: 90,
            height: 90,
            src: (_ref = typeof window !== "undefined" && window !== null ? window.ostrich : void 0) != null ? _ref : '../img/ostrich.jpg'
          });
          canvas({
            id: 'picture',
            width: 90,
            height: 90
          });
          return canvas({
            id: 'histogram',
            width: 256,
            height: 100,
            onClick: 'onChange()'
          });
        });
      });
      return coffeescript(function() {
        var analyze, drawGraphs, hues, legend, textColor, textFont, textPos, view;
        hues = {
          red: 'rgba(255, 128, 128, 0.5)',
          green: 'rgba(128, 255, 128, 0.5)',
          blue: 'rgba(128, 128, 255, 0.5)',
          alpha: 'rgba(128, 128, 128, 0.5)'
        };
        legend = ['∀', 'R', 'G', 'B', 'α'];
        textColor = '#F7C762';
        textFont = '12pt Times';
        textPos = {
          x: 230,
          y: -80
        };
        view = 0;
        analyze = function(data) {
          var bin, bins, i, name, val, _len;
          bins = {
            red: [],
            green: [],
            blue: [],
            alpha: []
          };
          for (name in bins) {
            bin = bins[name];
            for (i = 0; i <= 255; i++) {
              bin[i] = 0;
            }
          }
          for (i = 0, _len = data.length; i < _len; i++) {
            val = data[i];
            switch (i % 4) {
              case 0:
                bins.red[val]++;
                break;
              case 1:
                bins.green[val]++;
                break;
              case 2:
                bins.blue[val]++;
                break;
              case 3:
                bins.alpha[val]++;
            }
          }
          return bins;
        };
        drawGraphs = function(ctx, graphs) {
          var drawPlot;
          drawPlot = function(ctx, plot, color) {
            var x, y, _len;
            ctx.fillStyle = color;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            for (x = 0, _len = plot.length; x < _len; x++) {
              y = plot[x];
              ctx.lineTo(x, y);
            }
            ctx.lineTo(plot.length, 0);
            ctx.closePath();
            return ctx.fill();
          };
          ctx.translate(0, ctx.canvas.height);
          ctx.fillStyle = textColor;
          ctx.font = textFont;
          ctx.fillText(legend[view], textPos.x, textPos.y);
          ctx.scale(1, -1);
          if (view === 0 || view === 1) drawPlot(ctx, graphs.red, hues.red);
          if (view === 0 || view === 2) drawPlot(ctx, graphs.green, hues.green);
          if (view === 0 || view === 3) drawPlot(ctx, graphs.blue, hues.blue);
          if (view === 0 || view === 4) {
            return drawPlot(ctx, graphs.alpha, hues.alpha);
          }
        };
        window.onload = function() {
          var $;
          $ = function(element) {
            return document.getElementById(element);
          };
          this.image = $('image');
          this.canvas = $('picture');
          this.histogram = $('histogram');
          this.context = canvas.getContext('2d');
          this.plot = histogram.getContext('2d');
          if (!((this.context != null) || (this.plot != null))) {
            alert('No canvas in this browser.');
            return;
          }
          return window.onChange();
        };
        return window.onChange = function() {
          var graphs, i, picture, _ref, _ref2;
          this.histogram.width = this.histogram.width;
          this.plot.clearRect(0, 0, this.histogram.width, this.histogram.height);
          this.context.drawImage(this.image, 0, 0);
          picture = this.context.getImageData(0, 0, this.image.width, this.image.height);
          graphs = analyze(picture.data);
          drawGraphs(this.plot, graphs, view);
          if ((0 < view && view < 4)) {
            picture = this.context.getImageData(0, 0, this.image.width, this.image.height);
            for (i = 0, _ref = picture.data.length; i < _ref; i += 1) {
              if ((_ref2 = i % 4) !== 3 && _ref2 !== (view - 1)) {
                picture.data[i] = 0;
              }
            }
            this.context.putImageData(picture, 0, 0);
          }
          if (view++ === 4) view = 0;
        };
      });
    });
  };

  webpage = kup.render(webapp, {
    format: true
  });

  showDocument(webpage);

}).call(this);
