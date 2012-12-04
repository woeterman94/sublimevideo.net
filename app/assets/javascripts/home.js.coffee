SublimeVideo.homeReady = ->
  if ($slides = $('#slides')).exists()
    new SublimeVideo.Slideshow($slides, 10)

  # (new SublimeVideo.Quotes).randomShow() if jQuery('section.showcase').exists()

  if ($highlights = $('section.highlights')).exists()
    $highlights.find('ul').slidify
      visibleSlides: 3
      speed: 5
      previousButtons: $highlights.find('button.arrow.previous')
      nextButtons: $highlights.find('button.arrow.next')

  new SublimeVideo.NewsTicker(6) if $('.news_ticker').exists()

class SublimeVideo.Slideshow
  constructor: (@div, pause) ->
    @pauseDuration = pause * 1000

    this.startTimer()
    this.setupObservers()

  startTimer: ->
    @timer = setInterval((=> this.showNext()), @pauseDuration)

  showNext: (index) ->
    currentSlide = @div.find('.slide.active').first()
    currentSelector = $('ul.selectors li.active').first()
    currentSlide.removeClass('active')
    currentSelector.removeClass('active')
    if index?
      $(@div.find('.slide')[index]).addClass('active')
      $($('ul.selectors li')[index]).addClass('active')
    else
      if currentSlide.next().length == 1
        currentSlide.next().addClass('active')
        currentSelector.next().addClass('active')
      else
        @div.find('.slide').first().addClass('active')
        $('ul.selectors li').first().addClass('active')

  setupObservers: ->
    $('ul.selectors li a').each (index, element) =>
      element = $(element)
      element.on 'click', (event) =>
        event.preventDefault()
        if @timer
          clearInterval(@timer)
          @timer = null
        this.showNext(index)


# class SublimeVideo.Quotes
#   constructor: ->
#     @quotes = jQuery("section.showcase .quote")
#
#   randomShow: ->
#     randomQuoteIndex = Math.ceil(Math.random() * @quotes.length) - 1
#     jQuery(@quotes[randomQuoteIndex]).show()

class SublimeVideo.NewsTicker
  constructor: (pause) ->
    @pauseDuration = pause * 1000
    @news = jQuery('.news_ticker .news')
    @activeBoxIndex = 0
    this.startTimer()

  startTimer: ->
    @timer = setInterval((=> this.nextNews(@activeBoxIndex + 1)), @pauseDuration)

  nextNews: (index) ->
    currentEl = jQuery(@news[@activeBoxIndex])

    @activeBoxIndex = index % @news.length
    nextEl = jQuery(@news[@activeBoxIndex])

    currentEl.transition({
      opacity: 0
    }, =>
      currentEl.hide()
      nextEl.css({ opacity : 0 }).show().transition({
        opacity: 1
      })
    )
