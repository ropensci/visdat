(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

exports.stamp = stamp;

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Events = function () {
  function Events() {
    _classCallCheck(this, Events);

    this._types = {};
    this._seq = 0;
  }

  _createClass(Events, [{
    key: "on",
    value: function on(eventType, listener) {
      var subs = this._types[eventType];
      if (!subs) {
        subs = this._types[eventType] = {};
      }
      var sub = "sub" + this._seq++;
      subs[sub] = listener;
      return sub;
    }
  }, {
    key: "off",
    value: function off(eventType, listener) {
      var subs = this._types[eventType];
      if (typeof listener === "function") {
        for (var key in subs) {
          if (subs.hasOwnProperty(key)) {
            if (subs[key] === listener) {
              delete subs[key];
              return;
            }
          }
        }
      } else if (typeof listener === "string") {
        if (subs) {
          delete subs[listener];
          return;
        }
      } else {
        throw new Error("Unexpected type for listener");
      }
    }
  }, {
    key: "trigger",
    value: function trigger(eventType, arg, thisObj) {
      var subs = this._types[eventType];
      for (var key in subs) {
        if (subs.hasOwnProperty(key)) {
          subs[key].call(thisObj, arg);
        }
      }
    }
  }]);

  return Events;
}();

exports.default = Events;


var stampSeq = 1;

function stamp(el) {
  if (el === null) {
    return "";
  }
  if (!el.__crosstalkStamp) {
    el.__crosstalkStamp = "ct" + stampSeq++;
  }
  return el.__crosstalkStamp;
}


},{}],2:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

exports.createHandle = createHandle;

var _filterset = require("./filterset");

var _filterset2 = _interopRequireDefault(_filterset);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function getFilterSet(group) {
  var fsVar = group.var("filterset");
  var result = fsVar.get();
  if (!result) {
    result = new _filterset2.default();
    fsVar.set(result);
  }
  return result;
}

var id = 1;
function nextId() {
  return id++;
}

function createHandle(group) {
  return new FilterHandle(getFilterSet(group), group.var("filter"));
}

var FilterHandle = function () {
  function FilterHandle(filterSet, filterVar) {
    var handleId = arguments.length <= 2 || arguments[2] === undefined ? "filter" + nextId() : arguments[2];

    _classCallCheck(this, FilterHandle);

    this._filterSet = filterSet;
    this._filterVar = filterVar;
    this._id = handleId;
  }

  _createClass(FilterHandle, [{
    key: "close",
    value: function close() {
      this.clear();
    }
  }, {
    key: "clear",
    value: function clear() {
      this._filterSet.clear(this._id);
      this._onChange();
    }
  }, {
    key: "set",
    value: function set(keys) {
      this._filterSet.update(this._id, keys);
      this._onChange();
    }
  }, {
    key: "on",
    value: function on(eventType, listener) {
      return this._filterVar.on(eventType, listener);
    }
  }, {
    key: "_onChange",
    value: function _onChange() {
      this._filterVar.set(this._filterSet.value);
    }
  }, {
    key: "filteredKeys",
    get: function get() {
      return this._filterSet.value;
    }
  }]);

  return FilterHandle;
}();


},{"./filterset":3}],3:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _util = require("./util");

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function naturalComparator(a, b) {
  if (a === b) {
    return 0;
  } else if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  }
}

var FilterSet = function () {
  function FilterSet() {
    _classCallCheck(this, FilterSet);

    this.reset();
  }

  _createClass(FilterSet, [{
    key: "reset",
    value: function reset() {
      // Key: handle ID, Value: array of selected keys, or null
      this._handles = {};
      // Key: key string, Value: count of handles that include it
      this._keys = {};
      this._value = null;
      this._activeHandles = 0;
    }
  }, {
    key: "update",
    value: function update(handleId, keys) {
      if (keys !== null) {
        keys = keys.slice(0); // clone before sorting
        keys.sort(naturalComparator);
      }

      var _diffSortedLists = (0, _util.diffSortedLists)(this._handles[handleId], keys);

      var added = _diffSortedLists.added;
      var removed = _diffSortedLists.removed;

      this._handles[handleId] = keys;

      for (var i = 0; i < added.length; i++) {
        this._keys[added[i]] = (this._keys[added[i]] || 0) + 1;
      }
      for (var _i = 0; _i < removed.length; _i++) {
        this._keys[removed[_i]]--;
      }

      this._updateValue(keys);
    }

    /**
     * @param {string[]} keys Sorted array of strings that indicate
     * a superset of possible keys.
     */

  }, {
    key: "_updateValue",
    value: function _updateValue() {
      var keys = arguments.length <= 0 || arguments[0] === undefined ? this._allKeys : arguments[0];

      var handleCount = Object.keys(this._handles).length;
      if (handleCount === 0) {
        this._value = null;
      } else {
        this._value = [];
        for (var i = 0; i < keys.length; i++) {
          var count = this._keys[keys[i]];
          if (count === handleCount) {
            this._value.push(keys[i]);
          }
        }
      }
    }
  }, {
    key: "clear",
    value: function clear(handleId) {
      if (typeof this._handles[handleId] === "undefined") {
        return;
      }

      var keys = this._handles[handleId] || [];
      for (var i = 0; i < keys.length; i++) {
        this._keys[keys[i]]--;
      }
      delete this._handles[handleId];

      this._updateValue();
    }
  }, {
    key: "value",
    get: function get() {
      return this._value;
    }
  }, {
    key: "_allKeys",
    get: function get() {
      var allKeys = Object.keys(this._keys);
      allKeys.sort(naturalComparator);
      return allKeys;
    }
  }]);

  return FilterSet;
}();

