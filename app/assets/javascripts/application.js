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
    var currentWord = null;
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

    function getAndSetNextWord() {
      $.ajax({
        type: 'GET',
        url: '/word_cards/study_word',
        success: function (data, textStatus, jqXHR) {
          currentWord = data.word_card;
          setWord(data.word_card)
        },
        error: function () {
          alert('error')
        }
      })
    }

    $('#button-answer').on('click', onClickButtonAnswer);
    $('#button-next').on('click', function (e) {
      e.preventDefault();
      getAndSetNextWord();
    });


    $('#button-remember').on('click', function (e) {
      e.preventDefault();
      var $this = $(this);
      $this.prop("disabled", true);
      $('#button-forget').prop('disabled', true);
      $.ajax({
        type: 'POST',
        url: '/word_cards/' + currentWord.id + '/word_card_results',
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
        url: '/word_cards/' + currentWord.id + '/word_card_results',
        data: {remember: false}
      })
    });

    getAndSetNextWord();
  }
});