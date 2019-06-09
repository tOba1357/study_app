// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function() {
  if ($('#word_cards-study').length > 0) {
    var currentIndex = 0;
    function sortWords() {
      var words = JSON.parse(JSON.stringify(gon.word_cards));
      words.forEach(function (word) {
        word.sortOrder = Math.random();
      });
      words.sort(function (w1, w2) {
        return w1.sortOrder - w2.sortOrder;
      })
      return words;
    }

    var words = sortWords();
    var $word = $('#word');
    var $description = $('#description');
    function onClickButtonAnswer(e) {
      e.preventDefault();
      $description.css('display', 'block');
    }

    function setWord(word) {
      $description.css('display', 'none');
      $word.text(word.word);
      $description.text(word.description);
      $('#button-forget').prop('disabled', false);
      $('#button-remember').prop('disabled', false);
    }

    $('#button-answer').on('click', onClickButtonAnswer);
    $('#button-next').on('click', function (e) {
      e.preventDefault();
      currentIndex += 1;
      if (currentIndex >= words.length) {
        currentIndex = 0;
        words = sortWords();
      }
      setWord(words[currentIndex])
    });


    $('#button-remember').on('click', function (e) {
      e.preventDefault();
      var $this = $(this);
      $this.prop("disabled", true);
      $('#button-forget').prop('disabled', true);
      $.ajax({
        type: 'POST',
        url: '/word_cards/' + words[currentIndex].id + '/word_card_results',
        data: {remember: true}
      });
    });

    $('#button-forget').on('click', function (e) {
      e.preventDefault();
      var $this = $(this);
      $this.prop("disabled", true);
      $('#button-remember').prop('disabled', true);
      $.ajax({
        type: 'POST',
        url: '/word_cards/' + words[currentIndex].id + '/word_card_results',
        data: {remember: false}
      })
    });

    setWord(words[currentIndex]);
  }
});