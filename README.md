# dixa_flutter

Flutter plugin for Dixa

## Getting Started

For web add this code 
```
 <script>
    (function (w, d, s) {
      if (w._dixa_) return;
      w._dixa_ = {
        invoke: function (m, a) {
          w._dixa_.pendingCalls = w._dixa_.pendingCalls || [];
          w._dixa_.pendingCalls.push([m, a]);
        },
      };
      s = d.createElement("script");
      s.type = "text/javascript";
      s.setAttribute("charset", "utf-8");
      s.async = true;
      s.src = "https://messenger.dixa.io/bootstrap.js";
      var before = d.getElementsByTagName("script")[0];
      before.parentNode.insertBefore(s, before);

      w.Dixa = function (m, a) {
        w._dixa_.invoke(m, a);
      }

    })(window, document);

  </script>
  ```

# dixa_flutter
