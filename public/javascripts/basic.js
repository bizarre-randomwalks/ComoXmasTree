 
(function($) {
 	


	$.placeholder = function(element) {
		
		if(element.attr("type") == "password") {
		
			var original_pass_field = element;

			if(original_pass_field.val() == "") {
				element.parent().append("<input type=\"text\" size=\"21\" style=\"color:#777777;\" value=\""+ element.attr("placeholder") +"\" name=\"pass_placeholder\" class=\"text\" id=\"pass_placeholder\">");
				element.css("display","none");
			}

			var original_pass_field = element;

			$("#pass_placeholder").focus(function() {
				if(original_pass_field.val() == "") {
					$("#pass_placeholder").css("display","none");
					original_pass_field.css("display","");
					original_pass_field.focus();
				}
			});

			original_pass_field.blur(function() {
				if(original_pass_field.val() == "") {
					$("#pass_placeholder").css("display","");
					original_pass_field.css("display","none");
				}
			});

		} else {

			if(element.val() === "") {
				element.val(element.attr("placeholder"));
				element.css("color","#777777");
			}

			element.focus(function() {
				if(element.val() === element.attr("placeholder")) {
					element.css("color","#000000");
					element.val("");
				}
			}).blur(function() {
				if(element.val() === "") {
					element.css("color","#777777");
					element.val(element.attr("placeholder"));
				}
			});
		}

	} 
	


   $.timeago = function(timestamp) {
    if (timestamp instanceof Date) return inWords(timestamp);
    else if (typeof timestamp == "string") return inWords($.timeago.parse(timestamp));
    else return inWords($.timeago.datetime(timestamp));
  };
  var $t = $.timeago;

  $.extend($.timeago, {
    settings: {
      refreshMillis: 60000,
      allowFuture: false,
      strings: {
        prefixAgo: null,
        prefixFromNow: null,
        suffixAgo: "전",
        suffixFromNow: "지금부터",
        ago: null, // DEPRECATED, use suffixAgo
        fromNow: null, // DEPRECATED, use suffixFromNow
        seconds: "방금",
        minute: "1분 전",
        minutes: "%d분",
        hour: "1시간",
        hours: "%d시간",
        day: "하루",
        days: "%d일",
        month: "한달",
        months: "%d달",
        year: "1년",
        years: "%d년"
      }
    },
    inWords: function(distanceMillis) {
      var $l = this.settings.strings;
      var prefix = $l.prefixAgo;
      var suffix = $l.suffixAgo || $l.ago;
      if (this.settings.allowFuture) {
        if (distanceMillis < 0) {
          prefix = $l.prefixFromNow;
          suffix = $l.suffixFromNow || $l.fromNow;
        }
        distanceMillis = Math.abs(distanceMillis);
      }

      var seconds = distanceMillis / 1000;
      var minutes = seconds / 60;
      var hours = minutes / 60;
      var days = hours / 24;
      var years = days / 365;

      var words = seconds < 45 && substitute($l.seconds, Math.round(seconds)) ||
        seconds < 90 && substitute($l.minute, 1) ||
        minutes < 45 && substitute($l.minutes, Math.round(minutes)) ||
        minutes < 90 && substitute($l.hour, 1) ||
        hours < 24 && substitute($l.hours, Math.round(hours)) ||
        hours < 48 && substitute($l.day, 1) ||
        days < 30 && substitute($l.days, Math.floor(days)) ||
        days < 60 && substitute($l.month, 1) ||
        days < 365 && substitute($l.months, Math.floor(days / 30)) ||
        years < 2 && substitute($l.year, 1) ||
        substitute($l.years, Math.floor(years));

      return $.trim([prefix, words, suffix].join(" "));
    },
    parse: function(iso8601) {
      var s = $.trim(iso8601);
      s = s.replace(/-/,"/").replace(/-/,"/");
      s = s.replace(/T/," ").replace(/Z/," UTC");
      s = s.replace(/([\+-]\d\d)\:?(\d\d)/," $1$2"); // -04:00 -> -0400
      return new Date(s);
    },
    datetime: function(elem) {
      // jQuery's `is()` doesn't play well with HTML5 in IE
      var isTime = $(elem).get(0).tagName.toLowerCase() == "time"; // $(elem).is("time");
      var iso8601 = isTime ? $(elem).attr("datetime") : $(elem).attr("title");
      return $t.parse(iso8601);
    }
  });

  $.fn.timeago = function() {
    var self = this;
    self.each(refresh);

    var $s = $t.settings;
    if ($s.refreshMillis > 0) {
      setInterval(function() { self.each(refresh); }, $s.refreshMillis);
    }
    return self;
  };

  function refresh() {
    var data = prepareData(this);
    if (!isNaN(data.datetime)) {
      $(this).text(inWords(data.datetime));
    }
    return this;
  }

  function prepareData(element) {
    element = $(element);
    if (!element.data("timeago")) {
      element.data("timeago", { datetime: $t.datetime(element) });
      var text = $.trim(element.text());
      if (text.length > 0) element.attr("title", text);
    }
    return element.data("timeago");
  }

  function inWords(date) {
    return $t.inWords(distance(date));
  }

  function distance(date) {
    return (new Date().getTime() - date.getTime());
  }

  function substitute(stringOrFunction, value) {
    var string = $.isFunction(stringOrFunction) ? stringOrFunction(value) : stringOrFunction;
    return string.replace(/%d/i, value);
  }

  // fix for IE6 suckage
  document.createElement("abbr");
  document.createElement("time");

  $.cookie = function(name, value, options) {
      if (typeof value != 'undefined') { // name and value given, set cookie
          options = options || {};
          if (value === null) {
              value = '';
              options.expires = -1;
          }
          var expires = '';
          if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {
              var date;
              if (typeof options.expires == 'number') {
                  date = new Date();
                  date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));
              } else {
                  date = options.expires;
              }
              expires = '; expires=' + date.toUTCString(); // use expires attribute, max-age is not supported by IE
          }
          // CAUTION: Needed to parenthesize options.path and options.domain
          // in the following expressions, otherwise they evaluate to undefined
          // in the packed version for some reason...
          var path = options.path ? '; path=' + (options.path) : '';
          var domain = options.domain ? '; domain=' + (options.domain) : '';
          var secure = options.secure ? '; secure' : '';
          document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');
      } else { // only name given, get cookie
          var cookieValue = null;
          if (document.cookie && document.cookie != '') {
              var cookies = document.cookie.split(';');
              for (var i = 0; i < cookies.length; i++) {
                  var cookie = jQuery.trim(cookies[i]);
                  // Does this cookie string begin with the name we want?
                  if (cookie.substring(0, name.length + 1) == (name + '=')) {
                      cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                      break;
                  }
              }
          }
          return cookieValue;
      }
  };

  $.log = function (msg) {
        console.log("%s: %o", msg, this);
        return this;
  };

  $.createProjectWidget = function(project, extraclass){
    if (extraclass != null)
    {
      var project_widget = $('<div/>', {class: 'project-widget ' + extraclass});
    }
    else
    {
      var project_widget = $('<div/>', {class: 'project-widget'});
    }


    var project_widget_icon = $('<a/>', {
      class: 'project-widget-icon',
      css: {
        background:'url(' + project.icon + ') no-repeat'
      },
      href: '/' + project.permalink,
      html: project.title    
    });

    var title = $('<p/>', {
      class: 'title',
      html: '<b>' + project.title + '</b>'
    });


    var short_description = $('<div/>', { class: 'project-short-description', html: project.short_description});

    var project_money_bar = $('<div/>', { class: 'project-money-bar' });
    var dark_bar = $('<div/>', { class: 'dark-bar' });
    var progress_bar = $('<div/>', {
      class: 'progress-bar', 
      css:{
        width: project.money_percentage + '%'
      }});

    var num = new NumberFormat();
    num.setInputDecimal('.');
    num.setNumber(project.current_money); // obj.value is '1000'
    num.setPlaces('0', false);
    num.setCurrencyValue('￦');
    num.setCurrency(true);
    num.setCurrencyPosition(num.LEFT_OUTSIDE);
    num.setNegativeFormat(num.LEFT_DASH);
    num.setNegativeRed(false);
    num.setSeparators(true, ',', ',');

    var current_money = $('<div/>', {
      class: 'current-money', 
      html: num.toFormatted()
    });

    dark_bar.append(progress_bar);
    dark_bar.append(current_money);
    project_money_bar.append(dark_bar);


    var creator_profile = $('<div/>', {class: 'creator-profile'});

    var creator_link = $('<div/>', { class: 'creator-link', html: '<a href="' + project.user.link + '">' + project.user.permalink + '</a>'});
    var clear = $('<div/>', { class: 'clear' });
    

    var dday = $('<p/>', {
      class: 'dday',
      html: project.dday + '일 남았습니다'
    });

    creator_profile.append(creator_link);
    creator_profile.append(dday);
    creator_profile.append(clear);


    project_widget.append(project_widget_icon);
    project_widget.append(title);
    project_widget.append(short_description);
    project_widget.append(project_money_bar);
    project_widget.append(creator_profile);
    return project_widget;
  };

    $.noticeMessage = function(message){
      $("<div/>", {
          id: 'message-notice',
          html: message
        }).appendTo($('body')).fadeIn().delay(2000).fadeOut();
    };

    $.errorMessage = function(message){
      $("<div/>", {
          id: 'message-error',
          html: message
        }).appendTo($('body')).fadeIn().delay(2000).fadeOut();
    };

})(jQuery);


$(document).ready(function(){
  
  $("#message-error").fadeIn().delay(2000).fadeOut();

  $("#message-notice").fadeIn().delay(2000).fadeOut();

});

(function($) {
    var userAgent = navigator.userAgent.toLowerCase();

    $.browser = {
        version: (userAgent.match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [0,'0'])[1],
        safari: /webkit/.test( userAgent ),
        opera: /opera/.test( userAgent ),
        msie: /msie/.test( userAgent ) && !/opera/.test( userAgent ),
        mozilla: /mozilla/.test( userAgent ) && !/(compatible|webkit)/.test( userAgent )
    };

})(jQuery);