exports.default = FilterSet;


},{"./util":11}],4:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol ? "symbol" : typeof obj; };

exports.default = group;

var _var2 = require("./var");

var _var3 = _interopRequireDefault(_var2);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var groups = {};

function group(groupName) {
  if (typeof groupName === "string") {
    if (!groups.hasOwnProperty(groupName)) {
      groups[groupName] = new Group(groupName);
    }
    return groups[groupName];
  } else if ((typeof groupName === "undefined" ? "undefined" : _typeof(groupName)) === "object" && groupName._vars && groupName.var) {
    // Appears to already be a group object
    return groupName;
  } else {
    throw new Error("Invalid groupName argument");
  }
}

var Group = function () {
  function Group(name) {
    _classCallCheck(this, Group);

    this.name = name;
    this._vars = {};
  }

  _createClass(Group, [{
    key: "var",
    value: function _var(name) {
      if (typeof name !== "string") {
        throw new Error("Invalid var name");
      }

      if (!this._vars.hasOwnProperty(name)) this._vars[name] = new _var3.default(this, name);
      return this._vars[name];
    }
  }, {
    key: "has",
    value: function has(name) {
      if (typeof name !== "string") {
        throw new Error("Invalid var name");
      }

      return this._vars.hasOwnProperty(name);
    }
  }]);

  return Group;
}();


},{"./var":12}],5:[function(require,module,exports){
(function (global){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _group = require("./group");

var _group2 = _interopRequireDefault(_group);

var _selection = require("./selection");

var selection = _interopRequireWildcard(_selection);

var _filter = require("./filter");

var filter = _interopRequireWildcard(_filter);

require("./input");

require("./input_selectize");

require("./input_checkboxgroup");

require("./input_slider");

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

var defaultGroup = (0, _group2.default)("default");

function var_(name) {
  return defaultGroup.var(name);
}

function has(name) {
  return defaultGroup.has(name);
}

if (global.Shiny) {
  global.Shiny.addCustomMessageHandler("update-client-value", function (message) {
    if (typeof message.group === "string") {
      (0, _group2.default)(message.group).var(message.name).set(message.value);
    } else {
      var_(message.name).set(message.value);
    }
  });
}

var crosstalk = {
  group: _group2.default,
  var: var_,
  has: has,
  selection: selection,
  filter: filter
};

exports.default = crosstalk;

global.crosstalk = crosstalk;


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./filter":2,"./group":4,"./input":6,"./input_checkboxgroup":7,"./input_selectize":8,"./input_slider":9,"./selection":10}],6:[function(require,module,exports){
(function (global){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.register = register;
var $ = global.jQuery;

var bindings = {};

function register(reg) {
  bindings[reg.className] = reg;
  if (global.document && global.document.readyState !== "complete") {
    $(function () {
      bind();
    });
  } else if (global.document) {
    setTimeout(bind, 100);
  }
}

function bind() {
  Object.keys(bindings).forEach(function (className) {
    var binding = bindings[className];
    $("." + binding.className).not(".crosstalk-input-bound").each(function (i, el) {
      bindInstance(binding, el);
    });
  });
}

// Escape jQuery identifier
function $escape(val) {
  return val.replace(/([!"#$%&'()*+,.\/:;<=>?@\[\\\]^`{|}~])/g, "\\$1");
}

function bindInstance(binding, el) {
  var jsonEl = $(el).find("script[type='application/json'][data-for='" + $escape(el.id) + "']");
  var data = JSON.parse(jsonEl[0].innerText);

  var instance = binding.factory(el, data);
  $(el).data("crosstalk-instance", instance);
  $(el).addClass("crosstalk-input-bound");
}

if (global.Shiny) {
  (function () {
    var inputBinding = new global.Shiny.InputBinding();
    var $ = global.jQuery;
    $.extend(inputBinding, {
      find: function find(scope) {
        return $(scope).find(".crosstalk-input");
      },
      getId: function getId(el) {
        return el.id;
      },
      getValue: function getValue(el) {},
      setValue: function setValue(el, value) {},
      receiveMessage: function receiveMessage(el, data) {},
      subscribe: function subscribe(el, callback) {
        $(el).on("crosstalk-value-change.crosstalk", function (event) {
          callback(false);
        });
      },
      unsubscribe: function unsubscribe(el) {
        $(el).off(".crosstalk");
      }
    });
    global.Shiny.inputBindings.register(inputBinding, "crosstalk.inputBinding");
  })();
}


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{}],7:[function(require,module,exports){
(function (global){
"use strict";

var _input = require("./input");

var input = _interopRequireWildcard(_input);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

var $ = global.jQuery;

input.register({
  className: "crosstalk-input-checkboxgroup",

  factory: function factory(el, data) {
    /*
     * map: {"groupA": ["keyA", "keyB", ...], ...}
     * group: "ct-groupname"
     */
    var ctGroup = global.crosstalk.group(data.group);
    var ctHandle = global.crosstalk.filter.createHandle(ctGroup);

    var $el = $(el);
    $el.on("change", "input[type='checkbox']", function () {
      var checked = $el.find("input[type='checkbox']:checked");
      if (checked.length === 0) {
        ctHandle.clear();
      } else {
        (function () {
          var keys = {};
          checked.each(function () {
            data.map[this.value].forEach(function (key) {
              keys[key] = true;
            });
          });
          var keyArray = Object.keys(keys);
          keyArray.sort();
          ctHandle.set(keyArray);
        })();
      }
    });
  }
});


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./input":6}],8:[function(require,module,exports){
(function (global){
"use strict";

var _input = require("./input");

var input = _interopRequireWildcard(_input);

var _util = require("./util");

var util = _interopRequireWildcard(_util);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

var $ = global.jQuery;

input.register({
  className: "crosstalk-input-select",

  factory: function factory(el, data) {
    /*
     * items: {value: [...], label: [...]}
     * map: {"groupA": ["keyA", "keyB", ...], ...}
     * group: "ct-groupname"
     */

    var first = [{ value: "", label: "(All)" }];
    var items = util.dataframeToD3(data.items);
    var opts = {
      options: first.concat(items),
      valueField: "value",
      labelField: "label"
    };

    var select = $(el).find("select")[0];

    var selectize = $(select).selectize(opts)[0].selectize;

    var ctGroup = global.crosstalk.group(data.group);
    var ctHandle = global.crosstalk.filter.createHandle(ctGroup);

    selectize.on("change", function () {
      if (selectize.items.length === 0) {
        ctHandle.clear();
      } else {
        (function () {
          var keys = {};
          selectize.items.forEach(function (group) {
            data.map[group].forEach(function (key) {
              keys[key] = true;
            });
          });
          var keyArray = Object.keys(keys);
          keyArray.sort();
          ctHandle.set(keyArray);
        })();
      }
    });

    return selectize;
  }
});


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./input":6,"./util":11}],9:[function(require,module,exports){
(function (global){
"use strict";

var _slicedToArray = function () { function sliceIterator(arr, i) { var _arr = []; var _n = true; var _d = false; var _e = undefined; try { for (var _i = arr[Symbol.iterator](), _s; !(_n = (_s = _i.next()).done); _n = true) { _arr.push(_s.value); if (i && _arr.length === i) break; } } catch (err) { _d = true; _e = err; } finally { try { if (!_n && _i["return"]) _i["return"](); } finally { if (_d) throw _e; } } return _arr; } return function (arr, i) { if (Array.isArray(arr)) { return arr; } else if (Symbol.iterator in Object(arr)) { return sliceIterator(arr, i); } else { throw new TypeError("Invalid attempt to destructure non-iterable instance"); } }; }();

var _input = require("./input");

var input = _interopRequireWildcard(_input);

function _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }

var $ = global.jQuery;
var strftime = global.strftime;

input.register({
  className: "crosstalk-input-slider",

  factory: function factory(el, data) {
    /*
     * map: {"groupA": ["keyA", "keyB", ...], ...}
     * group: "ct-groupname"
     */
    var ctGroup = global.crosstalk.group(data.group);
    var ctHandle = global.crosstalk.filter.createHandle(ctGroup);

    var opts = {};
    var $el = $(el).find("input");
    var dataType = $el.data("data-type");
    var timeFormat = $el.data("time-format");
    var timeFormatter;

    // Set up formatting functions
    if (dataType === "date") {
      timeFormatter = strftime.utc();
      opts.prettify = function (num) {
        return timeFormatter(timeFormat, new Date(num));
      };
    } else if (dataType === "datetime") {
      var timezone = $el.data("timezone");
      if (timezone) timeFormatter = strftime.timezone(timezone);else timeFormatter = strftime;

      opts.prettify = function (num) {
        return timeFormatter(timeFormat, new Date(num));
      };
    }

    $el.ionRangeSlider(opts);

    function getValue() {
      var result = $el.data("ionRangeSlider").result;

      // Function for converting numeric value from slider to appropriate type.
      var convert = void 0;
      var dataType = $el.data("data-type");
      if (dataType === "date") {
        convert = function convert(val) {
          return formatDateUTC(new Date(+val));
        };
      } else if (dataType === "datetime") {
        convert = function convert(val) {
          // Convert ms to s
          return +val / 1000;
        };
      } else {
        convert = function convert(val) {
          return +val;
        };
      }

      if ($el.data("ionRangeSlider").options.type === "double") {
        return [convert(result.from), convert(result.to)];
      } else {
        return convert(result.from);
      }
    }

    $el.on("change.crosstalkSliderInput", function (event) {
      if (!$el.data("updating") && !$el.data("animating")) {
        var _getValue = getValue();

        var _getValue2 = _slicedToArray(_getValue, 2);

        var from = _getValue2[0];
        var to = _getValue2[1];

        var keys = [];
        for (var i = 0; i < data.values.length; i++) {
          var val = data.values[i];
          if (val >= from && val <= to) {
            keys.push(data.keys[i]);
          }
        }
        keys.sort();
        ctHandle.set(keys);
      }
    });

    // let $el = $(el);
    // $el.on("change", "input[type="checkbox"]", function() {
    //   let checked = $el.find("input[type="checkbox"]:checked");
    //   if (checked.length === 0) {
    //     ctHandle.clear();
    //   } else {
    //     let keys = {};
    //     checked.each(function() {
    //       data.map[this.value].forEach(function(key) {
    //         keys[key] = true;
    //       });
    //     });
    //     let keyArray = Object.keys(keys);
    //     keyArray.sort();
    //     ctHandle.set(keyArray);
    //   }
    // });
  }
});

// Convert a number to a string with leading zeros
function padZeros(n, digits) {
  var str = n.toString();
  while (str.length < digits) {
    str = "0" + str;
  }return str;
}

// Given a Date object, return a string in yyyy-mm-dd format, using the
// UTC date. This may be a day off from the date in the local time zone.
function formatDateUTC(date) {
  if (date instanceof Date) {
    return date.getUTCFullYear() + "-" + padZeros(date.getUTCMonth() + 1, 2) + "-" + padZeros(date.getUTCDate(), 2);
  } else {
    return null;
  }
}


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./input":6}],10:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.toggle = exports.remove = exports.add = undefined;

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

exports.createHandle = createHandle;

var _group = require("./group");

var _group2 = _interopRequireDefault(_group);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

/**
 * Use this class to get (`.value`) and set (`.set()`) the selection for
 * a Crosstalk group. This is intended to be used for linked brushing.
 * 
 * Besides getting and setting, you can also use the convenience methods
 * `add`, `remove`, and `toggle` to modify the active selection, and
 * subscribe/unsubscribe to `"change"` events to be notified whenever the
 * selection changes.
 * 
 * @constructor
 */

var SelectionHandle = function () {
  /**
   * @ignore
   */

  function SelectionHandle(group) {
    var owner = arguments.length <= 1 || arguments[1] === undefined ? null : arguments[1];
    var options = arguments.length <= 2 || arguments[2] === undefined ? null : arguments[2];

    _classCallCheck(this, SelectionHandle);

    this._group = group;
    this._var = group.var("selection");

    this._extraInfo = {};
    if (owner) {
      this._extraInfo.sender = owner;
    }

    if (options) {
      for (var key in options) {
        if (options.hasOwnProperty(key)) {
          this._extraInfo[key] = options[key];
        }
      }
    }
  }

  /**
   * Retrieves the current selection for the group represented by this
   * `SelectionHandle`. Can be `undefined` (meaning no selection is active),
   * an empty array (meaning a selection with no elements is active), or an
   * array with one or more keys.
   */


  _createClass(SelectionHandle, [{
    key: "set",


    /**
     * Overwrites the current selection for the group, and raises the `"change"`
     * event among all of the group's '`SelectionHandle` instances (including
     * this one).
     * 
     * @param {string[]} selectedKeys - `undefined`, empty array, or array of keys.
     * @param {Object} [extraInfo] - Extra attributes to be included on the event
     *   object that's passed to listeners. One common usage is `{sender: this}`
     *   if the caller needs to distinguish between events raised by itself and
     *   events raised by others. 
     */
    value: function set(selectedKeys, extraInfo) {
      this._var.set(selectedKeys, extraInfo);
    }
  }, {
    key: "clear",
    value: function clear(extraInfo) {
      this.set(void 0, extraInfo);
    }
  }, {
    key: "add",
    value: function add(keys, extraInfo) {
      _add(this._group, keys, extraInfo);
    }
  }, {
    key: "remove",
    value: function remove(keys, extraInfo) {
      _remove(this._group, keys, extraInfo);
    }
  }, {
    key: "toggle",
    value: function toggle(keys, extraInfo) {
      _toggle(this._group, keys, extraInfo);
    }
  }, {
    key: "on",
    value: function on(eventType, listener) {
      return this._var.on(eventType, listener);
    }
  }, {
    key: "off",
    value: function off(eventType, listener) {
      return this._var.off(eventType, listener);
    }
  }, {
    key: "value",
    get: function get() {
      return this._var.get();
    }
  }]);

  return SelectionHandle;
}();

function createHandle(groupName) {
  var owner = arguments.length <= 1 || arguments[1] === undefined ? null : arguments[1];
  var options = arguments.length <= 2 || arguments[2] === undefined ? null : arguments[2];

  var grp = (0, _group2.default)(groupName);
  return new SelectionHandle(grp);
}

function _add(group, keys, extraInfo) {
  if (!keys || keys.length === 0) {
    // Nothing to do
    return this;
  }

  var sel = group.var("selection").get();

  if (!sel) {
    // No keys to keep, but go through the machinery below anyway,
    // to remove dupes in `keys`
    sel = [];
  }

  var result = sel.slice(0);

  // Populate an object with the keys to add
  var keySet = {};
  for (var i = 0; i < keys.length; i++) {
    keySet[keys[i]] = true;
  }

  // Remove any keys that are already in the set
  for (var j = 0; j < sel.length; j++) {
    delete keySet[sel[j]];
  }

  var anyKeys = false;
  // Add the remaining keys
  for (var key in keySet) {
    anyKeys = true;
    if (keySet.hasOwnProperty(key)) result.push(key);
  }

  if (anyKeys) {
    group.var("selection").set(result, extraInfo);
  }

  return this;
}

exports.add = _add;
function _remove(group, keys, extraInfo) {
  if (!keys || keys.length === 0) {
    // Nothing to do
    return this;
  }

  var sel = group.var("selection").get();

  var keySet = {};
  for (var i = 0; i < keys.length; i++) {
    keySet[keys[i]] = true;
  }

  var anyKeys = false;
  var result = [];
  for (var j = 0; j < sel.length; j++) {
    if (!keySet.hasOwnProperty(sel[j])) {
      result.push(sel[j]);
    } else {
      anyKeys = true;
    }
  }

  // Only set the selection if values actually changed
  if (anyKeys) {
    group.var("selection").set(result, extraInfo);
  }

  return this;
}

exports.remove = _remove;
function _toggle(group, keys, extraInfo) {
  if (!keys || keys.length === 0) {
    // Nothing to do
    return this;
  }

  var sel = group.var("selection").get();

  var keySet = {};
  for (var i = 0; i < keys.length; i++) {
    keySet[keys[i]] = true;
  }

  var result = [];
  for (var j = 0; j < sel.length; j++) {
    if (!keySet.hasOwnProperty(sel[j])) {
      result.push(sel[j]);
    } else {
      keySet[sel[j]] = false;
    }
  }

  for (var key in keySet) {
    if (keySet[key]) {
      result.push(key);
    }
  }

  group.var("selection").set(result, extraInfo);
  return this;
}
exports.toggle = _toggle;


},{"./group":4}],11:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol ? "symbol" : typeof obj; };

exports.extend = extend;
exports.checkSorted = checkSorted;
exports.diffSortedLists = diffSortedLists;
exports.dataframeToD3 = dataframeToD3;
function extend(target) {
  for (var _len = arguments.length, sources = Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
    sources[_key - 1] = arguments[_key];
  }

  for (var i = 0; i < sources.length; i++) {
    var src = sources[i];
    if (typeof src === "undefined" || src === null) continue;

    for (var key in src) {
      if (src.hasOwnProperty(key)) {
        target[key] = src[key];
      }
    }
  }
  return target;
}

function checkSorted(list) {
  for (var i = 1; i < list.length; i++) {
    if (list[i] <= list[i - 1]) {
      throw new Error("List is not sorted or contains duplicate");
    }
  }
}

function diffSortedLists(a, b) {
  var i_a = 0;
  var i_b = 0;

  a = a || [];
  b = b || [];

  var a_only = [];
  var b_only = [];

  checkSorted(a);
  checkSorted(b);

  while (i_a < a.length && i_b < b.length) {
    if (a[i_a] === b[i_b]) {
      i_a++;
      i_b++;
    } else if (a[i_a] < b[i_b]) {
      a_only.push(a[i_a++]);
    } else {
      b_only.push(b[i_b++]);
    }
  }

  if (i_a < a.length) a_only = a_only.concat(a.slice(i_a));
  if (i_b < b.length) b_only = b_only.concat(b.slice(i_b));
  return {
    removed: a_only,
    added: b_only
  };
}

// Convert from wide: { colA: [1,2,3], colB: [4,5,6], ... }
// to long: [ {colA: 1, colB: 4}, {colA: 2, colB: 5}, ... ]
function dataframeToD3(df) {
  var names = [];
  var length = void 0;
  for (var name in df) {
    if (df.hasOwnProperty(name)) names.push(name);
    if (_typeof(df[name]) !== "object" || typeof df[name].length === "undefined") {
      throw new Error("All fields must be arrays");
    } else if (typeof length !== "undefined" && length !== df[name].length) {
      throw new Error("All fields must be arrays of the same length");
    }
    length = df[name].length;
  }
  var results = [];
  var item = void 0;
  for (var row = 0; row < length; row++) {
    item = {};
    for (var col = 0; col < names.length; col++) {
      item[names[col]] = df[names[col]][row];
    }
    results.push(item);
  }
  return results;
}


},{}],12:[function(require,module,exports){
(function (global){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _typeof = typeof Symbol === "function" && typeof Symbol.iterator === "symbol" ? function (obj) { return typeof obj; } : function (obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol ? "symbol" : typeof obj; };

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _events = require("./events");

var _events2 = _interopRequireDefault(_events);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var Var = function () {
  function Var(group, name, /*optional*/value) {
    _classCallCheck(this, Var);

    this._group = group;
    this._name = name;
    this._value = value;
    this._events = new _events2.default();
  }

  _createClass(Var, [{
    key: "get",
    value: function get() {
      return this._value;
    }
  }, {
    key: "set",
    value: function set(value, /*optional*/event) {
      if (this._value === value) {
        // Do nothing; the value hasn't changed
        return;
      }
      var oldValue = this._value;
      this._value = value;
      // Alert JavaScript listeners that the value has changed
      var evt = {};
      if (event && (typeof event === "undefined" ? "undefined" : _typeof(event)) === "object") {
        for (var k in event) {
          if (event.hasOwnProperty(k)) evt[k] = event[k];
        }
      }
      evt.oldValue = oldValue;
      evt.value = value;
      this._events.trigger("change", evt, this);

      // TODO: Make this extensible, to let arbitrary back-ends know that
      // something has changed
      if (global.Shiny && global.Shiny.onInputChange) {
        global.Shiny.onInputChange(".clientValue-" + (this._group.name !== null ? this._group.name + "-" : "") + this._name, value);
      }
    }
  }, {
    key: "on",
    value: function on(eventType, listener) {
      return this._events.on(eventType, listener);
    }
  }, {
    key: "off",
    value: function off(eventType, listener) {
      return this._events.off(eventType, listener);
    }
  }]);

  return Var;
}();

exports.default = Var;


}).call(this,typeof global !== "undefined" ? global : typeof self !== "undefined" ? self : typeof window !== "undefined" ? window : {})
},{"./events":1}]},{},[5]);
